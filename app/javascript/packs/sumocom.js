import Vue from 'vue/dist/vue.esm.js'
import axios from 'axios'
import VueAxiosPlugin from './plugins/vue_axios'
import Router from './router/router'
import SideNav from './components/sidenav'

Vue.use(VueAxiosPlugin, {axios: axios})

var app = new Vue({
  router: Router, 
  el: '#app',
  components: {
    'sidenav': SideNav
  },
  watch: {
    '$route': function(to, from) {
      console.log(to)
      console.log(from)
    }
  }
})

