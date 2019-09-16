<template>
  <label>
    <input type="checkbox"
      :name="name"
      :value="value"
      :friend="friend"
      :checked="(value)? true: false"
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
      if(e.target.checked) {
        this.$emit("input", true);
      } else {
        this.$emit("input", false);
      }
    }
  },
}
</script>

<style>

</style>