package controllers

import (
	"github.com/gin-gonic/gin"
	"github.com/gookit/color"
	"net/http"
	"strconv"
	"strings"
	"time"
	"xapimanager/application/Services"
	"xapimanager/application/common"
	"xapimanager/application/models"
)

//获取权限组列表
func GroupList(c *gin.Context) {

	var group []models.AuthGroup
	//获取用户信息
	userInfo, _ := c.Get("user")
	//获取组织下的权限组
	auth := models.GetOrganizeGroup(userInfo.(map[string]interface{})["oid"].(int))

	for _, v := range auth {
		v.Description = common.SubString(v.Description, 0, 30, true)
		group = append(group, v)
	}

	c.HTML(http.StatusOK, "group.html", gin.H{
		"website": Services.GetWebsite(),
		"group":   group,
	})
}

//新增或编辑权限组
func GroupInfo(c *gin.Context) {

	gid, _ := strconv.Atoi(c.Query("gid"))

	info := models.GetGroupInfo(gid)

	c.HTML(http.StatusOK, "group_info.html", gin.H{
		"website": Services.GetWebsite(),
		"info":    info,
	})
}

type CreateGroupReq struct {
	GroupName   string `json:"groupname"`
	Description string `json:"description"`
	Status      int    `json:"status"`
}

//
// @Summary 保存权限组
// @Description 描述信息
// @Tags group
// @Accept  json
// @Produce  json
// @Router /group/save [post]
func GroupSave(c *gin.Context) {

	gid, _ := strconv.Atoi(c.PostForm("gid"))

	var message string
	var status int
	models.OperateLog("编辑权限组", 2, c)
	//获取用户信息
	userContext, exist := c.Get("user")
	if !exist {
		color.Danger.Println("失败了")
	}
	//查询用户组及该组的功能权限
	user, ok := userContext.(models.QyUser) //这个是类型推断,判断接口是什么类型
	if !ok {

		color.Danger.Println("断言失败")
	}
	req := CreateGroupReq{}
	if err := c.ShouldBindJSON(&req); err != nil {
		color.Red.Println("绑定失败")
	}
	data := map[string]interface{}{
		"organize":    user.Uid,
		"groupname":   req.GroupName,
		"description": req.Description,
		"status":      req.Status,
	}
	if gid == 0 {
		data["rules"] = ""
		data["operate"] = ""
	}
	optid := models.GroupSave(gid, data)
	if optid > 0 {
		status = 200
		message = "保存成功"
	} else {
		status = 2010
		message = "保存失败"
	}
	c.JSON(http.StatusOK, gin.H{
		"status":  status,
		"message": message,
		"data": map[string]interface{}{
			"group_id": optid,
		},
	})

}

//
// @Summary 权限组操作
// @Description 描述信息
// @Tags group
// @Accept  json
// @Produce  json
// @Router /group/delete/:id [post]
func GroupDelete(c *gin.Context) {

	gid, _ := strconv.Atoi(c.Param("gid"))
	num := models.GetGroupUserNum(gid)

	models.OperateLog("删除权限组", 3, c)
	if num > 0 {
		c.JSON(http.StatusOK, gin.H{
			"status":  2010,
			"message": "该权限组下有绑定的用户，不能删除",
		})
	} else {
		models.GroupOperate(1, gid)
		c.JSON(http.StatusOK, gin.H{
			"status":  200,
			"message": "成功",
		})
	}
}

//功能权限
func GroupfeatureAuth(c *gin.Context) {

	var node map[int][]models.QyAuthOperate
	node = make(map[int][]models.QyAuthOperate)
	//获取菜单节点权限
	apimenu := models.GetMenu(2, 0)
	//获取功能节点权限
	auth := models.GetFeatureAuth()
	for _, v := range auth {
		node[v.Rid] = append(node[v.Rid], v)
	}
	//获取gid
	gid, _ := strconv.Atoi(c.Param("gid"))
	group := models.GetGroupInfo(gid)

	c.HTML(http.StatusOK, "group_feature.html", gin.H{
		"website": Services.GetWebsite(),
		"gid":     gid,
		"apimenu": apimenu,
		"node":    node,
		"rules":   strings.Split(group.Rules, ","),
		"operate": strings.Split(group.Operate, ","),
	})
}

//功能权限保存
func GroupfeatureSave(c *gin.Context) {

	gid, _ := strconv.Atoi(c.Param("gid"))
	req := c.Request
	req.ParseForm()

	operate := ""
	rules := ""
	models.OperateLog("编辑功能权限", 2, c)
	for k, param := range req.PostForm {
		if k == "operate[]" {
			operate = strings.Join(param, ",")
		} else if k == "rules[]" {
			rules = strings.Join(param, ",")
		}
	}
	data := map[string]interface{}{
		"rules":   rules,
		"operate": operate,
	}
	if models.GroupFeatureUpdate(gid, data) {
		c.JSON(http.StatusOK, gin.H{
			"status":  200,
			"message": "保存成功",
		})
	} else {
		c.JSON(http.StatusOK, gin.H{
			"status":  2010,
			"message": "保存失败",
		})
	}

}

//数据权限
func GroupdataAuth(c *gin.Context) {

	//获取用户信息
	userInfo, _ := c.Get("user")
	oid := userInfo.(map[string]interface{})["oid"].(int)
	//获取组织下的权限组
	gid, _ := strconv.Atoi(c.Param("gid"))
	group := models.GetGroupInfo(gid)
	//获取组织下的所有项目
	item := models.GerOrganizeProject(oid)
	//获取当前数据权限
	data := models.GetGroupDataAuth(gid)

	var proids []string
	var classifyIds []string
	for _, v := range data {
		if v.Type == 1 {
			proids = append(proids, v.Record)
		} else if v.Type == 2 {
			classifyIds = strings.Split(v.Record, ",")
		}
	}

	var project map[int]interface{}
	project = make(map[int]interface{})

	for k, v := range item {
		project[k] = map[string]interface{}{
			"Id":        v.Id,
			"Organize":  v.Organize,
			"Proname":   v.Proname,
			"Desc":      v.Desc,
			"Attribute": v.Attribute,
			"Status":    v.Status,
			"Classify":  models.GetClassify(v.Id, 0, []string{}),
		}
	}

	c.HTML(http.StatusOK, "group_data.html", gin.H{
		"website":     Services.GetWebsite(),
		"gid":         gid,
		"group":       group,
		"project":     project,
		"proids":      proids,
		"classifyIds": classifyIds,
	})
}

//数据权限保存
func GroupdataAuthSave(c *gin.Context) {

	gid, _ := strconv.Atoi(c.Param("gid"))
	proids := c.PostForm("proids")
	classifyids := c.PostForm("classifyids")
	authType := c.PostForm("authType")

	time := time.Now().Unix()
	models.OperateLog("编辑数据权限", 2, c)
	//保存项目
	if authType == "xProject" {
		str := []string{}
		for _, v := range strings.Split(proids, ",") {
			temp := ""
			proid, _ := strconv.Atoi(v)
			if proid > 0 {

				temp = "(" + c.Param("gid") + ",1," + v + "," + strconv.FormatInt(time, 10) + ")"
				str = append(str, temp)
			}
		}
		if models.ProjectDataSave(gid, str) {
			c.JSON(http.StatusOK, gin.H{
				"status":  200,
				"message": "保存成功",
			})
		} else {
			c.JSON(http.StatusOK, gin.H{
				"status":  2010,
				"message": "保存失败，请稍后重试",
			})
		}
	}
	//保存接口分类
	if authType == "xClassify" {
		str := strings.Trim(classifyids, ",")
		data := models.AuthData{
			gid,
			2,
			str,
			int(time),
		}
		if models.ClassifyDataSave(gid, data) {
			c.JSON(http.StatusOK, gin.H{
				"status":  200,
				"message": "保存成功",
			})
		} else {
			c.JSON(http.StatusOK, gin.H{
				"status":  2010,
				"message": "保存失败，请稍后重试",
			})
		}
	}
}

//获取权限组
func AjaxGroupList(c *gin.Context) {

	//获取用户信息
	userContext, exist := c.Get("user")
	if !exist {
		color.Danger.Println("失败了")
	}
	//查询用户组及该组的功能权限
	user, ok := userContext.(models.QyUser) //这个是类型推断,判断接口是什么类型
	if !ok {

		color.Danger.Println("断言失败")
	}
	//获取组织下的权限组
	group := models.GetOrganizeGroup(user.Uid)

	c.JSON(http.StatusOK, gin.H{
		"status":  200,
		"message": "成功",
		"data":    group,
	})

}
