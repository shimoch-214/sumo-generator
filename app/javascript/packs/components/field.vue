<template>
  <div class="row">
    <nav class="grey lighten-2">
      <div class="nav-wrapper">
        <div class="col s12 m10 offset-m1">
          <span class="brand-logo black-text">Field</span>
        </div>
      </div>
    </nav>
    <div class="col s10 offset-s1" style="padding-top: 20px;">
      <div id="field" class="col s12 m8">
        <!-- ボタン押したらここにfieldが挿入される -->
        <Cell
          :fieldData="fieldData"
          @updateField="updateField($event)"
        ></Cell>
      </div>
      <div class="col s12 m4">
        <!-- <div class="input-field"> 
          <input type="text" id="rows" :value="fieldData.rows" placeholder="1~20">
          <label for="rows">Rows</label>
        </div>
        <div class="input-field">
          <input type="text" id="cols" :value="fieldData.cols" placeholder="1~20">
          <label for="cols">Cols</label>
        </div> -->
        <!-- <div class="btn waves-effect waves-light"
          @click="createField">
          Reset
        </div> -->
        <div class="input-field">
          <input type="text" id="cols" v-model="turns" placeholder="1~20">
          <label for="cols">Turns</label>
        </div>
        <div class="input-field">
          <input type="text" id="cols" v-model="times" placeholder="1~20">
          <label for="cols">Times</label>
        </div>
        <div class="btn" @click="submitData">
          Simulate!!
        </div>
      </div>
    </div>
  </div>
</template>

<script>
// import Cell from './cells/cell'
import Cell from './cells/cell_modify'
import Vue from 'vue/dist/vue.esm.js'

export default {
  components: {
    Cell,
  },
  data: function() {
    return {
      fieldData: {
        rows: 12,
        cols: 12,
      },
      field: [],
      turns: "1000",
      times: "100",
    }
  },
  methods: {
    createField: function(e) {
      var oldRows = Number(this.fieldData.rows);
      var oldCols = Number(this.fieldData.cols);
      var newRows = Number(document.querySelector('#rows').value);
      var newCols = Number(document.querySelector('#cols').value);
      if (oldRows == newRows && oldCols == newCols) {
        // 行列m,nに変化がない場合
        return
      } else if(newRows < 1 || newCols < 1 || newRows > 20 || newCols > 20) {
        alert("1~20の値を入力してください。");
        return
      } else if(isNaN(newRows) || isNaN(newCols) ) {
        alert("値を入力してください。")
        return
      }

      this.fieldData.rows = newRows;
      this.fieldData.cols = newCols;
      this.initializeField();
    },
    initializeField: function() {
      this.field = new Array(this.fieldData.rows);
      for(var i=0; i < this.fieldData.rows; i++) {
        this.field[i] = new Array(this.fieldData.cols).fill(0);
      }
    },
    updateField: function(field) {
      this.field = Array.from(field);
    },
    submitData: function(e) {
      this.$emit('runCalculate')
    }
  },
  mounted: function() {
    this.initializeField();
    this.$emit('turnsChange', this.turns)
    this.$emit('timesChange', this.times)
  },
  watch: {
    field: {
      handler: function(val) {
        this.$emit('fieldChange', val)
      },
      deep: true,
      immediate: true
    },
    turns: function(val) {
      this.$emit('turnsChange', val)
    },
    times: function(val) {
      this.$emit('timesChange', val)
    }
  }
}
</script>

<style>
</style>