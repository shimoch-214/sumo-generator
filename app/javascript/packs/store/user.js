import axios from 'axios'
import Vue from 'vue/dist/vue.esm.js'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    auth: {
      token: null,
      userId: null
    },
    current_user: null
  },
  mutations: {
    
  },
  getters: {

  },
  actions: {

  }
})