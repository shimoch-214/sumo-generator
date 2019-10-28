<template>
  <label>
    <input type="checkbox"
      :name="name"
      :value="value"
      :friend="friend"
      :checked="value"
      @change="updateValue"
      :disabled="!(friend)"
    >
    <span></span>
  </label>
</template>

<script>
export default {
  name: "SumoCheckbox",
  props: {
    name: { type: String, required: true },
    value: { type: Boolean, required: true },
    friend: { type: Boolean, required: true}
  },
  data: function() {
    return {
    };
  },
  methods: {
    updateValue: function(e) {
      this.$emit("input", e.target.checked);
    }
  },
}
</script>

<style>

</style>