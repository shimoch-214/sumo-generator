<template>
  <div class="row">
    <div class="col s8 offset-s2">
      <h2>Sign In</h2>
      <UserForm
        :name="'sign in'"
        :clickAction="signIn"
      ></UserForm>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import UserForm from './userform'

export default {
  components: {
    UserForm
  },
  methods: {
    signIn () {

    }
  }
}
</script>

<style>

</style>