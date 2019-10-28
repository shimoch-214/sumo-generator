<template>
  <div class="row">
    <nav class="grey lighten-2">
      <div class="nav-wrapper">
        <div class="col s12 m10 offset-m1">
          <span class="brand-logo black-text">sumo generator</span>
        </div>
      </div>
    </nav>
    <div class="col s8 offset-s2" style="padding-top: 40px;">
      <div id="field" class="col s12 m8">
        <Cell
          @updateField="updateField($event)"
        ></Cell>
      </div>
      <div class="col s12 m4">
        <div class="input-field">
          <input type="text" id="cols" v-model="turns" placeholder="ターン数">
          <label for="cols">Turns</label>
        </div>
        <div class="input-field">
          <input type="text" id="cols" v-model="times" placeholder="試行回数">
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
import Cell from './cells/cell_modify'
import Vue from 'vue/dist/vue.esm.js'

export default {
  components: {
    Cell,
  },
  data: function() {
    return {
      field: [],
      turns: "1000",
      times: "100",
    }
  },
  methods: {
    initializeField: function() {
      this.field = new Array(12);
      for(var i=0; i < 12; i++) {
        this.field[i] = new Array(12).fill(0);
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