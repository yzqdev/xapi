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

<script lang="ts">
// 课题列表
import { Vue, Component, Prop, Watch } from "vue-property-decorator";
import { login } from "@/plugins/apis/account";
@Component({ components: {} })
export default class Login extends Vue {
  form = {
    user: "yzq",
    pass: "123456",
  };
  submitLogin() {

    login({username:this.form.user,password:this.form.pass}).then((res:any) => {
      if (res.data) {
        console.log(res);
        localStorage.setItem("token", res.data);
        this.$message.success(res.message);
        this.$router.push({ name: "AdminIndex" });
      }else {
        this.$message.error("登陆失败")
      }
    });
  }
}
</script>

<style lang="scss" scoped>
.login-form {
  margin: 1rem 30rem;
}
</style>
