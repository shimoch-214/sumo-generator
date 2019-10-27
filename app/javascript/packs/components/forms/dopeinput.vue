<template>
  <input 
    type="text"
    :name="name"
    :value="value"
    :friend="friend"
    :disabled="!(friend)"
    @input="updateValue"
    @change="checkValue"
  >
</template>

<script>
export default {
  name: "DopeInput",
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
      var dope = e.target.value;
      if (dope == '') {
        e.target.value = 0;
      }
      if (!/^([1-9][0-9]*|0)$/.test(dope) && dope != '') {
        alert('ドープは0以上です')
        e.target.value = 0;
      }
      this.$emit("input", e.target.value);
    },
  },
}
</script>

<style>
</style>