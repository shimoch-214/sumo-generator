import axios from '../plugins/devise_axios'
import Vue from 'vue/dist/vue.esm.js'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    auth: {},
    user: null
  },
  mutations: {
    setUser (state, user) {
      state.user = user
    },
    setAuth (state, auth) {
      state.auth = auth
    }
  },
  getters: {
    // user: (state) => state.user,
    // auth: (state) => state.auth
  },
  actions: {
    saveSession ({ state }) {
      localStorage.setItem('session', JSON.stringify(state.auth))
    },
    loadSession ({ commit }) {
      const session = localStorage.getItem('session')
      if (session) {
        commit('setAuth', JSON.parse(session))
      }
    }
  }
})