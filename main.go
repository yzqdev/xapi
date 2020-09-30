package main

import (
	"github.com/gin-gonic/gin"
	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
	"os/exec"
	"runtime"
	"xapimanager/application/common"
	"xapimanager/config"
	"xapimanager/docs"
	"xapimanager/routes"
)

func Run() {
	docs.SwaggerInfo.Title = "Swagger Example API"
	docs.SwaggerInfo.Description = "This is a sample server Petstore server."
	docs.SwaggerInfo.Version = "1.0"
	docs.SwaggerInfo.Host = "localhost:6300"
	docs.SwaggerInfo.BasePath = "/"
	docs.SwaggerInfo.Schemes = []string{"http", "https"}
	runtime.GOMAXPROCS(runtime.NumCPU())

	sysconfig := config.GetGlobal()

	if sysconfig.DEBUG {
		gin.SetMode(gin.DebugMode)
	} else {
		gin.SetMode(gin.ReleaseMode)
	}

	router := routes.InitRouter()
	router.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))
	router.Run(":" + sysconfig.ServerPort)

	common.Open(sysconfig.ServerWebsite)
}
func main() {
	// programatically set swagger info
	cmd := exec.Command("swag", "init")
	cmd.Run()
	   Run()

}
