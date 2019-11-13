<template>
  <form>
    <label for="email"></label>
    <input type="text" v-model="form.email" id="email" placeholder="email">
    <label for="password"></label>
    <input type="text" v-model="form.password" id="password" placeholder="password">
    <label for="password_confirmation"></label>
    <input type="text" v-model="form.password_confirmation" id="password_confirmation" placeholder="password_confirmation">
    <button class="btn" @click="clickAction">{{ name }}</button>
  </form>
</template>

<script>
export default {
  props: {
    name: { type: String, required: true },
  },
  data() {
    return {
      form: {
        email: '',
        password: '',
        password_confirmation: ''
      }
    }
  },
  methods: {
    clickAction (e) {
      e.preventDefault()
      return this.$emit('clickAction', this.form)
    }
  }
}
</script>

<style>

</style>