<template>
  <div class="input-field">
    <select
      :name="name"
      :friend="friend"
      @change="updateValue"
      class="browser-default"
      :disabled="!(friend)"
      :value="value"
      >
      <option
        :value="value"
        v-if="!friend"
      >
        タネすも
      </option>
      <option
        v-for="(option,index) in options"
        :value="option.value"
        :key="index"
      >
        {{ option.label }}
      </option>
    </select>
  </div>
</template>

<script>
export default {
  name: "TribeSelect",
  props: {
    name: { type: String, required: true },
    value: { required: true },
    options: { type: Array, required: true },
    friend: { type: Boolean, required: true }
  },
  methods: {
    updateValue: function(e) {
      this.$emit("input", e.target.value);
      this.$emit('change', [e.target.value, e.target.parentNode.parentNode.parentNode.getAttribute('id')])
    },
  },
}
</script>

<style>

</style>