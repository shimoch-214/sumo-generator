<template>
  <input class="sumo-input"
    type="text"
    :name="name"
    :value="value"
    :friend="friend"
    :placeholder="placeholder"
    @input="updateValue"
    @change="changeValue"
    :disabled="!(friend) && name!='position'"
  >
</template>

<script>
export default {
  name: "SumoInput",
  props: {
    name: { type: String, required: true },
    value: { type: String, required: true },
    friend: { type: Boolean, required: true },
    placeholder: { type: String, required: false },
  },
  methods: {
    updateValue: function(e) {
      this.$emit("input", e.target.value);
    },
    changeValue: function(e) {
      this.$emit("change", [e.target.value, e.target.parentNode.parentNode.getAttribute('id')]);
    }
  }
}
</script>

<style>
</style>