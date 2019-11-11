<template>
  <form>
    <label for="email"></label>
    <input type="text" v-model="email" id="email" placeholder="email">
    <label for="password"></label>
    <input type="text" v-model="password" id="password" placeholder="password">
    <label for="password_confirmation"></label>
    <input type="text" v-model="password_confirmation" id="password_confirmation" placeholder="password_confirmation">
    <button class="btn" @click="clickAction">{{ name }}</button>
  </form>
</template>

<script>
export default {
  props: {
    name: { type: String, required: true },
    clickAction: { type: Function, required: true }
  },
  data() {
    return {
      email: '',
      password: '',
      password_confirmation: ''
    }
  }
}
</script>

<style>

</style>