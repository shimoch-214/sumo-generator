<template>
  <div>
    <button @click="createUser">hoge</button>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      sample: {
        email: "example@example.com",
        password: "password",
        password_confirmation: "password",
        // name: "daiya",
      }
    }
  },
  methods: {
    createUser: function() {
      axios.post('/api/auth/sign_in', this.sample)
      .then((response) => {
        console.log(response)
      }, (error) => {
        console.log(error)
      })
    }
  }
}
</script>

<style>

</style>