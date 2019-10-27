<template>
  <div>
    <div
      class="fieldrow"
      v-for="row in 12"
      :key="row"
    >
      <div
        class="cells wall"
        @contextmenu="dblexchangeImage"
        @click="exchangeImage"
        v-for="col in 12"
        :key="col"
        :id="'r'+(row-1)+'c'+(col-1)"
        :style="style"
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
  },
  data: function(){
    return {
      cellLength: 0,
      style: "",
      editedField: [],
      oldField: {}
    }
  },
  methods: {
    exchangeImage: function(e) {
      // cellのクラスを取得
      var elClass = e.target.classList

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

      if (elClass.contains("wall")) {
        elClass.remove("wall");
        elClass.add("empty");
        this.editedField[row][col] = 1;
      } else {
        elClass.remove("empty");
        elClass.add("wall");
        this.editedField[row][col] = 0;
      }

      this.emitField();
    },
    dblexchangeImage: function(e) {
      e.preventDefault();

      // cellのクラスを取得
      var elClass = e.target.classList;

      // cellのidを取得
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

      if ((elClass.contains("wall"))) {
        var fromClass = "wall"
        var toClass = "empty";
      } else {
        var fromClass = "empty"
        var toClass = "wall";
      }

      for (var i = -1; i < 2; i++) {
        if (row+i == 0 || row+i == 11) {
          continue;
        }
        for (var j = -1; j < 2; j++) {
          if (col+j == 0 || col+j == 11) {
            continue;
          } else {
            document.querySelector(`#r${row+i}c${col+j}`).classList.remove(fromClass);
            document.querySelector(`#r${row+i}c${col+j}`).classList.add(toClass);
            if (toClass == "wall") {
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
        line-height: ${this.cellLength}px;
      `
    },
    geteditedField: function() {
      this.editedField = new Array(12);
      for(var i=0; i < 12; i++) {
        this.editedField[i] = new Array(12).fill(0);
      }
    }
  },
  updated: function() {
    this.$nextTick(function(){

      // フラグの初期化
      this.geteditedField();
      // サイズの取得
      this.getComponentSize();

      // cell背景の初期化
      for (var i=0; i<12; i++) {
        for (var j=0; j<12; j++) {
          var classes = document.querySelector(`#r${i}c${j}`).classList
          if (classes.contains("empty")) {
            classes.remove("empty");
            classes.add("wall");
          }
        }
      }
    })
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
}

.line-modifier {
  line-height: 0.8rem;
}
</style>