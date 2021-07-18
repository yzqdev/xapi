import http from "@/plugins/FetchApi";
export const projectList = () => {
  return http.get("/project/list");
};
