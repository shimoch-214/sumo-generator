<template>
  <div>
    <div class="line-modifier"
    v-for="row in field.rows"
    :key="row"
    >
      <img :src="wallPath" alt="wall" class="wallimage"
      @click="exchangeImage"
      @dblclick="dblexchangeImage"
      v-for="col in field.cols"
      :width="Math.floor(field.width/field.cols)"
      height="auto"
      :key="col"
      :id="'r'+(row-1)+'c'+(col-1)"
      >
    </div>
  </div>
</template>

<script>
import 'images/wall.png'
import 'images/empty.png'

export default {
  name: 'Cell',
  props: {
    field: {
      rows: { type: Number, required: true },
      cols: { type: Number, required: true },
      width: { type: Number, required: true}
    },
  },
  data: function(){
    return {
      wallPath: require('images/wall.png'),
      emptyPath: require('images/empty.png'),
      editedPosition: [],
      oldField: {}
    }
  },
  methods: {
    exchangeImage: function(e) {
      var elSrc = e.target.getAttribute("src");
      var elId = e.target.getAttribute("id");
      elId = elId.split(/[a-z]/);
      elId.shift();
      var row = Number(elId[0]);
      var col = Number(elId[1]);
      // console.log(this.editedPosition)

      if(row == 0 || row == this.field.rows-1){
        return
      }
      if(col == 0 || col == this.field.cols-1){
        return
      }

      if(elSrc==this.wallPath){
        e.target.setAttribute("src", this.emptyPath);
        this.editedPosition[row][col] = 1;
      } else {
        e.target.setAttribute("src", this.wallPath);
        this.editedPosition[row][col] = 0;
      }
      this.emitPosition();
    },
    dblexchangeImage: function(e) {
      var elSrc = e.target.getAttribute("src");
      var elId = e.target.getAttribute("id");
      elId = elId.split(/[a-z]/);
      elId.shift();
      var row = Number(elId[0]);
      var col = Number(elId[1]);

      if (elSrc == this.wallPath) {
        var toSrc = this.emptyPath;
      } else {
        var toSrc = this.wallPath;
      }

      if(row == 0 || row == this.field.rows-1){
        return
      }
      if(col == 0 || col == this.field.cols-1){
        return
      }

      for (var i = -1; i < 2; i++) {
        if (row+i == 0 || row+i == this.field.rows-1) {
          continue;
        }
        for (var j = -1; j < 2; j++) {
          if (col+j == 0 || col+j == this.field.cols-1) {
            continue;
          } else {
            document.querySelector(`#r${row+i}c${col+j}`).setAttribute("src", toSrc);
            if (toSrc == this.wallPath) {
              this.editedPosition[row+i][col+j] = 0;
            } else {
              this.editedPosition[row+i][col+j] = 1;
            }
          }
        }
      }
      this.emitPosition();
    },
    emitPosition: function() {
      this.$emit('updatePosition', this.editedPosition)
    }
  },
  updated: function() {
    this.$nextTick(function(){
      if (this.field.rows == this.oldField.rows && this.field.cols == this.oldField.cols) {
        return
      }
      console.log("hoge")
      // フラグの初期化
      this.editedPosition = new Array(this.field.rows);
      for(var i=0; i < this.field.rows; i++) {
        this.editedPosition[i] = new Array(this.field.cols).fill(0);
      }
      // 画像の初期化
      for(var i = 0; i < this.field.rows; i++) {
        for(var j = 0; j < this.field.cols; j++) {
          document.querySelector(`#r${i}c${j}`).setAttribute("src", this.wallPath)
        }
      }
      // oldFieldの初期化
      this.oldField = Object.assign({}, this.field);
    })
  },
}
</script>


<style>
.wallimage {
  padding: 0;
  margin: 0;
  cursor: pointer;
}
.line-modifier {
  line-height: 0.8rem;
}
</style>