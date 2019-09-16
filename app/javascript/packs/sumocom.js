import Vue from 'vue/dist/vue.esm.js'
import axios from 'axios'
import VueAxiosPlugin from './plugins/vue_axios'
import Calculate from './components/calculate'

Vue.use(VueAxiosPlugin, {axios: axios})

var app = new Vue({
  el: '#app',
  components: {
    'calculate': Calculate,
  }
})

