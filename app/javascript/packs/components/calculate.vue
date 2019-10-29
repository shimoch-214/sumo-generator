<template>
  <div class="row grey lighten-4 main-forms" >
    
    <!-- modal -->
    <MyModal @close="closeModal" v-if="modal" :running="running" :result="result">
    </MyModal>


    <Field
      @fieldChange="updateField($event)"
      @turnsChange="updateTurns($event)"
      @timesChange="updateTimes($event)"
      @runCalculate="submitData"
      :key="'field'+reRendering"
    >
    </Field>

    <Monster
      class="monster-forms"
      :field="setting.field"
      @monsterChange="updateMonsterForms($event)"
      :key="'monster'+reRendering"
    >
    </Monster>

  </div>
</template>

<script>
import Field from './field'
import Monster from './monster'
import MyModal from './resultmodal'
import axios from 'axios'
import qs from 'qs'

export default {
  components: {
    Field,
    Monster,
    MyModal
  },
  data: function() {
    return {
      setting: {
        field: [],
        monsterForms: [],
        turns: "",
        times: "",
      },
      reRendering: "none",
      modal: false,
      message: "",
      running: true,
      result: {},
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
    updateTurns: function(turns) {
      this.setting.turns = turns;
    },
    updateTimes: function(times) {
      this.setting.times = times;
    },
    submitData: function() {
      var message = this.monsterFormsValidation();
      if (message != "") {
        alert(message);
        return
      }
      
      this.openModal();
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
      axios.post('/api/calcs/calculate', setting)
      .then((response) => {
        this.result = response.data;
        this.running = false;
      }, (error) => {
        alert("sorry, failed");
        this.running = false;
      });
    },
    formatSetting: function() {
      var setting =  new Object();
      console.log(this.setting)
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
    },
    monsterFormsValidation: function() {
      var orderArray = new Array();
      var orderFlag = false;
      var lvFlag = false;
      var dopingFlag = false;
      var field = this.setting.field;
      var positionFlag = false;
      var message = "";

      this.setting.monsterForms.forEach(function(monster, index) {
        if (!monster.join || !monster.friend) {
          return
        }

        if (orderArray.includes(Number(monster.order)) && !orderFlag) {
          message += "行動順が重複しています\n";
          orderFlag = !orderFlag;
        }
        orderArray.push(Number(monster.order));

        var position = monster.position.split(',');
        if (!field[Number(position[0])][Number(position[1])] && !positionFlag) {
          message += "位置が不正です\n"
          positionFlag = !positionFlag;
        }
      })
      return message.trim();
    },
    openModal() {
      this.modal = true
    },
    closeModal() {
      this.modal = false;
      this.running = true;
    },
    getSample(id) {
      axios.get(`/api/samples/${id}`, id)
      .then((response) => {
        this.setting = response.data;
      }), (error) => {
        alert("sorry, failed.")
      }
      this.reRendering = id

    }
  },
  watch: {
    '$route' (to, from) {
      if (to.params.sampleId) {
        var id = to.params.sampleId.match(/\d/)[0]
        this.getSample(id)
      }
    }
  },
  created: function() {
    if (this.$route.params.sampleId) {
      var id = this.$route.params.sampleId.match(/\d/)[0]
      this.getSample(id)
    }
  }
}
</script>

<style scoped>
.main-forms {
  height: 100vh;
  margin-bottom: 0;
}
.monster-forms {
  position: fixed;
  bottom: 0;
  margin-bottom: 0;
  padding-bottom: 20px; 
}
</style>