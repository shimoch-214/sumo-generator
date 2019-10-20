<template>
  <div>
    <div
      class="fieldrow"
      v-for="row in fieldData.rows"
      :key="row"
    >
      <div
        class="cells wall"
        @contextmenu="dblexchangeImage"
        @click="exchangeImage"
        v-for="col in fieldData.cols"
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
    fieldData: {
      rows: { type: Number, required: true },
      cols: { type: Number, required: true },
    },
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

      if(row == 0 || row == this.fieldData.rows-1){
        return
      }
      if(col == 0 || col == this.fieldData.cols-1){
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

      if(row == 0 || row == this.fieldData.rows-1){
        return
      }
      if(col == 0 || col == this.fieldData.cols-1){
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
        if (row+i == 0 || row+i == this.fieldData.rows-1) {
          continue;
        }
        for (var j = -1; j < 2; j++) {
          if (col+j == 0 || col+j == this.fieldData.cols-1) {
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
      this.cellLength = Math.floor(width/this.fieldData.cols)
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
      this.editedField = new Array(this.fieldData.rows);
      for(var i=0; i < this.fieldData.rows; i++) {
        this.editedField[i] = new Array(this.fieldData.cols).fill(0);
      }
    }
  },
  updated: function() {
    this.$nextTick(function(){
      if (this.fieldData.rows == this.oldField.rows && this.fieldData.cols == this.oldField.cols) {
        return
      } 

      // フラグの初期化
      this.geteditedField();

      // cellサイズの変更
      this.getComponentSize();

      // cell背景の初期化
      for (var i=0; i<this.fieldData.rows; i++) {
        for (var j=0; j<this.fieldData.cols; j++) {
          var classes = document.querySelector(`#r${i}c${j}`).classList
          if (classes.contains("empty")) {
            classes.remove("empty");
            classes.add("wall");
          }
        }
      }

      // oldFieldの初期化
      this.oldField = Object.assign({}, this.fieldData);
    })
  },
  mounted: function() {
    // フラグの初期化
    this.geteditedField()
    // oldFieldの初期化
    this.oldField = Object.assign({}, this.fieldData);
    // cellLengthの初期化
    this.getComponentSize();
    // 画面リサイズをリスナーに登録
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