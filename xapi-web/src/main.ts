import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
Vue.use(ElementUI)
import http from "@/plugins/FetchApi";
// Install BootstrapVue
import dayjs from "dayjs";
import 'dayjs/locale/zh-cn'
dayjs.locale('zh-cn')
Vue.prototype.$dayjs=dayjs
Vue.prototype.$http = http;
Vue.config.productionTip = false;

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");
