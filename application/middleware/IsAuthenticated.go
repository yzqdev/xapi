package middleware

import (
	"github.com/gin-gonic/gin"
)

func Auth() gin.HandlerFunc {
	return func(c *gin.Context) {

		userInfo, _ := c.Get("user")
		uid := userInfo.(map[string]interface{})["uid"].(int)
		username := userInfo.(map[string]interface{})["username"].(string)
//color.Danger.Println(username,"中间件")
		//未登录用户直接跳转到登录页
		if uid == 0 || username == "" {
			//c.Redirect(http.StatusFound, "/login")
			//c.Abort()
			return
		} else {
			c.Set("user", map[string]interface{}{
				"uid":      uid,
				"username": username,
				"oid":      1,
			})
			c.Next()
		}
	}
}
