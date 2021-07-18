import qs from "qs";
import {getApiUrl} from "@/plugins/config";
// import { Message } from "element-ui";
//
// const errorMessage = msg => {
//   Message({
//     showClose: true,
//     message: msg,
//     type: "error",
//     center: true
//   });
// };
// 环境的切换

export enum ContentType {
  json = "application/json;charset=UTF-8",
  form = "application/x-www-form-urlencoded; charset=UTF-8",
}
export interface IReqConfig {
  body?: any;
  method?: string;
  headers?: IHeader;
  token?: string;
  "Content-Type"?: string;
}

export interface IHeader {
  "Content-Type": string;
  "X-Requested-With": string;
  token: string;
  [propName: string]: any;
}



let baseURL: any = getApiUrl()
let HttpMethodMap = {
  get: "GET",
  post: "POST",
  put: "PUT",
  patch: "PATCH",
  delete: "DELETE",
};

class FetchApi {
  constructor() {}
  static get(url: string | number | Request) {
    return new Promise((resolve, reject) => {
      url = baseURL + url;
      fetch(<Request | string>url,{
        method:"GET",
          headers: {
            "Content-type": "application/json",

            "Authorization": localStorage.token ? localStorage.token : "",

        }
      })
        .then((res) => res.json())
        .then((data) => resolve(data))
        .catch((err) => reject(err));
    });
  }

  static post(url: string | number | Request, data: any) {
    return new Promise((resolve, reject) => {
      url = baseURL + url;
      fetch(<Request | string>url, {
        method: "POST",
        headers: {
          "Content-type": "application/json",

          "Authorization": localStorage.token ? localStorage.token : "",
        },
        body: JSON.stringify(data),
      })
        .then((res) => res.json())
        .then((data) => resolve(data))
        .catch((err) => reject(err));
    });
  }
  static postForm(url: string | number | Request, data: any) {
    return new Promise((resolve, reject) => {
      url = baseURL + url;
      fetch(<Request | string>url, {
        method: "POST",
        headers: {
          "Content-type": "application/x-www-form-urlencoded",
          "Authorization": localStorage.token ? localStorage.token : "",
        },
        body: JSON.stringify(data),
      })
        .then((res) => res.json())
        .then((data) => resolve(data))
        .catch((err) => reject(err));
    });
  }

  static put(url: string | number | Request, data: any) {
    return new Promise((resolve, reject) => {
      url = baseURL + url;
      fetch(<Request | string>url, {
        method: "PUT",
        headers: {
          "Content-type": "application/json",
        },
        body: JSON.stringify(data),
      })
        .then((res) => res.json())
        .then((data) => resolve(data))
        .catch((err) => reject(err));
    });
  }

  static delete(url: string | number | Request, data: any) {
    return new Promise((resolve, reject) => {
      url = baseURL + url;
      fetch(<Request | string>url, {
        method: "DELETE",
        headers: {
          "Content-type": "application/json",
        },
        body: JSON.stringify(data),
      })
        .then((res) => res.json())
        .then((data) => resolve("删除成功"))
        .catch((err) => reject(err));
    });
  }
}
export default FetchApi;
