package main

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/gookit/color"
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

	runtime.GOMAXPROCS(runtime.NumCPU())

	sysconfig := config.GetGlobal()

	if sysconfig.DEBUG {
		gin.SetMode(gin.DebugMode)
	} else {
		gin.SetMode(gin.ReleaseMode)
	}
	cmd := exec.Command("swag", "init")
	err := cmd.Run()
	if err != nil {
		color.Red.Print("发生错误")
	}
	router := routes.InitRouter()
	router.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))
	router.Run(":" + sysconfig.ServerPort)

	common.Open(sysconfig.ServerWebsite)
	swaggerUrl := "http://localhost:" + sysconfig.ServerPort + "/swagger/index.html"
	fmt.Printf("%s\n", swaggerUrl)
}
func main() {
	// programatically set swagger info

	docs.SwaggerInfo.Title = "Swagger Example API"
	docs.SwaggerInfo.Description = "xapi的帮助文档."
	docs.SwaggerInfo.Version = "1.0"
	docs.SwaggerInfo.Host = "localhost:6300"
	docs.SwaggerInfo.BasePath = "/"
	docs.SwaggerInfo.Schemes = []string{"http", "https"}
	Run()

}
