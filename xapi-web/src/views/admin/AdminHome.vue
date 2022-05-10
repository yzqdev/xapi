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
              <template v-if="item.child">
                <el-menu-item-group
                  :index="item.id"
                  :key="item.id"
                  v-if="item.status"
                >
                  <template #title >
                    <span>{{ item.title }}</span>
                  </template>
                  <template v-for="subItem in item.child">
                    <el-sub-menu
                      v-if="subItem.child"
                      :index="subItem.id"
                      :key="subItem.id"
                    >
                      <template #title >{{ subItem.title }}</template>
                      <el-menu-item
                        v-for="(threeItem, i) in subItem.child"
                        :key="threeItem.id"
                        :index="threeItem.path"
                      >
                        <span>{{ threeItem.title }}</span>
                      </el-menu-item>
                    </el-sub-menu>
                    <el-menu-item
                      v-else
                      :index="subItem.path"
                      :key="subItem.id"
                    >
                      <template  #title>{{ subItem.title }} </template>
                    </el-menu-item>
                  </template>
                </el-menu-item-group>
              </template>
              <template v-else>
                <el-menu-item :index="item.path" :key="item.id">
                  <template #title>{{ item.title }}</template>
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

<script setup lang="ts">
// 课题列表
import { getIndex } from "@/plugins/apis/account";
import {useRouter} from "vue-router";
import {onMounted} from "vue";
import {ElMessage} from "element-plus";
let router=useRouter()
 let popList: any[] = $ref([
    { name: "home", txt: "个人首页" },
    { name: "home", txt: "个人资料设置" },
    { name: "Login", txt: "退出" },
  ]);
 let showMenu: boolean = $ref(false);
 let showSubMenu: boolean = $ref(false);
 let menus: any[] = $ref([
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
  ]) ;
 let username: string = $ref("yzq");
 let userImage: string =  $ref('');
 let email: string = $ref("yzqdev@outlook.com");
 let website: any = $ref('');
 function gotoRoute(name:string){
     router.push({name:name})
  }
  onMounted(() => {
    getIndex().then((res: any) => {
      console.log(res);
      menus = res.menu;
      website = res.website;
      if (res.status == 200) {
         ElMessage({
           type:'success'
           ,message:res.message
         })
      }
    });
  })
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
