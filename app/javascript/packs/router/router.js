import Vue from 'vue/dist/vue.esm.js'
import VueRouter from 'vue-router'
import Home from '../components/home'
import HowTo from '../components/howtouse'
import Calculate from '../components/calculate'

Vue.use(VueRouter)

export default new VueRouter ({
  mode: 'history',
  routes: [
    { path: '/', component: Home },
    { path: '/how_to', component: HowTo },
    { path: '/calculate', component: Calculate, children: [
        { path: ':sampleId', component: Calculate }, 
    ]},
  ],
})