<template>
  <div class="admin-home">
    <section class="home-index">
      <article class="left">
        <el-scrollbar style="height: 100%"
          ><el-menu
            router
            background-color="#545c64"
            text-color="#fff"
            active-text-color="#ffd04b"
style="height: 100vh;"

            mode="vertical"
          >
            <template v-for="item in menus">
              <template v-if="item.Child">
                <el-menu-item-group
                  :index="item.Id"
                  :key="item.Id"
                  v-if="item.Status"
                >
                  <template slot="title">
                    <span>{{ item.Title }}</span>
                  </template>
                  <template v-for="subItem in item.Child">
                    <el-submenu
                      v-if="subItem.Child"
                      :index="subItem.Id"
                      :key="subItem.Id"
                    >
                      <template slot="title">{{ subItem.Title }}</template>
                      <el-menu-item
                        v-for="(threeItem, i) in subItem.Child"
                        :key="threeItem.Id"
                        :index="threeItem.Path"
                      >
                        <span>{{ threeItem.Title }}</span>
                      </el-menu-item>
                    </el-submenu>
                    <el-menu-item
                      v-else
                      :index="subItem.Path"
                      :key="subItem.Id"
                    >
                      <span slot="title">{{ subItem.Title }} </span>
                    </el-menu-item>
                  </template>
                </el-menu-item-group>
              </template>
              <template v-else>
                <el-menu-item :index="item.Path" :key="item.Id">
                  <span slot="title">{{ item.Title }}</span>
                </el-menu-item>
              </template>
            </template>
          </el-menu></el-scrollbar
        >
      </article>

      <article class="right">
        <header class="admin-header">
          <a class="logo">GO语言中文网管理后台</a>
          <el-popover trigger="click">
            <article class="pop-user">
              <el-image
                thumbnail
                src="https://avatar-static.segmentfault.com/271/671/2716710913-58f6132c92807_big64"
              />
              <article class="pop-user-right">
                <article>{{ username + `  ` }}{{ email }}</article>
                <article v-for="item in popList">
                  <el-link @click="gotoRoute(item.name)">{{ item.txt }}</el-link>
                </article>
              </article>
            </article>
            <a class="user-name" slot="reference"
              ><el-image :src="userImage"></el-image> {{ username }}</a
            >
          </el-popover>
        </header>
        <router-view />
      </article>
    </section>
  </div>
</template>

<script lang="ts">
// 课题列表
import { Component, Vue, Prop } from "vue-property-decorator";
import { getIndex } from "@/plugins/apis/account";

@Component({
  components: {},
})
export default class AdminHome extends Vue {
  popList: any[] = [
    { name: "home", txt: "个人首页" },
    { name: "home", txt: "个人资料设置" },
    { name: "Login", txt: "退出" },
  ];
  showMenu: boolean = false;
  showSubMenu: boolean = false;
  menus: any[] = [
    {
      txt: "用户管理",
      subMenu: [
        { txt: "权限管理", path: "" },
        { txt: "权限管理" },
        { txt: "权限管理" },
      ],
    },
    {
      txt: "社区管理",
      subMenu: [{ txt: "权限管理" }, { txt: "权限管理" }, { txt: "权限管理" }],
    },
    {
      txt: "抓取管理",
      subMenu: [{ txt: "权限管理" }, { txt: "权限管理" }, { txt: "权限管理" }],
    },
  ];
  username: string = "yzq";
  userImage: string = "";
  email: string = "yzqdev@outlook.com";
  website: any = "";
  gotoRoute(name:string){
    this.$router.push({name:name})
  }
  created() {
    getIndex().then((res: any) => {
      console.log(res);
      this.menus = res.menu;
      this.website = res.website;
      if (res.status == 200) {
        this.$message.success(res.message);
      }
    });
  }
}
</script>

<style lang="scss" scoped>
.admin-home {
  height: 100%;
  .admin-header {
    background-color: #ccc;
    padding: 1rem;
    display: grid;
    grid-template-columns: 9fr 1fr;
    .user-name {
      cursor: pointer;
    }
    .logo {
      cursor: pointer;
    }
  }
}
::v-deep.home-index {
  display: grid;
  grid-template-columns: 1fr 5fr;
  .left {
    height: 100%;

  }
  .right {
    width: 100%;
    height: 100%;
  }
}
.pop-user {
  width: 20rem;
  height: 6rem;
  display: flex;

  .pop-user-right {
    display: flex;
    flex: 1;
    flex-direction: column;
  }
}
</style>
