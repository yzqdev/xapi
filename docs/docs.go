// GENERATED BY THE COMMAND ABOVE; DO NOT EDIT
// This file was generated by swaggo/swag

package docs

import (
	"bytes"
	"encoding/json"
	"strings"

	"github.com/alecthomas/template"
	"github.com/swaggo/swag"
)

var doc = `{
    "schemes": {{ marshal .Schemes }},
    "swagger": "2.0",
    "info": {
        "description": "{{.Description}}",
        "title": "{{.Title}}",
        "contact": {},
        "license": {},
        "version": "{{.Version}}"
    },
    "host": "{{.Host}}",
    "basePath": "{{.BasePath}}",
    "paths": {
        "/dashboard": {
            "get": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "dashboard"
                ]
            }
        },
        "/getIndex": {
            "get": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "index"
                ],
                "summary": "获取首页信息",
                "responses": {}
            }
        },
        "/group/delete/:id": {
            "post": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "group"
                ],
                "summary": "权限组操作"
            }
        },
        "/group/save": {
            "post": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "group"
                ],
                "summary": "保存权限组"
            }
        },
        "/help": {
            "post": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "help"
                ],
                "summary": "显示网站信息"
            }
        },
        "/help/detail/:hid": {
            "get": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "help"
                ],
                "summary": "显示帮助详情"
            }
        },
        "/help/operate": {
            "post": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "help"
                ],
                "summary": "显示网站信息"
            }
        },
        "/help/store": {
            "post": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "accounts"
                ],
                "summary": "新增帮助保存",
                "responses": {
                    "200": {
                        "description": "OK",
                        "schema": {
                            "$ref": "#/definitions/controllers.CreateHelpReq"
                        }
                    }
                }
            }
        },
        "/login": {
            "post": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "accounts"
                ],
                "summary": "登陆",
                "parameters": [
                    {
                        "description": "login",
                        "name": "account",
                        "in": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/controllers.ReqLogin"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK",
                        "schema": {
                            "$ref": "#/definitions/models.Result"
                        }
                    }
                }
            }
        },
        "/logout": {
            "get": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "accounts"
                ],
                "summary": "退出登录"
            }
        },
        "/manager/:proid": {
            "get": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "index"
                ],
                "summary": "显示首页manage"
            }
        },
        "/message/detail": {
            "get": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "message"
                ],
                "summary": "消息详情"
            }
        },
        "/message/list": {
            "get": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "message"
                ],
                "summary": "消息列表 Api"
            }
        },
        "/message/operate": {
            "post": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "message"
                ],
                "summary": "更新已读和删除，"
            }
        },
        "/message/unread": {
            "get": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "message"
                ],
                "summary": "获取未读消息数"
            }
        },
        "/organize/detail/:oid": {
            "get": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "organize"
                ],
                "summary": "保存修改信息"
            }
        },
        "/organize/join": {
            "post": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "organize"
                ],
                "summary": "加入组织"
            }
        },
        "/organize/list": {
            "get": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "accounts"
                ],
                "summary": "获取项目列表"
            }
        },
        "/person": {
            "post": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "accounts"
                ],
                "summary": "个人中心"
            }
        },
        "/person/check": {
            "post": {
                "description": "资料检查",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "accounts"
                ],
                "summary": "个人资料检查,检查时只会一次传一个字段",
                "parameters": [
                    {
                        "description": "用户验证",
                        "name": "account",
                        "in": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/models.UserInfo"
                        }
                    }
                ]
            }
        },
        "/person/store": {
            "post": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "accounts"
                ],
                "summary": "个人资料修改",
                "parameters": [
                    {
                        "description": "用户验证",
                        "name": "account",
                        "in": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/models.UserInfo"
                        }
                    }
                ]
            }
        },
        "/user/all": {
            "post": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "accounts"
                ],
                "summary": "ajax获取用户列表"
            }
        },
        "/users/detail/:userid": {
            "get": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "accounts"
                ],
                "summary": "用户详情"
            }
        },
        "/users/list": {
            "get": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "accounts"
                ],
                "summary": "获取用户列表页（组织成员）"
            }
        },
        "/website/info": {
            "post": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "website"
                ],
                "summary": "更新网站信息"
            }
        },
        "/website/web": {
            "get": {
                "description": "描述信息",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "website"
                ],
                "summary": "获取网站设置页"
            }
        }
    },
    "definitions": {
        "controllers.CreateHelpReq": {
            "type": "object",
            "properties": {
                "content": {
                    "type": "string"
                },
                "hid": {
                    "type": "integer"
                },
                "title": {
                    "type": "string"
                }
            }
        },
        "controllers.ReqLogin": {
            "type": "object",
            "properties": {
                "password": {
                    "type": "string"
                },
                "username": {
                    "type": "string"
                }
            }
        },
        "models.Result": {
            "type": "object",
            "properties": {
                "code": {
                    "type": "integer",
                    "example": 0
                },
                "data": {
                    "type": "object"
                },
                "message": {
                    "type": "string",
                    "example": "请求信息"
                }
            }
        },
        "models.UserInfo": {
            "type": "object",
            "properties": {
                "email": {
                    "type": "string"
                },
                "intro": {
                    "type": "string"
                },
                "phone": {
                    "type": "string"
                },
                "status": {
                    "type": "string"
                },
                "uid": {
                    "type": "integer"
                },
                "username": {
                    "type": "string"
                }
            }
        }
    }
}`

type swaggerInfo struct {
	Version     string
	Host        string
	BasePath    string
	Schemes     []string
	Title       string
	Description string
}

// SwaggerInfo holds exported Swagger Info so clients can modify it
var SwaggerInfo = swaggerInfo{
	Version:     "",
	Host:        "",
	BasePath:    "",
	Schemes:     []string{},
	Title:       "",
	Description: "",
}

type s struct{}

func (s *s) ReadDoc() string {
	sInfo := SwaggerInfo
	sInfo.Description = strings.Replace(sInfo.Description, "\n", "\\n", -1)

	t, err := template.New("swagger_info").Funcs(template.FuncMap{
		"marshal": func(v interface{}) string {
			a, _ := json.Marshal(v)
			return string(a)
		},
	}).Parse(doc)
	if err != nil {
		return doc
	}

	var tpl bytes.Buffer
	if err := t.Execute(&tpl, sInfo); err != nil {
		return doc
	}

	return tpl.String()
}

func init() {
	swag.Register(swag.Name, &s{})
}
