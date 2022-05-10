package models

import (
	"time"
	"xapimanager/application/common"
)

type QyUser struct {
	Uid      int    `json:"uid" gorm:"primary_key"`
	Username string `json:"username"`
	Email    string `json:"email"`
	Avatar   string `json:"avatar"`
	Phone    string `json:"phone"`
	Intro    string `json:"intro"`
	Password string `json:"password"`
	Salt     string `json:"salt"`
	Isadmin  int    `json:"isadmin"`

	Ctime int `json:"ctime"`
}
type UserGroup struct {
	Uid       int
	GroupId   int
	Groupname string
}
type UserOrganize struct {
	Uid      int
	Leader   int
	Organize int
	Name     string
	Desc     string
	Identify string
	Icon     string
}
type UserInfo struct {
	Uid      int
	Username string
	Email    string
	Phone    string
	Intro    string
	Status   string
}
type OrganizeUsers struct {
	UserInfo
	Groupname string
}
type UserRole struct {
	GroupId   int
	Groupname string
}
type AuthAccess struct {
	Uid     int
	GroupId int
}
type QyEmail struct {
	Id        int
	From      string
	Toaddress string
	Toname    string
	Subject   string
	Content   string
	Status    int
	Reason    string
}

//获取用户所在的所有组织
func GetOrganize(uid int) (organize []UserOrganize) {

	Db = Connect()
	Db.Hander.Table("qy_user_organize as u").
		Joins("join qy_organize as o on u.organize = o.id").
		Select("u.uid, u.organize, o.leader, o.name, o.desc , o.identify, o.icon").
		Where("u.uid=?", uid).
		Find(&organize)

	return

}

//获取用户组织id
func GetOrganizeIds(uid int) (Ids []int) {

	organize := GetOrganize(uid)
	for _, v := range organize {
		Ids = append(Ids, v.Organize)
	}
	return Ids
}

//获取用户组
func GetGroup(uid int) (group []UserGroup) {

	Db = Connect()
	Db.Hander.Table("qy_auth_access as a").
		Joins("join qy_auth_group as g on a.group_id = g.id").
		Select("a.uid, a.group_id, g.groupname").
		Where("a.uid=?", uid).
		Scan(&group)

	return

}

//获取用户组id
func GetGroupIds(uid int) (Ids []int) {

	organize := GetGroup(uid)
	for _, v := range organize {
		Ids = append(Ids, v.GroupId)
	}
	return Ids
}

//获取组织下的用户列表
func GetOrganizeUsers(oid int, keyword string, status int, gid int, start int, limit int) (result map[string]interface{}) {

	Db = Connect()
	var count int64
	var users []OrganizeUsers

	info := Db.Hander.Table("qy_user_organize as uo").
		Joins("left join qy_user as u on u.uid = uo.uid").
		Joins("left join qy_auth_access as a on a.uid = uo.uid").
		Joins("left join qy_auth_group as g on g.id = a.group_id").
		Select("u.uid, u.username, u.email , u.phone, uo.status, g.groupname").
		Where("uo.organize=?", oid)

	//搜索条件判断
	if keyword != "" {
		switch {
		case common.IsPhone(keyword):
			info = info.Where("u.phone = ?", keyword)
		case common.IsEmail(keyword):
			info = info.Where("u.email = ?", keyword)
		default:
			info = info.Where("u.username like ?", "%"+keyword+"%")
		}
	}
	if status > 0 {
		info = info.Where("uo.status = ?", status)
	}
	if gid > 0 {
		info = info.Where("a.group_id = ?", gid)
	}
	//查询信息
	info.Count(&count)
	info.Offset(start).Limit(limit).Find(&users)

	result = map[string]interface{}{
		"totalCount": count,
		"list":       users,
	}

	return

}

//获取用户信息
func GetUserInfo(uid int) (result UserInfo) {

	Db = Connect()
	Db.Hander.Table("qy_user as u").
		Where("u.uid = ?", uid).Find(&result)

	return
}

func QueryByUsername(username string) (result QyUser) {

	Db = Connect()
	Db.Hander.Table("qy_user").Where("username = ?", username).First(&result)
	return

}

//通过获取用户信息,多条件查询
func GetUserDetail(data map[string]interface{}) (result QyUser) {

	Db = Connect()
	Db.Hander.Table("qy_user").Where(data).Find(&result)

	return
}

//用户检查
func GetUserCheck(uid int, username string, phone string, email string) bool {

	Db = Connect()
	var count int64
	obj := Db.Hander.Table("qy_user").
		Where("username = ? or phone = ? or email= ?", username, phone, email).
		Where("status in (?)", []string{"1", "2"})
	if uid > 0 {
		obj = obj.Where("uid !=", uid)
	}
	obj.Count(&count)

	if count > 0 {
		return true
	} else {
		return false
	}
}

//获取用户在当前组织下的角色
func GetOrganizeRole(oid int, uid int) (rule UserRole) {

	Db = Connect()
	Db.Hander.Table("qy_auth_access as a").
		Joins("join qy_auth_group as g on a.group_id = g.id").
		Select("a.group_id, g.groupname").
		Where("g.organize=? and a.uid=?", oid, uid).
		Scan(&rule)

	return
}

//添加用户
func UserSave(data map[string]interface{}) (insertId int) {

	Db = Connect()
	ctime := time.Now().Unix()
	info := QyUser{
		0,
		data["username"].(string),
		data["email"].(string),
		"",
		data["phone"].(string),
		"",
		data["password"].(string),
		data["salt"].(string),
		1,
		int(ctime),
	}
	Db.Hander.Table("qy_user").Create(&info)
	//insertId = obj.(*QyUser).Uid

	return info.Uid

}

//更新用户信息
func UpdateUser(uid int, data map[string]interface{}) (result bool) {

	Db = Connect()
	err := Db.Hander.Table("qy_user").Where("uid = ?", uid).Updates(data).Error
	if err != nil {
		return false
	}
	return true
}

//更新用户权限组
func UpdateUserGroup(uid int, group_id int) (result bool) {

	Db = Connect()
	var count int
	//Db.Hander.Table("qy_auth_access").Where("uid = ?", uid).Count(&count)
	Db.Hander.Table("qy_auth_access").Where("uid = ?", uid).Delete(struct{}{})
	if count > 0 {
		err := Db.Hander.Table("qy_auth_access").Where("uid = ?", uid).Update("group_id", group_id).Error
		if err != nil {
			return false
		}
	} else {
		info := &AuthAccess{uid, group_id}
		err := Db.Hander.Table("qy_auth_access").Create(info).Error
		if err != nil {
			return false
		}
	}
	return true
}

//批量获取用户信息
func BatchUsers(userIds []int) (result map[int]UserInfo) {

	Db = Connect()
	var users []UserInfo
	result = make(map[int]UserInfo)
	Db.Hander.Table("qy_user").Where("uid in (?)", userIds).Find(&users)
	for _, v := range users {
		result[v.Uid] = v
	}

	return
}

//登录用户信息
func LoginUserInfo(info string) (user QyUser) {

	Db = Connect()
	Db.Hander.Table("qy_user").
		Where("username = ? or phone = ? or email= ?", info, info, info).
		Find(&user)
	return
}

//发送邮件记录
func EmailRecord(data map[string]interface{}) bool {

	Db = Connect()
	info := &QyEmail{
		0,
		data["from"].(string),
		data["toaddress"].(string),
		data["toname"].(string),
		data["subject"].(string),
		data["content"].(string),
		data["status"].(int),
		data["reason"].(string),
	}
	err := Db.Hander.Table("qy_email").Create(info).Error
	if err != nil {
		return false
	}
	return true
}
