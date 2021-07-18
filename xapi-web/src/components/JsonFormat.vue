<template>
  <div>$</div>
</template>

<script lang="ts">
// 课题列表
import {Component, Vue, Prop} from "vue-property-decorator";

@Component({})
export default class JsonFormat extends Vue {
  @Prop({})
  name: string;
}
</script>

<style lang="scss" scoped></style>
