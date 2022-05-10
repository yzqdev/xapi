<template>
  <div>
    <h3>注册新用户</h3>
    <hr />
    <article class="reg-form">
      <el-form :model="form">
        <el-form-item label="用户名">
          <el-input
            required
            v-model="form.username"
            placeholder="请输入用户名"
          ></el-input>
        </el-form-item>
        <el-form-item label="email">
          <el-input
            required
            type="email"
            placeholder="请输入email"
            v-model="form.email"
          ></el-input>
        </el-form-item>
        <el-form-item label="电话号码">
          <el-input
            required
            type="text"
            placeholder="请输入电话"
            v-model="form.phone"
          ></el-input>
        </el-form-item>
        <el-form-item label="密码">
          <el-input required v-model="form.password"></el-input>
        </el-form-item>
        <el-form-item label="确认密码">
          <el-input required v-model="form.pass2"></el-input>
        </el-form-item>
        <el-form-item label="验证码" v-if="false">
          <el-input required v-model="form.captchaCode"></el-input
          ><img :src="capImg" />
        </el-form-item>
        <el-button type="primary " @click="submitReg">提交</el-button>
      </el-form>
    </article>
  </div>
</template>

<script setup lang="ts">
// 课题列表
import { getCapcha, reg } from "@/plugins/apis/account";
import {computed} from "vue";

 let form: any = $ref({
    username: "yangzq",
    email: "yzqdev@qq.com",
    password: "123456",
    pass2: "123456",
    phone: "18845645678",
    capthaId: "123",
    captchaCode: "123",
  });
 let formV = $ref({
    usernameState: false,
    emailState: false,
  });
  let capId: string =$ref('');
 let capImg= computed(() => {
    return "/captcha/" +  capId + ".png"
  })

  function submitReg() {
    reg( form).then((res) => {
      console.log(res, "调剂");
    });
  }

</script>

<style lang="scss" scoped>
.reg-form {
  padding: 1rem 5rem;
}
</style>
