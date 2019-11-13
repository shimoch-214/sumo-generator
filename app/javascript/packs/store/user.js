import axios from '../plugins/devise_axios'
import Vue from 'vue/dist/vue.esm.js'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    data: null
  },

  getters: {
    data(state) {
      return state.data
    }
  },

  mutations: {
    setUser (state, data) {
      state.data = data
    }
  },

  actions: {
    signIn ({ commit }, { email, password }) {
      axios.post('/api/auth/sign_in', { email: email, password: password })
        .then((response) => {
          commit('setUser', response.data)
        }, (error) => {
          commit('setUser', null)
        })
    },
    signUp ({ commit }, { email, password }) {
      axios.post('/api/auth', { email, password })
        .then((response) => {
          console.log(response)
          commit('setUser', response.data)
        }, (error) => {
          console.log(error)
          commit('setUser', null)
        })
    }
  }
})