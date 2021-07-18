<template>
  <div class="unix-time">
    <h3>UNIX时间戳普通时间相互转换</h3>
    <el-form :model="form">
      <el-form-item label="unix时间戳(单位秒)"
        ><el-input v-model="form.unix"></el-input>
      </el-form-item>
      <article class="transfer-btn">
        <el-button type="primary" @click="toCommon"
          >转为普通日期<i class="el-icon-bottom"></i> </el-button
        ><el-button type="primary" @click="toUnix"
          >转为UNIX日期<i class="el-icon-top"></i
        ></el-button>
        <el-button type="warning" @click="clearDate">清空</el-button>
        <el-button type="warning" @click="resetDate">重置</el-button>
      </article>
      <el-form-item label="普通日期(格式为YYYY-MM-DD HH:mm:ss)"
        ><el-input v-model="form.common"></el-input>
      </el-form-item>
      <article>
        Unix时间戳(Unix timestamp)，或称Unix时间(Unix time)、POSIX时间(POSIX
        time)，是一种时间表示方式，定义为从格林威治时间1970年01月01日00时00分00秒起至现在的总秒数。
      </article>
      <article>当前UNIX时间戳（基于浏览器时间）：<span style="color:rgb(39, 194, 76)">{{ current }}</span></article>
    </el-form>
  </div>
</template>

<script lang="ts">
// 课题列表
import { Component, Vue, Prop } from "vue-property-decorator";

@Component({})
export default class UnixTime extends Vue {

  form: any = {
    unix: "1618781876",
    common: "",
  };
  current: any = this.$dayjs(new Date()).unix();
  toCommon() {
    this.form.common = this.$dayjs
      .unix(this.form.unix)
      .format("YYYY-MM-DD HH:mm:ss");
  }
  resetDate(){
    this.form = {
      unix: "1618781876",
      common: "2021-04-19 05:37:56",
    };
  }
  clearDate(){
    this.form.unix=''
    this.form.common=''
  }
  toUnix() {
    this.form.unix=this.$dayjs(this.form.common).unix()
  }
 created() {
    this.form.common = this.$dayjs
      .unix(this.form.unix)
      .format("YYYY-MM-DD HH:mm:ss");
    setInterval(() => {
      this.current = this.$dayjs(new Date()).unix();
    }, 1000);
  }
}
</script>

<style lang="scss" scoped>
.unix-time {
  margin: 5rem;
  .transfer-btn {
    display: flex;
    i {
      font-size: 1rem;
    }
  }
}
</style>
