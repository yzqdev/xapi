// import ElementPlus from "element-plus";
// import "element-plus/dist/index.css";
import {createApp} from "vue";
import router from "./router";
import App from "./App.vue";
import "./index.scss";

import store from "@/store";
import dayjs from "dayjs";

const app = createApp(App);


app.config.globalProperties.$dayjs = dayjs;
app.use(router);
app.use(store);
app.mount("#app");
