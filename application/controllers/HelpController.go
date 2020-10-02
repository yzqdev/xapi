package controllers

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/gookit/color"
	"html/template"
	"net/http"
	"regexp"
	"time"
	"xapimanager/application/Services"
	"xapimanager/application/common"
	"xapimanager/application/models"
)

//帮助中心页
// @Tags help
// @Summary
// @Description 描述信息
// @Tags accounts
// @Accept  json
// @Produce  json
// @Router /help  [get]
func HelpList(c *gin.Context) {
	c.HTML(http.StatusOK, "help_list.html", gin.H{
		"website": Services.GetWebsite(),
	})
}

type helpListReq struct {
	Page int `json:"page"`
}

//帮组中心Api
// @Summary 显示网站信息
// @Description 描述信息
// @Tags help
// @Accept  json
// @Produce  json
// @Router /help [post]
func AjaxHelpList(c *gin.Context) {

	//用户自己的组织信息
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
	oid := user.Uid

	data := map[string]interface{}{
		"organize": oid,
	}
	obj := helpListReq{}
	if err := c.ShouldBind(&obj); err != nil {
		color.Cyan.Println("解析page错误")
	}
	page := obj.Page
	//page := common.StringToInt(c.DefaultQuery("page", "1"))
	start := (page - 1) * limit

	help := models.GetHelpList(data, start, limit)
	var result []map[string]interface{}
	for _, v := range help["list"].([]models.UserHelp) {
		temp := map[string]interface{}{
			"id":      v.Id,
			"author":  v.Username,
			"title":   v.Title,
			"content": common.SubString(common.StripTags(v.Content), 0, 100, true),
			"ctime":   time.Unix(int64(v.Ctime), 0).Format("2006-01-02"),
		}
		result = append(result, temp)
	}
	c.JSON(http.StatusOK, gin.H{
		"status":  200,
		"message": "成功",
		"data": map[string]interface{}{
			"totalCount": help["totalCount"],
			"list":       result,
		},
	})

}

//帮助中心详情
// @Summary 显示网站信息
// @Description 描述信息
// @Tags help
// @Accept  json
// @Produce  json
// @Router /help/detail/:hid [get]
func HelpDetail(c *gin.Context) {
	//用户自己的组织信息
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
	oid := user.Uid

	hid := common.StringToInt(c.Param("hid"))

	detail := models.GetHelpDetail(oid, hid)

	c.JSON(http.StatusOK, gin.H{
		"website": Services.GetWebsite(),
		"data": map[string]interface{}{
			"id":      detail.Id,
			"author":  detail.Username,
			"title":   detail.Title,
			"content": template.HTML(detail.Content),
			"ctime":   time.Unix(int64(detail.Ctime), 0).Format("2006-01-02"),
		},
	})

}

//帮助中心删除
// @Summary 显示网站信息
// @Description 描述信息
// @Tags accounts
// @Accept  json
// @Produce  json
// @Router /help/operate [post]
func HelpDelete(c *gin.Context) {
	fmt.Println("hhh")
	//用户自己的组织信息
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
	oid := user.Uid

	hid := common.StringToInt(c.PostForm("hid"))

	if models.DeleteHelp(oid, hid) {
		c.JSON(http.StatusOK, gin.H{
			"status":  200,
			"message": "删除成功",
		})
	} else {
		c.JSON(http.StatusOK, gin.H{
			"status":  2010,
			"message": "删除失败，请稍后重试",
		})
	}
}

//新增帮助
func HelpInfo(c *gin.Context) {

	//用户自己的组织信息
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
	oid := user.Uid

	hid := common.StringToInt(c.Query("hid"))
	detail := models.GetHelpDetail(oid, hid)
	c.JSON(http.StatusOK, gin.H{
		"website": Services.GetWebsite(),
		"data": map[string]interface{}{
			"id":      detail.Id,
			"title":   detail.Title,
			"content": template.HTML(detail.Content),
		},
	})
}

type CreateHelpReq struct {
	Hid     int    `json:"hid"`
	Content string `json:"content"`
	Title   string `json:"title"`
}

//新增帮助保存
func HelpStore(c *gin.Context) {

	//用户自己的组织信息
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
	oid := user.Uid
	uid := user.Uid
	helpNew := CreateHelpReq{}

	if err := c.ShouldBindJSON(&helpNew); err != nil {
		color.Red.Println("帮顶失败")
		color.Println(err)
	}
	hid := helpNew.Hid

	content := helpNew.Content

	//图片移动及替换
	re, _ := regexp.Compile("\\/upload\\/images.+?\\.\\w+")
	content = re.ReplaceAllStringFunc(content, common.ReplaceImage)

	//删除编辑器版权说明
	re1, _ := regexp.Compile("<p data-f-id=\"pbf\".+?<\\/p>")
	content = re1.ReplaceAllStringFunc(content, func(str string) string { return "" })

	data := map[string]interface{}{
		"author":  uid,
		"title":   helpNew.Title,
		"content": content,
	}
	color.Cyan.Println(data, "新增帮助")
	if models.HelpStore(oid, hid, data) {
		c.JSON(http.StatusOK, gin.H{
			"status":  200,
			"message": "保存成功",
		})
	} else {
		c.JSON(http.StatusOK, gin.H{
			"status":  2010,
			"message": "保存失败，请稍后重试！",
		})
	}
}
