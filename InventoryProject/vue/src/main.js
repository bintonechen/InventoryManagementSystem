import Vue from 'vue'
import App from './App.vue'
import router from './router'

import 'element-ui/lib/theme-chalk/index.css'
import ElementUI from 'element-ui'

import '@/assets/css/global.css'

import request from '@/utils/request'
// Vue.prototype.$request=request

Vue.use(ElementUI)

Vue.config.productionTip = false

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
