/*
 Navicat Premium Data Transfer

 Source Server         : localpg
 Source Server Type    : PostgreSQL
 Source Server Version : 140002
 Source Host           : localhost:5432
 Source Catalog        : xapi
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 140002
 File Encoding         : 65001

 Date: 18/05/2022 09:32:50
*/


-- ----------------------------
-- Table structure for qy_apidetail
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_apidetail";
CREATE TABLE "public"."qy_apidetail" (
  "id" int4 NOT NULL,
  "listid" int4 NOT NULL,
  "proid" int4 NOT NULL,
  "envid" int4 NOT NULL,
  "apiname" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "subclassify" int4 NOT NULL,
  "version" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "uri" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "gateway" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "local" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "network" int2 NOT NULL,
  "authentication" int2 NOT NULL,
  "description" text COLLATE "pg_catalog"."default" NOT NULL,
  "author" int4 NOT NULL,
  "editor" varchar(100) COLLATE "pg_catalog"."default",
  "method" int2,
  "requesttype" int2,
  "responsetype" int2,
  "header" text COLLATE "pg_catalog"."default",
  "request" text COLLATE "pg_catalog"."default",
  "response" text COLLATE "pg_catalog"."default",
  "statuscode" text COLLATE "pg_catalog"."default",
  "successgoback" text COLLATE "pg_catalog"."default",
  "failgoback" text COLLATE "pg_catalog"."default",
  "status" int2 NOT NULL,
  "mtime" int4,
  "ctime" int4
)
;
COMMENT ON COLUMN "public"."qy_apidetail"."id" IS '接口id';
COMMENT ON COLUMN "public"."qy_apidetail"."listid" IS '列表id，同一个Api的多个版本，listid相同';
COMMENT ON COLUMN "public"."qy_apidetail"."proid" IS '项目id';
COMMENT ON COLUMN "public"."qy_apidetail"."envid" IS '环境id';
COMMENT ON COLUMN "public"."qy_apidetail"."apiname" IS 'api名称';
COMMENT ON COLUMN "public"."qy_apidetail"."subclassify" IS '子分类id';
COMMENT ON COLUMN "public"."qy_apidetail"."version" IS '版本';
COMMENT ON COLUMN "public"."qy_apidetail"."uri" IS '接口URI部分';
COMMENT ON COLUMN "public"."qy_apidetail"."gateway" IS 'gateway地址';
COMMENT ON COLUMN "public"."qy_apidetail"."local" IS 'localapi本地开发地址';
COMMENT ON COLUMN "public"."qy_apidetail"."network" IS '网络访问(1内网,2外网)';
COMMENT ON COLUMN "public"."qy_apidetail"."authentication" IS '认证方式(1session认证,2key/secret认证)';
COMMENT ON COLUMN "public"."qy_apidetail"."description" IS '接口描述';
COMMENT ON COLUMN "public"."qy_apidetail"."author" IS '开发者';
COMMENT ON COLUMN "public"."qy_apidetail"."editor" IS '编辑人';
COMMENT ON COLUMN "public"."qy_apidetail"."method" IS '请求方法(1GET,2POST,3PUT,4DELETE)';
COMMENT ON COLUMN "public"."qy_apidetail"."requesttype" IS '请求类型(1json,2xml,3form,4raw)';
COMMENT ON COLUMN "public"."qy_apidetail"."responsetype" IS '响应类型(1json,2xml,3jsonp,4html)';
COMMENT ON COLUMN "public"."qy_apidetail"."header" IS 'header参数';
COMMENT ON COLUMN "public"."qy_apidetail"."request" IS '请求参数';
COMMENT ON COLUMN "public"."qy_apidetail"."response" IS '响应参数';
COMMENT ON COLUMN "public"."qy_apidetail"."statuscode" IS '状态码';
COMMENT ON COLUMN "public"."qy_apidetail"."successgoback" IS '成功示例';
COMMENT ON COLUMN "public"."qy_apidetail"."failgoback" IS '失败示例';
COMMENT ON COLUMN "public"."qy_apidetail"."status" IS '状态(1已审核,2待审核,3.废弃,4已删除,5已拒绝)';
COMMENT ON COLUMN "public"."qy_apidetail"."mtime" IS '修改时间';
COMMENT ON COLUMN "public"."qy_apidetail"."ctime" IS '添加时间';

-- ----------------------------
-- Records of qy_apidetail
-- ----------------------------

-- ----------------------------
-- Table structure for qy_apienv
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_apienv";
CREATE TABLE "public"."qy_apienv" (
  "id" int4 NOT NULL,
  "proid" int4 NOT NULL,
  "envname" varchar(60) COLLATE "pg_catalog"."default",
  "domain" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "sort" int2 NOT NULL,
  "status" int2
)
;
COMMENT ON COLUMN "public"."qy_apienv"."id" IS 'id';
COMMENT ON COLUMN "public"."qy_apienv"."proid" IS '项目id';
COMMENT ON COLUMN "public"."qy_apienv"."envname" IS '环境名称';
COMMENT ON COLUMN "public"."qy_apienv"."domain" IS '环境域名';
COMMENT ON COLUMN "public"."qy_apienv"."sort" IS '排序';
COMMENT ON COLUMN "public"."qy_apienv"."status" IS '状态(1已启用,2已禁用)';

-- ----------------------------
-- Records of qy_apienv
-- ----------------------------
INSERT INTO "public"."qy_apienv" VALUES (1, 1, '线上环境', 'http://api.smaty.net', 0, 1);
INSERT INTO "public"."qy_apienv" VALUES (2, 1, '预发布环境', 'http://api.pre.smaty.net', 1, 1);
INSERT INTO "public"."qy_apienv" VALUES (3, 1, '集成环境', 'http://api.sit.smaty.net', 2, 1);
INSERT INTO "public"."qy_apienv" VALUES (4, 1, '测试环境', 'http://api.test.smaty.net', 3, 1);

-- ----------------------------
-- Table structure for qy_area
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_area";
CREATE TABLE "public"."qy_area" (
  "id" int4 NOT NULL,
  "area_id" int4 NOT NULL,
  "area_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "pid" int4 NOT NULL,
  "longitude" float8,
  "latitude" float8,
  "sort" int4 NOT NULL
)
;
COMMENT ON COLUMN "public"."qy_area"."area_id" IS '地区id';
COMMENT ON COLUMN "public"."qy_area"."area_name" IS '地区名称';
COMMENT ON COLUMN "public"."qy_area"."pid" IS '父级地区ID';
COMMENT ON COLUMN "public"."qy_area"."longitude" IS '经度';
COMMENT ON COLUMN "public"."qy_area"."latitude" IS '纬度';
COMMENT ON COLUMN "public"."qy_area"."sort" IS '排序值';

-- ----------------------------
-- Records of qy_area
-- ----------------------------
INSERT INTO "public"."qy_area" VALUES (1, 110000, '北京市', 0, 116.46, 39.92, 0);
INSERT INTO "public"."qy_area" VALUES (2, 110100, '北京市', 110000, 116.46, 39.92, 1);
INSERT INTO "public"."qy_area" VALUES (3, 120000, '天津市', 0, 117.2, 39.13, 2);
INSERT INTO "public"."qy_area" VALUES (4, 130000, '河北省', 0, 0, 0, 3);
INSERT INTO "public"."qy_area" VALUES (5, 130100, '石家庄市', 130000, 114.48, 38.03, 4);
INSERT INTO "public"."qy_area" VALUES (6, 130181, '辛集市', 130100, 0, 0, 5);
INSERT INTO "public"."qy_area" VALUES (7, 130182, '藁城市', 130100, 0, 0, 6);
INSERT INTO "public"."qy_area" VALUES (8, 130183, '晋州市', 130100, 0, 0, 7);
INSERT INTO "public"."qy_area" VALUES (9, 130184, '新乐市', 130100, 0, 0, 8);
INSERT INTO "public"."qy_area" VALUES (10, 130185, '鹿泉市', 130100, 0, 0, 9);
INSERT INTO "public"."qy_area" VALUES (11, 130200, '唐山市', 130000, 118.02, 39.63, 10);
INSERT INTO "public"."qy_area" VALUES (12, 130281, '遵化市', 130200, 0, 0, 11);
INSERT INTO "public"."qy_area" VALUES (13, 130283, '迁安市', 130200, 0, 0, 12);
INSERT INTO "public"."qy_area" VALUES (14, 130300, '秦皇岛市', 130000, 119.57, 39.95, 13);
INSERT INTO "public"."qy_area" VALUES (15, 130400, '邯郸市', 130000, 114.47, 36.6, 14);
INSERT INTO "public"."qy_area" VALUES (16, 130481, '武安市', 130400, 0, 0, 15);
INSERT INTO "public"."qy_area" VALUES (17, 130500, '邢台市', 130000, 114.48, 37.05, 16);
INSERT INTO "public"."qy_area" VALUES (18, 130581, '南宫市', 130500, 0, 0, 17);
INSERT INTO "public"."qy_area" VALUES (19, 130582, '沙河市', 130500, 0, 0, 18);
INSERT INTO "public"."qy_area" VALUES (20, 130600, '保定市', 130000, 115.48, 38.85, 19);
INSERT INTO "public"."qy_area" VALUES (21, 130681, '涿州市', 130600, 0, 0, 20);
INSERT INTO "public"."qy_area" VALUES (22, 130682, '定州市', 130600, 0, 0, 21);
INSERT INTO "public"."qy_area" VALUES (23, 130683, '安国市', 130600, 0, 0, 22);
INSERT INTO "public"."qy_area" VALUES (24, 130684, '高碑店市', 130600, 0, 0, 23);
INSERT INTO "public"."qy_area" VALUES (25, 130700, '张家口市', 130000, 114.87, 40.82, 24);
INSERT INTO "public"."qy_area" VALUES (26, 130800, '承德市', 130000, 117.93, 40.97, 25);
INSERT INTO "public"."qy_area" VALUES (27, 130900, '沧州市', 130000, 116.83, 38.33, 26);
INSERT INTO "public"."qy_area" VALUES (28, 130981, '泊头市', 130900, 0, 0, 27);
INSERT INTO "public"."qy_area" VALUES (29, 130982, '任丘市', 130900, 0, 0, 28);
INSERT INTO "public"."qy_area" VALUES (30, 130983, '黄骅市', 130900, 0, 0, 29);
INSERT INTO "public"."qy_area" VALUES (31, 130984, '河间市', 130900, 0, 0, 30);
INSERT INTO "public"."qy_area" VALUES (32, 131000, '廊坊市', 130000, 116.7, 39.53, 31);
INSERT INTO "public"."qy_area" VALUES (33, 131081, '霸州市', 131000, 0, 0, 32);
INSERT INTO "public"."qy_area" VALUES (34, 131082, '三河市', 131000, 0, 0, 33);
INSERT INTO "public"."qy_area" VALUES (35, 131100, '衡水市', 130000, 115.72, 37.72, 34);
INSERT INTO "public"."qy_area" VALUES (36, 131181, '冀州市', 131100, 0, 0, 35);
INSERT INTO "public"."qy_area" VALUES (37, 131182, '深州市', 131100, 0, 0, 36);
INSERT INTO "public"."qy_area" VALUES (38, 140000, '山西省', 0, 0, 0, 37);
INSERT INTO "public"."qy_area" VALUES (39, 140100, '太原市', 140000, 112.53, 37.87, 38);
INSERT INTO "public"."qy_area" VALUES (40, 140181, '古交市', 140100, 0, 0, 39);
INSERT INTO "public"."qy_area" VALUES (41, 140200, '大同市', 140000, 113.3, 40.12, 40);
INSERT INTO "public"."qy_area" VALUES (42, 140300, '阳泉市', 140000, 113.57, 37.85, 41);
INSERT INTO "public"."qy_area" VALUES (43, 140400, '长治市', 140000, 113.08, 36.18, 42);
INSERT INTO "public"."qy_area" VALUES (44, 140481, '潞城市', 140400, 0, 0, 43);
INSERT INTO "public"."qy_area" VALUES (45, 140500, '晋城市', 140000, 0, 0, 44);
INSERT INTO "public"."qy_area" VALUES (46, 140581, '高平市', 140500, 0, 0, 45);
INSERT INTO "public"."qy_area" VALUES (47, 140600, '朔州市', 140000, 0, 0, 46);
INSERT INTO "public"."qy_area" VALUES (48, 140700, '晋中市', 140000, 0, 0, 47);
INSERT INTO "public"."qy_area" VALUES (49, 140781, '介休市', 140700, 0, 0, 48);
INSERT INTO "public"."qy_area" VALUES (50, 140800, '运城市', 140000, 0, 0, 49);
INSERT INTO "public"."qy_area" VALUES (51, 140881, '永济市', 140800, 0, 0, 50);
INSERT INTO "public"."qy_area" VALUES (52, 140882, '河津市', 140800, 0, 0, 51);
INSERT INTO "public"."qy_area" VALUES (53, 140900, '忻州市', 140000, 0, 0, 52);
INSERT INTO "public"."qy_area" VALUES (54, 140981, '原平市', 140900, 0, 0, 53);
INSERT INTO "public"."qy_area" VALUES (55, 141000, '临汾市', 140000, 111.5, 36.08, 54);
INSERT INTO "public"."qy_area" VALUES (56, 141081, '侯马市', 141000, 0, 0, 55);
INSERT INTO "public"."qy_area" VALUES (57, 141082, '霍州市', 141000, 0, 0, 56);
INSERT INTO "public"."qy_area" VALUES (58, 141100, '吕梁市', 140000, 0, 0, 57);
INSERT INTO "public"."qy_area" VALUES (59, 141181, '孝义市', 141100, 0, 0, 58);
INSERT INTO "public"."qy_area" VALUES (60, 141182, '汾阳市', 141100, 0, 0, 59);
INSERT INTO "public"."qy_area" VALUES (61, 150000, '内蒙古', 0, 0, 0, 60);
INSERT INTO "public"."qy_area" VALUES (62, 150100, '呼和浩特市', 150000, 111.65, 40.82, 61);
INSERT INTO "public"."qy_area" VALUES (63, 150121, '土默特左旗', 150100, 0, 0, 62);
INSERT INTO "public"."qy_area" VALUES (64, 150200, '包头市', 150000, 110, 40.58, 63);
INSERT INTO "public"."qy_area" VALUES (65, 150221, '土默特右旗', 150200, 0, 0, 64);
INSERT INTO "public"."qy_area" VALUES (66, 150223, '达尔罕茂明安联合旗', 150200, 0, 0, 65);
INSERT INTO "public"."qy_area" VALUES (67, 150300, '乌海市', 150000, 0, 0, 66);
INSERT INTO "public"."qy_area" VALUES (68, 150400, '赤峰市', 150000, 118.87, 42.28, 67);
INSERT INTO "public"."qy_area" VALUES (69, 150421, '阿鲁科尔沁旗', 150400, 0, 0, 68);
INSERT INTO "public"."qy_area" VALUES (70, 150422, '巴林左旗', 150400, 0, 0, 69);
INSERT INTO "public"."qy_area" VALUES (71, 150423, '巴林右旗', 150400, 0, 0, 70);
INSERT INTO "public"."qy_area" VALUES (72, 150425, '克什克腾旗', 150400, 0, 0, 71);
INSERT INTO "public"."qy_area" VALUES (73, 150426, '翁牛特旗', 150400, 0, 0, 72);
INSERT INTO "public"."qy_area" VALUES (74, 150428, '喀喇沁旗', 150400, 0, 0, 73);
INSERT INTO "public"."qy_area" VALUES (75, 150430, '敖汉旗', 150400, 0, 0, 74);
INSERT INTO "public"."qy_area" VALUES (76, 150500, '通辽市', 150000, 0, 0, 75);
INSERT INTO "public"."qy_area" VALUES (77, 150521, '科尔沁左翼中旗', 150500, 0, 0, 76);
INSERT INTO "public"."qy_area" VALUES (78, 150522, '科尔沁左翼后旗', 150500, 0, 0, 77);
INSERT INTO "public"."qy_area" VALUES (79, 150524, '库伦旗', 150500, 0, 0, 78);
INSERT INTO "public"."qy_area" VALUES (80, 150525, '奈曼旗', 150500, 0, 0, 79);
INSERT INTO "public"."qy_area" VALUES (81, 150526, '扎鲁特旗', 150500, 0, 0, 80);
INSERT INTO "public"."qy_area" VALUES (82, 150581, '霍林郭勒市', 150500, 0, 0, 81);
INSERT INTO "public"."qy_area" VALUES (83, 150600, '鄂尔多斯市', 150000, 109.781327, 39.608266, 82);
INSERT INTO "public"."qy_area" VALUES (84, 150621, '达拉特旗', 150600, 0, 0, 83);
INSERT INTO "public"."qy_area" VALUES (85, 150622, '准格尔旗', 150600, 0, 0, 84);
INSERT INTO "public"."qy_area" VALUES (86, 150623, '鄂托克前旗', 150600, 0, 0, 85);
INSERT INTO "public"."qy_area" VALUES (87, 150624, '鄂托克旗', 150600, 0, 0, 86);
INSERT INTO "public"."qy_area" VALUES (88, 150625, '杭锦旗', 150600, 0, 0, 87);
INSERT INTO "public"."qy_area" VALUES (89, 150626, '乌审旗', 150600, 0, 0, 88);
INSERT INTO "public"."qy_area" VALUES (90, 150627, '伊金霍洛旗', 150600, 0, 0, 89);
INSERT INTO "public"."qy_area" VALUES (91, 150700, '呼伦贝尔市', 150000, 0, 0, 90);
INSERT INTO "public"."qy_area" VALUES (92, 150721, '阿荣旗', 150700, 0, 0, 91);
INSERT INTO "public"."qy_area" VALUES (93, 150722, '莫力达瓦达斡尔族自治旗', 150700, 0, 0, 92);
INSERT INTO "public"."qy_area" VALUES (94, 150723, '鄂伦春自治旗', 150700, 0, 0, 93);
INSERT INTO "public"."qy_area" VALUES (95, 150724, '鄂温克族自治旗', 150700, 0, 0, 94);
INSERT INTO "public"."qy_area" VALUES (96, 150725, '陈巴尔虎旗', 150700, 0, 0, 95);
INSERT INTO "public"."qy_area" VALUES (97, 150726, '新巴尔虎左旗', 150700, 0, 0, 96);
INSERT INTO "public"."qy_area" VALUES (98, 150727, '新巴尔虎右旗', 150700, 0, 0, 97);
INSERT INTO "public"."qy_area" VALUES (99, 150781, '满洲里市', 150700, 0, 0, 98);
INSERT INTO "public"."qy_area" VALUES (100, 150782, '牙克石市', 150700, 0, 0, 99);
INSERT INTO "public"."qy_area" VALUES (101, 150783, '扎兰屯市', 150700, 0, 0, 100);
INSERT INTO "public"."qy_area" VALUES (102, 150784, '额尔古纳市', 150700, 0, 0, 101);
INSERT INTO "public"."qy_area" VALUES (103, 150785, '根河市', 150700, 0, 0, 102);
INSERT INTO "public"."qy_area" VALUES (104, 150800, '巴彦淖尔市', 150000, 0, 0, 103);
INSERT INTO "public"."qy_area" VALUES (105, 150823, '乌拉特前旗', 150800, 0, 0, 104);
INSERT INTO "public"."qy_area" VALUES (106, 150824, '乌拉特中旗', 150800, 0, 0, 105);
INSERT INTO "public"."qy_area" VALUES (107, 150825, '乌拉特后旗', 150800, 0, 0, 106);
INSERT INTO "public"."qy_area" VALUES (108, 150826, '杭锦后旗', 150800, 0, 0, 107);
INSERT INTO "public"."qy_area" VALUES (109, 150900, '乌兰察布市', 150000, 0, 0, 108);
INSERT INTO "public"."qy_area" VALUES (110, 150926, '察哈尔右翼前旗', 150900, 0, 0, 109);
INSERT INTO "public"."qy_area" VALUES (111, 150927, '察哈尔右翼中旗', 150900, 0, 0, 110);
INSERT INTO "public"."qy_area" VALUES (112, 150928, '察哈尔右翼后旗', 150900, 0, 0, 111);
INSERT INTO "public"."qy_area" VALUES (113, 150929, '四子王旗', 150900, 0, 0, 112);
INSERT INTO "public"."qy_area" VALUES (114, 150981, '丰镇市', 150900, 0, 0, 113);
INSERT INTO "public"."qy_area" VALUES (115, 152200, '兴安盟', 150000, 0, 0, 114);
INSERT INTO "public"."qy_area" VALUES (116, 152201, '乌兰浩特市', 152200, 0, 0, 115);
INSERT INTO "public"."qy_area" VALUES (117, 152202, '阿尔山市', 152200, 0, 0, 116);
INSERT INTO "public"."qy_area" VALUES (118, 152221, '科尔沁右翼前旗', 152200, 0, 0, 117);
INSERT INTO "public"."qy_area" VALUES (119, 152222, '科尔沁右翼中旗', 152200, 0, 0, 118);
INSERT INTO "public"."qy_area" VALUES (120, 152223, '扎赉特旗', 152200, 0, 0, 119);
INSERT INTO "public"."qy_area" VALUES (121, 152500, '锡林郭勒盟', 150000, 0, 0, 120);
INSERT INTO "public"."qy_area" VALUES (122, 152501, '二连浩特市', 152500, 0, 0, 121);
INSERT INTO "public"."qy_area" VALUES (123, 152502, '锡林浩特市', 152500, 0, 0, 122);
INSERT INTO "public"."qy_area" VALUES (124, 152522, '阿巴嘎旗', 152500, 0, 0, 123);
INSERT INTO "public"."qy_area" VALUES (125, 152523, '苏尼特左旗', 152500, 0, 0, 124);
INSERT INTO "public"."qy_area" VALUES (126, 152524, '苏尼特右旗', 152500, 0, 0, 125);
INSERT INTO "public"."qy_area" VALUES (127, 152525, '东乌珠穆沁旗', 152500, 0, 0, 126);
INSERT INTO "public"."qy_area" VALUES (128, 152526, '西乌珠穆沁旗', 152500, 0, 0, 127);
INSERT INTO "public"."qy_area" VALUES (129, 152527, '太仆寺旗', 152500, 0, 0, 128);
INSERT INTO "public"."qy_area" VALUES (130, 152528, '镶黄旗', 152500, 0, 0, 129);
INSERT INTO "public"."qy_area" VALUES (131, 152529, '正镶白旗', 152500, 0, 0, 130);
INSERT INTO "public"."qy_area" VALUES (132, 152530, '正蓝旗', 152500, 0, 0, 131);
INSERT INTO "public"."qy_area" VALUES (133, 152900, '阿拉善盟', 150000, 0, 0, 132);
INSERT INTO "public"."qy_area" VALUES (134, 152921, '阿拉善左旗', 152900, 0, 0, 133);
INSERT INTO "public"."qy_area" VALUES (135, 152922, '阿拉善右旗', 152900, 0, 0, 134);
INSERT INTO "public"."qy_area" VALUES (136, 152923, '额济纳旗', 152900, 0, 0, 135);
INSERT INTO "public"."qy_area" VALUES (137, 210000, '辽宁省', 0, 0, 0, 136);
INSERT INTO "public"."qy_area" VALUES (138, 210100, '沈阳市', 210000, 123.38, 41.8, 137);
INSERT INTO "public"."qy_area" VALUES (139, 210181, '新民市', 210100, 0, 0, 138);
INSERT INTO "public"."qy_area" VALUES (140, 210200, '大连市', 210000, 121.62, 38.92, 139);
INSERT INTO "public"."qy_area" VALUES (141, 210281, '瓦房店市', 210200, 121.979603, 39.627114, 140);
INSERT INTO "public"."qy_area" VALUES (142, 210282, '普兰店市', 210200, 0, 0, 141);
INSERT INTO "public"."qy_area" VALUES (143, 210283, '庄河市', 210200, 0, 0, 142);
INSERT INTO "public"."qy_area" VALUES (144, 210300, '鞍山市', 210000, 122.85, 41.12, 143);
INSERT INTO "public"."qy_area" VALUES (145, 210381, '海城市', 210300, 0, 0, 144);
INSERT INTO "public"."qy_area" VALUES (146, 210400, '抚顺市', 210000, 123.97, 41.97, 145);
INSERT INTO "public"."qy_area" VALUES (147, 210500, '本溪市', 210000, 123.73, 41.3, 146);
INSERT INTO "public"."qy_area" VALUES (148, 210600, '丹东市', 210000, 124.37, 40.13, 147);
INSERT INTO "public"."qy_area" VALUES (149, 210681, '东港市', 210600, 0, 0, 148);
INSERT INTO "public"."qy_area" VALUES (150, 210682, '凤城市', 210600, 0, 0, 149);
INSERT INTO "public"."qy_area" VALUES (151, 210700, '锦州市', 210000, 121.15, 41.13, 150);
INSERT INTO "public"."qy_area" VALUES (152, 210781, '凌海市', 210700, 0, 0, 151);
INSERT INTO "public"."qy_area" VALUES (153, 210782, '北宁市', 210700, 0, 0, 152);
INSERT INTO "public"."qy_area" VALUES (154, 210800, '营口市', 210000, 122.18, 40.65, 153);
INSERT INTO "public"."qy_area" VALUES (155, 210881, '盖州市', 210800, 0, 0, 154);
INSERT INTO "public"."qy_area" VALUES (156, 210882, '大石桥市', 210800, 0, 0, 155);
INSERT INTO "public"."qy_area" VALUES (157, 210900, '阜新市', 210000, 0, 0, 156);
INSERT INTO "public"."qy_area" VALUES (158, 211000, '辽阳市', 210000, 0, 0, 157);
INSERT INTO "public"."qy_area" VALUES (159, 211081, '灯塔市', 211000, 0, 0, 158);
INSERT INTO "public"."qy_area" VALUES (160, 211100, '盘锦市', 210000, 122.070714, 41.119997, 159);
INSERT INTO "public"."qy_area" VALUES (161, 211200, '铁岭市', 210000, 0, 0, 160);
INSERT INTO "public"."qy_area" VALUES (162, 211281, '调兵山市', 211200, 0, 0, 161);
INSERT INTO "public"."qy_area" VALUES (163, 211282, '开原市', 211200, 0, 0, 162);
INSERT INTO "public"."qy_area" VALUES (164, 211300, '朝阳市', 210000, 0, 0, 163);
INSERT INTO "public"."qy_area" VALUES (165, 211381, '北票市', 211300, 0, 0, 164);
INSERT INTO "public"."qy_area" VALUES (166, 211382, '凌源市', 211300, 0, 0, 165);
INSERT INTO "public"."qy_area" VALUES (167, 211400, '葫芦岛市', 210000, 120.836932, 40.711052, 166);
INSERT INTO "public"."qy_area" VALUES (168, 211481, '兴城市', 211400, 0, 0, 167);
INSERT INTO "public"."qy_area" VALUES (169, 220000, '吉林省', 0, 0, 0, 168);
INSERT INTO "public"."qy_area" VALUES (170, 220100, '长春市', 220000, 125.35, 43.88, 169);
INSERT INTO "public"."qy_area" VALUES (171, 220181, '九台市', 220100, 0, 0, 170);
INSERT INTO "public"."qy_area" VALUES (172, 220182, '榆树市', 220100, 0, 0, 171);
INSERT INTO "public"."qy_area" VALUES (173, 220183, '德惠市', 220100, 0, 0, 172);
INSERT INTO "public"."qy_area" VALUES (174, 220200, '吉林市', 220000, 126.57, 43.87, 173);
INSERT INTO "public"."qy_area" VALUES (175, 220281, '蛟河市', 220200, 0, 0, 174);
INSERT INTO "public"."qy_area" VALUES (176, 220282, '桦甸市', 220200, 0, 0, 175);
INSERT INTO "public"."qy_area" VALUES (177, 220283, '舒兰市', 220200, 0, 0, 176);
INSERT INTO "public"."qy_area" VALUES (178, 220284, '磐石市', 220200, 0, 0, 177);
INSERT INTO "public"."qy_area" VALUES (179, 220300, '四平市', 220000, 0, 0, 178);
INSERT INTO "public"."qy_area" VALUES (180, 220381, '公主岭市', 220300, 0, 0, 179);
INSERT INTO "public"."qy_area" VALUES (181, 220382, '双辽市', 220300, 0, 0, 180);
INSERT INTO "public"."qy_area" VALUES (182, 220400, '辽源市', 220000, 0, 0, 181);
INSERT INTO "public"."qy_area" VALUES (183, 220500, '通化市', 220000, 0, 0, 182);
INSERT INTO "public"."qy_area" VALUES (184, 220581, '梅河口市', 220500, 0, 0, 183);
INSERT INTO "public"."qy_area" VALUES (185, 220582, '集安市', 220500, 0, 0, 184);
INSERT INTO "public"."qy_area" VALUES (186, 220600, '白山市', 220000, 0, 0, 185);
INSERT INTO "public"."qy_area" VALUES (187, 220681, '临江市', 220600, 0, 0, 186);
INSERT INTO "public"."qy_area" VALUES (188, 220700, '松原市', 220000, 0, 0, 187);
INSERT INTO "public"."qy_area" VALUES (189, 220800, '白城市', 220000, 0, 0, 188);
INSERT INTO "public"."qy_area" VALUES (190, 220881, '洮南市', 220800, 0, 0, 189);
INSERT INTO "public"."qy_area" VALUES (191, 220882, '大安市', 220800, 0, 0, 190);
INSERT INTO "public"."qy_area" VALUES (192, 222400, '延边朝鲜族自治州', 220000, 0, 0, 191);
INSERT INTO "public"."qy_area" VALUES (193, 222401, '延吉市', 222400, 0, 0, 192);
INSERT INTO "public"."qy_area" VALUES (194, 222402, '图们市', 222400, 0, 0, 193);
INSERT INTO "public"."qy_area" VALUES (195, 222403, '敦化市', 222400, 0, 0, 194);
INSERT INTO "public"."qy_area" VALUES (196, 222404, '珲春市', 222400, 0, 0, 195);
INSERT INTO "public"."qy_area" VALUES (197, 222405, '龙井市', 222400, 0, 0, 196);
INSERT INTO "public"."qy_area" VALUES (198, 222406, '和龙市', 222400, 0, 0, 197);
INSERT INTO "public"."qy_area" VALUES (199, 230000, '黑龙江', 0, 0, 0, 198);
INSERT INTO "public"."qy_area" VALUES (200, 230100, '哈尔滨市', 230000, 126.63, 45.75, 199);
INSERT INTO "public"."qy_area" VALUES (201, 230181, '阿城市', 230100, 0, 0, 200);
INSERT INTO "public"."qy_area" VALUES (202, 230182, '双城市', 230100, 0, 0, 201);
INSERT INTO "public"."qy_area" VALUES (203, 230183, '尚志市', 230100, 0, 0, 202);
INSERT INTO "public"."qy_area" VALUES (204, 230184, '五常市', 230100, 0, 0, 203);
INSERT INTO "public"."qy_area" VALUES (205, 230200, '齐齐哈尔市', 230000, 123.97, 47.33, 204);
INSERT INTO "public"."qy_area" VALUES (206, 230281, '讷河市', 230200, 0, 0, 205);
INSERT INTO "public"."qy_area" VALUES (207, 230300, '鸡西市', 230000, 0, 0, 206);
INSERT INTO "public"."qy_area" VALUES (208, 230381, '虎林市', 230300, 0, 0, 207);
INSERT INTO "public"."qy_area" VALUES (209, 230382, '密山市', 230300, 0, 0, 208);
INSERT INTO "public"."qy_area" VALUES (210, 230400, '鹤岗市', 230000, 0, 0, 209);
INSERT INTO "public"."qy_area" VALUES (211, 230500, '双鸭山市', 230000, 0, 0, 210);
INSERT INTO "public"."qy_area" VALUES (212, 230600, '大庆市', 230000, 125.03, 46.58, 211);
INSERT INTO "public"."qy_area" VALUES (213, 230700, '伊春市', 230000, 0, 0, 212);
INSERT INTO "public"."qy_area" VALUES (214, 230781, '铁力市', 230700, 0, 0, 213);
INSERT INTO "public"."qy_area" VALUES (215, 230800, '佳木斯市', 230000, 0, 0, 214);
INSERT INTO "public"."qy_area" VALUES (216, 230881, '同江市', 230800, 0, 0, 215);
INSERT INTO "public"."qy_area" VALUES (217, 230882, '富锦市', 230800, 0, 0, 216);
INSERT INTO "public"."qy_area" VALUES (218, 230900, '七台河市', 230000, 0, 0, 217);
INSERT INTO "public"."qy_area" VALUES (219, 231000, '牡丹江市', 230000, 129.58, 44.6, 218);
INSERT INTO "public"."qy_area" VALUES (220, 231081, '绥芬河市', 231000, 0, 0, 219);
INSERT INTO "public"."qy_area" VALUES (221, 231083, '海林市', 231000, 0, 0, 220);
INSERT INTO "public"."qy_area" VALUES (222, 231084, '宁安市', 231000, 0, 0, 221);
INSERT INTO "public"."qy_area" VALUES (223, 231085, '穆棱市', 231000, 0, 0, 222);
INSERT INTO "public"."qy_area" VALUES (224, 231100, '黑河市', 230000, 0, 0, 223);
INSERT INTO "public"."qy_area" VALUES (225, 231181, '北安市', 231100, 0, 0, 224);
INSERT INTO "public"."qy_area" VALUES (226, 231182, '五大连池市', 231100, 0, 0, 225);
INSERT INTO "public"."qy_area" VALUES (227, 231200, '绥化市', 230000, 0, 0, 226);
INSERT INTO "public"."qy_area" VALUES (228, 231281, '安达市', 231200, 0, 0, 227);
INSERT INTO "public"."qy_area" VALUES (229, 231282, '肇东市', 231200, 0, 0, 228);
INSERT INTO "public"."qy_area" VALUES (230, 231283, '海伦市', 231200, 0, 0, 229);
INSERT INTO "public"."qy_area" VALUES (231, 310000, '上海市', 0, 121.48, 31.22, 230);
INSERT INTO "public"."qy_area" VALUES (232, 320000, '江苏省', 0, 0, 0, 231);
INSERT INTO "public"."qy_area" VALUES (233, 320100, '南京市', 320000, 118.78, 32.04, 232);
INSERT INTO "public"."qy_area" VALUES (234, 320200, '无锡市', 320000, 120.29, 31.59, 233);
INSERT INTO "public"."qy_area" VALUES (235, 320281, '江阴市', 320200, 120.26, 31.91, 234);
INSERT INTO "public"."qy_area" VALUES (236, 320282, '宜兴市', 320200, 119.82, 31.36, 235);
INSERT INTO "public"."qy_area" VALUES (237, 320300, '徐州市', 320000, 117.2, 34.26, 236);
INSERT INTO "public"."qy_area" VALUES (238, 320381, '新沂市', 320300, 0, 0, 237);
INSERT INTO "public"."qy_area" VALUES (239, 320382, '邳州市', 320300, 0, 0, 238);
INSERT INTO "public"."qy_area" VALUES (240, 320400, '常州市', 320000, 119.95, 31.79, 239);
INSERT INTO "public"."qy_area" VALUES (241, 320481, '溧阳市', 320400, 119.48, 31.43, 240);
INSERT INTO "public"."qy_area" VALUES (242, 320482, '金坛市', 320400, 119.56, 31.74, 241);
INSERT INTO "public"."qy_area" VALUES (243, 320500, '苏州市', 320000, 120.62, 31.32, 242);
INSERT INTO "public"."qy_area" VALUES (244, 320581, '常熟市', 320500, 120.74, 31.64, 243);
INSERT INTO "public"."qy_area" VALUES (245, 320582, '张家港市', 320500, 120.555821, 31.875428, 244);
INSERT INTO "public"."qy_area" VALUES (246, 320583, '昆山市', 320500, 120.95, 31.39, 245);
INSERT INTO "public"."qy_area" VALUES (247, 320584, '吴江市', 320500, 120.63, 31.16, 246);
INSERT INTO "public"."qy_area" VALUES (248, 320585, '太仓市', 320500, 121.1, 31.45, 247);
INSERT INTO "public"."qy_area" VALUES (249, 320600, '南通市', 320000, 121.05, 32.08, 248);
INSERT INTO "public"."qy_area" VALUES (250, 320681, '启东市', 320600, 0, 0, 249);
INSERT INTO "public"."qy_area" VALUES (251, 320682, '如皋市', 320600, 0, 0, 250);
INSERT INTO "public"."qy_area" VALUES (252, 320683, '通州市', 320600, 0, 0, 251);
INSERT INTO "public"."qy_area" VALUES (253, 320684, '海门市', 320600, 121.15, 31.89, 252);
INSERT INTO "public"."qy_area" VALUES (254, 320700, '连云港市', 320000, 119.16, 34.59, 253);
INSERT INTO "public"."qy_area" VALUES (255, 320800, '淮安市', 320000, 119.15, 33.5, 254);
INSERT INTO "public"."qy_area" VALUES (256, 320900, '盐城市', 320000, 120.13, 33.38, 255);
INSERT INTO "public"."qy_area" VALUES (257, 320981, '东台市', 320900, 0, 0, 256);
INSERT INTO "public"."qy_area" VALUES (258, 320982, '大丰市', 320900, 0, 0, 257);
INSERT INTO "public"."qy_area" VALUES (259, 321000, '扬州市', 320000, 119.42, 32.39, 258);
INSERT INTO "public"."qy_area" VALUES (260, 321081, '仪征市', 321000, 0, 0, 259);
INSERT INTO "public"."qy_area" VALUES (261, 321084, '高邮市', 321000, 0, 0, 260);
INSERT INTO "public"."qy_area" VALUES (262, 321088, '江都市', 321000, 0, 0, 261);
INSERT INTO "public"."qy_area" VALUES (263, 321100, '镇江市', 320000, 119.44, 32.2, 262);
INSERT INTO "public"."qy_area" VALUES (264, 321181, '丹阳市', 321100, 0, 0, 263);
INSERT INTO "public"."qy_area" VALUES (265, 321182, '扬中市', 321100, 0, 0, 264);
INSERT INTO "public"."qy_area" VALUES (266, 321183, '句容市', 321100, 119.16, 31.95, 265);
INSERT INTO "public"."qy_area" VALUES (267, 321200, '泰州市', 320000, 119.9, 32.49, 266);
INSERT INTO "public"."qy_area" VALUES (268, 321281, '兴化市', 321200, 0, 0, 267);
INSERT INTO "public"."qy_area" VALUES (269, 321282, '靖江市', 321200, 0, 0, 268);
INSERT INTO "public"."qy_area" VALUES (270, 321283, '泰兴市', 321200, 0, 0, 269);
INSERT INTO "public"."qy_area" VALUES (271, 321284, '姜堰市', 321200, 0, 0, 270);
INSERT INTO "public"."qy_area" VALUES (272, 321300, '宿迁市', 320000, 118.3, 33.96, 271);
INSERT INTO "public"."qy_area" VALUES (273, 330000, '浙江省', 0, 0, 0, 272);
INSERT INTO "public"."qy_area" VALUES (274, 330100, '杭州市', 330000, 120.19, 30.26, 273);
INSERT INTO "public"."qy_area" VALUES (275, 330182, '建德市', 330100, 0, 0, 274);
INSERT INTO "public"."qy_area" VALUES (276, 330183, '富阳市', 330100, 119.95, 30.07, 275);
INSERT INTO "public"."qy_area" VALUES (277, 330185, '临安市', 330100, 119.72, 30.23, 276);
INSERT INTO "public"."qy_area" VALUES (278, 330200, '宁波市', 330000, 121.56, 29.86, 277);
INSERT INTO "public"."qy_area" VALUES (279, 330281, '余姚市', 330200, 0, 0, 278);
INSERT INTO "public"."qy_area" VALUES (280, 330282, '慈溪市', 330200, 0, 0, 279);
INSERT INTO "public"."qy_area" VALUES (281, 330283, '奉化市', 330200, 0, 0, 280);
INSERT INTO "public"."qy_area" VALUES (282, 330300, '温州市', 330000, 120.65, 28.01, 281);
INSERT INTO "public"."qy_area" VALUES (283, 330381, '瑞安市', 330300, 0, 0, 282);
INSERT INTO "public"."qy_area" VALUES (284, 330382, '乐清市', 330300, 0, 0, 283);
INSERT INTO "public"."qy_area" VALUES (285, 330400, '嘉兴市', 330000, 120.76, 30.77, 284);
INSERT INTO "public"."qy_area" VALUES (286, 330481, '海宁市', 330400, 0, 0, 285);
INSERT INTO "public"."qy_area" VALUES (287, 330482, '平湖市', 330400, 0, 0, 286);
INSERT INTO "public"."qy_area" VALUES (288, 330483, '桐乡市', 330400, 0, 0, 287);
INSERT INTO "public"."qy_area" VALUES (289, 330500, '湖州市', 330000, 120.1, 30.86, 288);
INSERT INTO "public"."qy_area" VALUES (290, 330600, '绍兴市', 330000, 120.58, 30.01, 289);
INSERT INTO "public"."qy_area" VALUES (291, 330681, '诸暨市', 330600, 120.23, 29.71, 290);
INSERT INTO "public"."qy_area" VALUES (292, 330682, '上虞市', 330600, 0, 0, 291);
INSERT INTO "public"."qy_area" VALUES (293, 330683, '嵊州市', 330600, 0, 0, 292);
INSERT INTO "public"."qy_area" VALUES (294, 330700, '金华市', 330000, 119.64, 29.12, 293);
INSERT INTO "public"."qy_area" VALUES (295, 330781, '兰溪市', 330700, 0, 0, 294);
INSERT INTO "public"."qy_area" VALUES (296, 330782, '义乌市', 330700, 120.06, 29.32, 295);
INSERT INTO "public"."qy_area" VALUES (297, 330783, '东阳市', 330700, 0, 0, 296);
INSERT INTO "public"."qy_area" VALUES (298, 330784, '永康市', 330700, 0, 0, 297);
INSERT INTO "public"."qy_area" VALUES (299, 330800, '衢州市', 330000, 118.88, 28.97, 298);
INSERT INTO "public"."qy_area" VALUES (300, 330881, '江山市', 330800, 0, 0, 299);
INSERT INTO "public"."qy_area" VALUES (301, 330900, '舟山市', 330000, 122.207216, 29.985295, 300);
INSERT INTO "public"."qy_area" VALUES (302, 331000, '台州市', 330000, 121.420757, 28.656386, 301);
INSERT INTO "public"."qy_area" VALUES (303, 331081, '温岭市', 331000, 0, 0, 302);
INSERT INTO "public"."qy_area" VALUES (304, 331082, '临海市', 331000, 0, 0, 303);
INSERT INTO "public"."qy_area" VALUES (305, 331100, '丽水市', 330000, 119.92, 28.45, 304);
INSERT INTO "public"."qy_area" VALUES (306, 331181, '龙泉市', 331100, 0, 0, 305);
INSERT INTO "public"."qy_area" VALUES (307, 340000, '安徽省', 0, 0, 0, 306);
INSERT INTO "public"."qy_area" VALUES (308, 340100, '合肥市', 340000, 117.27, 31.86, 307);
INSERT INTO "public"."qy_area" VALUES (309, 340200, '芜湖市', 340000, 118.38, 31.33, 308);
INSERT INTO "public"."qy_area" VALUES (310, 340300, '蚌埠市', 340000, 0, 0, 309);
INSERT INTO "public"."qy_area" VALUES (311, 340400, '淮南市', 340000, 0, 0, 310);
INSERT INTO "public"."qy_area" VALUES (312, 340500, '马鞍山市', 340000, 118.48, 31.56, 311);
INSERT INTO "public"."qy_area" VALUES (313, 340600, '淮北市', 340000, 0, 0, 312);
INSERT INTO "public"."qy_area" VALUES (314, 340700, '铜陵市', 340000, 0, 0, 313);
INSERT INTO "public"."qy_area" VALUES (315, 340800, '安庆市', 340000, 0, 0, 314);
INSERT INTO "public"."qy_area" VALUES (316, 340881, '桐城市', 340800, 0, 0, 315);
INSERT INTO "public"."qy_area" VALUES (317, 341000, '黄山市', 340000, 0, 0, 316);
INSERT INTO "public"."qy_area" VALUES (318, 341100, '滁州市', 340000, 0, 0, 317);
INSERT INTO "public"."qy_area" VALUES (319, 341181, '天长市', 341100, 0, 0, 318);
INSERT INTO "public"."qy_area" VALUES (320, 341182, '明光市', 341100, 0, 0, 319);
INSERT INTO "public"."qy_area" VALUES (321, 341200, '阜阳市', 340000, 0, 0, 320);
INSERT INTO "public"."qy_area" VALUES (322, 341282, '界首市', 341200, 0, 0, 321);
INSERT INTO "public"."qy_area" VALUES (323, 341300, '宿州市', 340000, 0, 0, 322);
INSERT INTO "public"."qy_area" VALUES (324, 341402, '巢湖市', 340100, 0, 0, 323);
INSERT INTO "public"."qy_area" VALUES (325, 341500, '六安市', 340000, 0, 0, 324);
INSERT INTO "public"."qy_area" VALUES (326, 341600, '亳州市', 340000, 0, 0, 325);
INSERT INTO "public"."qy_area" VALUES (327, 341700, '池州市', 340000, 0, 0, 326);
INSERT INTO "public"."qy_area" VALUES (328, 341800, '宣城市', 340000, 0, 0, 327);
INSERT INTO "public"."qy_area" VALUES (329, 341881, '宁国市', 341800, 0, 0, 328);
INSERT INTO "public"."qy_area" VALUES (330, 350000, '福建省', 0, 0, 0, 329);
INSERT INTO "public"."qy_area" VALUES (331, 350100, '福州市', 350000, 119.3, 26.08, 330);
INSERT INTO "public"."qy_area" VALUES (332, 350181, '福清市', 350100, 0, 0, 331);
INSERT INTO "public"."qy_area" VALUES (333, 350182, '长乐市', 350100, 0, 0, 332);
INSERT INTO "public"."qy_area" VALUES (334, 350200, '厦门市', 350000, 118.1, 24.46, 333);
INSERT INTO "public"."qy_area" VALUES (335, 350300, '莆田市', 350000, 0, 0, 334);
INSERT INTO "public"."qy_area" VALUES (336, 350400, '三明市', 350000, 0, 0, 335);
INSERT INTO "public"."qy_area" VALUES (337, 350481, '永安市', 350400, 0, 0, 336);
INSERT INTO "public"."qy_area" VALUES (338, 350500, '泉州市', 350000, 118.58, 24.93, 337);
INSERT INTO "public"."qy_area" VALUES (339, 350581, '石狮市', 350500, 0, 0, 338);
INSERT INTO "public"."qy_area" VALUES (340, 350582, '晋江市', 350500, 0, 0, 339);
INSERT INTO "public"."qy_area" VALUES (341, 350583, '南安市', 350500, 0, 0, 340);
INSERT INTO "public"."qy_area" VALUES (342, 350600, '漳州市', 350000, 0, 0, 341);
INSERT INTO "public"."qy_area" VALUES (343, 350681, '龙海市', 350600, 0, 0, 342);
INSERT INTO "public"."qy_area" VALUES (344, 350700, '南平市', 350000, 0, 0, 343);
INSERT INTO "public"."qy_area" VALUES (345, 350781, '邵武市', 350700, 0, 0, 344);
INSERT INTO "public"."qy_area" VALUES (346, 350782, '武夷山市', 350700, 0, 0, 345);
INSERT INTO "public"."qy_area" VALUES (347, 350783, '建瓯市', 350700, 0, 0, 346);
INSERT INTO "public"."qy_area" VALUES (348, 350784, '建阳市', 350700, 0, 0, 347);
INSERT INTO "public"."qy_area" VALUES (349, 350800, '龙岩市', 350000, 0, 0, 348);
INSERT INTO "public"."qy_area" VALUES (350, 350881, '漳平市', 350800, 0, 0, 349);
INSERT INTO "public"."qy_area" VALUES (351, 350900, '宁德市', 350000, 0, 0, 350);
INSERT INTO "public"."qy_area" VALUES (352, 350981, '福安市', 350900, 0, 0, 351);
INSERT INTO "public"."qy_area" VALUES (353, 350982, '福鼎市', 350900, 0, 0, 352);
INSERT INTO "public"."qy_area" VALUES (354, 360000, '江西省', 0, 0, 0, 353);
INSERT INTO "public"."qy_area" VALUES (355, 360100, '南昌市', 360000, 115.89, 28.68, 354);
INSERT INTO "public"."qy_area" VALUES (356, 360200, '景德镇市', 360000, 0, 0, 355);
INSERT INTO "public"."qy_area" VALUES (357, 360281, '乐平市', 360200, 0, 0, 356);
INSERT INTO "public"."qy_area" VALUES (358, 360300, '萍乡市', 360000, 0, 0, 357);
INSERT INTO "public"."qy_area" VALUES (359, 360400, '九江市', 360000, 115.97, 29.71, 358);
INSERT INTO "public"."qy_area" VALUES (360, 360481, '瑞昌市', 360400, 0, 0, 359);
INSERT INTO "public"."qy_area" VALUES (361, 360500, '新余市', 360000, 0, 0, 360);
INSERT INTO "public"."qy_area" VALUES (362, 360600, '鹰潭市', 360000, 0, 0, 361);
INSERT INTO "public"."qy_area" VALUES (363, 360681, '贵溪市', 360600, 0, 0, 362);
INSERT INTO "public"."qy_area" VALUES (364, 360700, '赣州市', 360000, 0, 0, 363);
INSERT INTO "public"."qy_area" VALUES (365, 360781, '瑞金市', 360700, 0, 0, 364);
INSERT INTO "public"."qy_area" VALUES (366, 360782, '南康市', 360700, 0, 0, 365);
INSERT INTO "public"."qy_area" VALUES (367, 360800, '吉安市', 360000, 0, 0, 366);
INSERT INTO "public"."qy_area" VALUES (368, 360881, '井冈山市', 360800, 0, 0, 367);
INSERT INTO "public"."qy_area" VALUES (369, 360900, '宜春市', 360000, 0, 0, 368);
INSERT INTO "public"."qy_area" VALUES (370, 360981, '丰城市', 360900, 0, 0, 369);
INSERT INTO "public"."qy_area" VALUES (371, 360982, '樟树市', 360900, 0, 0, 370);
INSERT INTO "public"."qy_area" VALUES (372, 360983, '高安市', 360900, 0, 0, 371);
INSERT INTO "public"."qy_area" VALUES (373, 361000, '抚州市', 360000, 0, 0, 372);
INSERT INTO "public"."qy_area" VALUES (374, 361100, '上饶市', 360000, 0, 0, 373);
INSERT INTO "public"."qy_area" VALUES (375, 361181, '德兴市', 361100, 0, 0, 374);
INSERT INTO "public"."qy_area" VALUES (376, 370000, '山东省', 0, 0, 0, 375);
INSERT INTO "public"."qy_area" VALUES (377, 370100, '济南市', 370000, 117, 36.65, 376);
INSERT INTO "public"."qy_area" VALUES (378, 370181, '章丘市', 370100, 117.53, 36.72, 377);
INSERT INTO "public"."qy_area" VALUES (379, 370200, '青岛市', 370000, 120.33, 36.07, 378);
INSERT INTO "public"."qy_area" VALUES (380, 370281, '胶州市', 370200, 120.03336, 36.264622, 379);
INSERT INTO "public"."qy_area" VALUES (381, 370282, '即墨市', 370200, 120.45, 36.38, 380);
INSERT INTO "public"."qy_area" VALUES (382, 370283, '平度市', 370200, 119.97, 36.77, 381);
INSERT INTO "public"."qy_area" VALUES (383, 370284, '胶南市', 370200, 119.97, 35.88, 382);
INSERT INTO "public"."qy_area" VALUES (384, 370285, '莱西市', 370200, 120.53, 36.86, 383);
INSERT INTO "public"."qy_area" VALUES (385, 370300, '淄博市', 370000, 118.05, 36.78, 384);
INSERT INTO "public"."qy_area" VALUES (386, 370400, '枣庄市', 370000, 117.57, 34.86, 385);
INSERT INTO "public"."qy_area" VALUES (387, 370481, '滕州市', 370400, 0, 0, 386);
INSERT INTO "public"."qy_area" VALUES (388, 370500, '东营市', 370000, 118.49, 37.46, 387);
INSERT INTO "public"."qy_area" VALUES (389, 370600, '烟台市', 370000, 121.39, 37.52, 388);
INSERT INTO "public"."qy_area" VALUES (390, 370681, '龙口市', 370600, 0, 0, 389);
INSERT INTO "public"."qy_area" VALUES (391, 370682, '莱阳市', 370600, 0, 0, 390);
INSERT INTO "public"."qy_area" VALUES (392, 370683, '莱州市', 370600, 119.942327, 37.177017, 391);
INSERT INTO "public"."qy_area" VALUES (393, 370684, '蓬莱市', 370600, 120.75, 37.8, 392);
INSERT INTO "public"."qy_area" VALUES (394, 370685, '招远市', 370600, 120.38, 37.35, 393);
INSERT INTO "public"."qy_area" VALUES (395, 370686, '栖霞市', 370600, 0, 0, 394);
INSERT INTO "public"."qy_area" VALUES (396, 370687, '海阳市', 370600, 0, 0, 395);
INSERT INTO "public"."qy_area" VALUES (397, 370700, '潍坊市', 370000, 119.1, 36.62, 396);
INSERT INTO "public"."qy_area" VALUES (398, 370781, '青州市', 370700, 0, 0, 397);
INSERT INTO "public"."qy_area" VALUES (399, 370782, '诸城市', 370700, 0, 0, 398);
INSERT INTO "public"."qy_area" VALUES (400, 370783, '寿光市', 370700, 118.73, 36.86, 399);
INSERT INTO "public"."qy_area" VALUES (401, 370784, '安丘市', 370700, 0, 0, 400);
INSERT INTO "public"."qy_area" VALUES (402, 370785, '高密市', 370700, 0, 0, 401);
INSERT INTO "public"."qy_area" VALUES (403, 370786, '昌邑市', 370700, 0, 0, 402);
INSERT INTO "public"."qy_area" VALUES (404, 370800, '济宁市', 370000, 116.59, 35.38, 403);
INSERT INTO "public"."qy_area" VALUES (405, 370881, '曲阜市', 370800, 0, 0, 404);
INSERT INTO "public"."qy_area" VALUES (406, 370882, '兖州市', 370800, 0, 0, 405);
INSERT INTO "public"."qy_area" VALUES (407, 370883, '邹城市', 370800, 0, 0, 406);
INSERT INTO "public"."qy_area" VALUES (408, 370900, '泰安市', 370000, 117.13, 36.18, 407);
INSERT INTO "public"."qy_area" VALUES (409, 370982, '新泰市', 370900, 0, 0, 408);
INSERT INTO "public"."qy_area" VALUES (410, 370983, '肥城市', 370900, 0, 0, 409);
INSERT INTO "public"."qy_area" VALUES (411, 371000, '威海市', 370000, 122.1, 37.5, 410);
INSERT INTO "public"."qy_area" VALUES (412, 371081, '文登市', 371000, 122.05, 37.2, 411);
INSERT INTO "public"."qy_area" VALUES (413, 371082, '荣成市', 371000, 122.41, 37.16, 412);
INSERT INTO "public"."qy_area" VALUES (414, 371083, '乳山市', 371000, 121.52, 36.89, 413);
INSERT INTO "public"."qy_area" VALUES (415, 371100, '日照市', 370000, 119.46, 35.42, 414);
INSERT INTO "public"."qy_area" VALUES (416, 371200, '莱芜市', 370000, 117.67, 36.19, 415);
INSERT INTO "public"."qy_area" VALUES (417, 371300, '临沂市', 370000, 118.35, 35.05, 416);
INSERT INTO "public"."qy_area" VALUES (418, 371400, '德州市', 370000, 116.29, 37.45, 417);
INSERT INTO "public"."qy_area" VALUES (419, 371481, '乐陵市', 371400, 0, 0, 418);
INSERT INTO "public"."qy_area" VALUES (420, 371482, '禹城市', 371400, 0, 0, 419);
INSERT INTO "public"."qy_area" VALUES (421, 371500, '聊城市', 370000, 115.97, 36.45, 420);
INSERT INTO "public"."qy_area" VALUES (422, 371581, '临清市', 371500, 0, 0, 421);
INSERT INTO "public"."qy_area" VALUES (423, 371600, '滨州市', 370000, 118.03, 37.36, 422);
INSERT INTO "public"."qy_area" VALUES (424, 371700, '菏泽市', 370000, 115.480656, 35.23375, 423);
INSERT INTO "public"."qy_area" VALUES (425, 410000, '河南省', 0, 0, 0, 424);
INSERT INTO "public"."qy_area" VALUES (426, 410100, '郑州市', 410000, 113.65, 34.76, 425);
INSERT INTO "public"."qy_area" VALUES (427, 410181, '巩义市', 410100, 0, 0, 426);
INSERT INTO "public"."qy_area" VALUES (428, 410182, '荥阳市', 410100, 0, 0, 427);
INSERT INTO "public"."qy_area" VALUES (429, 410183, '新密市', 410100, 0, 0, 428);
INSERT INTO "public"."qy_area" VALUES (430, 410184, '新郑市', 410100, 0, 0, 429);
INSERT INTO "public"."qy_area" VALUES (431, 410185, '登封市', 410100, 0, 0, 430);
INSERT INTO "public"."qy_area" VALUES (432, 410200, '开封市', 410000, 114.35, 34.79, 431);
INSERT INTO "public"."qy_area" VALUES (433, 410300, '洛阳市', 410000, 112.44, 34.7, 432);
INSERT INTO "public"."qy_area" VALUES (434, 410381, '偃师市', 410300, 0, 0, 433);
INSERT INTO "public"."qy_area" VALUES (435, 410400, '平顶山市', 410000, 113.29, 33.75, 434);
INSERT INTO "public"."qy_area" VALUES (436, 410481, '舞钢市', 410400, 0, 0, 435);
INSERT INTO "public"."qy_area" VALUES (437, 410482, '汝州市', 410400, 0, 0, 436);
INSERT INTO "public"."qy_area" VALUES (438, 410500, '安阳市', 410000, 114.35, 36.1, 437);
INSERT INTO "public"."qy_area" VALUES (439, 410581, '林州市', 410500, 0, 0, 438);
INSERT INTO "public"."qy_area" VALUES (440, 410600, '鹤壁市', 410000, 0, 0, 439);
INSERT INTO "public"."qy_area" VALUES (441, 410700, '新乡市', 410000, 0, 0, 440);
INSERT INTO "public"."qy_area" VALUES (442, 410781, '卫辉市', 410700, 0, 0, 441);
INSERT INTO "public"."qy_area" VALUES (443, 410800, '焦作市', 410000, 113.21, 35.24, 442);
INSERT INTO "public"."qy_area" VALUES (444, 410881, '济源市', 410800, 0, 0, 443);
INSERT INTO "public"."qy_area" VALUES (445, 410882, '沁阳市', 410800, 0, 0, 444);
INSERT INTO "public"."qy_area" VALUES (446, 410883, '孟州市', 410800, 0, 0, 445);
INSERT INTO "public"."qy_area" VALUES (447, 410900, '濮阳市', 410000, 0, 0, 446);
INSERT INTO "public"."qy_area" VALUES (448, 411000, '许昌市', 410000, 0, 0, 447);
INSERT INTO "public"."qy_area" VALUES (449, 411081, '禹州市', 411000, 0, 0, 448);
INSERT INTO "public"."qy_area" VALUES (450, 411082, '长葛市', 411000, 0, 0, 449);
INSERT INTO "public"."qy_area" VALUES (451, 411100, '漯河市', 410000, 0, 0, 450);
INSERT INTO "public"."qy_area" VALUES (452, 411200, '三门峡市', 410000, 111.19, 34.76, 451);
INSERT INTO "public"."qy_area" VALUES (453, 411281, '义马市', 411200, 0, 0, 452);
INSERT INTO "public"."qy_area" VALUES (454, 411282, '灵宝市', 411200, 0, 0, 453);
INSERT INTO "public"."qy_area" VALUES (455, 411300, '南阳市', 410000, 0, 0, 454);
INSERT INTO "public"."qy_area" VALUES (456, 411381, '邓州市', 411300, 0, 0, 455);
INSERT INTO "public"."qy_area" VALUES (457, 411400, '商丘市', 410000, 0, 0, 456);
INSERT INTO "public"."qy_area" VALUES (458, 411481, '永城市', 411400, 0, 0, 457);
INSERT INTO "public"."qy_area" VALUES (459, 411500, '信阳市', 410000, 0, 0, 458);
INSERT INTO "public"."qy_area" VALUES (460, 411600, '周口市', 410000, 0, 0, 459);
INSERT INTO "public"."qy_area" VALUES (461, 411681, '项城市', 411600, 0, 0, 460);
INSERT INTO "public"."qy_area" VALUES (462, 411700, '驻马店市', 410000, 0, 0, 461);
INSERT INTO "public"."qy_area" VALUES (463, 420000, '湖北省', 0, 0, 0, 462);
INSERT INTO "public"."qy_area" VALUES (464, 420100, '武汉市', 420000, 114.31, 30.52, 463);
INSERT INTO "public"."qy_area" VALUES (465, 420200, '黄石市', 420000, 0, 0, 464);
INSERT INTO "public"."qy_area" VALUES (466, 420281, '大冶市', 420200, 0, 0, 465);
INSERT INTO "public"."qy_area" VALUES (467, 420300, '十堰市', 420000, 0, 0, 466);
INSERT INTO "public"."qy_area" VALUES (468, 420381, '丹江口市', 420300, 0, 0, 467);
INSERT INTO "public"."qy_area" VALUES (469, 420500, '宜昌市', 420000, 111.3, 30.7, 468);
INSERT INTO "public"."qy_area" VALUES (470, 420581, '宜都市', 420500, 0, 0, 469);
INSERT INTO "public"."qy_area" VALUES (471, 420582, '当阳市', 420500, 0, 0, 470);
INSERT INTO "public"."qy_area" VALUES (472, 420583, '枝江市', 420500, 0, 0, 471);
INSERT INTO "public"."qy_area" VALUES (473, 420600, '襄樊市', 420000, 0, 0, 472);
INSERT INTO "public"."qy_area" VALUES (474, 420682, '老河口市', 420600, 0, 0, 473);
INSERT INTO "public"."qy_area" VALUES (475, 420683, '枣阳市', 420600, 0, 0, 474);
INSERT INTO "public"."qy_area" VALUES (476, 420684, '宜城市', 420600, 0, 0, 475);
INSERT INTO "public"."qy_area" VALUES (477, 420700, '鄂州市', 420000, 0, 0, 476);
INSERT INTO "public"."qy_area" VALUES (478, 420800, '荆门市', 420000, 0, 0, 477);
INSERT INTO "public"."qy_area" VALUES (479, 420881, '钟祥市', 420800, 0, 0, 478);
INSERT INTO "public"."qy_area" VALUES (480, 420900, '孝感市', 420000, 0, 0, 479);
INSERT INTO "public"."qy_area" VALUES (481, 420981, '应城市', 420900, 0, 0, 480);
INSERT INTO "public"."qy_area" VALUES (482, 420982, '安陆市', 420900, 0, 0, 481);
INSERT INTO "public"."qy_area" VALUES (483, 420984, '汉川市', 420900, 0, 0, 482);
INSERT INTO "public"."qy_area" VALUES (484, 421000, '荆州市', 420000, 112.239741, 30.335165, 483);
INSERT INTO "public"."qy_area" VALUES (485, 421081, '石首市', 421000, 0, 0, 484);
INSERT INTO "public"."qy_area" VALUES (486, 421083, '洪湖市', 421000, 0, 0, 485);
INSERT INTO "public"."qy_area" VALUES (487, 421087, '松滋市', 421000, 0, 0, 486);
INSERT INTO "public"."qy_area" VALUES (488, 421100, '黄冈市', 420000, 0, 0, 487);
INSERT INTO "public"."qy_area" VALUES (489, 421181, '麻城市', 421100, 0, 0, 488);
INSERT INTO "public"."qy_area" VALUES (490, 421182, '武穴市', 421100, 0, 0, 489);
INSERT INTO "public"."qy_area" VALUES (491, 421200, '咸宁市', 420000, 0, 0, 490);
INSERT INTO "public"."qy_area" VALUES (492, 421281, '赤壁市', 421200, 0, 0, 491);
INSERT INTO "public"."qy_area" VALUES (493, 421300, '随州市', 420000, 0, 0, 492);
INSERT INTO "public"."qy_area" VALUES (494, 421381, '广水市', 421300, 0, 0, 493);
INSERT INTO "public"."qy_area" VALUES (495, 422800, '恩施土家族苗族自治州', 420000, 0, 0, 494);
INSERT INTO "public"."qy_area" VALUES (496, 422801, '恩施市', 422800, 0, 0, 495);
INSERT INTO "public"."qy_area" VALUES (497, 422802, '利川市', 422800, 0, 0, 496);
INSERT INTO "public"."qy_area" VALUES (498, 429000, '省直辖行政单位', 420000, 0, 0, 497);
INSERT INTO "public"."qy_area" VALUES (499, 429004, '仙桃市', 429000, 0, 0, 498);
INSERT INTO "public"."qy_area" VALUES (500, 429005, '潜江市', 429000, 0, 0, 499);
INSERT INTO "public"."qy_area" VALUES (501, 429006, '天门市', 429000, 0, 0, 500);
INSERT INTO "public"."qy_area" VALUES (502, 430000, '湖南省', 0, 0, 0, 501);
INSERT INTO "public"."qy_area" VALUES (503, 430100, '长沙市', 430000, 113, 28.21, 502);
INSERT INTO "public"."qy_area" VALUES (504, 430181, '浏阳市', 430100, 0, 0, 503);
INSERT INTO "public"."qy_area" VALUES (505, 430200, '株洲市', 430000, 113.16, 27.83, 504);
INSERT INTO "public"."qy_area" VALUES (506, 430281, '醴陵市', 430200, 0, 0, 505);
INSERT INTO "public"."qy_area" VALUES (507, 430300, '湘潭市', 430000, 112.91, 27.87, 506);
INSERT INTO "public"."qy_area" VALUES (508, 430381, '湘乡市', 430300, 0, 0, 507);
INSERT INTO "public"."qy_area" VALUES (509, 430382, '韶山市', 430300, 0, 0, 508);
INSERT INTO "public"."qy_area" VALUES (510, 430400, '衡阳市', 430000, 0, 0, 509);
INSERT INTO "public"."qy_area" VALUES (511, 430481, '耒阳市', 430400, 0, 0, 510);
INSERT INTO "public"."qy_area" VALUES (512, 430482, '常宁市', 430400, 0, 0, 511);
INSERT INTO "public"."qy_area" VALUES (513, 430500, '邵阳市', 430000, 0, 0, 512);
INSERT INTO "public"."qy_area" VALUES (514, 430581, '武冈市', 430500, 0, 0, 513);
INSERT INTO "public"."qy_area" VALUES (515, 430600, '岳阳市', 430000, 113.09, 29.37, 514);
INSERT INTO "public"."qy_area" VALUES (516, 430681, '汨罗市', 430600, 0, 0, 515);
INSERT INTO "public"."qy_area" VALUES (517, 430682, '临湘市', 430600, 0, 0, 516);
INSERT INTO "public"."qy_area" VALUES (518, 430700, '常德市', 430000, 111.69, 29.05, 517);
INSERT INTO "public"."qy_area" VALUES (519, 430781, '津市市', 430700, 0, 0, 518);
INSERT INTO "public"."qy_area" VALUES (520, 430800, '张家界市', 430000, 110.479191, 29.117096, 519);
INSERT INTO "public"."qy_area" VALUES (521, 430900, '益阳市', 430000, 0, 0, 520);
INSERT INTO "public"."qy_area" VALUES (522, 430981, '沅江市', 430900, 0, 0, 521);
INSERT INTO "public"."qy_area" VALUES (523, 431000, '郴州市', 430000, 0, 0, 522);
INSERT INTO "public"."qy_area" VALUES (524, 431081, '资兴市', 431000, 0, 0, 523);
INSERT INTO "public"."qy_area" VALUES (525, 431100, '永州市', 430000, 0, 0, 524);
INSERT INTO "public"."qy_area" VALUES (526, 431200, '怀化市', 430000, 0, 0, 525);
INSERT INTO "public"."qy_area" VALUES (527, 431281, '洪江市', 431200, 0, 0, 526);
INSERT INTO "public"."qy_area" VALUES (528, 431300, '娄底市', 430000, 0, 0, 527);
INSERT INTO "public"."qy_area" VALUES (529, 431381, '冷水江市', 431300, 0, 0, 528);
INSERT INTO "public"."qy_area" VALUES (530, 431382, '涟源市', 431300, 0, 0, 529);
INSERT INTO "public"."qy_area" VALUES (531, 433100, '湘西土家族苗族自治州', 430000, 0, 0, 530);
INSERT INTO "public"."qy_area" VALUES (532, 433101, '吉首市', 433100, 0, 0, 531);
INSERT INTO "public"."qy_area" VALUES (533, 440000, '广东省', 0, 0, 0, 532);
INSERT INTO "public"."qy_area" VALUES (534, 440100, '广州市', 440000, 113.23, 23.16, 533);
INSERT INTO "public"."qy_area" VALUES (535, 440183, '增城市', 440100, 0, 0, 534);
INSERT INTO "public"."qy_area" VALUES (536, 440184, '从化市', 440100, 0, 0, 535);
INSERT INTO "public"."qy_area" VALUES (537, 440200, '韶关市', 440000, 113.62, 24.84, 536);
INSERT INTO "public"."qy_area" VALUES (538, 440281, '乐昌市', 440200, 0, 0, 537);
INSERT INTO "public"."qy_area" VALUES (539, 440282, '南雄市', 440200, 0, 0, 538);
INSERT INTO "public"."qy_area" VALUES (540, 440300, '深圳市', 440000, 114.07, 22.62, 539);
INSERT INTO "public"."qy_area" VALUES (541, 440400, '珠海市', 440000, 113.52, 22.3, 540);
INSERT INTO "public"."qy_area" VALUES (542, 440500, '汕头市', 440000, 116.69, 23.39, 541);
INSERT INTO "public"."qy_area" VALUES (543, 440600, '佛山市', 440000, 113.11, 23.05, 542);
INSERT INTO "public"."qy_area" VALUES (544, 440700, '江门市', 440000, 113.06, 22.61, 543);
INSERT INTO "public"."qy_area" VALUES (545, 440781, '台山市', 440700, 0, 0, 544);
INSERT INTO "public"."qy_area" VALUES (546, 440783, '开平市', 440700, 0, 0, 545);
INSERT INTO "public"."qy_area" VALUES (547, 440784, '鹤山市', 440700, 0, 0, 546);
INSERT INTO "public"."qy_area" VALUES (548, 440785, '恩平市', 440700, 0, 0, 547);
INSERT INTO "public"."qy_area" VALUES (549, 440800, '湛江市', 440000, 110.359377, 21.270708, 548);
INSERT INTO "public"."qy_area" VALUES (550, 440881, '廉江市', 440800, 0, 0, 549);
INSERT INTO "public"."qy_area" VALUES (551, 440882, '雷州市', 440800, 0, 0, 550);
INSERT INTO "public"."qy_area" VALUES (552, 440883, '吴川市', 440800, 0, 0, 551);
INSERT INTO "public"."qy_area" VALUES (553, 440900, '茂名市', 440000, 110.88, 21.68, 552);
INSERT INTO "public"."qy_area" VALUES (554, 440981, '高州市', 440900, 0, 0, 553);
INSERT INTO "public"."qy_area" VALUES (555, 440982, '化州市', 440900, 0, 0, 554);
INSERT INTO "public"."qy_area" VALUES (556, 440983, '信宜市', 440900, 0, 0, 555);
INSERT INTO "public"."qy_area" VALUES (557, 441200, '肇庆市', 440000, 112.44, 23.05, 556);
INSERT INTO "public"."qy_area" VALUES (558, 441283, '高要市', 441200, 0, 0, 557);
INSERT INTO "public"."qy_area" VALUES (559, 441284, '四会市', 441200, 0, 0, 558);
INSERT INTO "public"."qy_area" VALUES (560, 441300, '惠州市', 440000, 114.4, 23.09, 559);
INSERT INTO "public"."qy_area" VALUES (561, 441400, '梅州市', 440000, 116.1, 24.55, 560);
INSERT INTO "public"."qy_area" VALUES (562, 441481, '兴宁市', 441400, 0, 0, 561);
INSERT INTO "public"."qy_area" VALUES (563, 441500, '汕尾市', 440000, 115.375279, 22.786211, 562);
INSERT INTO "public"."qy_area" VALUES (564, 441581, '陆丰市', 441500, 0, 0, 563);
INSERT INTO "public"."qy_area" VALUES (565, 441600, '河源市', 440000, 114.68, 23.73, 564);
INSERT INTO "public"."qy_area" VALUES (566, 441700, '阳江市', 440000, 111.95, 21.85, 565);
INSERT INTO "public"."qy_area" VALUES (567, 441781, '阳春市', 441700, 0, 0, 566);
INSERT INTO "public"."qy_area" VALUES (568, 441800, '清远市', 440000, 113.01, 23.7, 567);
INSERT INTO "public"."qy_area" VALUES (569, 441881, '英德市', 441800, 0, 0, 568);
INSERT INTO "public"."qy_area" VALUES (570, 441882, '连州市', 441800, 0, 0, 569);
INSERT INTO "public"."qy_area" VALUES (571, 441900, '东莞市', 440000, 113.75, 23.04, 570);
INSERT INTO "public"."qy_area" VALUES (572, 442000, '中山市', 440000, 113.38, 22.52, 571);
INSERT INTO "public"."qy_area" VALUES (573, 445100, '潮州市', 440000, 116.63, 23.68, 572);
INSERT INTO "public"."qy_area" VALUES (574, 445200, '揭阳市', 440000, 116.35, 23.55, 573);
INSERT INTO "public"."qy_area" VALUES (575, 445281, '普宁市', 445200, 0, 0, 574);
INSERT INTO "public"."qy_area" VALUES (576, 445300, '云浮市', 440000, 112.02, 22.93, 575);
INSERT INTO "public"."qy_area" VALUES (577, 445381, '罗定市', 445300, 0, 0, 576);
INSERT INTO "public"."qy_area" VALUES (578, 450000, '广西省', 0, 0, 0, 577);
INSERT INTO "public"."qy_area" VALUES (579, 450100, '南宁市', 450000, 108.33, 22.84, 578);
INSERT INTO "public"."qy_area" VALUES (580, 450200, '柳州市', 450000, 109.4, 24.33, 579);
INSERT INTO "public"."qy_area" VALUES (581, 450300, '桂林市', 450000, 110.28, 25.29, 580);
INSERT INTO "public"."qy_area" VALUES (582, 450400, '梧州市', 450000, 0, 0, 581);
INSERT INTO "public"."qy_area" VALUES (583, 450481, '岑溪市', 450400, 0, 0, 582);
INSERT INTO "public"."qy_area" VALUES (584, 450500, '北海市', 450000, 109.12, 21.49, 583);
INSERT INTO "public"."qy_area" VALUES (585, 450600, '防城港市', 450000, 0, 0, 584);
INSERT INTO "public"."qy_area" VALUES (586, 450681, '东兴市', 450600, 0, 0, 585);
INSERT INTO "public"."qy_area" VALUES (587, 450700, '钦州市', 450000, 0, 0, 586);
INSERT INTO "public"."qy_area" VALUES (588, 450800, '贵港市', 450000, 0, 0, 587);
INSERT INTO "public"."qy_area" VALUES (589, 450881, '桂平市', 450800, 0, 0, 588);
INSERT INTO "public"."qy_area" VALUES (590, 450900, '玉林市', 450000, 0, 0, 589);
INSERT INTO "public"."qy_area" VALUES (591, 450981, '北流市', 450900, 0, 0, 590);
INSERT INTO "public"."qy_area" VALUES (592, 451000, '百色市', 450000, 0, 0, 591);
INSERT INTO "public"."qy_area" VALUES (593, 451100, '贺州市', 450000, 0, 0, 592);
INSERT INTO "public"."qy_area" VALUES (594, 451200, '河池市', 450000, 0, 0, 593);
INSERT INTO "public"."qy_area" VALUES (595, 451281, '宜州市', 451200, 0, 0, 594);
INSERT INTO "public"."qy_area" VALUES (596, 451300, '来宾市', 450000, 0, 0, 595);
INSERT INTO "public"."qy_area" VALUES (597, 451381, '合山市', 451300, 0, 0, 596);
INSERT INTO "public"."qy_area" VALUES (598, 451400, '崇左市', 450000, 0, 0, 597);
INSERT INTO "public"."qy_area" VALUES (599, 451481, '凭祥市', 451400, 0, 0, 598);
INSERT INTO "public"."qy_area" VALUES (600, 460000, '海南省', 0, 0, 0, 599);
INSERT INTO "public"."qy_area" VALUES (601, 460100, '海口市', 460000, 110.35, 20.02, 600);
INSERT INTO "public"."qy_area" VALUES (602, 460200, '三亚市', 460000, 109.511909, 18.252847, 601);
INSERT INTO "public"."qy_area" VALUES (603, 469001, '五指山市', 469000, 0, 0, 602);
INSERT INTO "public"."qy_area" VALUES (604, 469002, '琼海市', 469000, 0, 0, 603);
INSERT INTO "public"."qy_area" VALUES (605, 469003, '儋州市', 469000, 0, 0, 604);
INSERT INTO "public"."qy_area" VALUES (606, 469005, '文昌市', 469000, 0, 0, 605);
INSERT INTO "public"."qy_area" VALUES (607, 469006, '万宁市', 469000, 0, 0, 606);
INSERT INTO "public"."qy_area" VALUES (608, 469007, '东方市', 469000, 0, 0, 607);
INSERT INTO "public"."qy_area" VALUES (609, 469037, '西沙群岛', 469000, 0, 0, 608);
INSERT INTO "public"."qy_area" VALUES (610, 469038, '南沙群岛', 469000, 0, 0, 609);
INSERT INTO "public"."qy_area" VALUES (611, 469039, '中沙群岛的岛礁及其海域', 469000, 0, 0, 610);
INSERT INTO "public"."qy_area" VALUES (612, 500000, '重庆市', 0, 106.54, 29.59, 611);
INSERT INTO "public"."qy_area" VALUES (613, 500300, '市', 500000, 0, 0, 612);
INSERT INTO "public"."qy_area" VALUES (614, 500381, '江津市', 500300, 0, 0, 613);
INSERT INTO "public"."qy_area" VALUES (615, 500382, '合川市', 500300, 0, 0, 614);
INSERT INTO "public"."qy_area" VALUES (616, 500383, '永川市', 500300, 0, 0, 615);
INSERT INTO "public"."qy_area" VALUES (617, 500384, '南川市', 500300, 0, 0, 616);
INSERT INTO "public"."qy_area" VALUES (618, 510000, '四川省', 0, 0, 0, 617);
INSERT INTO "public"."qy_area" VALUES (619, 510100, '成都市', 510000, 104.06, 30.67, 618);
INSERT INTO "public"."qy_area" VALUES (620, 510181, '都江堰市', 510100, 0, 0, 619);
INSERT INTO "public"."qy_area" VALUES (621, 510182, '彭州市', 510100, 0, 0, 620);
INSERT INTO "public"."qy_area" VALUES (622, 510183, '邛崃市', 510100, 0, 0, 621);
INSERT INTO "public"."qy_area" VALUES (623, 510184, '崇州市', 510100, 0, 0, 622);
INSERT INTO "public"."qy_area" VALUES (624, 510300, '自贡市', 510000, 104.778442, 29.33903, 623);
INSERT INTO "public"."qy_area" VALUES (625, 510400, '攀枝花市', 510000, 101.718637, 26.582347, 624);
INSERT INTO "public"."qy_area" VALUES (626, 510500, '泸州市', 510000, 105.39, 28.91, 625);
INSERT INTO "public"."qy_area" VALUES (627, 510600, '德阳市', 510000, 104.37, 31.13, 626);
INSERT INTO "public"."qy_area" VALUES (628, 510681, '广汉市', 510600, 0, 0, 627);
INSERT INTO "public"."qy_area" VALUES (629, 510682, '什邡市', 510600, 0, 0, 628);
INSERT INTO "public"."qy_area" VALUES (630, 510683, '绵竹市', 510600, 0, 0, 629);
INSERT INTO "public"."qy_area" VALUES (631, 510700, '绵阳市', 510000, 104.73, 31.48, 630);
INSERT INTO "public"."qy_area" VALUES (632, 510781, '江油市', 510700, 0, 0, 631);
INSERT INTO "public"."qy_area" VALUES (633, 510800, '广元市', 510000, 0, 0, 632);
INSERT INTO "public"."qy_area" VALUES (634, 510900, '遂宁市', 510000, 0, 0, 633);
INSERT INTO "public"."qy_area" VALUES (635, 511000, '内江市', 510000, 0, 0, 634);
INSERT INTO "public"."qy_area" VALUES (636, 511100, '乐山市', 510000, 0, 0, 635);
INSERT INTO "public"."qy_area" VALUES (637, 511181, '峨眉山市', 511100, 0, 0, 636);
INSERT INTO "public"."qy_area" VALUES (638, 511300, '南充市', 510000, 106.110698, 30.837793, 637);
INSERT INTO "public"."qy_area" VALUES (639, 511381, '阆中市', 511300, 0, 0, 638);
INSERT INTO "public"."qy_area" VALUES (640, 511400, '眉山市', 510000, 0, 0, 639);
INSERT INTO "public"."qy_area" VALUES (641, 511500, '宜宾市', 510000, 104.56, 29.77, 640);
INSERT INTO "public"."qy_area" VALUES (642, 511600, '广安市', 510000, 0, 0, 641);
INSERT INTO "public"."qy_area" VALUES (643, 511681, '华莹市', 511600, 0, 0, 642);
INSERT INTO "public"."qy_area" VALUES (644, 511700, '达州市', 510000, 0, 0, 643);
INSERT INTO "public"."qy_area" VALUES (645, 511781, '万源市', 511700, 0, 0, 644);
INSERT INTO "public"."qy_area" VALUES (646, 511800, '雅安市', 510000, 0, 0, 645);
INSERT INTO "public"."qy_area" VALUES (647, 511900, '巴中市', 510000, 0, 0, 646);
INSERT INTO "public"."qy_area" VALUES (648, 512000, '资阳市', 510000, 0, 0, 647);
INSERT INTO "public"."qy_area" VALUES (649, 512081, '简阳市', 512000, 0, 0, 648);
INSERT INTO "public"."qy_area" VALUES (650, 513200, '阿坝藏族羌族自治州', 510000, 0, 0, 649);
INSERT INTO "public"."qy_area" VALUES (651, 513300, '甘孜藏族自治州', 510000, 0, 0, 650);
INSERT INTO "public"."qy_area" VALUES (652, 513400, '凉山彝族自治州', 510000, 0, 0, 651);
INSERT INTO "public"."qy_area" VALUES (653, 513401, '西昌市', 513400, 0, 0, 652);
INSERT INTO "public"."qy_area" VALUES (654, 520000, '贵州省', 0, 0, 0, 653);
INSERT INTO "public"."qy_area" VALUES (655, 520100, '贵阳市', 520000, 106.71, 26.57, 654);
INSERT INTO "public"."qy_area" VALUES (656, 520181, '清镇市', 520100, 0, 0, 655);
INSERT INTO "public"."qy_area" VALUES (657, 520200, '六盘水市', 520000, 0, 0, 656);
INSERT INTO "public"."qy_area" VALUES (658, 520300, '遵义市', 520000, 106.9, 27.7, 657);
INSERT INTO "public"."qy_area" VALUES (659, 520381, '赤水市', 520300, 0, 0, 658);
INSERT INTO "public"."qy_area" VALUES (660, 520382, '仁怀市', 520300, 0, 0, 659);
INSERT INTO "public"."qy_area" VALUES (661, 520400, '安顺市', 520000, 0, 0, 660);
INSERT INTO "public"."qy_area" VALUES (662, 522201, '铜仁市', 522200, 0, 0, 661);
INSERT INTO "public"."qy_area" VALUES (663, 522300, '黔西南布依族苗族自治州', 520000, 0, 0, 662);
INSERT INTO "public"."qy_area" VALUES (664, 522301, '兴义市', 522300, 0, 0, 663);
INSERT INTO "public"."qy_area" VALUES (665, 522401, '毕节市', 522400, 0, 0, 664);
INSERT INTO "public"."qy_area" VALUES (666, 522600, '黔东南苗族侗族自治州', 520000, 0, 0, 665);
INSERT INTO "public"."qy_area" VALUES (667, 522601, '凯里市', 522600, 0, 0, 666);
INSERT INTO "public"."qy_area" VALUES (668, 522700, '黔南布依族苗族自治州', 520000, 0, 0, 667);
INSERT INTO "public"."qy_area" VALUES (669, 522701, '都匀市', 522700, 0, 0, 668);
INSERT INTO "public"."qy_area" VALUES (670, 522702, '福泉市', 522700, 0, 0, 669);
INSERT INTO "public"."qy_area" VALUES (671, 530000, '云南省', 0, 0, 0, 670);
INSERT INTO "public"."qy_area" VALUES (672, 530100, '昆明市', 530000, 102.73, 25.04, 671);
INSERT INTO "public"."qy_area" VALUES (673, 530181, '安宁市', 530100, 0, 0, 672);
INSERT INTO "public"."qy_area" VALUES (674, 530300, '曲靖市', 530000, 103.79, 25.51, 673);
INSERT INTO "public"."qy_area" VALUES (675, 530381, '宣威市', 530300, 0, 0, 674);
INSERT INTO "public"."qy_area" VALUES (676, 530400, '玉溪市', 530000, 102.52, 24.35, 675);
INSERT INTO "public"."qy_area" VALUES (677, 530500, '保山市', 530000, 0, 0, 676);
INSERT INTO "public"."qy_area" VALUES (678, 530600, '昭通市', 530000, 0, 0, 677);
INSERT INTO "public"."qy_area" VALUES (679, 530700, '丽江市', 530000, 0, 0, 678);
INSERT INTO "public"."qy_area" VALUES (680, 530800, '思茅市', 530000, 0, 0, 679);
INSERT INTO "public"."qy_area" VALUES (681, 530900, '临沧市', 530000, 0, 0, 680);
INSERT INTO "public"."qy_area" VALUES (682, 532300, '楚雄彝族自治州', 530000, 0, 0, 681);
INSERT INTO "public"."qy_area" VALUES (683, 532301, '楚雄市', 532300, 0, 0, 682);
INSERT INTO "public"."qy_area" VALUES (684, 532500, '红河哈尼族彝族自治州', 530000, 0, 0, 683);
INSERT INTO "public"."qy_area" VALUES (685, 532501, '个旧市', 532500, 0, 0, 684);
INSERT INTO "public"."qy_area" VALUES (686, 532502, '开远市', 532500, 0, 0, 685);
INSERT INTO "public"."qy_area" VALUES (687, 532600, '文山壮族苗族自治州', 530000, 0, 0, 686);
INSERT INTO "public"."qy_area" VALUES (688, 532800, '西双版纳傣族自治州', 530000, 0, 0, 687);
INSERT INTO "public"."qy_area" VALUES (689, 532801, '景洪市', 532800, 0, 0, 688);
INSERT INTO "public"."qy_area" VALUES (690, 532900, '大理白族自治州', 530000, 0, 0, 689);
INSERT INTO "public"."qy_area" VALUES (691, 532901, '大理市', 532900, 0, 0, 690);
INSERT INTO "public"."qy_area" VALUES (692, 533100, '德宏傣族景颇族自治州', 530000, 0, 0, 691);
INSERT INTO "public"."qy_area" VALUES (693, 533102, '瑞丽市', 533100, 0, 0, 692);
INSERT INTO "public"."qy_area" VALUES (694, 533103, '潞西市', 533100, 0, 0, 693);
INSERT INTO "public"."qy_area" VALUES (695, 533300, '怒江傈僳族自治州', 530000, 0, 0, 694);
INSERT INTO "public"."qy_area" VALUES (696, 533400, '迪庆藏族自治州', 530000, 0, 0, 695);
INSERT INTO "public"."qy_area" VALUES (697, 540000, '西　藏', 0, 0, 0, 696);
INSERT INTO "public"."qy_area" VALUES (698, 540100, '拉萨市', 540000, 91.11, 29.97, 697);
INSERT INTO "public"."qy_area" VALUES (699, 542301, '日喀则市', 542300, 0, 0, 698);
INSERT INTO "public"."qy_area" VALUES (700, 610000, '陕西省', 0, 0, 0, 699);
INSERT INTO "public"."qy_area" VALUES (701, 610100, '西安市', 610000, 108.95, 34.27, 700);
INSERT INTO "public"."qy_area" VALUES (702, 610200, '铜川市', 610000, 109.11, 35.09, 701);
INSERT INTO "public"."qy_area" VALUES (703, 610300, '宝鸡市', 610000, 107.15, 34.38, 702);
INSERT INTO "public"."qy_area" VALUES (704, 610400, '咸阳市', 610000, 108.72, 34.36, 703);
INSERT INTO "public"."qy_area" VALUES (705, 610481, '兴平市', 610400, 0, 0, 704);
INSERT INTO "public"."qy_area" VALUES (706, 610500, '渭南市', 610000, 109.5, 34.52, 705);
INSERT INTO "public"."qy_area" VALUES (707, 610581, '韩城市', 610500, 0, 0, 706);
INSERT INTO "public"."qy_area" VALUES (708, 610582, '华阴市', 610500, 0, 0, 707);
INSERT INTO "public"."qy_area" VALUES (709, 610600, '延安市', 610000, 109.47, 36.6, 708);
INSERT INTO "public"."qy_area" VALUES (710, 610700, '汉中市', 610000, 0, 0, 709);
INSERT INTO "public"."qy_area" VALUES (711, 610800, '榆林市', 610000, 0, 0, 710);
INSERT INTO "public"."qy_area" VALUES (712, 610900, '安康市', 610000, 0, 0, 711);
INSERT INTO "public"."qy_area" VALUES (713, 611000, '商洛市', 610000, 0, 0, 712);
INSERT INTO "public"."qy_area" VALUES (714, 620000, '甘肃省', 0, 0, 0, 713);
INSERT INTO "public"."qy_area" VALUES (715, 620100, '兰州市', 620000, 103.73, 36.03, 714);
INSERT INTO "public"."qy_area" VALUES (716, 620200, '嘉峪关市', 620000, 98.289152, 39.77313, 715);
INSERT INTO "public"."qy_area" VALUES (717, 620300, '金昌市', 620000, 102.188043, 38.520089, 716);
INSERT INTO "public"."qy_area" VALUES (718, 620400, '白银市', 620000, 0, 0, 717);
INSERT INTO "public"."qy_area" VALUES (719, 620500, '天水市', 620000, 0, 0, 718);
INSERT INTO "public"."qy_area" VALUES (720, 620600, '武威市', 620000, 0, 0, 719);
INSERT INTO "public"."qy_area" VALUES (721, 620700, '张掖市', 620000, 0, 0, 720);
INSERT INTO "public"."qy_area" VALUES (722, 620800, '平凉市', 620000, 0, 0, 721);
INSERT INTO "public"."qy_area" VALUES (723, 620900, '酒泉市', 620000, 0, 0, 722);
INSERT INTO "public"."qy_area" VALUES (724, 620981, '玉门市', 620900, 0, 0, 723);
INSERT INTO "public"."qy_area" VALUES (725, 620982, '敦煌市', 620900, 0, 0, 724);
INSERT INTO "public"."qy_area" VALUES (726, 621000, '庆阳市', 620000, 0, 0, 725);
INSERT INTO "public"."qy_area" VALUES (727, 621100, '定西市', 620000, 0, 0, 726);
INSERT INTO "public"."qy_area" VALUES (728, 621200, '陇南市', 620000, 0, 0, 727);
INSERT INTO "public"."qy_area" VALUES (729, 622900, '临夏回族自治州', 620000, 0, 0, 728);
INSERT INTO "public"."qy_area" VALUES (730, 622901, '临夏市', 622900, 0, 0, 729);
INSERT INTO "public"."qy_area" VALUES (731, 623000, '甘南藏族自治州', 620000, 0, 0, 730);
INSERT INTO "public"."qy_area" VALUES (732, 623001, '合作市', 623000, 0, 0, 731);
INSERT INTO "public"."qy_area" VALUES (733, 630000, '青海省', 0, 0, 0, 732);
INSERT INTO "public"."qy_area" VALUES (734, 630100, '西宁市', 630000, 101.74, 36.56, 733);
INSERT INTO "public"."qy_area" VALUES (735, 632200, '海北藏族自治州', 630000, 0, 0, 734);
INSERT INTO "public"."qy_area" VALUES (736, 632300, '黄南藏族自治州', 630000, 0, 0, 735);
INSERT INTO "public"."qy_area" VALUES (737, 632500, '海南藏族自治州', 630000, 0, 0, 736);
INSERT INTO "public"."qy_area" VALUES (738, 632600, '果洛藏族自治州', 630000, 0, 0, 737);
INSERT INTO "public"."qy_area" VALUES (739, 632700, '玉树藏族自治州', 630000, 0, 0, 738);
INSERT INTO "public"."qy_area" VALUES (740, 632800, '海西蒙古族藏族自治州', 630000, 0, 0, 739);
INSERT INTO "public"."qy_area" VALUES (741, 632801, '格尔木市', 632800, 0, 0, 740);
INSERT INTO "public"."qy_area" VALUES (742, 632802, '德令哈市', 632800, 0, 0, 741);
INSERT INTO "public"."qy_area" VALUES (743, 640000, '宁　夏', 0, 0, 0, 742);
INSERT INTO "public"."qy_area" VALUES (744, 640100, '银川市', 640000, 106.27, 38.47, 743);
INSERT INTO "public"."qy_area" VALUES (745, 640181, '灵武市', 640100, 0, 0, 744);
INSERT INTO "public"."qy_area" VALUES (746, 640200, '石嘴山市', 640000, 106.39, 39.04, 745);
INSERT INTO "public"."qy_area" VALUES (747, 640300, '吴忠市', 640000, 0, 0, 746);
INSERT INTO "public"."qy_area" VALUES (748, 640381, '青铜峡市', 640300, 0, 0, 747);
INSERT INTO "public"."qy_area" VALUES (749, 640400, '固原市', 640000, 0, 0, 748);
INSERT INTO "public"."qy_area" VALUES (750, 640500, '中卫市', 640000, 0, 0, 749);
INSERT INTO "public"."qy_area" VALUES (751, 650000, '新　疆', 0, 0, 0, 750);
INSERT INTO "public"."qy_area" VALUES (752, 650100, '乌鲁木齐市', 650000, 87.68, 43.77, 751);
INSERT INTO "public"."qy_area" VALUES (753, 650200, '克拉玛依市', 650000, 84.77, 45.59, 752);
INSERT INTO "public"."qy_area" VALUES (754, 652101, '吐鲁番市', 652100, 0, 0, 753);
INSERT INTO "public"."qy_area" VALUES (755, 652201, '哈密市', 652200, 0, 0, 754);
INSERT INTO "public"."qy_area" VALUES (756, 652300, '昌吉回族自治州', 650000, 0, 0, 755);
INSERT INTO "public"."qy_area" VALUES (757, 652301, '昌吉市', 652300, 0, 0, 756);
INSERT INTO "public"."qy_area" VALUES (758, 652302, '阜康市', 652300, 0, 0, 757);
INSERT INTO "public"."qy_area" VALUES (759, 652303, '米泉市', 652300, 0, 0, 758);
INSERT INTO "public"."qy_area" VALUES (760, 652700, '博尔塔拉蒙古自治州', 650000, 0, 0, 759);
INSERT INTO "public"."qy_area" VALUES (761, 652701, '博乐市', 652700, 0, 0, 760);
INSERT INTO "public"."qy_area" VALUES (762, 652800, '巴音郭楞蒙古自治州', 650000, 0, 0, 761);
INSERT INTO "public"."qy_area" VALUES (763, 652801, '库尔勒市', 652800, 86.06, 41.68, 762);
INSERT INTO "public"."qy_area" VALUES (764, 652901, '阿克苏市', 652900, 0, 0, 763);
INSERT INTO "public"."qy_area" VALUES (765, 653000, '克孜勒苏柯尔克孜自治州', 650000, 0, 0, 764);
INSERT INTO "public"."qy_area" VALUES (766, 653001, '阿图什市', 653000, 0, 0, 765);
INSERT INTO "public"."qy_area" VALUES (767, 653101, '喀什市', 653100, 0, 0, 766);
INSERT INTO "public"."qy_area" VALUES (768, 653201, '和田市', 653200, 0, 0, 767);
INSERT INTO "public"."qy_area" VALUES (769, 654000, '伊犁哈萨克自治州', 650000, 0, 0, 768);
INSERT INTO "public"."qy_area" VALUES (770, 654002, '伊宁市', 654000, 0, 0, 769);
INSERT INTO "public"."qy_area" VALUES (771, 654003, '奎屯市', 654000, 0, 0, 770);
INSERT INTO "public"."qy_area" VALUES (772, 654201, '塔城市', 654200, 0, 0, 771);
INSERT INTO "public"."qy_area" VALUES (773, 654202, '乌苏市', 654200, 0, 0, 772);
INSERT INTO "public"."qy_area" VALUES (774, 654301, '阿勒泰市', 654300, 0, 0, 773);
INSERT INTO "public"."qy_area" VALUES (775, 659000, '省直辖行政单位', 650000, 0, 0, 774);
INSERT INTO "public"."qy_area" VALUES (776, 659001, '石河子市', 659000, 0, 0, 775);
INSERT INTO "public"."qy_area" VALUES (777, 659002, '阿拉尔市', 659000, 0, 0, 776);
INSERT INTO "public"."qy_area" VALUES (778, 659003, '图木舒克市', 659000, 0, 0, 777);
INSERT INTO "public"."qy_area" VALUES (779, 659004, '五家渠市', 659000, 0, 0, 778);
INSERT INTO "public"."qy_area" VALUES (780, 710000, '台湾省', 0, 0, 0, 779);
INSERT INTO "public"."qy_area" VALUES (781, 710001, '台北市', 710000, 0, 0, 780);
INSERT INTO "public"."qy_area" VALUES (782, 710003, '基隆市', 710000, 0, 0, 781);
INSERT INTO "public"."qy_area" VALUES (783, 810000, '香　港', 0, 0, 0, 782);
INSERT INTO "public"."qy_area" VALUES (784, 810001, '香港', 810000, 0, 0, 783);
INSERT INTO "public"."qy_area" VALUES (785, 820000, '澳　门', 0, 0, 0, 784);
INSERT INTO "public"."qy_area" VALUES (786, 820001, '澳门', 820000, 0, 0, 785);
INSERT INTO "public"."qy_area" VALUES (787, 820002, '澳门', 820001, 0, 0, 786);
INSERT INTO "public"."qy_area" VALUES (788, 910005, '中山市', 442000, 113.38, 22.52, 787);
INSERT INTO "public"."qy_area" VALUES (789, 910006, '东莞市', 441900, 113.75, 23.04, 788);

-- ----------------------------
-- Table structure for qy_audit
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_audit";
CREATE TABLE "public"."qy_audit" (
  "id" int4 NOT NULL,
  "auditor" int4,
  "did" int4,
  "status" int2,
  "isdel" int2,
  "remark" varchar(600) COLLATE "pg_catalog"."default",
  "ctime" int4
)
;
COMMENT ON COLUMN "public"."qy_audit"."auditor" IS '审核人uid';
COMMENT ON COLUMN "public"."qy_audit"."did" IS 'Api详情Id';
COMMENT ON COLUMN "public"."qy_audit"."status" IS '审核状态(1通过,2拒绝)';
COMMENT ON COLUMN "public"."qy_audit"."isdel" IS '是否删除(1已删除,2未删除)';
COMMENT ON COLUMN "public"."qy_audit"."remark" IS '审核备注';
COMMENT ON COLUMN "public"."qy_audit"."ctime" IS '审核时间';

-- ----------------------------
-- Records of qy_audit
-- ----------------------------

-- ----------------------------
-- Table structure for qy_auth_access
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_auth_access";
CREATE TABLE "public"."qy_auth_access" (
  "id" int4 NOT NULL,
  "uid" int4 NOT NULL,
  "group_id" int4 NOT NULL
)
;
COMMENT ON COLUMN "public"."qy_auth_access"."uid" IS '用户id';
COMMENT ON COLUMN "public"."qy_auth_access"."group_id" IS '组id';

-- ----------------------------
-- Records of qy_auth_access
-- ----------------------------
INSERT INTO "public"."qy_auth_access" VALUES (1, 1, 1);
INSERT INTO "public"."qy_auth_access" VALUES (2, 2, 1);

-- ----------------------------
-- Table structure for qy_auth_data
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_auth_data";
CREATE TABLE "public"."qy_auth_data" (
  "id" int4 NOT NULL,
  "groupid" int4,
  "type" int2,
  "record" text COLLATE "pg_catalog"."default",
  "ctime" int4
)
;
COMMENT ON COLUMN "public"."qy_auth_data"."groupid" IS '组id';
COMMENT ON COLUMN "public"."qy_auth_data"."type" IS '类型(1项目选择,2分类选择,3用户选择,4企业密钥)';
COMMENT ON COLUMN "public"."qy_auth_data"."record" IS '类型对应的记录';
COMMENT ON COLUMN "public"."qy_auth_data"."ctime" IS '创建时间';

-- ----------------------------
-- Records of qy_auth_data
-- ----------------------------

-- ----------------------------
-- Table structure for qy_auth_group
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_auth_group";
CREATE TABLE "public"."qy_auth_group" (
  "id" int4 NOT NULL,
  "organize" int4 NOT NULL,
  "groupname" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "description" varchar(300) COLLATE "pg_catalog"."default" NOT NULL,
  "status" int2 NOT NULL,
  "rules" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "operate" varchar(100) COLLATE "pg_catalog"."default" NOT NULL
)
;
COMMENT ON COLUMN "public"."qy_auth_group"."organize" IS '组织id';
COMMENT ON COLUMN "public"."qy_auth_group"."groupname" IS '组名称';
COMMENT ON COLUMN "public"."qy_auth_group"."description" IS '组权限描述';
COMMENT ON COLUMN "public"."qy_auth_group"."status" IS '状态(1已启用,2已禁用)';
COMMENT ON COLUMN "public"."qy_auth_group"."rules" IS '规则';
COMMENT ON COLUMN "public"."qy_auth_group"."operate" IS '操作';

-- ----------------------------
-- Records of qy_auth_group
-- ----------------------------
INSERT INTO "public"."qy_auth_group" VALUES (1, 1, '超级管理员', '管理整个团队、Api操作等', 1, '21,22,23,26,27,28,24,29,30,25,31,32,33,35,34,37,38', '11,12,13,14,9,5,7,3,4');

-- ----------------------------
-- Table structure for qy_auth_operate
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_auth_operate";
CREATE TABLE "public"."qy_auth_operate" (
  "id" int4 NOT NULL,
  "title" varchar(100) COLLATE "pg_catalog"."default",
  "identify" varchar(100) COLLATE "pg_catalog"."default",
  "rid" int4,
  "path" varchar(100) COLLATE "pg_catalog"."default",
  "status" int2
)
;
COMMENT ON COLUMN "public"."qy_auth_operate"."title" IS '名称';
COMMENT ON COLUMN "public"."qy_auth_operate"."identify" IS '标识';
COMMENT ON COLUMN "public"."qy_auth_operate"."rid" IS '对应auth_rule的id';
COMMENT ON COLUMN "public"."qy_auth_operate"."path" IS 'api 路由地址';
COMMENT ON COLUMN "public"."qy_auth_operate"."status" IS '状态(1可用,2不可用)';

-- ----------------------------
-- Records of qy_auth_operate
-- ----------------------------
INSERT INTO "public"."qy_auth_operate" VALUES (1, '添加版本', 'addVersion', 26, '/Api/info', 1);
INSERT INTO "public"."qy_auth_operate" VALUES (2, '废弃Api', 'discardApi', 26, '/Api/discard', 1);
INSERT INTO "public"."qy_auth_operate" VALUES (3, '密钥创建/编辑', 'modifyCompany', 31, '/company/store', 1);
INSERT INTO "public"."qy_auth_operate" VALUES (4, '密钥删除', 'delCompany', 31, '/company/operate', 1);
INSERT INTO "public"."qy_auth_operate" VALUES (5, '分类创建/编辑', 'modifyCategory', 29, '/category/store', 1);
INSERT INTO "public"."qy_auth_operate" VALUES (7, '分类删除', 'delCategory', 29, '/category/operate', 1);
INSERT INTO "public"."qy_auth_operate" VALUES (9, '通过/拒绝', 'auditOperate', 28, '/Api/audit', 1);
INSERT INTO "public"."qy_auth_operate" VALUES (11, 'Api保存', 'apiStore', 27, '/Api/store', 1);
INSERT INTO "public"."qy_auth_operate" VALUES (12, 'Api发布', 'publishApi', 27, '/Api/publish', 1);
INSERT INTO "public"."qy_auth_operate" VALUES (13, 'Api编辑', 'modifyApi', 27, '/Api/info', 1);
INSERT INTO "public"."qy_auth_operate" VALUES (14, 'Api删除', 'delApi', 27, '/Api/operate', 1);

-- ----------------------------
-- Table structure for qy_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_auth_rule";
CREATE TABLE "public"."qy_auth_rule" (
  "id" int4 NOT NULL,
  "identify" int2 NOT NULL,
  "pid" int4 NOT NULL,
  "path" varchar(80) COLLATE "pg_catalog"."default" NOT NULL,
  "title" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "icon" varchar(100) COLLATE "pg_catalog"."default",
  "status" int2 NOT NULL,
  "sort" int4 NOT NULL,
  "isdel" int2
)
;
COMMENT ON COLUMN "public"."qy_auth_rule"."identify" IS '标识(1主控制台,2接口平台)';
COMMENT ON COLUMN "public"."qy_auth_rule"."pid" IS '父级id';
COMMENT ON COLUMN "public"."qy_auth_rule"."path" IS '路径';
COMMENT ON COLUMN "public"."qy_auth_rule"."title" IS '名称';
COMMENT ON COLUMN "public"."qy_auth_rule"."icon" IS 'icon图标';
COMMENT ON COLUMN "public"."qy_auth_rule"."status" IS '状态(0隐藏,1显示)';
COMMENT ON COLUMN "public"."qy_auth_rule"."sort" IS '排序';
COMMENT ON COLUMN "public"."qy_auth_rule"."isdel" IS '是否删除(1已删除,2未删除)';

-- ----------------------------
-- Records of qy_auth_rule
-- ----------------------------
INSERT INTO "public"."qy_auth_rule" VALUES (1, 1, 0, '', '导航栏', NULL, 1, 1, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (2, 1, 0, '', '用户', NULL, 1, 2, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (3, 1, 0, '', '设置', NULL, 1, 3, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (4, 1, 1, '/project', '所有项目', 'fa fa-th-large text-info', 1, 1, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (5, 1, 1, '/admin/apps', '应用管理', 'fa fa-tasks text-green', 1, 2, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (6, 1, 2, '', '用户管理', 'fa fa-group text-warning', 1, 1, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (7, 1, 2, '', '消息通知', 'fa fa-envelope text-info', 1, 2, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (8, 1, 2, '', '帮助中心', 'fa fa-question-circle text-muted', 1, 3, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (9, 1, 3, '/admin/log', '操作日志', 'fa fa-tags text-muted', 1, 1, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (10, 1, 3, '', '系统设置', 'fa fa-gears text-navy', 2, 2, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (11, 1, 6, '/admin/organize', '团队信息', NULL, 2, 1, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (12, 1, 6, '/admin/users', '团队成员', NULL, 1, 2, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (13, 1, 6, '/admin/group', '权限管理', NULL, 1, 3, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (14, 1, 7, '/message/list', '消息列表', NULL, 1, 1, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (15, 1, 7, '', '发送消息', NULL, 2, 2, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (16, 1, 8, '/help/list', '帮助列表', NULL, 1, 1, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (17, 1, 8, '/help/info', '新增帮助', NULL, 1, 2, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (18, 1, 10, '/website', '网站设置', NULL, 1, 1, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (19, 2, 0, '', '导航栏', NULL, 1, 1, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (20, 2, 0, '', '用户', NULL, 1, 1, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (21, 2, 19, '/dash', '控制台', 'fa fa fa-area-chart text-primary', 1, 1, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (22, 2, 19, '/Api/search', 'Api 搜索', 'fa fa-search text-info', 1, 2, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (23, 2, 19, '', 'Api 信息', 'fa fa-tasks text-muted', 1, 3, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (24, 2, 19, '', '分类信息', 'fa fa-life-buoy text-green', 1, 4, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (25, 2, 19, '', '企业密钥', 'fa fa-chain text-warning', 1, 5, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (26, 2, 23, '/Api/list', 'Api 列表', NULL, 1, 1, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (27, 2, 23, '/Api/info', '添加 Api', NULL, 1, 2, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (28, 2, 23, '/Api/audit', '待审核 Api', NULL, 1, 3, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (29, 2, 24, '/category', '分类列表', NULL, 1, 1, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (30, 2, 24, '/category/info', '添加分类', NULL, 1, 2, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (31, 2, 25, '/company', '密钥列表', NULL, 1, 1, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (32, 2, 25, '/company/info', '添加密钥', NULL, 1, 2, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (33, 2, 20, '', '消息通知', 'fa fa-envelope text-info', 1, 2, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (34, 2, 20, '', '帮助中心', 'fa fa-question-circle text-muted', 1, 3, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (35, 2, 33, '/message/list', '消息列表', NULL, 1, 1, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (36, 2, 33, '', '发送消息', NULL, 2, 2, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (37, 2, 34, '/admin/help/list', '帮助列表', NULL, 1, 1, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (38, 2, 34, '/admin/help/info', '新增帮助', NULL, 1, 2, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (39, 2, 20, '', '用户权限', 'fa fa-group text-warning', 2, 1, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (40, 2, 39, '/admin/users', '用户列表', NULL, 2, 1, 2);
INSERT INTO "public"."qy_auth_rule" VALUES (41, 2, 39, '/admin/group', '权限管理', NULL, 2, 2, 2);

-- ----------------------------
-- Table structure for qy_classify
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_classify";
CREATE TABLE "public"."qy_classify" (
  "id" int4 NOT NULL,
  "proid" int4 NOT NULL,
  "classifyname" varchar(100) COLLATE "pg_catalog"."default",
  "pid" int4,
  "description" text COLLATE "pg_catalog"."default",
  "addtime" int4,
  "creator" int4,
  "leader" varchar(300) COLLATE "pg_catalog"."default",
  "status" int2
)
;
COMMENT ON COLUMN "public"."qy_classify"."id" IS '分类id';
COMMENT ON COLUMN "public"."qy_classify"."proid" IS '项目id';
COMMENT ON COLUMN "public"."qy_classify"."classifyname" IS '分类名称';
COMMENT ON COLUMN "public"."qy_classify"."pid" IS '父级id';
COMMENT ON COLUMN "public"."qy_classify"."description" IS '分类描述';
COMMENT ON COLUMN "public"."qy_classify"."addtime" IS '添加时间';
COMMENT ON COLUMN "public"."qy_classify"."creator" IS '添加人';
COMMENT ON COLUMN "public"."qy_classify"."leader" IS '负责人';
COMMENT ON COLUMN "public"."qy_classify"."status" IS '分类状态(1正常,2删除)';

-- ----------------------------
-- Records of qy_classify
-- ----------------------------

-- ----------------------------
-- Table structure for qy_debug
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_debug";
CREATE TABLE "public"."qy_debug" (
  "id" int4 NOT NULL,
  "uid" int4 NOT NULL,
  "type" int2,
  "apiurl" varchar(200) COLLATE "pg_catalog"."default",
  "param" varchar(500) COLLATE "pg_catalog"."default",
  "header" varchar(500) COLLATE "pg_catalog"."default",
  "addtime" int4
)
;
COMMENT ON COLUMN "public"."qy_debug"."id" IS 'id';
COMMENT ON COLUMN "public"."qy_debug"."uid" IS '用户uid';
COMMENT ON COLUMN "public"."qy_debug"."type" IS '请求方式(1GET,2POST,3PUT,4DELETE)';
COMMENT ON COLUMN "public"."qy_debug"."apiurl" IS '接口url';
COMMENT ON COLUMN "public"."qy_debug"."param" IS '接口参数';
COMMENT ON COLUMN "public"."qy_debug"."header" IS 'header头';
COMMENT ON COLUMN "public"."qy_debug"."addtime" IS '添加时间';

-- ----------------------------
-- Records of qy_debug
-- ----------------------------

-- ----------------------------
-- Table structure for qy_email
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_email";
CREATE TABLE "public"."qy_email" (
  "id" int4 NOT NULL,
  "from" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "toaddress" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "toname" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "subject" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "content" text COLLATE "pg_catalog"."default" NOT NULL,
  "status" int2 NOT NULL,
  "reason" varchar(500) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."qy_email"."from" IS '发件人邮箱';
COMMENT ON COLUMN "public"."qy_email"."toaddress" IS '收件人邮箱';
COMMENT ON COLUMN "public"."qy_email"."toname" IS '收件人姓名';
COMMENT ON COLUMN "public"."qy_email"."subject" IS '主题';
COMMENT ON COLUMN "public"."qy_email"."content" IS '内容';
COMMENT ON COLUMN "public"."qy_email"."status" IS '发送状态(1成功,2失败)';
COMMENT ON COLUMN "public"."qy_email"."reason" IS '失败原因';

-- ----------------------------
-- Records of qy_email
-- ----------------------------

-- ----------------------------
-- Table structure for qy_extend
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_extend";
CREATE TABLE "public"."qy_extend" (
  "id" int4 NOT NULL,
  "name" varchar(60) COLLATE "pg_catalog"."default",
  "producer" varchar(300) COLLATE "pg_catalog"."default",
  "down" int4,
  "des" varchar(600) COLLATE "pg_catalog"."default",
  "execute" text COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."qy_extend"."name" IS '应用名称';
COMMENT ON COLUMN "public"."qy_extend"."producer" IS '出品方';
COMMENT ON COLUMN "public"."qy_extend"."down" IS '下载次数';
COMMENT ON COLUMN "public"."qy_extend"."des" IS '键值描述';
COMMENT ON COLUMN "public"."qy_extend"."execute" IS '执行脚本';

-- ----------------------------
-- Records of qy_extend
-- ----------------------------

-- ----------------------------
-- Table structure for qy_help
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_help";
CREATE TABLE "public"."qy_help" (
  "id" int4 NOT NULL,
  "organize" int4 NOT NULL,
  "author" int4,
  "title" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "content" text COLLATE "pg_catalog"."default",
  "status" int2,
  "ctime" int4
)
;
COMMENT ON COLUMN "public"."qy_help"."organize" IS '组织id';
COMMENT ON COLUMN "public"."qy_help"."author" IS '发布人';
COMMENT ON COLUMN "public"."qy_help"."title" IS '标题';
COMMENT ON COLUMN "public"."qy_help"."content" IS '内容';
COMMENT ON COLUMN "public"."qy_help"."status" IS '状态(1正常,2删除)';
COMMENT ON COLUMN "public"."qy_help"."ctime" IS '发布时间';

-- ----------------------------
-- Records of qy_help
-- ----------------------------

-- ----------------------------
-- Table structure for qy_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_log";
CREATE TABLE "public"."qy_log" (
  "id" int4 NOT NULL,
  "organize" int4,
  "object" varchar(100) COLLATE "pg_catalog"."default",
  "logtype" int4,
  "operator" int4,
  "desc" text COLLATE "pg_catalog"."default",
  "addtime" int4
)
;
COMMENT ON COLUMN "public"."qy_log"."organize" IS '组织id';
COMMENT ON COLUMN "public"."qy_log"."object" IS '操作对象';
COMMENT ON COLUMN "public"."qy_log"."logtype" IS '类型(1添加.2修改,3删除)';
COMMENT ON COLUMN "public"."qy_log"."operator" IS '操作人用户id';
COMMENT ON COLUMN "public"."qy_log"."desc" IS '操作描述';
COMMENT ON COLUMN "public"."qy_log"."addtime" IS '添加时间';

-- ----------------------------
-- Records of qy_log
-- ----------------------------

-- ----------------------------
-- Table structure for qy_message
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_message";
CREATE TABLE "public"."qy_message" (
  "id" int4 NOT NULL,
  "sender" int4,
  "receiver" int4,
  "pid" int4,
  "subject" varchar(100) COLLATE "pg_catalog"."default",
  "content" varchar(900) COLLATE "pg_catalog"."default",
  "sendtime" int4,
  "isread" int2
)
;
COMMENT ON COLUMN "public"."qy_message"."sender" IS '发件人uid';
COMMENT ON COLUMN "public"."qy_message"."receiver" IS '收件人uid';
COMMENT ON COLUMN "public"."qy_message"."pid" IS '父id';
COMMENT ON COLUMN "public"."qy_message"."subject" IS '消息主题';
COMMENT ON COLUMN "public"."qy_message"."content" IS '消息内容';
COMMENT ON COLUMN "public"."qy_message"."sendtime" IS '发件时间';
COMMENT ON COLUMN "public"."qy_message"."isread" IS '状态(1已读,2未读)';

-- ----------------------------
-- Records of qy_message
-- ----------------------------

-- ----------------------------
-- Table structure for qy_organize
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_organize";
CREATE TABLE "public"."qy_organize" (
  "id" int4 NOT NULL,
  "leader" int4 NOT NULL,
  "name" varchar(100) COLLATE "pg_catalog"."default",
  "identify" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "icon" varchar(100) COLLATE "pg_catalog"."default",
  "desc" varchar(300) COLLATE "pg_catalog"."default",
  "ctime" int4
)
;
COMMENT ON COLUMN "public"."qy_organize"."id" IS '组织id';
COMMENT ON COLUMN "public"."qy_organize"."leader" IS ' 组织负责人';
COMMENT ON COLUMN "public"."qy_organize"."name" IS '组织名称';
COMMENT ON COLUMN "public"."qy_organize"."identify" IS '组织标识';
COMMENT ON COLUMN "public"."qy_organize"."icon" IS '组织icon';
COMMENT ON COLUMN "public"."qy_organize"."desc" IS '组织描述';
COMMENT ON COLUMN "public"."qy_organize"."ctime" IS '添加时间';

-- ----------------------------
-- Records of qy_organize
-- ----------------------------
INSERT INTO "public"."qy_organize" VALUES (1, 1, '梦之队', '9d1bf3db0b9e4d6e1af98f35f1b075a7', '', '我就是我，不一样的烟火！', 1557672748);

-- ----------------------------
-- Table structure for qy_project
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_project";
CREATE TABLE "public"."qy_project" (
  "id" int4 NOT NULL,
  "organize" int4 NOT NULL,
  "proname" varchar(50) COLLATE "pg_catalog"."default",
  "desc" text COLLATE "pg_catalog"."default",
  "attribute" int2,
  "status" int2,
  "ctime" int4
)
;
COMMENT ON COLUMN "public"."qy_project"."organize" IS '组织id';
COMMENT ON COLUMN "public"."qy_project"."proname" IS '项目名称';
COMMENT ON COLUMN "public"."qy_project"."desc" IS '项目描述';
COMMENT ON COLUMN "public"."qy_project"."attribute" IS '项目属性(1公有,2私有)';
COMMENT ON COLUMN "public"."qy_project"."status" IS '状态(1正常,2弃用)';
COMMENT ON COLUMN "public"."qy_project"."ctime" IS '添加时间';

-- ----------------------------
-- Records of qy_project
-- ----------------------------
INSERT INTO "public"."qy_project" VALUES (1, 1, '默认项目', '默认项目', 1, 1, 1558017861);

-- ----------------------------
-- Table structure for qy_secret
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_secret";
CREATE TABLE "public"."qy_secret" (
  "id" int4 NOT NULL,
  "proid" int4,
  "company" varchar(100) COLLATE "pg_catalog"."default",
  "appid" varchar(100) COLLATE "pg_catalog"."default",
  "appsecret" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "status" int2,
  "ctime" int4
)
;
COMMENT ON COLUMN "public"."qy_secret"."proid" IS '项目id';
COMMENT ON COLUMN "public"."qy_secret"."company" IS '公司名称';
COMMENT ON COLUMN "public"."qy_secret"."appid" IS '应用id';
COMMENT ON COLUMN "public"."qy_secret"."appsecret" IS '应用密钥';
COMMENT ON COLUMN "public"."qy_secret"."status" IS '状态(1正常,2冻结,3删除)';
COMMENT ON COLUMN "public"."qy_secret"."ctime" IS '创建时间';

-- ----------------------------
-- Records of qy_secret
-- ----------------------------

-- ----------------------------
-- Table structure for qy_site
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_site";
CREATE TABLE "public"."qy_site" (
  "id" int4 NOT NULL,
  "key" varchar(60) COLLATE "pg_catalog"."default",
  "value" varchar(300) COLLATE "pg_catalog"."default",
  "type" int2,
  "des" varchar(600) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."qy_site"."key" IS '键';
COMMENT ON COLUMN "public"."qy_site"."value" IS '值';
COMMENT ON COLUMN "public"."qy_site"."type" IS '类型';
COMMENT ON COLUMN "public"."qy_site"."des" IS '键值描述';

-- ----------------------------
-- Records of qy_site
-- ----------------------------
INSERT INTO "public"."qy_site" VALUES (1, 'sitename', 'xApi Manager - 哆啦接口管理平台', 0, NULL);
INSERT INTO "public"."qy_site" VALUES (2, 'title', 'xApi Manager', 0, NULL);
INSERT INTO "public"."qy_site" VALUES (3, 'keywords', 'xApi Manager，哆啦接口管理平台', 0, NULL);
INSERT INTO "public"."qy_site" VALUES (4, 'description', 'XAPI MANAGER -专业实用的开源接口管理平台，为程序开发者提供一个灵活，方便，快捷的API管理工具，让API管理变的更加清晰、明朗', 0, NULL);
INSERT INTO "public"."qy_site" VALUES (5, 'copyright', 'Copyright  © 2019', 0, NULL);

-- ----------------------------
-- Table structure for qy_user_env
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_user_env";
CREATE TABLE "public"."qy_user_env" (
  "id" int4 NOT NULL,
  "uid" int4 NOT NULL,
  "proid" int4 NOT NULL,
  "envid" int4 NOT NULL
)
;
COMMENT ON COLUMN "public"."qy_user_env"."id" IS '用户id';
COMMENT ON COLUMN "public"."qy_user_env"."uid" IS '用户id';
COMMENT ON COLUMN "public"."qy_user_env"."proid" IS '项目id';
COMMENT ON COLUMN "public"."qy_user_env"."envid" IS '环境id';

-- ----------------------------
-- Records of qy_user_env
-- ----------------------------
INSERT INTO "public"."qy_user_env" VALUES (1, 1, 1, 4);

-- ----------------------------
-- Table structure for qy_user_organize
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_user_organize";
CREATE TABLE "public"."qy_user_organize" (
  "id" int4 NOT NULL,
  "uid" int4 NOT NULL,
  "organize" int4,
  "ctime" int4,
  "status" int2
)
;
COMMENT ON COLUMN "public"."qy_user_organize"."uid" IS '用户id';
COMMENT ON COLUMN "public"."qy_user_organize"."organize" IS '组织id';
COMMENT ON COLUMN "public"."qy_user_organize"."ctime" IS '添加时间';
COMMENT ON COLUMN "public"."qy_user_organize"."status" IS '用户在组织中的状态(1已激活,2待激活,3失效)';

-- ----------------------------
-- Records of qy_user_organize
-- ----------------------------
INSERT INTO "public"."qy_user_organize" VALUES (1, 1, 1, 1557672748, 1);

-- ----------------------------
-- Table structure for qy_users
-- ----------------------------
DROP TABLE IF EXISTS "public"."qy_users";
CREATE TABLE "public"."qy_users" (
  "uid" int4 NOT NULL,
  "username" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "email" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "avatar" text COLLATE "pg_catalog"."default",
  "phone" varchar(11) COLLATE "pg_catalog"."default" NOT NULL,
  "intro" text COLLATE "pg_catalog"."default",
  "password" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "salt" varchar(6) COLLATE "pg_catalog"."default" NOT NULL,
  "isadmin" int2,
  "ctime" int4
)
;
COMMENT ON COLUMN "public"."qy_users"."uid" IS '用户id';
COMMENT ON COLUMN "public"."qy_users"."username" IS '用户名';
COMMENT ON COLUMN "public"."qy_users"."email" IS '用户邮箱';
COMMENT ON COLUMN "public"."qy_users"."avatar" IS '用户头像';
COMMENT ON COLUMN "public"."qy_users"."phone" IS '手机号';
COMMENT ON COLUMN "public"."qy_users"."intro" IS '简介';
COMMENT ON COLUMN "public"."qy_users"."password" IS '用户密码';
COMMENT ON COLUMN "public"."qy_users"."salt" IS '用户随机码';
COMMENT ON COLUMN "public"."qy_users"."isadmin" IS '是否是管理员(1是,2否)';
COMMENT ON COLUMN "public"."qy_users"."ctime" IS '添加时间';

-- ----------------------------
-- Records of qy_users
-- ----------------------------
INSERT INTO "public"."qy_users" VALUES (1, 'admin', 'admin@admin.com', '', '18600000000', '', 'ff868b37c069480bc7a26d101ae191d9', 'a5ck', 1, 1557672748);
INSERT INTO "public"."qy_users" VALUES (2, 'yzq', 'yzqdev@qq.com', '', '18845645678', '', '37c6a5abbf9b69b2fbaf7115128febe1', 'u2ip', 1, 1652196997);

-- ----------------------------
-- Primary Key structure for table qy_apidetail
-- ----------------------------
ALTER TABLE "public"."qy_apidetail" ADD CONSTRAINT "qy_apidetail_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table qy_apienv
-- ----------------------------
ALTER TABLE "public"."qy_apienv" ADD CONSTRAINT "qy_apienv_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table qy_area
-- ----------------------------
CREATE INDEX "pid" ON "public"."qy_area" USING btree (
  "pid" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table qy_area
-- ----------------------------
ALTER TABLE "public"."qy_area" ADD CONSTRAINT "qy_area_pkey" PRIMARY KEY ("id", "area_id");

-- ----------------------------
-- Indexes structure for table qy_audit
-- ----------------------------
CREATE INDEX "did" ON "public"."qy_audit" USING btree (
  "did" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table qy_audit
-- ----------------------------
ALTER TABLE "public"."qy_audit" ADD CONSTRAINT "qy_audit_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table qy_auth_access
-- ----------------------------
CREATE INDEX "group_id" ON "public"."qy_auth_access" USING btree (
  "group_id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "uid" ON "public"."qy_auth_access" USING btree (
  "uid" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table qy_auth_access
-- ----------------------------
ALTER TABLE "public"."qy_auth_access" ADD CONSTRAINT "qy_auth_access_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table qy_auth_data
-- ----------------------------
ALTER TABLE "public"."qy_auth_data" ADD CONSTRAINT "qy_auth_data_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table qy_auth_group
-- ----------------------------
ALTER TABLE "public"."qy_auth_group" ADD CONSTRAINT "qy_auth_group_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table qy_auth_operate
-- ----------------------------
ALTER TABLE "public"."qy_auth_operate" ADD CONSTRAINT "qy_auth_operate_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table qy_auth_rule
-- ----------------------------
ALTER TABLE "public"."qy_auth_rule" ADD CONSTRAINT "qy_auth_rule_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table qy_classify
-- ----------------------------
ALTER TABLE "public"."qy_classify" ADD CONSTRAINT "qy_classify_pkey" PRIMARY KEY ("id");
