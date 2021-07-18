package config

import (
	"encoding/json"
	"io/ioutil"
)

type Global struct {
	DEBUG         bool   `json:"debug"`
	ServerPort    string `json:"server_port"`
	ServerWebsite string `json:"server_website"`

	MysqlIp       string `json:"mysql_ip"`
	MysqlPort     string `json:"mysql_port"`
	MysqlUsername string `json:"mysql_username"`
	MysqlPassword string `json:"mysql_password"`
	MysqlDbname   string `json:"mysql_dbname"`
	MysqlPrefix   string `json:"mysql_prefix"`

	RedisIp       string `json:"redis_ip"`
	RedisPort     string `json:"redis_port"`
	RedisPassword string `json:"redis_password"`
	RedisDb       int    `json:"redis_db"`

	LogPath      string `json:"log_path"`
	TemplatePath string `json:"template_pate"`
	AssetsPath   string `json:"assets_path"`
	UploadPath   string `json:"upload_path"`

	DbLogMode         bool `json:"DbLogMode"`         //数据库日志模式，开启true, 关闭false
	DbMaxIdleConns    int  `json:"DbMaxIdleConns"`    //最大空闲连接数
	DbMaxOpenConns    int  `json:"DbMaxOpenConns"`    //最大连接数
	DbConnMaxLifetime int  `json:"DbConnMaxLifetime"` //mysql超时时间

	UserCache int `json:"user_cache"` //用户缓存，单位s
	SysCache  int `json:"sys_cache"`  //系统缓存，单位s

}

func GetGlobal() *Global {

	conf := "./config/config.json"
	data, _ := ioutil.ReadFile(conf)

	global := &Global{}
	json.Unmarshal(data, &global)

	return global
}
