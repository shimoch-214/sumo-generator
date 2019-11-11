<template>
  <div class="row">
    <div class="col s8 offset-s2">
      <h2>Sign Up</h2>
      <UserForm
        :name="'sign up'"
        :clickAction="signUp"
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
    signUp (e) {
      e.preventDefault()
      axios.post('/api/registrations', )
    }
  }
}
</script>

<style>

</style>