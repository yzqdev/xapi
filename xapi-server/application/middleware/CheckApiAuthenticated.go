package middleware

import (
	"github.com/gin-gonic/gin"
	"github.com/gookit/color"
	"net/http"
	"regexp"
	"strconv"
	"xapimanager/application/Services"
	"xapimanager/application/common"
	"xapimanager/application/models"
	"xapimanager/config"
)

/**
 * Api权限检查
 * 第一步检查是否有项目权限
 * 第二步检查Api权限
 * 第三步检查节点操作权限
 */
func ApiAuthCheck() gin.HandlerFunc {
	return func(c *gin.Context) {

		//获取用户信息
		userContext, exist := c.Get("user")
		if !exist {
			color.Danger.Println("失败了")
		}
		//查询用户组及该组的功能权限
		user, ok := userContext.(models.QyUser) //这个是类型推断,判断接口是什么类型
		color.Danger.Println(user, "getIndex获取用户信息")
		if !ok {

			color.Danger.Println("断言失败")
		}
		uid := user.Uid
		username := user.Username
		//未登录用户直接跳转到登录页
		if uid == 0 || username == "" {
			c.Redirect(http.StatusFound, "/login")
			c.Abort()
			return
		}

		proid, _ := strconv.Atoi(c.Param("proid"))
		c.Set("user", map[string]interface{}{
			"uid":      uid,
			"username": username,
			"oid":      1,
			"auth":     Services.GetUserAuth(uid, proid),
		})

		//项目权限检查
		project := Services.GetUserProject(uid)
		flag := false
		for _, v := range project {
			color.Danger.Println(proid, "项目id", v.Id)
			if proid == v.Id {
				flag = true
			}
		}
		if !flag {
			c.JSON(http.StatusOK, gin.H{
				"status":  513,
				"message": "您没有权限访问该项目，请联系管理员",
			})
			//终止
			c.Abort()
			return
		}

		//用户权限检查
		auth := Services.GetUserAuth(uid, proid)
		//匹配当前路由
		uri := c.Request.RequestURI
		reg := regexp.MustCompile(`\/manager\/\d+(\/[0-9A-Za-z\/]+)`)
		match := reg.FindStringSubmatch(uri)
		authflag := false
		str := ""
		optstr := ""
		if len(match) > 0 {
			//功能权限检查
			fetch := config.GetApiFetch()
			str = fetch[match[1]]
			if len(str) > 0 {
				authflag = common.CheckAuth(str, auth["rules"])
			}
			if len(str) == 0 {
				c.JSON(http.StatusOK, gin.H{
					"status":  512,
					"message": "您请求的Api没有fetch对应关系",
				})
				c.Abort()
				return
			} else if !authflag {
				//api不在映射列表中
				c.JSON(http.StatusOK, gin.H{
					"status":  511,
					"message": "您没有权限访问该Api",
				})
				c.Abort()
				return
			}
			//数据权限检查
			authflag = true
			optfetch := Services.GetNodeAuth()
			optstr = optfetch[match[1]]
			if len(optstr) > 0 {
				authflag = common.CheckAuth(optstr, auth["operate"])
			}
			if !authflag {
				c.JSON(http.StatusOK, gin.H{
					"status":  514,
					"message": "您没有该操作权限,请联系管理员",
				})
				c.Abort()
				return
			}

		}

		c.Next()
	}
}
