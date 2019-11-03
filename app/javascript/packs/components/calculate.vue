<template>
  <div class="row grey lighten-4 main-forms" >
    
    <!-- modal -->
    <MyModal @close="closeModal" v-if="modal" :running="running" :result="result">
    </MyModal>

    <div class="row">
      <nav class="grey lighten-4">
        <div class="nav-wrapper">
          <div class="col s12 m10 offset-m1">
            <span class="brand-logo blue-grey-text lighten-3 setting-style">Settings</span>
          </div>
        </div>
      </nav>
      <div class="col s10 offset-s1" style="padding-top: 40px;">
        <div id="field" class="col s12 m8">
          <Cells
            :field="setting.field"
            :monsterForms="setting.monsterForms"
            @updateField="updateField($event)"
          ></Cells>
        </div>
        <div class="col s12 m4">
          <div class="input-field">
            <input type="text" id="cols" v-model.lazy="setting.turns" placeholder="turns">
            <label for="cols" class='active'>Turns</label>
          </div>
          <div class="input-field">
            <input type="text" id="cols" v-model.lazy="setting.times" placeholder="times">
            <label for="cols" class='active'>Times</label>
          </div>
          <div class="btn" @click="submitData">
            Simulate!!
          </div>
        </div>
      </div>
    </div>

    <Monster
      class="monster-forms"
      :field="setting.field"
      :monster-forms="setting.monsterForms"
    >
    </Monster>

  </div>
</template>

<script>
import Cells from './cells/cell_modify.vue'
import Monster from './monster'
import MyModal from './resultmodal'
import axios from 'axios'
import qs from 'qs'

export default {
  components: {
    Cells,
    Monster,
    MyModal
  },
  data: function() {
    return {
      setting: {
        field: [
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        ],
        monsterForms: [
          {
            id: 1,
            tribe: "km",
            order: 0,
            lv: "",
            position: "",
            doping: "0",
            weaken: 0,
            speed: false,
            sealed: false,
            strip: false,
            join: true,
            friend: true
          },
          {
            id: 2,
            tribe: "km",
            order: 1,
            lv: "",
            position: "",
            doping: "0",
            weaken: 0,
            speed: false,
            sealed: false,
            strip: false,
            join: true,
            friend: true
          },
          {
            id: 3,
            tribe: "km",
            order: 2,
            lv: "",
            position: "",
            doping: "0",
            weaken: 0,
            speed: false,
            sealed: false,
            strip: false,
            join: true,
            friend: true
          },
          {
            id: 4,
            tribe: "km",
            order: 3,
            lv: "",
            position: "",
            doping: "0",
            weaken: 0,
            speed: false,
            sealed: false,
            strip: false,
            join: true,
            friend: true
          },
          {
            id: 5,
            tribe: "km",
            order: 4,
            lv: "",
            position: "",
            doping: "0",
            weaken: 0,
            speed: false,
            sealed: false,
            strip: false,
            join: true,
            friend: true
          },
          {
            id: 6,
            tribe: "km",
            order: 5,
            lv: "",
            position: "",
            doping: "0",
            weaken: 0,
            speed: false,
            sealed: false,
            strip: false,
            join: true,
            friend: true
          },
          {
            id: 7,
            tribe: "km",
            order: 6,
            lv: "",
            position: "",
            doping: "0",
            weaken: 0,
            speed: false,
            sealed: false,
            strip: false,
            join: true,
            friend: true
          },
          {
            id: 8,
            tribe: "km",
            order: 7,
            lv: "",
            position: "",
            doping: "0",
            weaken: 0,
            speed: false,
            sealed: false,
            strip: false,
            join: true,
            friend: true
          },
          {
            id: 9,
            tribe: "km",
            order: 8,
            lv: "",
            position: "",
            doping: "0",
            weaken: 0,
            speed: false,
            sealed: false,
            strip: false,
            join: true,
            friend: true
          },
          {
            id: 10,
            tribe: "km",
            order: 9,
            lv: "",
            position: "",
            doping: "0",
            weaken: 0,
            speed: false,
            sealed: false,
            strip: false,
            join: true,
            friend: true
          },
          {
            id: 11,
            tribe: "seed",
            order: 0,
            lv: "1",
            position: "",
            doping: "0",
            weaken: 0,
            speed: false,
            sealed: false,
            strip: false,
            join: true,
            friend: false
          }
        ],
        turns: "1000",
        times: "10",
      },
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