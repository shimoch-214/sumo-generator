import Vue from 'vue/dist/vue.esm.js'
// import axios from './plugins/vue_axios'
import router from './router/router'
import store from './store/user'
import SideNav from './components/sidenav'

// Vue.use(VueAxiosPlugin, {axios: axios})
// Vue.prototype.$http = axios.create()
// Vue.prototype.$http.interceptors.response.use((response) => {
//   if (response.headers['access-token']) {
//     const authHeaders = pick(response.headers, ["access-token", "client", "expiry", "uid", "token-type"])
//     store.commit('setAuth', authHeaders)
//     // var session = vueCookie.get('session')
//   //   var session = 
//   //   if ()
//   }
// })


var app = new Vue({
  router, 
  store,
  el: '#app',
  components: {
    'sidenav': SideNav
  },
})

