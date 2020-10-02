package controllers

import (
	"github.com/gin-gonic/gin"
	"github.com/gookit/color"
	"net/http"
	"strconv"
	"xapimanager/application/Services"
	"xapimanager/application/models"
)

type UserOrganize struct {
	Uid      int
	Leader   int
	Organize int
	Name     string
	Desc     string
	Identify string
	Icon     string
	Invite   string
}

//
// @Summary 获取项目列表
// @Description 描述信息
// @Tags accounts
// @Accept  json
// @Produce  json
// @Router /organize/list [get]
func OrganizeList(c *gin.Context) {

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

	//查询用户自己的团队信息
	self := models.GetUserOrganize(uid)
	if self.Id == 0 {
		models.OrganizeJoin(uid, 1, 1)
	}

	organize := models.GetOrganize(uid)

	data := map[string][]interface{}{}
	var OrganizeNo string
	var tmp UserOrganize
	for _, v := range organize {
		tmp = UserOrganize{
			v.Uid,
			v.Leader,
			v.Organize,
			v.Name,
			v.Desc,
			v.Identify,
			v.Icon,
			"http://" + c.Request.Host + "/register?invite=" + v.Identify,
		}
		if v.Uid == v.Leader {
			data["self"] = append(data["self"], tmp)
			OrganizeNo = v.Identify
		} else {
			data["everyone"] = append(data["everyone"], tmp)
		}
	}

	c.JSON(http.StatusOK, gin.H{
		"website":    Services.GetWebsite(),
		"OrganizeNo": OrganizeNo,
		"data":       data,
	})

}

//组织搜索
func Search(c *gin.Context) {

	var orginfo models.QyOrganize
	identify := c.Param("identify")

	org := models.GetOrganizeInfo(identify)
	if len(org) > 0 {
		orginfo = org[0]
	} else {
		orginfo = models.QyOrganize{}
	}
	c.JSON(http.StatusOK, gin.H{
		"status":  200,
		"message": "成功",
		"data":    orginfo,
	})

}

//
// @Summary 加入组织
// @Description 描述信息
// @Tags organize
// @Accept  json
// @Produce  json
// @Router /organize/join [post]
func OrganizeJoin(c *gin.Context) {

	identify := c.Param("identify")
	org := models.GetOrganizeOne(identify)

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

	err := models.OrganizeJoin(uid, org.Id, 2)

	if err == nil {
		c.JSON(http.StatusOK, gin.H{
			"status":  200,
			"message": "成功",
		})
	} else {
		c.JSON(http.StatusOK, gin.H{
			"status":  4010,
			"message": err.Error(),
		})
	}

}

//退出组织
func OrganizeQuit(c *gin.Context) {

	//获取用户信息
	userInfo, _ := c.Get("user")
	uid := userInfo.(map[string]interface{})["uid"].(int)

	//组织id
	oid := c.Param("oid")
	organizeId, _ := strconv.Atoi(oid)
	err := models.OrganizeQuit(uid, organizeId)

	if err == nil {
		c.JSON(http.StatusOK, gin.H{
			"status":  200,
			"message": "退出成功",
		})
	} else {
		c.JSON(http.StatusOK, gin.H{
			"status":  4010,
			"message": "退出失败",
		})
	}
}

//
// @Summary 组织详情
// @Description 描述信息
// @Tags organize
// @Accept  json
// @Produce  json
// @Router /organize/detail/:oid [get]
func OrganizeDetail(c *gin.Context) {

	//组织id
	var orginfo models.QyOrganize
	oid := c.Param("oid")

	organizeId, _ := strconv.Atoi(oid)
	org := models.GetOrganizeDetail(organizeId)
	if len(org) > 0 {
		orginfo = org[0]
	} else {
		orginfo = models.QyOrganize{}
	}
	c.JSON(http.StatusOK, gin.H{
		"website": Services.GetWebsite(),
		"org":     orginfo,
	})
}

type OrgRequest struct {
	OrganizeName string `form:"organize_name" binding:"required" validate:"required,max=20,min=2"`
	OrganizeDesc string `form:"organize_desc" binding:"required" validate:"required,max=100,min=2"`
}

//
// @Summary 保存修改信息
// @Description 描述信息
// @Tags organize
// @Accept  json
// @Produce  json
// @Router /organize/detail/:oid [get]
func OrganizeSave(c *gin.Context) {

	//组织id
	oid := c.Param("oid")
	organizeId, _ := strconv.Atoi(oid)

	data := OrgRequest{}
	if err := c.ShouldBindJSON(&data); err != nil {
		color.Red.Println("绑定组织失败")
	}
	err := models.OrganizeSave(organizeId, data)
	if err == nil {
		c.JSON(http.StatusOK, gin.H{
			"status":  200,
			"message": "保存成功",
		})
	} else {
		c.JSON(http.StatusOK, gin.H{
			"status":  4010,
			"message": "保存失败",
		})
	}
}
