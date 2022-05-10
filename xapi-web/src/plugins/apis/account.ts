import http from "@/plugins/FetchApi";

export const reg = (data: any) => {
  return http.post("/reg", data);
};
export const getIndex = () => {
  return http.get("/getIndex");
};
export const login = (data: any) => {
  return http.post("/login", data);
};
