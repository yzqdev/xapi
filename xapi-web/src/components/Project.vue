<template>
  <div>$</div>
</template>

<script setup lang="ts">
// 课题列表
import {projectList} from "@/plugins/apis/project";
import {onMounted} from "vue";

 onMounted(() => {
   projectList().then((res) => {
     console.log(res,'projects')
   })
 })
</script>

<style lang="scss" scoped></style>
