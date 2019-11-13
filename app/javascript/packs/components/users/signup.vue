<template>
  <div class="row">
    <div class="col s8 offset-s2">
      <h2>Sign Up</h2>
      <UserForm
        :name="'sign up'"
        @clickAction="signUp"
      ></UserForm>
    </div>
  </div>
</template>

<script>
import UserForm from './userform'

export default {
  components: {
    UserForm
  },
  methods: {
    signUp (data) {
      this.$store.dispatch('signUp', data)
    }
  }
}
</script>

<style>

</style>