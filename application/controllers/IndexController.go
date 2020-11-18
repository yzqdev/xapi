package controllers

import (
	"github.com/gin-contrib/sessions"
	"github.com/gin-gonic/gin"
	"github.com/gookit/color"
	"net/http"
	"strconv"
	"strings"
	"xapimanager/application/Services"
	"xapimanager/application/models"
	_ "xapimanager/application/utils"
)

// @Summary 获取首页信息
// @Description 描述信息
// @Tags index
// @Accept  json
// @Produce  json
// @Header 200 {string} token Request.Header
// @Router /getIndex [get]
func Index(c *gin.Context) {

	userContext, exist := c.Get("user")
	if !exist {
		color.Danger.Println("失败了")
	}
	//查询用户组及该组的功能权限
	user, ok := userContext.(models.QyUser) //这个是类型推断,判断接口是什么类型
	if !ok {

		color.Danger.Println("断言失败")
	}
	gid := models.GetUserGroup(user.Uid)
	var menu []models.Allmenu
	if gid == 1 {
		menu = models.GetMenu(1, 0)
	} else {
		rules := []string{"1", "2", "3", "4", "5", "7", "8", "9", "10", "14", "15", "16", "17", "18"}
		menu = models.GetManagerMenu(1, 0, rules)
	}
	data := map[string]interface{}{
		"website": Services.GetWebsite(),
		"menu":    menu,
		"userinfo": map[string]interface{}{
			"username": user.Username,
			"avatar":   user.Avatar,
		},
	}

	c.JSON(http.StatusOK, data)

}

// @Summary 显示首页manage
// @Description 描述信息
// @Tags index
// @Accept  json
// @Produce  json
// @Router /manager/:proid [get]
func Manager(c *gin.Context) {

	proid, _ := strconv.Atoi(c.Param("proid"))
	env := models.GetProjectValidEnv(proid, "asc")

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
	group := Services.GetProjectGroup(uid, proid)
	rules := strings.Split(group.Rules, ",")
	menu := models.GetManagerMenu(2, 0, rules)

	//用户当前环境
	cenv := models.GetCurrentEnv(uid, proid)
	currentEnv := map[int]string{
		0: "请选择环境",
	}
	for _, v := range env {
		if cenv.Envid == v.Id {
			delete(currentEnv, 0)
			currentEnv[v.Id] = v.Envname
		}
	}
	session := sessions.Default(c)

	c.JSON(http.StatusOK, gin.H{
		"website":    Services.GetWebsite(),
		"apimenu":    menu,
		"projectEnv": env,
		"proid":      proid,
		"currentEnv": currentEnv,
		"userinfo": map[string]interface{}{
			"username": session.Get("username"),
			"avatar":   session.Get("avatar"),
		},
	})
}
