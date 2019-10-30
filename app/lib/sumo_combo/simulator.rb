module SumoCombo

  module Reader
    def read_csv(file_path)
      data = {}
      File.read(file_path).split("\n").each.with_index do |line, i|
        if i == 0
          line.split(",").each do |col|
            data[col.to_sym] = []
          end
        else
          line.split(",").each.with_index do |val, j|
            case j%5
            when 0
              data[:lv] << val.to_i
            when 1
              data[:hp] << val.to_i
            when 2
              data[:attack] << val.to_i
            when 3
              data[:defense] << val.to_i
            when 4
              data[:EXP] << val.to_i
            end
          end
        end
      end
      return data
    end
    module_function :read_csv
  end

  module Simulator
    def experiment(params)
      result = {}
      exp_sum = 0
      failure = 0

      # 各試行の結果を加算
      params[:times].times do
        sequence = Sequence.new(params)
        sequence.one_set
        if result.empty?
          result[:monsters] = sequence.result
        else
          result[:monsters].each_key do |key|
            result[:monsters][key][:exp] += sequence.result[key][:exp]
            result[:monsters][key][:death] += sequence.result[key][:death]
          end
        end
      end
      
      # 崩壊回数
      result[:monsters].each_key do |key|
        failure += result[:monsters][key][:death]
      end

      # 成功時の獲得経験値の平均をとる
      result[:monsters].each_key do |key|
        begin
          result[:monsters][key][:exp] /= (params[:times]-failure)
        rescue ZeroDivisionError
          result[:monsters][key][:exp] = 0
        end
        exp_sum += result[:monsters][key][:exp]
      end

      result[:exp_sum] = exp_sum

      # 崩壊率の計算
      failure_rate = (failure.fdiv(params[:times])*100).round(2)
      result[:failure_rate] = failure_rate

      result
    end
    module_function :experiment
  end
  

  class Monster
    include Reader

    attr_accessor :name, :lv, :doping, :friend, :position,
                  :speed, :weaken, :sealed, :strip, :exp,
                  :attack, :defense, :hp, :hp_max, :order,
                  :health_const

    DSDATA = Reader.read_csv(Rails.root.join('app/lib/sumo_combo/resources/defense_slow.csv'))
    OFDATA = Reader.read_csv(Rails.root.join('app/lib/sumo_combo/resources/offense_fast.csv'))
    NFDATA = Reader.read_csv(Rails.root.join('app/lib/sumo_combo/resources/nomal_fast.csv'))

    def initialize(
                    name: "",
                    lv: 1,
                    doping: 0,
                    friend: true,
                    position: [0,0],
                    speed: false,
                    weaken: 0,
                    sealed: false,
                    strip: false,
                    exp: 0,
                    order: 0
      )
      @name         = name         # string
      @lv           = lv           # integer
      @doping       = doping       # integer
      @friend       = friend       # boolean
      @position     = position     # array
      @speed        = speed        # boolean
      @weaken       = weaken       # integer
      @sealed       = sealed       # boolean
      @strip        = strip        # boolean
      @exp          = exp          # integer
      @order        = order        # integer
    end

    # @@fieldの初期化
    def self.get_initial_field(field, monsters)
      @@field = field.map(&:dup)
      monsters.each do |options|
        case options[:name]
        when "km"
          mons = KillerMachine.new(options)
        when "su"
          mons = Sumoguru.new(options)
        when "ho"
          mons = HoimiSlime.new(options)
        when "kn"
          mons = Kinoko.new(options)
        when "kt"
          mons = Kitoshi.new(options)
        when "seed"
          mons = Sumoguru.new(options)
        else
          e = Exception.new("sorry, now we don't handle your monster.")
          p e.message
          exit
        end
        if @@field[mons.position[0]][mons.position[1]] == true
          @@field[mons.position[0]][mons.position[1]] = mons
        else
          e = Exception.new("it is a wrong position set.")
          p e.message
          exit
        end
      end
    end

    # @@friends, @@enemiesの行動順配列を作成
    def self.set_monsters_array
      # fieldからモンスターを検索し、行動順で並び替える。
      field = @@field.flatten
      monsters = field.keep_if{|cell| Monster === cell}
      @@friends = monsters.select{|mons| mons.friend}
      @@friends.sort_by!{|mons| mons.order}
      @@enemies = monsters.select{|mons| !mons.friend}
    end

    # @@friendsを外部に渡す
    def self.get_friends
      return @@friends
    end

    # @@enemiesを外部に渡す
    def self.get_enemies
      return @@enemies
    end

    # @@deathを外部に渡す
    def self.get_death
      return @@death
    end

    #  @@deathを初期化
    def self.set_death
      @@death = nil
    end

    # 与ダメの計算
    def calc_damage(df)
      # receiver is offense, attr is defense
      status_attack = attack.fdiv(2**weaken).ceil
      status_defense = df.strip ? (df.defense*0.7).floor : df.defense
      (status_attack*1.3*(35.fdiv(36))**status_defense*(128+rand(-16..15))/128).round
    end

    # ダメ計算と死亡判定(暫定的にexitしている。のちにn回目の試行を抜け出すように書き換え要。)
    def injured(damage)
      @hp -= damage
      if @hp.floor <= 0
        @@field[position[0]][position[1]] = true
        if friend
          @@friends.delete(self)
          @@death = self
        else
          @@enemies.delete(self)
        end
      end
    end

    def set_monster
      if @@field[position[0]][position[1]] == true
        @@field[position[0]][position[1]] = self
      else
        e = Exception.new("this position is occupied with other monster or wall")
        p e.message
        exit
      end
    end
  
    def around_monsters_with_corner
      monsters = []
      for i in -1..1
        for j in -1..1
          if Monster === @@field[position[0]+i][position[1]+j] && [i, j] != [0, 0]
            if [[-1,-1], [-1, 1], [1, -1], [1, 1]].include?([i, j])
              unless @@field[position[0]+i][position[1]] && @@field[position[0]][position[1]+j]
                next
              end
            end
            monsters << @@field[position[0]+i][position[1]+j]
          end
        end
      end
      monsters
    end
  
    def around_monsters_without_corner
      monsters = []
      for i in -1..1
        for j in -1..1
          if Monster === @@field[position[0]+i][position[1]+j] && [i, j] != [0, 0]
            monsters << @@field[position[0]+i][position[1]+j]
          end
        end
      end
      monsters
    end
  
    def around_empty_with_corner
      empty_positions = []
      for i in -1..1
        for j in -1..1
          if @@field[position[0]+i][position[1]+j] == true
            if [[-1,-1], [-1, 1], [1, -1], [1, 1]].include?([i, j])
              unless @@field[position[0]+i][position[1]] && @@field[position[0]][position[1]+j]
                next
              end
            end
            empty_positions << [position[0]+i, position[1]+j]
          end
        end
      end
      empty_positions
    end
  
    def around_empty_without_corner
      empty_positions = []
      for i in -1..1
        for j in -1..1
          if @@field[position[0]+i][position[1]+j] == true
            empty_positions << [position[0]+i, position[1]+j]
          end
        end
      end
      empty_positions
    end
  

    def turn_action
      # 殴れる敵を探す
      target_list = around_monsters_with_corner.map{|mons| mons if mons.friend != self.friend}
      target_list.compact!
      if target_list.empty?
        if @friend
          return
        else
          @@field[position[0]][position[1]] = true
          position = around_empty_with_corner.sample
          set_monster
          return
        end
      else
        target = target_list.sample
        return if rand(99) < 8            # hit?
        damage = calc_damage(target)      # もうちょっと綺麗にならんかね？
        if target.injured(damage) == target
          @exp += 22
        end
      end
    end

  end
  
  class Sumoguru < Monster
    def initialize(options={})
      super options
      @attack = 17+OFDATA[:attack][lv-1]
      @defense = 10+OFDATA[:defense][lv-1]
      @hp = 55+OFDATA[:hp][lv-1] + @doping
      @hp_max = @hp
      @health_const = 50
    end

    # スモグルはなぐられたときに増える
    def injured(damage)
      if @sealed
        super damage
        return
      end
      @hp -= damage
      if @hp.floor <= 0
        @@field[position[0]][position[1]] = true
        if friend
          @@friends.delete(self)
          @@death = self
        else
          @@enemies.delete(self)
        end
      else
        if rand(99) < 25 && @@friends.length + @@enemies.length < 40
          new_position = around_empty_without_corner.sample
          if new_position != nil
            new_su = Sumoguru.new(lv: 1, friend: false, position: new_position).set_monster
            @@enemies << new_su
          end
        end
      end
    end
  end
  
  class KillerMachine < Monster
    def initialize(options={})
      super options
      @attack = 20+DSDATA[:attack][lv-1]
      @defense = 25+DSDATA[:defense][lv-1]
      @hp = 60+DSDATA[:hp][lv-1]+@doping
      @hp_max = @hp
      @health_const = 100
    end

    # キラーマは二回攻撃
    def turn_action
      # 封印されていれば特技なしの行動
      if @sealed
        super
        return
      end
      # 殴れる敵を探す
      target_list = around_monsters_with_corner.map{|mons| mons if mons.friend != self.friend}
      target_list.compact!
      if target_list.empty?
        if @friend
          return
        else
          @@field[position[0]][position[1]] = true
          position = around_empty_with_corner.sample
          set_monster
          return
        end
      else
        target = target_list.sample
        # 攻撃対象は一定。1回目の攻撃で敵が死んだら終わり。
        2.times do
          next if rand(99) < 8           # hit?
          damage = calc_damage(target)      # もうちょっと綺麗にならんかね？
          if target.injured(damage) == target
            @exp += 22
          end
        end
      end
    end
  end
  
  class HoimiSlime < Monster
    def initialize(options={})
      super options
      @attack = 10+NFDATA[:attack][lv-1]
      @defense = 9+NFDATA[:defense][lv-1]
      @hp = 28+NFDATA[:hp][lv-1]
      @hp_max = @hp+@doping
      @health_const = 50
    end

    # ホイミンはホイミをする
    def turn_action
      # 封印されていれば特技なしの行動
      if @sealed
        super
        return
      end
      # 角抜けありでホイミ対象を探す
      target_list = around_monsters_without_corner.map{ |mons| mons if mons.hp < mons.hp_max }
      target_list.compact!
      # target_list.each do |tar|
      #   puts "ho at #{position} looks #{tar.position},#{tar.hp},#{tar.name}"
      # end
      target_list.each do |mons|
        if rand(99) < 33
          around_monsters_without_corner.each do |mons|
            mons.hp += 25
            if mons.hp > mons.hp_max
              mons.hp = mons.hp_max
            end
          end
          return
        end
      end
      # ホイミしなかった場合、33%の確率で攻撃する(検証要)
      if rand(99) < 33
        super
        return
      end
    end
  end
  
  class Kitoshi < Monster
    def initialize(options={})
      super options
      @attack = 8+DSDATA[:attack][lv-1]
      @defense = 10+DSDATA[:defense][lv-1]
      @hp = 39+DSDATA[:hp][lv-1]
      @hp_max = @hp+@doping
      @health_const = 50
      # default settings for Kitoshi
      @sealed = sealed
    end
  end
  
  class Kinoko < Monster
    def initialize(options={})
      super options
      @attack = 20+DSDATA[:attack][lv-1]
      @defense = 12+DSDATA[:defense][lv-1]
      @hp = 38+DSDATA[:hp][lv-1]
      @hp_max = @hp+@doping
      @health_const = 50
    end
  end
  
  class Sequence
    attr_accessor :friends, :enemies, :turns, :result, :failure
    def initialize(params)
      Monster.get_initial_field(params[:field], params[:monsters])
      Monster.set_monsters_array
      @friends = Monster.get_friends
      @enemies = Monster.get_enemies
      @turns = params[:turns]
      @result = @friends.map {|f| ["#{f.name}#{f.order}".to_sym, {position: f.position, exp: 0, death: 0}]}.to_h
    end

    @@failure = 0
    
    def self.get_failure
      @@failure
    end

    def one_turn
      # 敵の行動
      @enemies.each do |enemy|
        enemy.turn_action
      end

      # 味方の行動
      @friends.each do |friend|
        friend.turn_action
      end
    
      # 味方全員の自然回復
      @friends.each do |friend|
        # 倍速組の自然回復と行動2回目
        if friend.speed
          friend.hp += friend.hp_max/friend.health_const.to_f
          if friend.hp > friend.hp_max
            friend.hp = friend.hp_max
          end
          friend.turn_action
        end
        friend.hp += friend.hp_max/friend.health_const.to_f
        if friend.hp > friend.hp_max
          friend.hp = friend.hp_max
        end
      end
    end

    def one_set
      Monster.set_death
      flag = 0
      @turns.times do
        one_turn
        if Monster.get_death
          @@failure += 1
          flag = 1
          break
        end
      end
      set_result(flag)
    end

    def set_result(flag)
      if flag == 0
        @friends.each do |friend|
          @result["#{friend.name}#{friend.order}".to_sym][:exp] += friend.exp
        end
      else
        friend = Monster.get_death
        @result["#{friend.name}#{friend.order}".to_sym][:death] += 1
      end
    end
  end
end