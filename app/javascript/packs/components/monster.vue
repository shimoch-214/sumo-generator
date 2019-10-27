<template>
  <div class="row grey lighten-1 forms-updown">
    <nav class="grey lighten-1 waves-effect waves-light" @click="toggleCtrlPanel">
      <div class="nav-wrapper">
          <div class="col s12 m10 offset-m1">
            <span class="brand-logo black-text">Monsters</span>
          </div>
      </div>
    </nav>
    <transition name="slide" appear>
      <div class="col s12" v-show="!isPanelShown">
        <table class="striped" style="font-size: 0.8rem">
          <thead>
            <tr>
              <th class="tribe-width">種族</th>
              <th class="select-width">行動順</th>
              <th class="input-width">Lv</th>
              <th class="input-width">位置</th>
              <th class="input-width">ドープ</th>
              <th class="select-width">弱化</th>
              <th class="btn-width">倍速</th>
              <th class="btn-width">封印</th>
              <th class="btn-width">装備</th>
              <th class="btn-width">参加</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="monsterForm in monsterForms"
              :key="monsterForm.id"
              :id="'monsForm'+monsterForm.id"
              :class="(monsterForm.friend)? '': 'red lighten-3'"
            >
              <td class="tribe-width">
                <TribeSelect
                  v-model="monsterForm.tribe"
                  name="tribe"
                  :options="tribes"
                  :friend="monsterForm.friend"
                  @change="changeName($event)"
                ></TribeSelect>
              </td>
              <td class="select-width">
                <SumoSelect
                  v-model="monsterForm.order"
                  name="order"
                  :options="orders"
                  :friend="monsterForm.friend"
                ></SumoSelect>
              </td>
              <td class="input-width">
                <LvInput
                  v-model="monsterForm.lv"
                  name="lv"
                  :friend="monsterForm.friend"
                ></LvInput>
              </td>
              <td class="input-width">
                <PositionInput
                  :value="monsterForm.position"
                  name="position"
                  :friend="monsterForm.friend"
                  @change="setMonster($event)"
                ></PositionInput>
              </td>
              <td class="input-width">
                <DopeInput
                  v-model="monsterForm.doping"
                  name="doping"
                  :friend="monsterForm.friend"
                ></DopeInput>
              </td>
              <td class="select-width">
                <SumoSelect
                  v-model="monsterForm.weaken"
                  name="weaken"
                  :options="weakens"
                  :friend="monsterForm.friend"
                ></SumoSelect>
              </td>
              <td class="btn-width">
                <SumoCheckbox
                  v-model="monsterForm.speed"
                  name="speed"
                  :friend="monsterForm.friend"
                ></SumoCheckbox>
              </td>
              <td class="btn-width">
                <SumoCheckbox
                  v-model="monsterForm.sealed"
                  name="sealed"
                  :friend="monsterForm.friend"
                ></SumoCheckbox>
              </td>
              <td class="btn-width">
                <SumoCheckbox
                  v-model="monsterForm.strip"
                  name="strip"
                  :friend="monsterForm.friend"
                ></SumoCheckbox>
              </td>
              <td class="btn-width">
                <SumoCheckbox
                  v-model="monsterForm.join"
                  name="join"
                  :friend="monsterForm.friend"
                ></SumoCheckbox>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </transition>
  </div>
</template>

<script>
import Vue from 'vue/dist/vue.esm.js'
import LvInput from './forms/lvinput'
import PositionInput from './forms/positioninput'
import DopeInput from './forms/dopeinput'
import SumoCheckbox from './forms/sumocheckbox'
import TribeSelect from './forms/tribeselect'
import SumoSelect from './forms/sumoselect'



export default {
  components: {
    LvInput,
    PositionInput,
    DopeInput,
    SumoCheckbox,
    TribeSelect,
    SumoSelect,
  },
  props: {
    field: { type: Array, required: true }
  },
  data: function(){
    return {
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
      tribes: [
        { value: "km", label: "キラーマ" },
        { value: "su", label: "スモグル" },
        { value: "ho", label: "ホイミン" },
      ],
      orders: [
        { value: 0, label: "1番" },
        { value: 1, label: "2番" },
        { value: 2, label: "3番" },
        { value: 3, label: "4番" },
        { value: 4, label: "5番" },
        { value: 5, label: "6番" },
        { value: 6, label: "7番" },
        { value: 7, label: "8番" },
        { value: 8, label: "9番" },
        { value: 9, label: "10番" },
      ],
      weakens: [
        { value: 0, label: "0回"},
        { value: 1, label: "1回"},
        { value: 2, label: "2回"},
        { value: 3, label: "3回"},
        { value: 4, label: "4回"},
        { value: 5, label: "5回"},
        { value: 6, label: "6回"},
        { value: 7, label: "7回"},
        { value: 8, label: "8回"},
        { value: 9, label: "9回"},
      ],
      isPanelShown: false,
    }
  },
  methods: {
    positionClear: function(parentId) {
      document.querySelector(`#${parentId} input[name="position"]`).value="";
      parentId = Number(parentId.replace(/[^0-9]/g,''));
      this.monsterForms[parentId-1].position = ""
    },
    setMonster: function(params) {
      var val = params[0];
      var parentId = params[1];
      var rows = this.field.length;
      var cols = this.field[0].length;
      var row = val.split(',')[0]
      var col = val.split(',')[1]
      var tribe = document.querySelector(`#${parentId} select[name="tribe"]`).value
      var order = Number(document.querySelector(`#${parentId} select[name="order"]`).value)+1
      var target = document.querySelector(`#${tribe}${order}`);
      if (target) {
        target.parentNode.removeChild(target);
      }
      if (val == "") {
        return
      }
      // m,nの形式で入力されていなければダメ
      if (!val.match(/^\d{1,},\d{1,}/)) {
        alert("'m,n'の形式で入力してください");
        this.positionClear(parentId);
        return
      }
      // field[row][col]が空じゃないとだめ
      if (row < 1 || col < 1 || row > rows-2 || col > cols-2) {
        alert("壁際には配置できません")
        this.positionClear(parentId);
        return
      } else if (!this.field[row][col]) {
        alert("壁の中には配置できません")
        this.positionClear(parentId);
        return
      } else if (document.querySelector(`#r${row}c${col}`).children.length) {
        alert("他のユニットがいます")
        this.positionClear(parentId);
        return
      }
      var html = this.buildMonsterName(tribe, order);
      document.querySelector(`#r${row}c${col}`).insertAdjacentHTML('beforeend', html);
    },
    changeName: function(params) {
      var val = params[0];
      var parentId = params[1];
      var position = document.querySelector(`#${parentId} input[name="position"]`).value
      var order = Number(document.querySelector(`#${parentId} select[name="order"]`).value)+1
      if (position == "") {
        return;
      }
      var row = position.split(',')[0]
      var col = position.split(',')[1]
      var html = this.buildMonsterName(val, order)
      var target = document.querySelector(`#r${row}c${col}`)
      target.removeChild(target.lastChild)
      target.insertAdjacentHTML('beforeend', html)
    },
    buildMonsterName: function(tribe, order) {
      if (tribe == 'km') {
        var html = `<p id="${tribe}${order}" style="font-size: 1.5rem;">機${order}</p>`;
      } else if (tribe == 'ho') {
        var html = `<p id="${tribe}${order}" style="font-size: 1.5rem;">ホ${order}</p>`;
      } else if (tribe == 'su') {
        var html = `<p id="${tribe}${order}" style="font-size: 1.5rem;">ス${order}</p>`;
      } else if (tribe == 'seed') {
        var html = `<p id="${tribe}${order}" style="font-size: 1.5rem;">種</p>`;
      }
      return html
    },
    toggleCtrlPanel: function() {
      this.isPanelShown = !this.isPanelShown
    }
  },
  watch: {
    monsterForms: {
      handler: function(val) {
        this.$emit('monsterChange', val)
      },
      deep: true,
      immediate: true
    }
  }
}
</script>

<style scoped>
td {
  padding: 0 5px;
  margin: 0;
} 
th {
  padding: 15px 5px;
  margin: 0;
}

.input-width {
  width: 13%;
}
.select-width {
  width: 13%;
}
.btn-width {
  width: 4%;
}
.tribe-width {
  width: 20%;
}
.input-field {
  margin: 0;
  padding: 0;
}

tbody {
  display: block;
  height: 250px;
  overflow-y: scroll;
}
thead, tbody tr {
  display: table;
  width: 100%;
  table-layout: fixed;
}
thead {
  height: 50px;
  width: calc(100% - 1em);
} 
table {
  width: 100%;
}

.forms-updown {
  width: calc(100%);
}


.slide-enter-active, .slide-leave-active {
    transition: .5s;
    opacity: 1;
    height: 300px;

    /* transition: height 300px; */
}
.slide-enter, .slide-leave-to {
    opacity: 0;
    height: 0;
}

</style>

