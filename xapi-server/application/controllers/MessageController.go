package controllers

import (
	"github.com/gin-gonic/gin"
	"github.com/gookit/color"
	"net/http"
	"strings"
	"time"
	"xapimanager/application/Services"
	"xapimanager/application/common"
	"xapimanager/application/models"
)

var limit = 20

// GetAjaxMessageList
// @Summary 消息列表 Api
// @Description 描述信息
// @Tags message
// @Accept  json
// @Produce  json
// @Router /message/list [get]
func GetAjaxMessageList(c *gin.Context) {
	//获取用户信息
	var sender string
	userContext, exist := c.Get("user")
	if !exist {
		color.Danger.Println("失败了")
	}
	//查询用户组及该组的功能权限
	user, ok := userContext.(models.QyUser)
	if !ok {

		color.Danger.Println("断言失败")
	}
	data := map[string]interface{}{
		"receiver": user.Uid,
	}
	//查询消息列表
	page := common.StringToInt(c.DefaultQuery("page", "1"))
	start := (page - 1) * limit
	Message := models.GetMessageList(data, start, limit)
	var result []map[string]interface{}
	for _, v := range Message["list"].([]models.UserMessage) {
		sender = v.Username
		if v.Sender == 1 {
			sender = "管理员"
		}
		temp := map[string]interface{}{
			"id":       v.Id,
			"sender":   sender,
			"subject":  v.Subject,
			"isread":   v.Isread,
			"sendtime": time.Unix(int64(v.Sendtime), 0).Format("2006-01-02 03:04:05"),
		}
		result = append(result, temp)
	}

	c.JSON(http.StatusOK, gin.H{
		"status":  200,
		"message": "成功",
		"data": map[string]interface{}{
			"totalCount": Message["totalCount"],
			"list":       result,
		},
	})
}

type MessageOper struct {
	Status int    `json:"status"`
	Mids   string `json:"mids"`
}

// @Summary 更新已读和删除，
// @Description 描述信息
// @Tags message
// @Accept  json
// @Produce  json
// @Router /message/operate [post]
func MessageOperate(c *gin.Context) {

	var flag bool
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
	req := MessageOper{}
	if err := c.ShouldBindJSON(&req); err != nil {
		color.Red.Println(err)
	}
	uid := user.Uid
	mids := strings.Split(req.Mids, ",")
	status := req.Status

	switch status {
	case 1: //更新为已读
		flag = models.ReadUpdate(uid, mids)
	case 2: //删除
		flag = models.DeleteMessage(uid, mids)
	}
	if flag {
		c.JSON(http.StatusOK, gin.H{
			"status":  200,
			"message": "操作成功",
		})
	} else {
		c.JSON(http.StatusOK, gin.H{
			"status":  2010,
			"message": "操作失败，请稍后重试",
		})
	}

}

//
// @Summary 消息详情
// @Description 描述信息
// @Tags message
// @Accept  json
// @Produce  json
// @Router /message/detail [get]
func MessageDetail(c *gin.Context) {

	var sender string
	//获取用户信息及详细详情
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
	mid := common.StringToInt(c.Param("mid"))
	detail := models.GetMessageDetail(uid, mid)
	sender = detail.Username
	if detail.Sender == 1 {
		sender = "管理员"
	}
	data := map[string]interface{}{
		"id":       detail.Id,
		"sender":   sender,
		"subject":  detail.Subject,
		"isread":   detail.Isread,
		"content":  detail.Content,
		"sendtime": time.Unix(int64(detail.Sendtime), 0).Format("2006-01-02 03:04:05"),
	}

	c.JSON(http.StatusOK, gin.H{
		"website": Services.GetWebsite(),
		"data":    data,
	})
}

//
// @Summary 获取未读消息数
// @Description 描述信息
// @Tags message
// @Accept  json
// @Produce  json
// @Router /message/unread [get]
func GetUnreadMessage(c *gin.Context) {

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
	count := models.GetUnreadMessage(uid)
	c.JSON(http.StatusOK, gin.H{
		"status":  200,
		"message": "成功",
		"data":    map[string]int64{"count": count},
	})
}
