package manager

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"math/rand"
	"net/http"
	"strconv"
	"xapimanager/application/Services"
	"xapimanager/application/models"
)

//控制台
// @Summary
// @Description 描述信息
// @Tags dashboard
// @Accept  json
// @Produce  json
// @Router /dashboard [get]
func Dashboard(c *gin.Context) {
	fmt.Print("dashboard")
	proid, _ := strconv.Atoi(c.Param("proid"))

	c.JSON(http.StatusOK, gin.H{
		"website": Services.GetWebsite(),
		"proid":   proid,
	})
}

//各地区api调用量
func DashboardArea(c *gin.Context) {

	var result []map[string]interface{}
	data := models.GetAreaData()

	for _, v := range data {
		temp := map[string]interface{}{
			"area_id":   v.AreaId,
			"name":      v.AreaName,
			"value":     rand.Intn(200),
			"longitude": v.Longitude,
			"latitude":  v.Latitude,
		}
		result = append(result, temp)
	}

	c.JSON(http.StatusOK, gin.H{
		"status":  200,
		"message": "成功",
		"data":    result,
	})
}
