package controllers

import (
	"github.com/dgrijalva/jwt-go"
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	"github.com/gookit/color"
	"net/http"
	"strconv"
	"time"
	"xapimanager/application/Services"
	"xapimanager/application/common"
	"xapimanager/application/models"
)

var SecretKey = "9hUxqaGelNnCZaCW"

type ReqLogin struct {
	User string `json:"user"`
	Pass string `json:"pass"`
}

func Login(c *gin.Context) {

	c.HTML(http.StatusOK, "login.html", gin.H{
		"website": Services.GetWebsite(),
	})
}
func CreateJwt(c *gin.Context) {
	user := &models.QyUser{}
	result := &models.Result{
		Code:    200,
		Message: "登录成功n",
		Data:    nil,
	}
	if err := c.BindJSON(&user); err != nil {
		color.Cyan.Println("hhh")
		result.Message = "数据绑定失败"
		result.Code = http.StatusUnauthorized
		c.JSON(http.StatusUnauthorized, gin.H{
			"result": result,
		})
	}
	u := user.QueryByUsername()
	color.Danger.Println(u.Password,"==",user.Password,"获取的用户")
	if u.Password == user.Password {
		expiresTime := time.Now().Unix() + int64(60*60*24)
		claims := jwt.StandardClaims{
			Audience:  user.Username,          // 受众
			ExpiresAt: expiresTime,            // 失效时间
			Id:        string(rune(user.Uid)), // 编号
			IssuedAt:  time.Now().Unix(),      // 签发时间
			Issuer:    "gin hello",            // 签发人
			NotBefore: time.Now().Unix(),      // 生效时间
			Subject:   "login",                // 主题
		}
		var jwtSecret = []byte(SecretKey)
		tokenClaims := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
		if token, err := tokenClaims.SignedString(jwtSecret); err == nil {
			result.Message = "登录成功"
			result.Data =   token
			result.Code = http.StatusOK
			color.Danger.Println("最大的撒地方的")
			c.JSON(result.Code, result)
		} else {
			result.Message = "登录失败"
			result.Code = http.StatusOK
			c.JSON(result.Code, gin.H{
				"result": result,
			})
		}
	} else {
		result.Message = "登录失败"
		result.Code = http.StatusOK
		c.JSON(result.Code, gin.H{
			"result": result,
		})
	}
}

//ajax 登录
func AjaxLogin(c *gin.Context) {

	var avatar string
	var loginJson ReqLogin
	if err := c.ShouldBindJSON(&loginJson); err != nil {
		// 返回错误信息
		// gin.H封装了生成json数据的工具
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	session := sessions.Default(c)
	info := loginJson.User
	pass := loginJson.Pass

	userinfo := models.LoginUserInfo(info)

	if userinfo.Uid > 0 {
		salt := userinfo.Salt

		if common.MD5(pass+common.MD5(salt)) == userinfo.Password {

			if len(userinfo.Avatar) > 1 {
				avatar = userinfo.Avatar
			} else {
				avatar = "/assets/img/avatar.png"
			}
			color.Danger.Println(userinfo.Uid, userinfo.Username, "session 设置user")
			session.Set("uid", userinfo.Uid)
			session.Set("username", userinfo.Username)
			session.Set("avatar", avatar)

			session.Save()
			c.JSON(http.StatusOK, gin.H{
				"status":  200,
				"message": "登录成功",
			})
		} else {
			c.JSON(http.StatusOK, gin.H{
				"status":  2011,
				"message": "用户名或密码错误，请确认后输入",
			})
		}
	} else {
		c.JSON(http.StatusOK, gin.H{
			"status":  2010,
			"message": "用户信息不存在",
		})
	}

}

//注册
func Register(c *gin.Context) {

	var identify string
	session := sessions.Default(c)
	//已登录用户要求时直接弹框
	invite := c.Query("invite")
	if session.Get("uid") != nil && len(invite) > 0 {
		identify = invite
	} else {
		identify = "0"
	}
	c.HTML(http.StatusOK, "register.html", gin.H{
		"website": Services.GetWebsite(),
		"org":     models.GetOrganizeOne(identify),
		"invite":  invite,
	})
}

//注册api
func AjaxRegister(c *gin.Context) {

	username := c.PostForm("username")
	password := c.PostForm("password")
	phone := c.PostForm("phone")
	email := c.PostForm("email")

	have := models.GetUserCheck(0, username, phone, email)
	if !have {
		salt := common.GetRandomString(4)
		data := map[string]interface{}{
			"username": username,
			"password": common.MD5(password + common.MD5(salt)),
			"phone":    phone,
			"email":    email,
			"salt":     salt,
		}
		uid := models.UserSave(data)
		if uid > 0 {
			//加入组织
			models.OrganizeJoin(uid, 1, 2)
			c.JSON(http.StatusOK, gin.H{
				"status":  200,
				"message": "注册成功",
			})

		} else {
			c.JSON(http.StatusOK, gin.H{
				"status":  2010,
				"message": "注册失败，请稍后重试",
			})
		}
	} else {
		c.JSON(http.StatusOK, gin.H{
			"status":  2010,
			"message": "用户信息已存在，请确认后输入！",
		})
	}
}

//注册检查
func RegisterCheck(c *gin.Context) {

	flag := true
	data := map[string]interface{}{}
	field := []string{"username", "phone", "email"}
	for _, v := range field {
		if len(c.PostForm(v)) > 0 {
			data[v] = c.PostForm(v)
		}
	}
	if len(data) > 0 {
		info := models.GetUserDetail(data)
		if info.Uid > 0 {
			flag = false
		}
	}
	c.JSON(http.StatusOK, flag)

}

//获取用户列表页（组织成员）
func UserList(c *gin.Context) {

	//查询用户的组织及用户组
	group := models.GetUserPermissionGroup()

	c.HTML(http.StatusOK, "users.html", gin.H{
		"website": Services.GetWebsite(),
		"group":   group,
		"userStatus": map[int]string{
			1: "已激活",
			2: "待激活",
			3: "失效",
		},
	})
}

//ajax获取用户列表
func AjaxUserList(c *gin.Context) {

	//参数信息
	keyword := c.Query("keyword")
	userGroup, _ := strconv.Atoi(c.Query("userGroup"))
	userStatus, _ := strconv.Atoi(c.Query("userStatus"))
	page, _ := strconv.Atoi(c.DefaultQuery("page", "1"))
	limit := 20
	start := (page - 1) * limit

	//用户自己的组织信息
	userInfo, _ := c.Get("user")
	uid := userInfo.(map[string]interface{})["oid"].(int)

	//查询数据
	result := models.GetOrganizeUsers(uid, keyword, userStatus, userGroup, start, limit)

	c.JSON(http.StatusOK, gin.H{
		"status":  200,
		"message": "成功",
		"data":    result,
	})
}

func GetUserByUsername(c *gin.Context) string {
	return ""
}

//用户详情
func UserDetail(c *gin.Context) {

	//获取用户信息
	userInfo, _ := c.Get("user")
	oid := userInfo.(map[string]interface{})["oid"].(int)
	//获取组织下的权限组
	group := models.GetUserPermissionGroup()

	//获取传递的用户信息
	userid, _ := strconv.Atoi(c.Param("userid"))
	//获取传递的用户在当前组织下的角色
	userGroup := models.GetOrganizeRole(oid, userid)
	//组织下的用户信息
	info := models.GetOrganizeUserInfo(oid, userid)

	c.HTML(http.StatusOK, "users_detail.html", gin.H{
		"website": Services.GetWebsite(),
		"group":   group,
		"userStatus": map[string]string{
			"1": "已激活",
			"2": "待激活",
			"3": "失效",
		},
		"userInfo":  info,
		"userGroup": userGroup,
		"password":  "secret",
	})

}

//保存用户信息
func UsersSave(c *gin.Context) {

	var message string
	var status int

	models.OperateLog("编辑用户信息", 2, c)

	//获取编辑用户id
	userid, _ := strconv.Atoi(c.Param("userid"))
	//获取权限组及用户状态
	groupId, _ := strconv.Atoi(c.PostForm("auth"))
	userStatus := c.DefaultPostForm("status", "2")

	if models.UpdateUserOrganize(userid, map[string]interface{}{"status": userStatus}) &&
		models.UpdateUserGroup(userid, groupId) {
		if c.PostForm("password") != common.MD5("secret") {
			salt := common.GetRandomString(4)
			data := map[string]interface{}{
				"salt":     salt,
				"password": common.MD5(c.PostForm("password") + common.MD5(salt)),
			}
			models.UpdateUser(userid, data)
		}
		status = 200
		message = "更新成功"
	} else {
		status = 2010
		message = "更新失败"
	}
	c.JSON(http.StatusOK, gin.H{
		"status":  status,
		"message": message,
	})
}

//个人中心
func UserPerson(c *gin.Context) {

	session := sessions.Default(c)
	//获取用户信息
	userInfo, _ := c.Get("user")
	uid := userInfo.(map[string]interface{})["uid"].(int)

	info := models.GetUserInfo(uid)
	c.HTML(http.StatusOK, "users_person.html", gin.H{
		"website":  Services.GetWebsite(),
		"userinfo": info,
		"avatar":   session.Get("avatar"),
	})
}

//个人资料修改
func UserPersonStore(c *gin.Context) {

	//获取用户信息
	userInfo, _ := c.Get("user")
	uid := userInfo.(map[string]interface{})["uid"].(int)

	salt := common.GetRandomString(4)
	data := map[string]interface{}{}
	field := []string{"username", "phone", "email", "intro"}
	for _, v := range field {
		if len(c.PostForm(v)) > 0 {
			data[v] = c.PostForm(v)
		}
	}
	data["salt"] = salt
	data["password"] = common.MD5(c.PostForm("password") + common.MD5(salt))

	have := models.GetUserCheck(uid, data["username"].(string), data["phone"].(string), data["email"].(string))
	if !have {
		if models.UpdateUser(uid, data) {
			c.JSON(http.StatusOK, gin.H{
				"status":  200,
				"message": "修改成功",
			})
		} else {
			c.JSON(http.StatusOK, gin.H{
				"status":  2010,
				"message": "修改失败",
			})
		}
	} else {
		c.JSON(http.StatusOK, gin.H{
			"status":  2012,
			"message": "修改信息已存在，请重新输入待修改信息",
		})
	}
}

//个人资料检查,检查时只会一次传一个字段
func UserPersonCheck(c *gin.Context) {

	flag := true
	data := map[string]interface{}{}
	//获取用户信息
	userInfo, _ := c.Get("user")
	uid := userInfo.(map[string]interface{})["uid"].(int)
	info := models.GetUserInfo(uid)

	field := []string{"username", "phone", "email"}
	for _, v := range field {
		if len(c.PostForm(v)) > 0 {
			data[v] = c.PostForm(v)
		}
	}
	if len(data) > 0 {
		userDetail := models.GetUserDetail(data)
		if userDetail.Uid > 0 && info.Uid != uid {
			flag = false
		}
	}
	c.JSON(http.StatusOK, flag)
}

//退出登录
func Logout(c *gin.Context) {

	session := sessions.Default(c)
	session.Clear()
	session.Save()

	c.JSON(http.StatusOK, gin.H{
		"status":  200,
		"message": "成功",
	})
}
