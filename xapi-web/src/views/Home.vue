<template>
  <div class="home">
    <el-menu
      mode="horizontal"
      background-color="#545c64"
      text-color="#fff"
      active-text-color="#ffd04b"
    >
      <el-menu-item @click="gotoLink(`Index`)"
        ><el-image class="logo" :src="logo"></el-image
      ></el-menu-item>

      <el-menu-item
        v-for="item in routesLink"
        :index="item.path"
        @click="gotoLink(item.name)"
      >
        {{ item.txt }}
      </el-menu-item>
      <el-submenu index="2">
        <template slot="title">晨读</template>
        <el-menu-item index="">go晨读</el-menu-item>
        <el-menu-item index="">综合晨读</el-menu-item>
      </el-submenu>

        <el-menu-item class="login-btn" @click="gotoLink(`Login`)"> 登录 </el-menu-item
        ><el-menu-item class="signin" @click="gotoLink(`Register`)"> 注册 </el-menu-item>
    </el-menu>
    <section>
      <section class="home-main">
        <article class="main-left">
          <el-card>
            <el-breadcrumb separator="/" v-if="$route.name !== 'Index'"
              ><el-breadcrumb-item v-for="item in items" :to="item.path">{{
                item.text
              }}</el-breadcrumb-item></el-breadcrumb
            >
            <router-view />
          </el-card>
        </article>
        <article class="main-right">
          <el-card>
            <article class="user-div">
              <img class="user-img" :src="userImg" />
              <div class="user-right">
                <article>{{ username }}</article>
                <article>个人资料设置</article>
              </div>
            </article>
            <article class="btn-class">
              <el-button
                type="primary"
                v-for="item in btns"
                @click="gotoLink(item.name)"
                variant="success"
                >{{ item.txt }}</el-button
              >
            </article>
            <article class="user-message">
              <el-link>{{ msgNum }}条未读消息</el-link>
              <el-link>钱</el-link>
            </article>
          </el-card>
        </article>
      </section>
    </section>
    <footer class="footer">
      <article class="footer-first">
        <article class="footer-links">
          <el-link v-for="item in footerLinks" href="">{{ item.txt }}</el-link>
        </article>
        <article class="online-people">
          {{ peopleNum }}在线<span>最高记录</span>
        </article>
      </article>
      <article class="copyright">
        ©2013-2020 {{ domain }} {{ siteName }}，中国 Golang
        社区，致力于构建完善的 Golang 中文社区，Go语言爱好者的学习家园。 Powered
        by StudyGolang(Golang + MySQL) • · CDN 采用 七牛云
      </article>

      <article class="version">
        VERSION: V4.0.0 · 221.358962ms · 为了更好的体验，本站推荐使用 Chrome 或
        Firefox 浏览器
      </article>
    </footer>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Watch } from "vue-property-decorator";
import HelloWorld from "@/components/HelloWorld.vue";
import { friendLinks } from "@/plugins/apis/friends"; // @ is an alias to /src

@Component({
  components: {
    HelloWorld,
  },
})
export default class Home extends Vue {
  logo: string =
    "https://s3.pstatp.com/toutiao/xitu_juejin_web/img/logo.a7995ad.svg";
  peopleNum: number = 1234;
  items = [
    {
      text: "每日医学",
      href: "#",
    },
    {
      text: "问与答",
      href: "#",
    },
    {
      text: "go实战",
      active: true,
    },
  ];
  footerLinks: any[] = [
    { name: "About", path: "/about", txt: "关于" },
    { name: "FAQ", path: "/faq", txt: "FAQ" },
    { name: "Weekly", path: "/weekly", txt: "晨读" },
    { name: "Github", path: "/github", txt: "github" },
    { name: "Github", path: "/github", txt: "github" },
    { name: "Github", path: "/github", txt: "github" },
    { name: "Github", path: "/github", txt: "github" },
  ];
  routesLink: any[] = [
    { name: "Topics", txt: "主题", path: "/topics" },
    { name: "Articles", txt: "文章", path: "/articles" },

    { name: "Projects", txt: "项目", path: "/projects" },
    { name: "Resources", txt: "资源", path: "/resources" },
    { name: "Weekly", txt: "Go周刊", path: "/weekly" },
  ];
  btns: any[] = [
    { txt: "发布主题", path: "/topics/new", name: "NewTopic" },
    { txt: "撰写文章", path: "/articles/new", name: "NewArticle" },
    { txt: "分享资源", path: "/resource/new", name: "NewResource" },
  ];
  msgNum: number = 3;
  hasLogin: boolean = false;
  username: string = "yzqdev";
  @Watch("$route")
  watchRoute(newVal: string) {}
  gotoLink(name: string) {
    this.$router.push({ name: name });
  }
  domain: string = "";
  siteName: string = "";
  created() {
    friendLinks().then((res) => {
      this.domain = res.data[0].url;
      this.siteName = res.data[0].name;
    });
  }
  userImg: string =
    "https://avatars0.githubusercontent.com/u/20037151?v=4&s=80";
}
</script>

<style lang="scss" scoped>
.logo {
}
.home{
  .login-btn{
    float: right;
  }
  .signin{
    float: right;
  }
}
.home-main {
  width: 100%;
  margin-top: 1rem;
  display: grid;

  grid-template-columns: 3fr 1fr;
  grid-gap: 2rem;
  .main-left {
  }
  .main-right {
  }
  .user-message {
    margin-top: 1rem;
    display: grid;
    grid-template-columns: 1fr 1fr;
    width: 100%;
  }
  .btn-class {
    margin-top: 1rem;
    display: grid;
    grid-gap: 1rem;
    grid-template-columns: 1fr 1fr 1fr;
    width: 100%;
  }
  .user-div {
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    .user-img {
      border-radius: 50%;
    }
    .user-right {
      display: flex;
      flex-direction: column;
      justify-content: left;
    }
  }
}
.footer {
  padding: 2rem 4rem;
  background-color: #e2e2e2;
  .footer-first {
    display: flex;

    .footer-links {
      flex: 1;
      display: grid;
      grid-template-columns: repeat(7, 1fr);
      grid-gap: 1rem;
    }
  }
  .copyright {
    color: #534545;
  }
  .version {
    color: #3e3434;
  }
}
</style>
