<template>
  <div class="about">
    <div class="apps" v-if="showApps">
      <article v-for="item in apps" class="app-card">
        <div class="app-card-top">
          <article class="app-card-top__title">{{ item.title }}</article>
        </div>
        <div class="app-card-bottom">
          <article class="app-card-bottom__title">{{ item.desc }}</article>
          <article>
            <button class="look" @click="gotoApp(item.name)">查看</button>
          </article>
        </div>
      </article>
    </div>
  </div>
</template>
<script setup lang="ts">
import UnixTime from "@/components/UnixTime.vue";
import {useRouter} from "vue-router";
 let  showApps: boolean = $ref(true);
 let router=useRouter()
 let apps: any[] = $ref([
    {
      title: "JSON格式化",
      desc: "JSON格式化,压缩",
      path: "",
      name: "JsonFormat",
    },
    { title: "JSON转XML", desc: "JSON/XML互转", path: "", name: "" },
    {
      title: "时间戳转换",
      desc: "UNIX时间戳普通时间相互转换",
      path: "",
      name: "UnixTime",
    },
    { title: "4", desc: "4", path: "", name: "" },
    { title: "", desc: "", path: "", name: "" },
  ]);
 let unixTimeShow: boolean =  $ref(false);
 function gotoApp(name: string) {
    showApps = false;
     router.push({ name: name });
  }

</script>
<style lang="scss">
.about {
  .apps {
    display: flex;
    flex-wrap: wrap;
    .app-card {
      margin: 2rem;
      width: 15rem;
      background-color: #ccc;
      border-radius: 0.5rem;
      height: 12rem;
      display: grid;
      grid-template-rows: 1fr 1fr;
      .app-card-top {
        border-radius: 0.5rem 0.5rem 0 0;
        background-color: #23b7e5;
        display: flex;
        justify-content: center;
        align-items: center;
        .app-card-top__title {
          color: white;
          font-size: 1.8rem;
        }
      }
      .app-card-bottom {
        display: flex;
        justify-content: center;
        align-items: center;
        .look {
          all: unset;
          border: 1px solid grey;
          padding: 0.2rem 0.4rem;
          cursor: pointer;
          border-radius: 0.3rem;
          transition: all 0.3s;
          &:hover {
            background-color: #c2b2b2;
            color: white;
          }
        }
        .app-card-bottom__title {
          width: 60%;
          font-size: 1.1rem;
        }
      }
    }
  }
  .app-single {
    padding: 5rem;
  }
}
</style>
