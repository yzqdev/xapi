<template>
  <div>$</div>
</template>

<script lang="ts">
// 课题列表
import {Component, Vue, Prop} from "vue-property-decorator";
import {projectList} from "@/plugins/apis/project";

@Component({})
export default class Project extends Vue {
  @Prop({})
  name: string;
  created(){
projectList().then((res) => {
  console.log(res,'projects')
})
  }
}
</script>

<style lang="scss" scoped></style>
