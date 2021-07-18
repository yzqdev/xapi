import Vue from "vue";
import VueRouter, { RouteConfig } from "vue-router";
import Home from "../views/Home.vue";

import Index from "@/views/Index.vue";
import Register from "@/views/Register.vue";
import Login from "@/views/Login.vue";
import AdminHome from "@/views/admin/AdminHome.vue";
import AdminIndex from "@/views/admin/AdminIndex.vue";
import MyApps from "@/views/MyApps.vue";
import UnixTime from "@/components/UnixTime.vue";
import JsonFormat from "@/components/JsonFormat.vue";
import Project from "@/components/Project.vue";

Vue.use(VueRouter);

const routes: Array<RouteConfig> = [
  {
    path: "/",
    redirect: "/admin",
  },
  { path: "/register", name: "Register", component: Register },
  { path: "/login", name: "Login", component: Login },
  {
    path: "/admin",
    name: "Home",
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: AdminHome,
    children: [
      { path: "/", name: "AdminIndex", component: AdminIndex },
      { path: "/project", name: "Project", component: Project },
      {
        path: "/apps",
        name: "MyApps",
        component: MyApps,
      },
      { path: "/unix", name: "UnixTime", component: UnixTime },
      { path: "/json-format", name: "JsonFormat", component: JsonFormat },
    ],
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

export default router;