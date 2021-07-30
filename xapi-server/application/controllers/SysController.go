package controllers

import (
	"github.com/gin-gonic/gin"
	"github.com/gookit/color"
	"net/http"
	"xapimanager/application/Services"
	"xapimanager/application/models"
)

// Website @Summary 获取网站设置页
// @Description 描述信息
// @Tags website
// @Accept  json
// @Produce  json
// @Router /website/web [get]
func Website(c *gin.Context) {

	c.JSON(http.StatusOK, gin.H{
		"website": Services.GetWebsite(),
		"site":    models.GetWebsite(),
	})

}

type SiteInfo struct {
	Sitename    string `json:"sitename"`
	Title       string `json:"title"`
	Keywords    string `json:"keywords"`
	Description string `json:"description"`
	Copyright   string `json:"copyright"`
}

// WebsiteInfo @Summary 更新网站信息
// @Description 描述信息
// @Tags website
// @Accept  json
// @Produce  json
// @Router /website/info [post]
func WebsiteInfo(c *gin.Context) {
	req := SiteInfo{}
	if err := c.ShouldBindJSON(&req); err != nil {
		color.Red.Println(err)
	}

	var data = map[string]string{
		"sitename":    req.Sitename,
		"title":       req.Title,
		"keywords":    req.Keywords,
		"description": req.Description,
		"copyright":   req.Copyright,
	}

	for key, value := range data {
		models.WebsiteSave(key, value)
	}
	Services.ClearCache("qy_website")
	c.JSON(http.StatusOK, gin.H{
		"status": 200,

		"message": "保存成功",
	})
}
