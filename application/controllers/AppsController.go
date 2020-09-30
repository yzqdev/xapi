package controllers

import (
	"fmt"
	"xapimanager/application/Services"
	"github.com/gin-gonic/gin"
	"net/http"
)

//应用列表
func AppsList(c *gin.Context) {

	c.HTML(http.StatusOK, "apps.html", gin.H{
		"website": Services.GetWebsite(),
	})
}

//json/xml转换
func AppsTransform(c *gin.Context) {
	c.HTML(http.StatusOK, "apps_transform.html", gin.H{
		"website": Services.GetWebsite(),
	})
}

//json格式化、压缩
// @Summary json 格式化
// @Description 描述信息
// @Tags app
// @Accept  json
// @Produce  json
// @Router /json [get]
func AppsJson(c *gin.Context) {
	fmt.Println("节点 1")
	c.HTML(http.StatusOK, "apps_json.html", gin.H{
		"website": Services.GetWebsite(),
	})
}

//时间戳转换
func AppsTimestamp(c *gin.Context) {
	c.HTML(http.StatusOK, "apps_timestamp.html", gin.H{
		"website": Services.GetWebsite(),
	})
}
