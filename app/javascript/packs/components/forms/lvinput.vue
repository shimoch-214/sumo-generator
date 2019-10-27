<template>
  <input 
    type="text"
    :name="name"
    :value="value"
    :friend="friend"
    placeholder="1~99"
    :disabled="!(friend)"
    @input="updateValue"
    @change="checkValue"
  >
</template>

<script>
export default {
  name: "LvInput",
  props: {
    name: { type: String, required: true },
    value: { type: String, required: true },
    friend: { type: Boolean, required: true },
  },
  methods: {
    updateValue: function(e) {
      this.$emit("input", e.target.value);
    },
    checkValue: function(e) {
      var lv = e.target.value;
      if (/[1-9]|[1-9][0-9]/.test(lv) && lv != 0) {
        alert('Lvは1~99の間です')
        e.target.value = '';
        this.$emit("input", e.target.value);
      }
    },
  },
}
</script>

<style>
</style>