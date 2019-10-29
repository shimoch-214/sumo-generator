<template>
  <div>
    <div
      class="fieldrow"
      v-for="row in 12"
      :key="row"
    >
      <div
        @contextmenu="dblexchangeImage"
        @click="exchangeImage"
        v-for="col in 12"
        :key="col"
        :id="'r'+(row-1)+'c'+(col-1)"
        :style="style"
        :class="setClass(row, col)"
      >
        <p v-if="row-1==0">{{col-1}}</p>
        <p v-if="col-1==0 && row-1!=0">{{row-1}}</p>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  name: 'Cell',
  props: {
    field: { type: Array, required: true }
  },
  data: function(){
    return {
      cellLength: 0,
      style: "",
      editedField: [],
    }
  },
  methods: {
    exchangeImage: function(e) {
      // cellのid取得
      var elId = e.target.getAttribute("id");
      elId = elId.split(/[a-z]/);
      elId.shift();
      var row = Number(elId[0]);
      var col = Number(elId[1]);

      if(row == 0 || row == 11){
        return
      }
      if(col == 0 || col == 11){
        return
      }
      if (this.editedField[row][col]==0) {
        this.editedField[row][col] = 1;
      } else {
        this.editedField[row][col] = 0;
      }
      this.emitField();
    },
    dblexchangeImage: function(e) {
      e.preventDefault();
      // cellのidを取得
      var elId = e.target.getAttribute("id");
      elId = elId.split(/[a-z]/);
      elId.shift();
      var row = Number(elId[0]);
      var col = Number(elId[1]);
      var flag = this.editedField[row][col];
      if(row == 0 || row == 11){
        return
      }
      if(col == 0 || col == 11){
        return
      }
      for (var i = -1; i < 2; i++) {
        if (row+i == 0 || row+i == 11) {
          continue;
        }
        for (var j = -1; j < 2; j++) {
          if (col+j == 0 || col+j == 11) {
            continue;
          } else {
            if (flag == 1) {
              this.editedField[row+i][col+j] = 0;
            } else {
              this.editedField[row+i][col+j] = 1;
            }
          }
        }
      }
      this.emitField();
    },
    emitField: function() {
      this.$emit('updateField', this.editedField)
    },
    getComponentSize: function() {
      var width = this.$el.clientWidth;
      this.cellLength = Math.floor(width/12)
      this.setStyle();
    },
    setStyle: function() {
      this.style = `
        width: ${this.cellLength}px;
        height: ${this.cellLength}px;
        line-height: ${this.cellLength}px;`
    },
    setClass: function(row, col) {
      if (this.field[row-1][col-1]) {
        return "cells empty"
      } else {
        return "cells wall"
      }
    },
    geteditedField: function() {
      this.editedField = new Array(12);
      for(var i=0; i < 12; i++) {
        this.editedField[i] = Array.from(this.field[i]);
      }
    }
  },
  updated: function() {
    this.geteditedField();
  },
  mounted: function() {
    this.geteditedField();
    this.getComponentSize();
    window.addEventListener('resize', this.getComponentSize);
  }
}
</script>


<style>
.fieldrow {
  display: flex;
}
.cells {
  box-sizing: border-box;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 1px solid gray;
  cursor: pointer;
}

.wall {
  background-color: rgba(6, 3, 163, 0.685);
  color: rgba(216, 212, 221, 0.644)
}
.empty {
  background-color: rgba(216, 212, 221, 0.644);
  color: rgba(6, 3, 163, 0.685);
  font-size: 1.4vw;
}

.line-modifier {
  line-height: 0.8rem;
}
</style>