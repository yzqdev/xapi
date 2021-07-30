package middleware

import (
	"fmt"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt"
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
	//@Security ApiKeyAuth
	return func(context *gin.Context) {
		result := models.Result{
			Code:    http.StatusUnauthorized,
			Message: "无法认证，重新登录",
			Data:    nil,
		}
		auth := context.Request.Header.Get("Authorization")
		if len(auth) == 0 {
			context.Abort()
			context.JSON(http.StatusUnauthorized, gin.H{
				"result": result,
			})
		}

		// 校验token
		qyUser, err := parseToken(auth)
		context.Set("user", qyUser)

		if err != nil {
			context.Abort()
			result.Message = err.Error()
			context.JSON(http.StatusUnauthorized, gin.H{
				"result": result,
			})
		} else {
			println("token 正确")
		}
		context.Next()
	}
}
func parseToken(yourToken string) (models.QyUser, error) {
	claims := controllers.NewJwtClaims{}
	_, err := jwt.ParseWithClaims(yourToken, &claims, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("unexpected signing method: %v", token.Header["alg"])
		}
		// hmacSampleSecret is a []byte containing your secret, e.g. []byte("my_secret_key")
		return controllers.SecretKey, nil

	})
	if err != nil {
		color.Danger.Println("token值为空")

	}
	color.Danger.Println(claims.QyUser, "编译token")
	return *claims.QyUser, err

}

//func AuthMiddle() gin.HandlerFunc{
//	return func(context *gin.Context) {
//
//		authMiddleware, err := jwt.New(&jwt.GinJWTMiddleware{
//			Realm:       "test zone",
//			Key:         []byte("secret key"),
//			Timeout:     time.Hour,
//			MaxRefresh:  time.Hour,
//			IdentityKey: identityKey,
//			PayloadFunc: func(data interface{}) jwt.MapClaims {
//				if v, ok := data.(*models.QyUser); ok {
//					return jwt.MapClaims{
//						identityKey: v.Username,
//					}
//				}
//				return jwt.MapClaims{}
//			},
//			IdentityHandler: func(c *gin.Context) interface{} {
//				claims := jwt.ExtractClaims(c)
//				return &models.QyUser{
//					Username: claims[identityKey].(string),
//				}
//			},
//			Authenticator: func(c *gin.Context) (interface{}, error) {
//				var loginVals models.QyUser
//				if err := c.ShouldBind(&loginVals); err != nil {
//					return "ddddd", jwt.ErrMissingLoginValues
//				}
//
//				u := loginVals.QueryByUsername()
//				if u.Password == loginVals.Password {
//					return loginVals, nil
//				}
//
//				return nil, jwt.ErrFailedAuthentication
//			},
//			Authorizator: func(data interface{}, c *gin.Context) bool {
//				if _, ok := data.(*models.QyUser); ok   {
//					return true
//				}
//
//				return false
//			},
//			Unauthorized: func(c *gin.Context, code int, message string) {
//				c.JSON(code, gin.H{
//					"code":    code,
//					"message": message,
//				})
//			},
//			// TokenLookup is a string in the form of "<source>:<name>" that is used
//			// to extract token from the request.
//			// Optional. Default value "header:Authorization".
//			// Possible values:
//			// - "header:<name>"
//			// - "query:<name>"
//			// - "cookie:<name>"
//			// - "param:<name>"
//			TokenLookup: "header: Authorization, query: token, cookie: jwt",
//			// TokenLookup: "query:token",
//			// TokenLookup: "cookie:token",
//
//			// TokenHeadName is a string in the header. Default value is "Bearer"
//			TokenHeadName: "Bearer",
//
//			// TimeFunc provides the current time. You can override it to use another time value. This is useful for testing or if your server uses a different time zone than your tokens.
//			TimeFunc: time.Now,
//		})
//
//		if err != nil {
//			log.Fatal("JWT Error:" + err.Error())
//		}
//
//		errInit := authMiddleware.MiddlewareInit()
//
//		if errInit != nil {
//			log.Fatal("authMiddleware.MiddlewareInit() Error:" + errInit.Error())
//		}
//		context.Next()
//	}
//}
