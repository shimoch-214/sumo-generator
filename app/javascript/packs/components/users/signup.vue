<template>
  <div>
    <form>
      <label for="email"></label>
      <input type="text" v-model="email" id="email" placeholder="email">
      <label for="password"></label>
      <input type="text" v-model="password" id="password" placeholder="password">
      <label for="password_confirmation"></label>
      <input type="text" v-model="password_confirmation" id="password_confirmation" placeholder="password_confirmation">
    </form>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      email: "",
      password: "",
      password_confirmation
    }
  },
  methods: {
  }
}
</script>

<style>

</style>