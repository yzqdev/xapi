package middleware

import (
	"github.com/gin-gonic/gin"
	"net/http"
	"xapimanager/application/models"
)

func Auth() gin.HandlerFunc {
	return func(c *gin.Context) {

		result := models.Result{
			Code:    http.StatusUnauthorized,
			Message: "无法认证，重新登录",
			Data:    nil,
		}
		auth := c.Request.Header.Get("Authorization")
		if len(auth) == 0 {
			c.Abort()
			c.JSON(http.StatusUnauthorized, gin.H{
				"result": result,
			})
		}

		// 校验token
		qyUser, err := parseToken(auth)

username:=qyUser.Username
uid:=qyUser.Uid
		if err != nil {
			c.Abort()
			result.Message = err.Error()
			c.JSON(http.StatusUnauthorized, gin.H{
				"result": result,
			})
		} else {
			println("token 正确")
		}

		//未登录用户直接跳转到登录页
		if uid == 0 || username == "" {
			//c.Redirect(http.StatusFound, "/login")
			//c.Abort()
			return
		} else {
			c.Set("puser", map[string]interface{}{
				"uid":      uid,
				"username": username,
				"oid":      1,
			})
			c.Next()
		}
	}
}
