package routes

import (
	"github.com/gin-gonic/gin"
	"xapimanager/application/controllers"
	"xapimanager/application/controllers/manager"
	"xapimanager/application/middleware"
	"xapimanager/application/requests"
)

type login struct {
	Username string `form:"username" json:"username" binding:"required"`
	Password string `form:"password" json:"password" binding:"required"`
}

var identityKey = "id"

func projectRouter(router *gin.Engine) {
	// the jwt middleware

	basicRouter := router.Group("")
	{
		basicRouter.POST("/login", controllers.FetchLogin)

		basicRouter.GET("/logout", controllers.Logout)
		basicRouter.POST("/reg", controllers.AjaxRegister)
		basicRouter.GET("/getIndex", middleware.JwtHandler(), controllers.Index)
		//manager 主页
		basicRouter.GET("/manager/:proid", middleware.JwtHandler(), controllers.Manager)
		//注册验证
		basicRouter.POST("/register/check", controllers.RegisterCheck)
	}
	apiRouter := router.Group("/manager/:proid", middleware.ApiAuthCheck())
	{
		//控制台
		apiRouter.GET("/dash/area", manager.DashboardArea)
		//Api列表
		apiRouter.GET("/Api", manager.GetAjaxApilist)
		//Api保存
		apiRouter.POST("/Api/store", requests.ApiVerify(), manager.ApiStore)
		//Api待审核操作
		apiRouter.POST("/Api/audit", manager.ApiAuditOpearate)
		//Api删除操作
		apiRouter.POST("/Api/operate", manager.ApiOpearate)
		//Api 发布
		apiRouter.POST("/Api/publish", manager.ApiPublish)
		//Api 废弃
		apiRouter.POST("/Api/discard", manager.ApiDiscard)
		//Api分类保存
		apiRouter.POST("/category/store", requests.CategoryVerify(), manager.CategorySave)
		//Api分类操作
		apiRouter.POST("/category/operate", manager.CategoryOperate)
		//企业密钥
		apiRouter.GET("/company/list", manager.GetAjaxCompany)
		//创建/编辑企业秘钥
		apiRouter.POST("/company/store", requests.CompanyVerify(), manager.CompanySave)
		//企业密钥操作
		apiRouter.POST("/company/operate", manager.CompanyOperate)
	}
	projRouter := router.Group("/project")
	{
		//保存项目
		projRouter.POST("/info", controllers.ProjectSave)
		//项目环境
		projRouter.POST("/env/:proid", requests.ProjectEnv(), controllers.ProjectEnvSave)
		//项目切换
		projRouter.POST("/envchange", controllers.ProjectEnvChange)
		projRouter.GET("/all", controllers.ProjectList)
	}
	//json路由
	organizeRouter := router.Group("/organize", middleware.JwtHandler())
	{
		//组织搜索
		organizeRouter.GET("/search/:identify", controllers.Search)
		//加入组织
		organizeRouter.POST("/join/:identify", controllers.OrganizeJoin)
		//退出组织
		organizeRouter.POST("/quit/:oid", controllers.OrganizeQuit)
		//编辑组织信息
		organizeRouter.POST("/detail/:oid", controllers.OrganizeUpate)
		organizeRouter.POST("/create", controllers.OrganizeCreate)
	}
	userRouter := router.Group("/users", middleware.JwtHandler())
	{

		//用户列表
		userRouter.POST("/all", controllers.AjaxUserList)
		userRouter.POST("/list", controllers.UserList)
		//用户详情
		userRouter.POST("/update/:userid", controllers.UserUpdate)
		userRouter.POST("/details/:userid", controllers.UserDetail)
		//个人资料修改
		userRouter.POST("/person/store", controllers.UserPersonStore)
		userRouter.GET("/person", controllers.UserPerson)
		//个人中心数据检查
		userRouter.POST("/person/check", controllers.UserPersonCheck)
	}
	groupRouter := router.Group("/group", middleware.JwtHandler())
	{
		groupRouter.GET("/list", controllers.GroupList)
		//编辑权限组
		groupRouter.POST("/create", controllers.GroupSave)
		groupRouter.POST("/delete/:gid", controllers.GroupDelete)
		//功能权限
		groupRouter.POST("/featureAuth/:gid", controllers.GroupfeatureSave)
		//数据权限
		groupRouter.POST("/dataAuth/:gid", controllers.GroupdataAuthSave)
		//获取权限组
		groupRouter.GET("/all", controllers.AjaxGroupList)
	}
	logRouter := router.Group("/log", middleware.Auth())
	{
		//获取日志列表数据
		logRouter.GET("/all", controllers.AjaxOperateLog)
	}
	websiteRouter := router.Group("/website", middleware.JwtHandler())
	{
		websiteRouter.GET("/web", controllers.Website)
		//网站设置
		websiteRouter.POST("/info", controllers.WebsiteInfo)
	}
	cacheRouter := router.Group("/cache", middleware.Auth())
	{
		//清除缓存
		cacheRouter.GET("/clear", controllers.ClearCache)
	}
	messageRouter := router.Group("/message", middleware.Auth())
	{
		//消息列表
		messageRouter.GET("/list", controllers.GetAjaxMessageList)
		//消息操作
		messageRouter.POST("/operate", controllers.MessageOperate)
		//获取未读消息数
		messageRouter.GET("/unread", controllers.GetUnreadMessage)
	}
	helpRouter := router.Group("/help", middleware.JwtHandler())
	{
		//帮助中心
		helpRouter.GET("/list", controllers.AjaxHelpList)
		//帮助中心操作
		helpRouter.POST("/operate", controllers.HelpDelete)
		//帮助中心文章保存
		helpRouter.POST("/store", controllers.HelpStore)
		//新增帮助
		helpRouter.GET("/info", controllers.HelpInfo)
	}
	uploadRouter := router.Group("/uploads", middleware.Auth())
	{
		//图片上传
		uploadRouter.POST("/image", controllers.UploadImage)
	}

}
