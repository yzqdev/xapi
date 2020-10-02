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

var SecretKey = []byte("9hUxqaGelNnCZaCW")

type ReqLogin struct {
	Username string `json:"username"`
	Password string `json:"password"`
}
type ReqReg struct {
	Username string `json:"username"`
	Password string `json:"password"`
	Phone    string `json:"phone"`
	Email    string `json:"email"`
}
type NewJwtClaims struct {
	*models.QyUser
	jwt.StandardClaims
}

// @Summary 登陆
// @Description 描述信息
// @Tags accounts
// @Success 200 {object} models.Result
// @Accept  json
// @Param account body ReqLogin true "login"
// @Produce  json
// @Router /login [post]
func FetchLogin(c *gin.Context) {
	user := &ReqLogin{}
	result := &models.Result{
		Code:    200,
		Message: "登录成功n",
		Data:    nil,
	}
	if err := c.ShouldBindJSON(user); err != nil {
		color.Cyan.Println("hhh")
		result.Message = "数据绑定失败"
		result.Code = http.StatusUnauthorized
		c.JSON(http.StatusUnauthorized, gin.H{
			"result": result,
		})
	}
	sqlU := models.QueryByUsername(user.Username)
	salt := sqlU.Salt

	if sqlU.Password == common.MD5(user.Password+salt) {
		expiresTime := time.Now().Unix() + int64(60*60*24)
		//claims := jwt.StandardClaims{
		//	Audience:  user.Username,          // 受众
		//	ExpiresAt: expiresTime,            // 失效时间
		//	Id:        string(rune(user.Uid)), // 编号
		//	IssuedAt:  time.Now().Unix(),      // 签发时间
		//	Issuer:    sqlU.Username,            // 签发人
		//	NotBefore: time.Now().Unix(),      // 生效时间
		//	Subject:   "login",                // 主题
		//}
		stdClaims := jwt.StandardClaims{

			Audience:  "啊啊啊",             // 受众
			ExpiresAt: expiresTime,       // 失效时间
			Id:        "id",              // 编号
			IssuedAt:  time.Now().Unix(), // 签发时间
			Issuer:    " sqlU.Username",  // 签发人
			NotBefore: time.Now().Unix(), // 生效时间
			Subject:   "login",           // 主题
		}
		newClaims := NewJwtClaims{
			QyUser:         &sqlU,
			StandardClaims: stdClaims,
		}
		tokenClaims := jwt.NewWithClaims(jwt.SigningMethodHS256, newClaims)
		if token, err := tokenClaims.SignedString(SecretKey); err == nil {
			result.Message = "登录成功"
			result.Data = token
			result.Code = http.StatusOK
			c.JSON(result.Code, result)
		} else {
			result.Message = "登录失败，请重新登陆"
			result.Code = http.StatusOK
			c.JSON(result.Code, gin.H{
				"result": result,
			})
		}
	} else {
		result.Message = "密码不一样"
		result.Code = http.StatusOK
		c.JSON(result.Code, gin.H{
			"result": result,
		})
	}
}

// @Summary 注册api
// @Description 描述信息
// @Tags accounts
// @Accept  json
// @Produce  json
// @Router /register [post]
func AjaxRegister(c *gin.Context) {

	u := &ReqReg{}
	if err := c.ShouldBindJSON(u); err != nil {
		color.Danger.Println("json解析失败")
	}
	username := u.Username
	password := u.Password
	phone := u.Phone
	email := u.Email
	have := models.GetUserCheck(0, username, phone, email)
	if !have {
		salt := common.GetRandomString(4)
		data := map[string]interface{}{
			"username": username,
			"password": common.MD5(password + salt),
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

//
// @Summary 获取用户列表页（组织成员）
// @Description 描述信息
// @Tags accounts
// @Accept  json
// @Produce  json
// @Router /users/list [get]
func UserList(c *gin.Context) {

	//查询用户的组织及用户组
	group := models.GetUserPermissionGroup()

	c.JSON(http.StatusOK, gin.H{
		"website": Services.GetWebsite(),
		"group":   group,
		"userStatus": map[int]string{
			1: "已激活",
			2: "待激活",
			3: "失效",
		},
	})
}

type UserListReq struct {
	Keyword    string `json:"keyword"`
	UserGroup  int    `json:"user_group"`
	UserStatus int    `json:"user_status"`
	Page       int    `json:"page"`
}

//
// @Summary ajax获取用户列表
// @Description 描述信息
// @Tags accounts
// @Accept  json
// @Produce  json
// @Router /user/all [post]
func AjaxUserList(c *gin.Context) {

	//参数信息
	req := UserListReq{}
	if err := c.ShouldBindJSON(&req); err != nil {
		color.Red.Println("绑定userlist失败")
	}
	keyword := req.Keyword
	userGroup := req.UserGroup
	userStatus := req.UserStatus
	page := req.Page
	limit := 20
	start := (page - 1) * limit

	//用户自己的组织信息
	userContext, exist := c.Get("user")
	if !exist {
		color.Danger.Println("失败了")
	}
	//查询用户组及该组的功能权限
	user, ok := userContext.(models.QyUser)
	if !ok {

		color.Danger.Println("断言失败")
	}
	uid := user.Uid

	//查询数据
	result := models.GetOrganizeUsers(uid, keyword, userStatus, userGroup, start, limit)

	c.JSON(http.StatusOK, gin.H{
		"status":  200,
		"message": "成功",
		"data":    result,
	})
}

//
// @Summary 用户详情
// @Description 描述信息
// @Tags accounts
// @Accept  json
// @Produce  json
// @Router /users/detail/:userid [get]
func UserDetail(c *gin.Context) {

	//获取用户信息
	userContext, exist := c.Get("user")
	if !exist {
		color.Danger.Println("失败了")
	}
	//查询用户组及该组的功能权限
	user, ok := userContext.(models.QyUser)
	if !ok {

		color.Danger.Println("断言失败")
	}
	oid := user.Uid

	//获取组织下的权限组
	group := models.GetUserPermissionGroup()

	//获取传递的用户信息
	userid, _ := strconv.Atoi(c.Param("userid"))
	//获取传递的用户在当前组织下的角色
	userGroup := models.GetOrganizeRole(oid, userid)
	//组织下的用户信息
	info := models.GetOrganizeUserInfo(oid, userid)

	c.JSON(http.StatusOK, gin.H{
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

//
// @Summary 修改用户信息
// @Description 描述信息
// @Tags accounts
// @Accept  json
// @Produce  json
// @Router /user/update [post]
func UserUpdate(c *gin.Context) {

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

// @Summary 个人中心
// @Description 描述信息
// @Tags accounts
// @Accept  json
// @Produce  json
// @Router /users/person [post]
func UserPerson(c *gin.Context) {

	session := sessions.Default(c)
	//获取用户信息
	userContext, exist := c.Get("user")
	if !exist {
		color.Danger.Println("失败了")
	}
	//查询用户组及该组的功能权限
	user, ok := userContext.(models.QyUser)
	if !ok {

		color.Danger.Println("断言失败")
	}
	uid := user.Uid

	info := models.GetUserInfo(uid)
	c.JSON(http.StatusOK, gin.H{
		"website":  Services.GetWebsite(),
		"userinfo": info,
		"avatar":   session.Get("avatar"),
	})
}

// @Summary 个人资料修改
// @Description 描述信息
// @Tags accounts
// @Accept  json
// @Param account body models.UserInfo true "用户验证"
// @Produce  json
// @Router /person/store [post]
func UserPersonStore(c *gin.Context) {

	//获取用户信息
	userContext, exist := c.Get("user")
	if !exist {
		color.Danger.Println("失败了")
	}
	//查询用户组及该组的功能权限
	user, ok := userContext.(models.QyUser)
	if ok {
		color.Danger.Println("成功获取用户信息")
		color.Danger.Println(ok)
	} else {
		color.Danger.Println("断言失败")
	}
	uid := user.Uid
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

// @Summary 个人资料检查,检查时只会一次传一个字段
// @Description 资料检查
// @Tags accounts
// @Accept  json
// @Param account body models.UserInfo true "用户验证"
// @Produce  json
// @Router /person/check [post]
func UserPersonCheck(c *gin.Context) {

	flag := true
	data := map[string]interface{}{}
	//获取用户信息
	userInfo, _ := c.Get("user")
	color.Red.Println(userInfo)
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
// @Summary 退出登录
// @Description 描述信息
// @Tags accounts
// @Accept  json
// @Produce  json
// @Router /logout [get]
func Logout(c *gin.Context) {

	session := sessions.Default(c)
	session.Clear()
	session.Save()

	c.JSON(http.StatusOK, gin.H{
		"status":  200,
		"message": "成功",
	})
}
