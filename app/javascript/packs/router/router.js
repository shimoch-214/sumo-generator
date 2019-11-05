import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import Home from '../components/home'
import HowTo from '../components/howtouse'
import Calculate from '../components/calculate'
import User from '../components/users/user'
import SignUp from '../components/users/signup'
import SignIn from '../components/users/signin'

Vue.use(VueRouter)

export default new VueRouter ({
  mode: 'history',
  routes: [
    { path: '/', component: Home },
    { path: '/how_to', component: HowTo },
    { path: '/users', component: User, children: [
      {
        path: 'signup', component: SignUp
      },
      {
        path: 'signin', component: SignIn
      },
    ]},
    { path: '/calculate', component: Calculate, children: [
      {
        path: ':sampleId', component: Calculate
      }, 
    ]},
  ],
})