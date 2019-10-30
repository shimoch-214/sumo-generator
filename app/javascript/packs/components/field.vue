<template>
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
          :field="field"
          :monsterForms="monsterForms"
          @updateField="updateField($event)"
        ></Cells>
      </div>
      <div class="col s12 m4">
        <div class="input-field">
          <input type="text" id="cols" v-model="turnsInput" placeholder="ターン数">
          <label for="cols" class='active'>Turns</label>
        </div>
        <div class="input-field">
          <input type="text" id="cols" v-model="timesInput" placeholder="試行回数">
          <label for="cols" class='active'>Times</label>
        </div>
        <div class="btn" @click="submitData">
          Simulate!!
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Cells from './cells/cell_modify'
import Vue from 'vue/dist/vue.esm.js'

export default {
  components: {
    Cells,
  },
  props: {
    field: { type: Array, required: true },
    monsterForms: { type: Array, required: true },
    turns: { type: String, required: true },
    times: { type: String, required: true }
  },
  methods: {
    updateField: function(value) {
      this.$emit('fieldChange', value)
    },
    submitData: function(e) {
      this.$emit('runCalculate')
    }
  },
  computed: {
    turnsInput: {
      get: function() {
        return this.turns
      },
      set: function(value) {
        this.$emit('turnsInput', value)
      }
    },
    timesInput: {
      get: function() {
        return this.times
      },
      set: function(value) {
        this.$emit('timesInput', value)
      }
    }
  }
}
</script>

<style>

</style>