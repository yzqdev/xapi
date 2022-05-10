<template>
  <div>
    <el-tabs  >
      <el-tab-pane v-for="item in tabs" :label="item.title"  :name="item.active"
        > sdfsdf</el-tab-pane
      >

    </el-tabs>
  </div>
</template>

<script setup lang="ts">
// 课题列表

   let tabs=$ref([
    {title:'推荐',active:true},
    {title:'最热',},
    {title:'Golang',},
    {title:'问与答',},
    {title:'Go项目',},
    {title:'web框架',},
    {title:'全部',},
  ])
</script>

<style lang="scss" scoped></style>
