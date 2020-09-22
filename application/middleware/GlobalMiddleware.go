package middleware

import (
	"github.com/dgrijalva/jwt-go"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	"github.com/gookit/color"
	"net/http"
	"xapimanager/application/controllers"
	"xapimanager/application/models"
)

func GlobalHandle() gin.HandlerFunc {
	return func(c *gin.Context) {

		session := sessions.Default(c)
		//获取用户信息
		uid := session.Get("uid")
		username := session.Get("username")
		avatar := session.Get("avatar")
		//获取用户信息
		if uid == nil || username == nil {
			c.Set("user", map[string]interface{}{
				"uid":      0,
				"username": "",
				"avatar":   "/assets/images/avatar.png",
			})
		} else {
			c.Set("user", map[string]interface{}{
				"uid":      uid.(int),
				"username": username.(string),
				"avatar":   avatar,
			})
		}
		c.Next()
	}
}
func JwtHandler() gin.HandlerFunc {
	return func(context *gin.Context) {
		result := models.Result{
			Code:    http.StatusUnauthorized,
			Message: "无法认证，重新登录",
			Data:    nil,
		}
		auth := context.Request.Header.Get("Authorization")
		color.Danger.Println(auth,"token")
		if len(auth) == 0 {
			context.Abort()
			context.JSON(http.StatusUnauthorized, gin.H{
				"result": result,
			})
		}

		// 校验token
		rs, err := parseToken(auth)
		color.Danger.Println(rs,"token 安琥用")
		if err != nil {
			context.Abort()
			result.Message = "token 过期" + err.Error()
			context.JSON(http.StatusUnauthorized, gin.H{
				"result": result,
			})
		} else {
			println("token 正确")
		}
		context.Next()
	}
}
func parseToken(token string) (*jwt.StandardClaims, error) {
	jwtToken, err := jwt.ParseWithClaims(token, &jwt.StandardClaims{}, func(token *jwt.Token) (i interface{}, e error) {
		return []byte(controllers.SecretKey), nil
	})
	if err == nil && jwtToken != nil {
		if claim, ok := jwtToken.Claims.(*jwt.StandardClaims); ok && jwtToken.Valid {
			return claim, nil
		}
	}
	return nil, err
}
