<template>
  <div>
    <h2>Field</h2>
    <div class="row valign-wrapper">
      <div class="input-field col s4"> 
        <input type="text" id="rows" :value="field.rows" placeholder="1~20">
        <label for="rows">行数</label>
      </div>
      <div class="input-field col s4">
        <input type="text" id="cols" :value="field.cols" placeholder="1~20">
        <label for="cols">列数</label>
      </div>
      <div class="btn waves-effect waves-light col s4"
        @click="createField">
        作成
      </div>
    </div>
    <div id="field">
      <!-- ボタン押したらここにfieldが挿入される -->
      <Cell
        :field="field"
        @updatePosition="updatePosition($event)"
      ></Cell>
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
      field: {
        rows: 10,
        cols: 10,
      },
      position: []
    }
  },
  methods: {
    createField: function(e) {
      var oldRows = Number(this.field.rows);
      var oldCols = Number(this.field.cols);
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

      this.field.rows = newRows;
      this.field.cols = newCols;
      this.initializePosition();
    },
    initializePosition: function() {
      this.position = new Array(this.field.rows);
      for(var i=0; i < this.field.rows; i++) {
        this.position[i] = new Array(this.field.cols).fill(0);
      }
    },
    updatePosition: function(position) {
      this.position = Array.from(position);
      // console.log(this.position);
    }
  },
  mounted: function() {
    this.initializePosition();
  },
  watch: {
    position: {
      handler: function(val) {
        this.$emit('fieldChange', val)
      },
      deep: true,
      immediate: true
    }
  }
}
</script>

<style>

</style>