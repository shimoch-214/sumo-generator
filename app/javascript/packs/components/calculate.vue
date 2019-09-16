<template>
  <div>
    <div class="row">
      <div class="col s12 m4 offset-m1">
        <Field
          @fieldChange="updateField($event)"
        >
        </Field>
      </div>
      <div class="col s12 m5 offset-m1">
        <Monster
          :field="setting.field"
          @monsterChange="updateMonsterForms($event)"
        >
        </Monster>
      </div>
    </div>
    <div class="btn"
      @click="submitData"
    >clal</div>
  </div>
</template>

<script>
import Field from './field'
import Monster from './monster'
import axios from 'axios'
import qs from 'qs'

export default {
  components: {
    Field,
    Monster
  },
  data: function() {
    return {
      setting: {
        field: [],
        monsterForms: [],
        turns: 1000,
        times: 10
      }
    }
  },
  methods: {
    updateField: function(field) {
      this.setting.field = new Array(field.length);
      for(var i = 0; i < field.length; i++) {
        this.setting.field[i] = Array.from(field[i]);
      }
    },
    updateMonsterForms: function(monsterForms) {
      this.setting.monsterForms = new Array(monsterForms.length);
      for(var i = 0; i < monsterForms.length; i++) {
        this.setting.monsterForms[i] = Object.assign({}, monsterForms[i]);
      }
    },
    submitData: function(e) {
      var setting = this.formatSetting();
      // axios.get('/api/calcs', {
      //   params: {
      //     field: JSON.stringify(setting.field),
      //     monsters: setting.monsters,
      //     turns: Number(this.setting.turns),
      //     times: Number(this.setting.times)
      //   },
      //   paramsSerializer: function(params) {
      //     return qs.stringify(params, {arrayFormat: 'brackets'})
      //   }
      // }
      axios.post('/api/calcs', setting)
      .then((response) => {
        console.log(response);
        console.log("done");
      }, (error) => {
        console.log('failed');
      });
    },
    formatSetting: function() {
      var setting =  new Object();

      // field部分
      setting.field = new Array(this.setting.field.length);
      for(var i = 0; i < setting.field.length; i++) {
        setting.field[i] = Array.from(this.setting.field[i]);
        setting.field[i] = this.setting.field[i].map(ele => Boolean(ele));
      }

      // monster部分
      setting.monsters = new Array(this.setting.monsterForms.length);
      for(var i = 0; i < setting.monsters.length; i++) {
        setting.monsters[i] = Object.assign({}, this.setting.monsterForms[i]);
      }
      setting.monsters = setting.monsters.filter(monster => monster.join)
      setting.monsters.forEach(function(monster) {
        delete monster.id;
        delete monster.join;
        monster.name = monster.tribe;
        delete monster.tribe;
        monster.position = monster.position.split(',').map(ele => Number(ele));
        monster.lv = Number(monster.lv);
        monster.doping = Number(monster.doping);
        monster.order = Number(monster.order);
        monster.weaken = Number(monster.weaken);
      })

      setting.times = Number(this.setting.times)
      setting.turns = Number(this.setting.turns)
      return setting
    }
  },
}
</script>

<style>

</style>