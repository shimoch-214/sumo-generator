<template>
  <input 
    type="text"
    :name="name"
    :value="value"
    :friend="friend"
    placeholder="m,n"
    @change="changeValue"
    @input="updateValue"
  >
</template>

<script>
export default {
  name: "PositionInput",
  props: {
    name: { type: String, required: true },
    value: { type: String, required: true },
    friend: { type: Boolean, required: true },
  },
  methods: {
    updateValue: function(e) {
      this.$emit("input", e.target.value)
    },
    changeValue: function(e) {
      this.$emit("change", [e.target.value, e.target.parentNode.parentNode.getAttribute('id')])
    },
  },
}
</script>

<style>
</style>