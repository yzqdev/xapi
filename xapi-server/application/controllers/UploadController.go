package controllers

import (
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
	"strings"
	"time"
	"xapimanager/application/common"
	"xapimanager/config"
)

// UploadImage 图片上传
func UploadImage(c *gin.Context) {
	file, _ := c.FormFile("file")
	// 保存文件
	year, month, _ := time.Now().Date()
	sysconfig := config.GetGlobal()

	suffix := common.GetFileSuffix(file.Filename)
	filename := strconv.Itoa(int(time.Now().UnixNano()/1e6)) + suffix
	dstdir := sysconfig.UploadPath + "/images/tmp/" + strconv.Itoa(year) + "/" + month.String()
	common.CreateDir(dstdir)
	dstfile := dstdir + "/" + filename
	c.SaveUploadedFile(file, dstfile)
	dst := strings.Split(dstfile, "storage")
	c.JSON(http.StatusOK, gin.H{
		"link": dst[1],
	})

}
