import Vue from 'vue/dist/vue.esm.js'
import axios from 'axios'
import VueAxiosPlugin from './plugins/vue_axios'
import router from './router/router'
import store from './store/user'
import SideNav from './components/sidenav'

Vue.use(VueAxiosPlugin, {axios: axios})

var app = new Vue({
  router, 
  store,
  el: '#app',
  components: {
    'sidenav': SideNav
  },
})

