<template>
  <div>
    <article class="login-form">
      <h3>登录</h3>
      <el-form :model="form">
        <el-form-item label="用户名">
          <el-input
            required
            v-model="form.user"
            placeholder="请输入用户名"
          ></el-input>
        </el-form-item>

        <el-form-item label="密码">
          <el-input required v-model="form.pass"></el-input>
        </el-form-item>

        <el-button type="primary " @click="submitLogin">提交</el-button>
      </el-form>
    </article>
  </div>
</template>

<script setup lang="ts">
// 课题列表
import { login } from "@/plugins/apis/account";
import {ElMessage} from "element-plus";
import {useRouter} from "vue-router";
let router=useRouter()
 let form = $ref({
    user: "yzq",
    pass: "123456",
  });
 function submitLogin() {

    login({username: form.user,password: form.pass}).then((res:any) => {
      if (res.data) {
        console.log(res);
        localStorage.setItem("token", res.data);
        ElMessage({
          type:'success',
          message:res.message
        })
         router.push({ name: "AdminIndex" });
      }else {
        ElMessage({
          type:'error',
          message:'登陆失败'
        })
      }
    });
  }
</script>

<style lang="scss" scoped>
.login-form {
  margin: 1rem 30rem;
}
</style>
