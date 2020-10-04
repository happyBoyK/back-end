/*
 Navicat Premium Data Transfer

 Source Server         : cmswing
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : cmswing

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 30/09/2020 10:53:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cmswing_action
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_action`;
CREATE TABLE `cmswing_action`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '行为唯一标识',
  `title` char(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '行为说明',
  `remark` char(140) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '行为描述',
  `rule` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '行为规则',
  `log` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '日志规则',
  `type` tinyint(2) UNSIGNED NOT NULL DEFAULT 1 COMMENT '类型',
  `status` tinyint(2) NOT NULL DEFAULT 0 COMMENT '状态',
  `update_time` bigint(13) UNSIGNED NOT NULL DEFAULT 0 COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统行为表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_action_log
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_action_log`;
CREATE TABLE `cmswing_action_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `action_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '行为id',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '执行用户id',
  `action_ip` bigint(20) NOT NULL COMMENT '执行行为者ip',
  `model` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '触发行为的表',
  `record_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '触发行为的数据id',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '日志备注',
  `status` tinyint(2) NOT NULL DEFAULT 1 COMMENT '状态',
  `create_time` bigint(13) UNSIGNED NOT NULL DEFAULT 0 COMMENT '执行行为的时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `action_ip_ix`(`action_ip`) USING BTREE,
  INDEX `action_id_ix`(`action_id`) USING BTREE,
  INDEX `user_id_ix`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1076 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '行为日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_address
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_address`;
CREATE TABLE `cmswing_address`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `accept_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mobile` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `province` bigint(20) NOT NULL,
  `city` bigint(20) NOT NULL,
  `county` bigint(20) NOT NULL,
  `zip` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addr` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_default` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 63 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_approval
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_approval`;
CREATE TABLE `cmswing_approval`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `model` int(10) NOT NULL,
  `data` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `uid` int(11) NOT NULL DEFAULT 0,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `time` bigint(13) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `time`(`time`) USING BTREE,
  INDEX `model`(`model`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 43 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_area
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_area`;
CREATE TABLE `cmswing_area`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `parent_id` bigint(20) NOT NULL DEFAULT 0,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`parent_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 910011 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_attribute
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_attribute`;
CREATE TABLE `cmswing_attribute`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '字段名',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '字段注释',
  `field` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '字段定义',
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '数据类型',
  `value` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '字段默认值',
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '备注',
  `is_show` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否显示',
  `extra` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '参数',
  `model_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '模型id',
  `is_must` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否必填',
  `status` tinyint(2) NOT NULL DEFAULT 0 COMMENT '状态',
  `update_time` bigint(13) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `create_time` bigint(13) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `validate_rule` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `validate_time` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `error_info` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `validate_type` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `auto_rule` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `auto_time` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `auto_type` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `model_id`(`model_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 151 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '模型属性表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_auth_role
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_auth_role`;
CREATE TABLE `cmswing_auth_role`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `description` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(11) NOT NULL DEFAULT 1,
  `rule_ids` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `module` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户组所属模块',
  `type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '组类型',
  `sort` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_auth_rule`;
CREATE TABLE `cmswing_auth_rule`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `pid` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `status` tinyint(11) NOT NULL DEFAULT 1,
  `condition` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `module` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '规则所属module',
  `type` tinyint(2) NOT NULL DEFAULT 1 COMMENT '1-url;2-主菜单',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `module`(`module`, `status`, `type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 247 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_auth_user_role
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_auth_user_role`;
CREATE TABLE `cmswing_auth_user_role`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_role`(`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cmswing_author
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_author`;
CREATE TABLE `cmswing_author`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` char(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `category_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '栏目目录',
  `group_id` smallint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属分组',
  `model_id` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '内容模型ID',
  `create_time` bigint(13) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` bigint(13) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '数据状态0禁用，1启用，-1删除',
  `sort_id` smallint(6) UNSIGNED NOT NULL DEFAULT 0,
  `pinyin` char(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名拼音',
  `pin` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '头像',
  `view` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '浏览次数',
  `focus_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '关注数',
  `runge` float(10, 2) NULL DEFAULT 0.00,
  `description` char(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '描述',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '文章内容',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `category_id`(`category_id`) USING BTREE,
  INDEX `group_id`(`group_id`) USING BTREE,
  INDEX `status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_balance_log
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_balance_log`;
CREATE TABLE `cmswing_balance_log`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `admin_id` bigint(11) NULL DEFAULT 0,
  `user_id` bigint(11) NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT 0,
  `time` bigint(13) NULL DEFAULT NULL,
  `amount` float(10, 2) NOT NULL,
  `amount_log` float(10, 2) NOT NULL,
  `note` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_cart
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_cart`;
CREATE TABLE `cmswing_cart`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `qty` int(11) NOT NULL COMMENT '商品数量',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品类型',
  `price` float(10, 2) NOT NULL COMMENT '商品价格小计',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品标题',
  `unit_price` float(10, 2) NOT NULL COMMENT '商品单价',
  `pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品图片',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品地址',
  `weight` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 49 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_category
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_category`;
CREATE TABLE `cmswing_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '标志',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级分类ID',
  `sort` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序（同级有效）',
  `list_row` tinyint(3) UNSIGNED NOT NULL DEFAULT 10 COMMENT '列表每页行数',
  `meta_title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'SEO的网页标题',
  `keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  `template_index` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '频道页模板',
  `template_lists` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '列表页模板',
  `template_detail` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '详情页模板',
  `template_edit` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '编辑页模板',
  `model` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '列表绑定模型',
  `model_sub` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '子文档绑定模型',
  `type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '允许发布的内容类型',
  `link_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '外链',
  `allow_publish` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否允许发布内容',
  `display` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '可见性',
  `reply` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否允许回复',
  `check` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '发布的文章是否需要审核',
  `reply_model` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `extend` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '扩展设置',
  `create_time` bigint(13) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` bigint(13) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '数据状态',
  `icon` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '分类图标',
  `groups` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '分组定义',
  `documentsorts` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `mold` tinyint(3) NOT NULL DEFAULT 0 COMMENT '栏目类型 0系统模型 1独立模型 2单页面',
  `isapp` tinyint(3) NOT NULL DEFAULT 1 COMMENT '是否在移动端显示 1显示 0不显示',
  `template_m_index` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机频道模版',
  `template_m_lists` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机列表模版',
  `template_m_detail` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机详情页模版',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `uk_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 131 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_category_priv
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_category_priv`;
CREATE TABLE `cmswing_category_priv`  (
  `catid` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `roleid` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `is_admin` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `action` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  INDEX `catid`(`catid`, `roleid`, `is_admin`, `action`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cmswing_category_sp
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_category_sp`;
CREATE TABLE `cmswing_category_sp`  (
  `cid` int(10) UNSIGNED NOT NULL,
  `ispct` tinyint(3) NOT NULL DEFAULT 0 COMMENT '0:系统模板，1:独立模板 ,2: 转跳',
  `sp_temp_pc` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `sp_html_pc` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ismt` tinyint(3) NOT NULL DEFAULT 0,
  `sp_temp_m` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `sp_html_m` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `pc_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `m_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cmswing_channel
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_channel`;
CREATE TABLE `cmswing_channel`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级频道ID',
  `title` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '频道标题',
  `url` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '频道连接',
  `sort` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '导航排序',
  `create_time` bigint(13) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` bigint(13) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '状态',
  `target` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '新窗口打开',
  `cid` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cmswing_doc_invoice
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_doc_invoice`;
CREATE TABLE `cmswing_doc_invoice`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `invoice_no` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `order_id` bigint(20) NOT NULL,
  `order_no` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `admin` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `accept_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `province` bigint(20) NULL DEFAULT NULL,
  `city` bigint(20) NULL DEFAULT NULL,
  `county` bigint(20) NULL DEFAULT NULL,
  `zip` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addr` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mobile` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` bigint(13) NULL DEFAULT NULL,
  `express_no` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `express_company_id` bigint(20) NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_doc_receiving
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_doc_receiving`;
CREATE TABLE `cmswing_doc_receiving`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `admin_id` bigint(20) NULL DEFAULT NULL,
  `amount` float(10, 2) NULL DEFAULT 0.00,
  `create_time` bigint(13) NULL DEFAULT NULL,
  `payment_time` bigint(13) NULL DEFAULT NULL,
  `doc_type` tinyint(1) NULL DEFAULT NULL,
  `payment_id` bigint(20) NULL DEFAULT NULL,
  `pay_status` tinyint(1) NULL DEFAULT NULL,
  `note` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_doc_refund
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_doc_refund`;
CREATE TABLE `cmswing_doc_refund`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `order_no` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` bigint(13) NULL DEFAULT NULL,
  `refund_type` tinyint(3) NULL DEFAULT 0,
  `account_bank` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `account_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `refund_account` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `admin_id` int(11) NULL DEFAULT NULL,
  `pay_status` tinyint(3) NULL DEFAULT 0,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `handling_idea` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `handling_time` bigint(13) NULL DEFAULT NULL,
  `channel` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `bank_account` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `amount` float(10, 2) NULL DEFAULT 0.00,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_doc_returns
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_doc_returns`;
CREATE TABLE `cmswing_doc_returns`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `admin_id` int(11) NULL DEFAULT NULL,
  `order_id` int(11) NULL DEFAULT NULL,
  `order_no` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `province` bigint(20) NULL DEFAULT NULL,
  `city` bigint(20) NULL DEFAULT NULL,
  `county` binary(1) NULL DEFAULT NULL,
  `zip` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addr` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mobile` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` bigint(13) NULL DEFAULT NULL,
  `express_no` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `express` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `handling_idea` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint(3) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_document
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_document`;
CREATE TABLE `cmswing_document`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID',
  `name` char(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '标识',
  `title` char(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  `category_id` int(10) UNSIGNED NOT NULL COMMENT '所属分类',
  `group_id` smallint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属分组',
  `description` char(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '描述',
  `root` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '根节点',
  `topid` int(10) NOT NULL DEFAULT 0 COMMENT '所属顶级id',
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属ID',
  `model_id` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '内容模型ID',
  `type` tinyint(3) UNSIGNED NOT NULL DEFAULT 2 COMMENT '内容类型',
  `position` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '推荐位',
  `link_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '外链',
  `cover_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '封面',
  `display` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '可见性',
  `deadline` bigint(13) UNSIGNED NOT NULL DEFAULT 0 COMMENT '截至时间',
  `attach` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '附件数量',
  `view` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '浏览量',
  `comment` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论数',
  `extend` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '扩展统计字段',
  `level` int(10) NOT NULL DEFAULT 0 COMMENT '优先级',
  `create_time` bigint(13) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` bigint(13) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '数据状态0禁用，1启用，-1删除',
  `pics` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '多图上传',
  `price` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '价格',
  `sort_id` smallint(6) UNSIGNED NOT NULL DEFAULT 0,
  `keyname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键词',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_category_status`(`category_id`, `status`) USING BTREE,
  INDEX `idx_status_type_pid`(`status`, `uid`, `pid`) USING BTREE,
  INDEX `keyname`(`keyname`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 314 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文档模型基础表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_document_article
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_document_article`;
CREATE TABLE `cmswing_document_article`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `editor` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '文章内容',
  `template` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `bookmark` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '收藏数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 314 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文档模型文章表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_document_docs
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_document_docs`;
CREATE TABLE `cmswing_document_docs`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `editor` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文档内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 301 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_document_download
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_document_download`;
CREATE TABLE `cmswing_document_download`  (
  `id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文档ID',
  `editor` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '下载详细描述',
  `template` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `file_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文件ID',
  `download` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '下载次数',
  `size` bigint(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文件大小',
  `fileimgs` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '软件截图',
  `panurl` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '网盘链接',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文档模型下载表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_document_picture
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_document_picture`;
CREATE TABLE `cmswing_document_picture`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `template` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '详情页显示模板',
  `atlas` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '图片内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 309 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_document_shop
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_document_shop`;
CREATE TABLE `cmswing_document_shop`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `suk` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '库存/规格',
  `goods_no` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '商家编码',
  `total_stock` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '总库存',
  `quota` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '每人限购',
  `join_level_discount` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '会员折扣',
  `invoice` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '发票',
  `warranty` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '保修',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品详情',
  `freight` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '设置运费',
  `weight` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '重量(g)',
  `fare` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '运费模板',
  `editor` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 294 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_document_test
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_document_test`;
CREATE TABLE `cmswing_document_test`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `bbb2` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'bbbbb',
  `test` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'test',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_document_video
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_document_video`;
CREATE TABLE `cmswing_document_video`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `video_id` int(10) UNSIGNED NOT NULL COMMENT '视频id',
  `template` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '详情页显示模板',
  `videourl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '视频地址url',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 304 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_express
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_express`;
CREATE TABLE `cmswing_express`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `area` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `area_groupid` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `firstprice` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `secondprice` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `type` tinyint(1) NULL DEFAULT NULL,
  `first_weight` int(11) NULL DEFAULT NULL,
  `second_weight` int(11) NULL DEFAULT NULL,
  `first_price` float(10, 2) NULL DEFAULT 0.00,
  `second_price` float(10, 2) NULL DEFAULT 0.00,
  `status` tinyint(1) NULL DEFAULT 0,
  `sort` int(11) NULL DEFAULT 0,
  `is_save_price` tinyint(1) NULL DEFAULT 0,
  `save_rate` int(11) NULL DEFAULT NULL,
  `low_price` float(10, 2) NULL DEFAULT 0.00,
  `price_type` tinyint(1) NULL DEFAULT 0,
  `open_default` tinyint(1) NULL DEFAULT 1,
  `is_delete` tinyint(1) NULL DEFAULT 0,
  `express_company_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_express_company
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_express_company`;
CREATE TABLE `cmswing_express_company`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `alias` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sort` tinyint(3) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_express_template
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_express_template`;
CREATE TABLE `cmswing_express_template`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `background` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `width` int(5) NULL DEFAULT 900,
  `height` int(5) NULL DEFAULT 600,
  `offset_x` int(5) NULL DEFAULT 0,
  `offset_y` int(5) NULL DEFAULT 0,
  `is_default` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_ext
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_ext`;
CREATE TABLE `cmswing_ext`  (
  `ext` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `version` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `setting` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `sort` tinyint(3) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `installtime` bigint(13) NOT NULL,
  `isadm` tinyint(1) NOT NULL DEFAULT 0,
  `isindex` tinyint(1) NOT NULL DEFAULT 0,
  `author` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '作者',
  PRIMARY KEY (`ext`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cmswing_ext_ad
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_ext_ad`;
CREATE TABLE `cmswing_ext_ad`  (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `spaceid` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `setting` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `startdate` bigint(13) UNSIGNED NOT NULL DEFAULT 0,
  `enddate` bigint(13) UNSIGNED NOT NULL DEFAULT 0,
  `addtime` bigint(13) UNSIGNED NOT NULL DEFAULT 0,
  `hits` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `clicks` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `sort` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '0：禁用，1：启用',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `spaceid`(`spaceid`, `status`, `sort`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_ext_ad_space
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_ext_ad_space`;
CREATE TABLE `cmswing_ext_ad_space`  (
  `spaceid` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` char(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `width` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `height` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
  `setting` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `description` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `items` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `code` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `json` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`spaceid`) USING BTREE,
  INDEX `disabled`(`status`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_ext_ad_temp
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_ext_ad_temp`;
CREATE TABLE `cmswing_ext_ad_temp`  (
  `tempid` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `align` tinyint(2) NOT NULL DEFAULT 0 COMMENT '0:无，1：全屏居中，2：随屏滚动',
  `select` tinyint(2) NOT NULL DEFAULT 0,
  `padding` tinyint(2) NOT NULL DEFAULT 0,
  `size` tinyint(2) NOT NULL DEFAULT 0,
  `option` tinyint(2) NOT NULL DEFAULT 0,
  `num` tinyint(2) NOT NULL DEFAULT 0,
  `iscore` tinyint(2) NOT NULL DEFAULT 1,
  `type` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  `temp` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`tempid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_ext_attachment
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_ext_attachment`;
CREATE TABLE `cmswing_ext_attachment`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` char(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_time` bigint(13) NOT NULL,
  `type` tinyint(3) NOT NULL DEFAULT 0 COMMENT '0:图片,1:文件',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '数据状态0禁用，1启用，-1删除',
  `sort` int(8) NOT NULL DEFAULT 0,
  `rule` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `use` tinyint(3) NOT NULL DEFAULT 0 COMMENT '0:后台,1:前台',
  `dis` char(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `path` char(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `mark` tinyint(3) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cmswing_ext_attachment_file
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_ext_attachment_file`;
CREATE TABLE `cmswing_ext_attachment_file`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` char(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '原始文件名',
  `savename` char(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '保存名称',
  `savepath` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件保存路径',
  `ext` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mime` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文件大小',
  `md5` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `type` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文件保存位置 1微信，2，七牛',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '远程地址',
  `create_time` bigint(13) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上传时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_md5`(`md5`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文件表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_ext_attachment_pic
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_ext_attachment_pic`;
CREATE TABLE `cmswing_ext_attachment_pic`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '路径',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '图片链接',
  `md5` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `status` tinyint(2) NOT NULL DEFAULT 0 COMMENT '状态',
  `create_time` bigint(13) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `type` int(2) NULL DEFAULT 0 COMMENT '图片来源，或模块区分 1:微信2:七牛',
  `source_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '来源id，当关联其他平台时该平台生产的id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 963 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_ext_changyan
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_ext_changyan`;
CREATE TABLE `cmswing_ext_changyan`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `callback` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `nickname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `img_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `profile_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `user_id` int(11) NULL DEFAULT NULL,
  `sign` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uid` int(11) NULL DEFAULT NULL,
  `cy_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_ext_collector
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_ext_collector`;
CREATE TABLE `cmswing_ext_collector`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `name` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '模型标识',
  `title` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '模型名称',
  `attribute_list` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '属性列表（表的字段）',
  `model` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '列表绑定模型',
  `info` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接口说明',
  `create_time` bigint(15) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` bigint(15) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cmswing_ext_demo
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_ext_demo`;
CREATE TABLE `cmswing_ext_demo`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cmswing_ext_link
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_ext_link`;
CREATE TABLE `cmswing_ext_link`  (
  `id` smallint(5) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `typeid` smallint(5) NOT NULL DEFAULT 0 COMMENT '类别id',
  `linktype` tinyint(1) NOT NULL DEFAULT 0 COMMENT '链接类型 1 logo，0文字',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '网站名称',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '网站地址',
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '网站logo',
  `introduce` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '网站介绍',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '申请者',
  `sort` smallint(5) NOT NULL DEFAULT 0 COMMENT '排序',
  `elite` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否推荐 0 不推荐，1推荐',
  `passed` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0没有审核，1通过审核',
  `addtime` bigint(13) NOT NULL DEFAULT 0 COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cmswing_ext_qq
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_ext_qq`;
CREATE TABLE `cmswing_ext_qq`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ret` int(11) NULL DEFAULT NULL COMMENT '返回码',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '如果ret<0，会有相应的错误信息提示，返回数据全部用UTF-8编码。',
  `nickname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户在QQ空间的昵称。',
  `figureurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '大小为30×30像素的QQ空间头像URL。',
  `figureurl_1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '大小为50×50像素的QQ空间头像URL。',
  `figureurl_2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '大小为100×100像素的QQ空间头像URL。',
  `figureurl_qq_1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '大小为40×40像素的QQ头像URL。',
  `figureurl_qq_2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '大小为100×100像素的QQ头像URL。需要注意，不是所有的用户都拥有QQ的100x100的头像，但40x40像素则是一定会有。',
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '性别。 如果获取不到则默认返回\"男\"',
  `is_yellow_vip` int(2) NULL DEFAULT 0 COMMENT '标识用户是否为黄钻用户（0：不是；1：是）。',
  `vip` int(2) NULL DEFAULT 0 COMMENT '标识用户是否为黄钻用户（0：不是；1：是）',
  `yellow_vip_level` int(2) NULL DEFAULT 0 COMMENT '黄钻等级',
  `level` int(2) NULL DEFAULT 0 COMMENT '黄钻等级',
  `is_yellow_year_vip` int(2) NULL DEFAULT 0 COMMENT '标识是否为年费黄钻用户（0：不是； 1：是）',
  `uid` int(11) NULL DEFAULT NULL COMMENT '关联用户id',
  `openid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'openid',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cmswing_ext_smslog
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_ext_smslog`;
CREATE TABLE `cmswing_ext_smslog`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `mobile` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` tinyint(4) NOT NULL,
  `create_time` bigint(13) NOT NULL,
  `code` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cmswing_ext_type
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_ext_type`;
CREATE TABLE `cmswing_ext_type`  (
  `typeid` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ext` char(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `extid` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `name` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pid` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `typedir` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `url` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `template` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `sort` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`typeid`) USING BTREE,
  INDEX `ext`(`ext`, `pid`, `sort`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_ext_weibo
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_ext_weibo`;
CREATE TABLE `cmswing_ext_weibo`  (
  `id` bigint(11) NOT NULL COMMENT '用户UID',
  `screen_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '友好显示名称',
  `province` int(5) NULL DEFAULT NULL COMMENT '用户所在省级ID',
  `city` int(5) NULL DEFAULT NULL COMMENT '用户所在城市ID',
  `location` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户所在地',
  `description` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户个人描述',
  `url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户博客地址',
  `profile_image_url` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户头像地址（中图），50×50像素',
  `profile_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户的微博统一URL地址',
  `domain` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户的个性化域名',
  `weihao` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户的微号',
  `gender` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '性别，m：男、f：女、n：未知',
  `followers_count` int(10) NOT NULL DEFAULT 0 COMMENT '粉丝数',
  `friends_count` int(10) NOT NULL DEFAULT 0 COMMENT '关注数',
  `statuses_count` int(10) NOT NULL DEFAULT 0 COMMENT '微博数',
  `favourites_count` int(10) NOT NULL DEFAULT 0 COMMENT '收藏数',
  `created_at` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户创建（注册）时间',
  `verified_type` int(1) NOT NULL DEFAULT 0 COMMENT '暂未支持\n暂未支持\n暂未支持\n暂未支持\n暂未支持',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户备注信息，只有在查询用户关系时才返回此字段',
  `avatar_large` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户头像地址（大图），180×180像素',
  `avatar_hd` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户头像地址（高清），高清头像原图',
  `verified_reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '认证原因',
  `online_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '用户的在线状态，0：不在线、1：在线',
  `bi_followers_coun` int(10) NOT NULL DEFAULT 0 COMMENT '用户的互粉数',
  `lang` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户当前的语言版本，zh-cn：简体中文，zh-tw：繁体中文，en：英语',
  `uid` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_ext_weixin
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_ext_weixin`;
CREATE TABLE `cmswing_ext_weixin`  (
  `openid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'OopenId',
  `unionid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'UnionId',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '微信昵称',
  `sex` int(5) NULL DEFAULT NULL COMMENT '性别',
  `language` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户的语言',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '城市',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省',
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '国家',
  `headimgurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像url',
  `access_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'access_token',
  `refresh_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'refresh_token',
  `uid` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`openid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_fare
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_fare`;
CREATE TABLE `cmswing_fare`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `first_weight` int(11) NOT NULL,
  `second_weight` int(11) NOT NULL,
  `first_price` float(10, 2) NOT NULL,
  `second_price` float(10, 2) NULL DEFAULT NULL,
  `zoning` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `is_default` int(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_hooks
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_hooks`;
CREATE TABLE `cmswing_hooks`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '描述',
  `type` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '类型',
  `update_time` bigint(13) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `ext` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '钩子挂载的插件 \'，\'分割',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 40 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cmswing_keyword
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_keyword`;
CREATE TABLE `cmswing_keyword`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `keyname` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pinyin` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `videonum` int(11) NOT NULL DEFAULT 0,
  `searchnums` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '话题描述',
  `pic` int(10) NOT NULL DEFAULT 0 COMMENT '话题图片',
  `lock` tinyint(2) NOT NULL DEFAULT 0 COMMENT '话题是否锁定 1 锁定 0 未锁定',
  `focus_count` int(10) NOT NULL DEFAULT 0 COMMENT '关注统计',
  `user_related` tinyint(1) NULL DEFAULT 0 COMMENT '是否被用户关联',
  `url_token` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `merged_id` int(11) NULL DEFAULT 0,
  `seo_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pid` int(10) NULL DEFAULT 0,
  `is_parent` tinyint(1) NULL DEFAULT 0,
  `discuss_count_last_week` int(10) NULL DEFAULT 0,
  `discuss_count_last_month` int(10) NULL DEFAULT 0,
  `discuss_count_update` bigint(13) NOT NULL DEFAULT 0,
  `add_time` bigint(13) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `keyname`(`keyname`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 41 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_keyword_data
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_keyword_data`;
CREATE TABLE `cmswing_keyword_data`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tagid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `docid` int(10) NOT NULL,
  `add_time` bigint(13) NULL DEFAULT 0 COMMENT '添加时间',
  `uid` int(11) NULL DEFAULT 0 COMMENT '用户ID',
  `mod_type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '模型类型，0为系统模型，1为独立模型。3是单页模型',
  `mod_id` tinyint(3) NOT NULL DEFAULT 0 COMMENT '独立模型id,只有mod_type为1时才有用',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tagid`(`tagid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 80 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_keyword_focus
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_keyword_focus`;
CREATE TABLE `cmswing_keyword_focus`  (
  `focus_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `key_id` int(11) NULL DEFAULT NULL COMMENT '话题ID',
  `uid` int(11) NULL DEFAULT NULL COMMENT '用户UID',
  `add_time` bigint(13) NULL DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`focus_id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `key_id`(`key_id`) USING BTREE,
  INDEX `doc_uid`(`key_id`, `uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '话题关注表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_keyword_merge
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_keyword_merge`;
CREATE TABLE `cmswing_keyword_merge`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source_id` int(11) NOT NULL DEFAULT 0,
  `target_id` int(11) NOT NULL DEFAULT 0,
  `uid` int(11) NULL DEFAULT 0,
  `time` bigint(13) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `source_id`(`source_id`) USING BTREE,
  INDEX `target_id`(`target_id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_member
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_member`;
CREATE TABLE `cmswing_member`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `score` mediumint(8) NOT NULL DEFAULT 0 COMMENT '用户积分',
  `email` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户邮箱',
  `login` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '登录次数',
  `mobile` char(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户手机',
  `reg_time` bigint(13) UNSIGNED NOT NULL DEFAULT 0 COMMENT '注册时间',
  `reg_ip` bigint(20) NOT NULL DEFAULT 0 COMMENT '注册IP',
  `last_login_time` bigint(13) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最后登录时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT 0 COMMENT '最后登录IP',
  `update_time` bigint(13) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '数据状态0禁用，1启用，-1删除',
  `is_admin` tinyint(2) NOT NULL DEFAULT 0 COMMENT '0前台用户 1管理用户',
  `groupid` tinyint(3) UNSIGNED NOT NULL DEFAULT 2 COMMENT '用户组',
  `amount` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '金钱',
  `modelid` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户模型id',
  `message` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '消息',
  `fans_count` int(10) NOT NULL DEFAULT 0 COMMENT '粉丝数',
  `friend_count` int(10) NOT NULL DEFAULT 0 COMMENT '观众数',
  `article_count` int(10) NOT NULL DEFAULT 0 COMMENT '文章数量',
  `views_count` int(10) NULL DEFAULT 0 COMMENT '个人主页查看数量',
  `province` bigint(20) NULL DEFAULT NULL COMMENT '省份',
  `city` bigint(20) NULL DEFAULT NULL COMMENT '城市',
  `county` bigint(20) NULL DEFAULT NULL COMMENT '市区',
  `addr` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `sex` tinyint(1) NULL DEFAULT 1 COMMENT '性别',
  `birthday` bigint(13) NULL DEFAULT NULL COMMENT '生日',
  `vip` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `overduedate` bigint(13) UNSIGNED NOT NULL DEFAULT 0,
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE,
  INDEX `status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 468 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cmswing_member_group
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_member_group`;
CREATE TABLE `cmswing_member_group`  (
  `groupid` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` char(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `issystem` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `starnum` tinyint(2) UNSIGNED NOT NULL,
  `point` smallint(6) UNSIGNED NOT NULL,
  `allowmessage` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `allowvisit` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `allowpost` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `allowpostverify` tinyint(1) UNSIGNED NOT NULL,
  `allowsearch` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `allowupgrade` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `allowsendmessage` tinyint(1) UNSIGNED NOT NULL,
  `allowpostnum` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `allowattachment` tinyint(1) NOT NULL,
  `price_y` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00,
  `price_m` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00,
  `price_d` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00,
  `icon` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `usernamecolor` char(7) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sort` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (`groupid`) USING BTREE,
  INDEX `disabled`(`status`) USING BTREE,
  INDEX `listorder`(`sort`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cmswing_member_public
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_member_public`;
CREATE TABLE `cmswing_member_public`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(10) NOT NULL COMMENT '用户ID',
  `public_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公众号名称',
  `public_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公众号原始id',
  `wechat` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '微信号',
  `interface_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接口地址',
  `headface_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公众号头像',
  `area` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地区',
  `addon_config` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '插件配置',
  `addon_status` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '插件状态',
  `token` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Token',
  `type` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '公众号类型',
  `appid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'AppID',
  `secret` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'AppSecret',
  `status` tinyint(4) NULL DEFAULT 0 COMMENT '2：未审核，1:启用，0：禁用，-1：删除',
  `group_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '等级',
  `encodingaeskey` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'EncodingAESKey',
  `mchid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商户号（微信支付必须配置）',
  `mchkey` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商户支付密钥（微信支付必须配置）',
  `notify_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接收微信支付异步通知回调地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_member_verify
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_member_verify`;
CREATE TABLE `cmswing_member_verify`  (
  `userid` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `encrypt` char(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nickname` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `regdate` int(10) UNSIGNED NOT NULL,
  `regip` char(15) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `modelid` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `point` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `amount` decimal(8, 2) UNSIGNED NOT NULL DEFAULT 0.00,
  `modelinfo` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `siteid` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `message` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mobile` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`userid`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  INDEX `email`(`email`(20)) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cmswing_member_vip
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_member_vip`;
CREATE TABLE `cmswing_member_vip`  (
  `userid` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  UNIQUE INDEX `userid`(`userid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cmswing_menu
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_menu`;
CREATE TABLE `cmswing_menu`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级分类ID',
  `sort` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序（同级有效）',
  `url` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '链接地址',
  `hide` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否隐藏',
  `tip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '提示',
  `group` int(10) NOT NULL COMMENT '分组',
  `is_dev` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否仅开发者模式可见',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '状态',
  `ico` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 287 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_model
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_model`;
CREATE TABLE `cmswing_model`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `name` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '模型标识',
  `title` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '模型名称',
  `extend` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '继承的模型',
  `relation` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '继承与被继承模型的关联字段',
  `need_pk` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '新建表时是否需要主键字段',
  `field_sort` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '表单字段排序',
  `field_group` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1:基础' COMMENT '字段分组',
  `attribute_list` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '属性列表（表的字段）',
  `attribute_alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '属性别名定义',
  `template_list` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '列表模板',
  `template_add` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '新增模板',
  `template_edit` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '编辑模板',
  `list_grid` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '列表定义',
  `list_row` smallint(2) UNSIGNED NOT NULL DEFAULT 10 COMMENT '列表数据长度',
  `search_key` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '默认搜索字段',
  `search_list` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '高级搜索的字段',
  `create_time` bigint(15) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` bigint(15) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态',
  `engine_type` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'MyISAM' COMMENT '数据库引擎',
  `key_show` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0不在话题显示，1在话题显示',
  `temp_show` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 启用模版，0不启用模版',
  `type_show` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1启用分类信息，0不启用分类信息',
  `priv_show` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1开启权限，0不开启权限。',
  `groups_show` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1开启分组，0不开启分组',
  `priv_roleid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `priv_groupid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `is_approval` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1启用审核，0禁用审核',
  `hooks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `table` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ismod` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否是系统模型',
  `editor` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '绑定内容编辑器',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文档模型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_order
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_order`;
CREATE TABLE `cmswing_order`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `pay_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `payment` bigint(20) NOT NULL DEFAULT 0,
  `express` bigint(20) NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT 1,
  `pay_status` tinyint(1) NULL DEFAULT 0,
  `delivery_status` tinyint(1) NULL DEFAULT 0,
  `accept_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mobile` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `province` bigint(20) NULL DEFAULT NULL,
  `city` bigint(20) NULL DEFAULT NULL,
  `county` bigint(20) NULL DEFAULT NULL,
  `addr` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `zip` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `payable_amount` float(10, 2) NULL DEFAULT NULL,
  `real_amount` float(10, 2) NULL DEFAULT 0.00,
  `payable_freight` float(10, 2) NULL DEFAULT 0.00,
  `real_freight` float(10, 2) NULL DEFAULT 0.00,
  `pay_time` bigint(13) NULL DEFAULT NULL,
  `send_time` bigint(13) NULL DEFAULT NULL,
  `create_time` bigint(13) NULL DEFAULT NULL,
  `completion_time` bigint(13) NULL DEFAULT NULL,
  `user_remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `admin_remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `handling_fee` float(10, 2) NULL DEFAULT 0.00,
  `is_invoice` tinyint(1) NULL DEFAULT 0,
  `invoice_title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `taxes` float(10, 2) NULL DEFAULT 0.00,
  `prom_id` bigint(20) NULL DEFAULT 0,
  `prom` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `discount_amount` float(10, 2) NULL DEFAULT 0.00,
  `adjust_amount` float(10, 2) NULL DEFAULT 0.00,
  `adjust_note` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `order_amount` float(10, 2) NULL DEFAULT 0.00,
  `is_print` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `accept_time` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `point` int(5) UNSIGNED NULL DEFAULT 0,
  `voucher_id` bigint(20) NULL DEFAULT 0,
  `voucher` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `type` int(4) UNSIGNED NULL DEFAULT 0 COMMENT '0-商品订单，1充值订单。',
  `trading_info` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_del` tinyint(1) NULL DEFAULT 0,
  `pingxx_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_order_goods`;
CREATE TABLE `cmswing_order_goods`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NULL DEFAULT NULL,
  `goods_id` bigint(20) NULL DEFAULT NULL,
  `product_id` bigint(20) NULL DEFAULT NULL,
  `goods_price` float(10, 2) NULL DEFAULT 0.00,
  `real_price` float(10, 2) NULL DEFAULT 0.00,
  `goods_nums` int(11) NULL DEFAULT 1,
  `goods_weight` float NULL DEFAULT 0,
  `shipments` int(11) NULL DEFAULT 0,
  `prom_goods` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `spec` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_order_log
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_order_log`;
CREATE TABLE `cmswing_order_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NULL DEFAULT NULL,
  `user` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `action` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  `result` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_pay_plugin
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_pay_plugin`;
CREATE TABLE `cmswing_pay_plugin`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `class_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_payment
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_payment`;
CREATE TABLE `cmswing_payment`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `plugin_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pay_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `config` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `client_type` int(1) NULL DEFAULT 0,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `note` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `pay_fee` float(10, 2) NULL DEFAULT 0.00,
  `fee_type` tinyint(1) NULL DEFAULT 0,
  `sort` int(11) NULL DEFAULT NULL,
  `status` int(1) NULL DEFAULT 0 COMMENT '0禁用，1启用，-1删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_pingxx
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_pingxx`;
CREATE TABLE `cmswing_pingxx`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `channel` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` int(2) NULL DEFAULT NULL,
  `info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `sort` int(10) NULL DEFAULT NULL,
  `status` tinyint(4) NULL DEFAULT 0 COMMENT '0关闭1开启',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_slovenian_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_question
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_question`;
CREATE TABLE `cmswing_question`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '问题内容',
  `category_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '分类 ID',
  `detail` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '问题说明',
  `create_time` bigint(13) NOT NULL COMMENT '添加时间',
  `update_time` bigint(13) NOT NULL COMMENT '更新时间',
  `uid` int(10) UNSIGNED NOT NULL COMMENT '发布用户UID',
  `answer_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '回答计数',
  `answer_users` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '回答者',
  `view` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '浏览次数',
  `focus_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '关注数',
  `comment_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论数',
  `action_history_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '动作的记录表的关连id',
  `agree_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '回复赞同数总和',
  `against_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '回复反对数总和',
  `best_answer` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最佳回复 ID',
  `has_attach` tinyint(2) NOT NULL DEFAULT 0 COMMENT '是否存在附件',
  `unverified_modify` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '未经证实的修改',
  `unverified_modify_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '未经证实的修改数',
  `ip` bigint(13) NOT NULL COMMENT '发布者ip',
  `last_answer` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最后回答 ID',
  `popular_value` double NOT NULL DEFAULT 0,
  `popular_value_update` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新热度',
  `lock` tinyint(2) NOT NULL DEFAULT 0 COMMENT '是否锁定',
  `anonymous` tinyint(2) NOT NULL DEFAULT 0 COMMENT '是否匿名',
  `thanks_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '答谢数',
  `question_content_fulltext` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '问题内容全文',
  `is_recommend` tinyint(2) NOT NULL DEFAULT 0 COMMENT '谁否推荐',
  `weibo_msg_id` bigint(20) NULL DEFAULT NULL,
  `received_email_id` int(10) NULL DEFAULT NULL,
  `chapter_id` int(10) UNSIGNED NULL DEFAULT NULL,
  `sort` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `group_id` smallint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属分组',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_question_answer
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_question_answer`;
CREATE TABLE `cmswing_question_answer`  (
  `answer_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '回答id',
  `question_id` int(11) NOT NULL COMMENT '问题id',
  `answer_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '回答内容',
  `add_time` bigint(13) NOT NULL DEFAULT 0 COMMENT '添加时间',
  `against_count` int(11) NOT NULL DEFAULT 0 COMMENT '反对人数',
  `agree_count` int(11) NOT NULL DEFAULT 0 COMMENT '支持人数',
  `uid` int(11) NULL DEFAULT 0 COMMENT '发布问题用户ID',
  `comment_count` int(11) NULL DEFAULT 0 COMMENT '评论总数',
  `uninterested_count` int(11) NULL DEFAULT 0 COMMENT '不感兴趣',
  `thanks_count` int(11) NULL DEFAULT 0 COMMENT '感谢数量',
  `category_id` int(11) NULL DEFAULT 0 COMMENT '分类id',
  `has_attach` tinyint(1) NULL DEFAULT 0 COMMENT '是否存在附件',
  `ip` bigint(11) NULL DEFAULT NULL,
  `force_fold` tinyint(1) NULL DEFAULT 0 COMMENT '强制折叠',
  `anonymous` tinyint(1) NULL DEFAULT 0,
  `publish_source` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`answer_id`) USING BTREE,
  INDEX `question_id`(`question_id`) USING BTREE,
  INDEX `agree_count`(`agree_count`) USING BTREE,
  INDEX `against_count`(`against_count`) USING BTREE,
  INDEX `add_time`(`add_time`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `uninterested_count`(`uninterested_count`) USING BTREE,
  INDEX `force_fold`(`force_fold`) USING BTREE,
  INDEX `anonymous`(`anonymous`) USING BTREE,
  INDEX `publich_source`(`publish_source`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '回答' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_question_answer_comments
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_question_answer_comments`;
CREATE TABLE `cmswing_question_answer_comments`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `answer_id` int(11) NULL DEFAULT 0,
  `uid` int(11) NULL DEFAULT 0,
  `message` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `time` bigint(13) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `answer_id`(`answer_id`) USING BTREE,
  INDEX `time`(`time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 71 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_question_answer_thanks
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_question_answer_thanks`;
CREATE TABLE `cmswing_question_answer_thanks`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT 0,
  `answer_id` int(11) NULL DEFAULT 0,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `time` int(10) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `answer_id`(`answer_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_question_answer_uninterested
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_question_answer_uninterested`;
CREATE TABLE `cmswing_question_answer_uninterested`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT 0,
  `answer_id` int(11) NULL DEFAULT 0,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `time` int(10) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `answer_id`(`answer_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_question_answer_vote
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_question_answer_vote`;
CREATE TABLE `cmswing_question_answer_vote`  (
  `voter_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自动ID',
  `answer_id` int(11) NULL DEFAULT NULL COMMENT '回复id',
  `answer_uid` int(11) NULL DEFAULT NULL COMMENT '回复作者id',
  `vote_uid` int(11) NULL DEFAULT NULL COMMENT '用户ID',
  `add_time` int(10) NULL DEFAULT NULL COMMENT '添加时间',
  `vote_value` tinyint(4) NOT NULL COMMENT '-1反对 1 支持',
  `reputation_factor` int(10) NULL DEFAULT 0,
  PRIMARY KEY (`voter_id`) USING BTREE,
  INDEX `answer_id`(`answer_id`) USING BTREE,
  INDEX `vote_value`(`vote_value`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_question_focus
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_question_focus`;
CREATE TABLE `cmswing_question_focus`  (
  `focus_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `question_id` int(11) NULL DEFAULT NULL COMMENT '话题ID',
  `uid` int(11) NULL DEFAULT NULL COMMENT '用户UID',
  `add_time` bigint(13) NULL DEFAULT NULL,
  PRIMARY KEY (`focus_id`) USING BTREE,
  INDEX `question_id`(`question_id`) USING BTREE,
  INDEX `question_uid`(`question_id`, `uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '问题关注表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_question_user
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_question_user`;
CREATE TABLE `cmswing_question_user`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `friend_count` int(10) NOT NULL DEFAULT 0 COMMENT '观众数',
  `invite_count` int(10) NOT NULL DEFAULT 0 COMMENT '邀请我回答数量',
  `question_count` int(10) NOT NULL DEFAULT 0 COMMENT '问题数量',
  `answer_count` int(10) NOT NULL DEFAULT 0 COMMENT '回答数量',
  `topic_focus_count` int(10) NOT NULL DEFAULT 0 COMMENT '关注话题数量',
  `invitation_available` int(10) NOT NULL DEFAULT 0 COMMENT '邀请数量',
  `agree_count` int(10) NULL DEFAULT 0 COMMENT '赞同数量',
  `thanks_count` int(10) NULL DEFAULT 0 COMMENT '感谢数量',
  `uid` int(10) NOT NULL DEFAULT 0 COMMENT '用户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cmswing_resume
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_resume`;
CREATE TABLE `cmswing_resume`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标题',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_search
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_search`;
CREATE TABLE `cmswing_search`  (
  `search_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '搜索索引id',
  `m_id` smallint(5) NOT NULL COMMENT '模型id',
  `d_id` int(10) NOT NULL COMMENT '数据id',
  `add_time` bigint(13) NOT NULL COMMENT '创建时间',
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '关键词',
  PRIMARY KEY (`search_id`) USING BTREE,
  INDEX `m_id`(`m_id`, `d_id`) USING BTREE,
  FULLTEXT INDEX `data`(`data`)
) ENGINE = MyISAM AUTO_INCREMENT = 3410 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_search_model
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_search_model`;
CREATE TABLE `cmswing_search_model`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `mod` smallint(5) NOT NULL DEFAULT 0,
  `extend` tinyint(3) NOT NULL DEFAULT 0 COMMENT '0独立模型，1系统模型',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `pk` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `addtime` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `data` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `info` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `sort` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序（同级有效）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_seat_cat
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_seat_cat`;
CREATE TABLE `cmswing_seat_cat`  (
  `id` int(10) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '座位类型',
  `price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '基础费用',
  `max_time` int(5) NOT NULL DEFAULT 0 COMMENT '使用时长0无限制',
  `time_out_price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '超时单价 以1小时为单位',
  `other_price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '其他单位费用，以小时计算，例如：每天12点过后的服务费',
  `create_time` bigint(13) NOT NULL COMMENT '创建时间',
  `other_price_start_time` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '其他费用超时起始时间',
  `other_price_end_time` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '其他费用超时结束时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cmswing_seat_list
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_seat_list`;
CREATE TABLE `cmswing_seat_list`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `paid` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '已付金额',
  `unpaid` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '未付金额',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '状态：0：未上座；1：已上座',
  `from` tinyint(1) NULL DEFAULT NULL COMMENT '客源：1：散客；2：老顾客；3：会员',
  `start_time` bigint(13) NULL DEFAULT NULL COMMENT '开始计费时间',
  `end_time` bigint(13) NULL DEFAULT NULL COMMENT '结束计费时间',
  `cat_id` int(10) NOT NULL COMMENT '座位分类',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cmswing_session
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_session`;
CREATE TABLE `cmswing_session`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cookie` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `data` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `expire` bigint(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `cookie`(`cookie`) USING BTREE,
  INDEX `expire`(`expire`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_setup
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_setup`;
CREATE TABLE `cmswing_setup`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '配置类型',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '配置分组',
  `extra` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配置说明',
  `create_time` bigint(13) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` bigint(13) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '状态',
  `value` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '配置值',
  `sort` smallint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`name`) USING BTREE,
  INDEX `type`(`type`) USING BTREE,
  INDEX `group`(`group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 123 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_tags
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_tags`;
CREATE TABLE `cmswing_tags`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `num` bigint(20) NULL DEFAULT 0,
  `type` int(2) NOT NULL DEFAULT 0 COMMENT '0文档，1suk,',
  `sort` int(11) NULL DEFAULT 0,
  `is_hot` int(1) NULL DEFAULT 0,
  `pid` int(11) NOT NULL DEFAULT 0,
  `model_id` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_temp
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_temp`;
CREATE TABLE `cmswing_temp`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `module` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `controller` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `action` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `html` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 1,
  `gid` smallint(5) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_temp_bak
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_temp_bak`;
CREATE TABLE `cmswing_temp_bak`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `module` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `controller` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `action` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `html` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 1,
  `gid` smallint(5) NOT NULL DEFAULT 1,
  `pid` smallint(5) NOT NULL DEFAULT 0,
  `baktime` bigint(13) NOT NULL,
  `lastuser` int(10) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_temp_group
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_temp_group`;
CREATE TABLE `cmswing_temp_group`  (
  `gid` smallint(5) NOT NULL AUTO_INCREMENT,
  `gname` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `isdefault` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`gid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_type
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_type`;
CREATE TABLE `cmswing_type`  (
  `typeid` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fid` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `displayorder` smallint(6) NOT NULL DEFAULT 0,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `special` smallint(6) NOT NULL DEFAULT 0,
  `modelid` smallint(6) UNSIGNED NOT NULL DEFAULT 0,
  `expiration` tinyint(1) NOT NULL DEFAULT 0,
  `template` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL,
  `stemplate` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ptemplate` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `btemplate` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`typeid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_type_optionvalue1
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_type_optionvalue1`;
CREATE TABLE `cmswing_type_optionvalue1`  (
  `tid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `fid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `expiration` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `aaa` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `bbb` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `ccc` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `shuzi` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `zichuan` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `wenben` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `danxuan` smallint(6) UNSIGNED NOT NULL DEFAULT 0,
  `duoxuan` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `xuanze` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `cpu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  INDEX `fid`(`fid`) USING BTREE,
  INDEX `dateline`(`dateline`) USING BTREE,
  INDEX `bbb`(`bbb`) USING BTREE,
  INDEX `danxuan`(`danxuan`) USING BTREE,
  INDEX `xuanze`(`xuanze`) USING BTREE,
  INDEX `cpu`(`cpu`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cmswing_type_optionvalue10
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_type_optionvalue10`;
CREATE TABLE `cmswing_type_optionvalue10`  (
  `tid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `fid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `expiration` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `txilie` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `bjiage` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `dnleixing` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `cpu` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `neicun` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `xianka` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `tpmingchichun` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `caozuoxitong` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `tshiyingchangjiang` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  INDEX `fid`(`fid`) USING BTREE,
  INDEX `dateline`(`dateline`) USING BTREE,
  INDEX `txilie`(`txilie`) USING BTREE,
  INDEX `dnleixing`(`dnleixing`) USING BTREE,
  INDEX `cpu`(`cpu`) USING BTREE,
  INDEX `neicun`(`neicun`) USING BTREE,
  INDEX `xianka`(`xianka`) USING BTREE,
  INDEX `tpmingchichun`(`tpmingchichun`) USING BTREE,
  INDEX `caozuoxitong`(`caozuoxitong`) USING BTREE,
  INDEX `tshiyingchangjiang`(`tshiyingchangjiang`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_type_optionvalue11
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_type_optionvalue11`;
CREATE TABLE `cmswing_type_optionvalue11`  (
  `tid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `fid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `expiration` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `pxilie` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `pjiage` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `ppingmuchichun` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `pchucun` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `pchaozuoxitong` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `gongnengpeizhi` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  INDEX `fid`(`fid`) USING BTREE,
  INDEX `dateline`(`dateline`) USING BTREE,
  INDEX `pxilie`(`pxilie`) USING BTREE,
  INDEX `ppingmuchichun`(`ppingmuchichun`) USING BTREE,
  INDEX `pchucun`(`pchucun`) USING BTREE,
  INDEX `pchaozuoxitong`(`pchaozuoxitong`) USING BTREE,
  INDEX `gongnengpeizhi`(`gongnengpeizhi`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cmswing_type_optionvalue12
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_type_optionvalue12`;
CREATE TABLE `cmswing_type_optionvalue12`  (
  `tid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `fid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `expiration` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `dianshixilie` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  INDEX `fid`(`fid`) USING BTREE,
  INDEX `dateline`(`dateline`) USING BTREE,
  INDEX `dianshixilie`(`dianshixilie`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_type_optionvalue13
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_type_optionvalue13`;
CREATE TABLE `cmswing_type_optionvalue13`  (
  `tid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `fid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `expiration` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `dayinjileixing` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  INDEX `fid`(`fid`) USING BTREE,
  INDEX `dateline`(`dateline`) USING BTREE,
  INDEX `dayinjileixing`(`dayinjileixing`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_type_optionvalue14
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_type_optionvalue14`;
CREATE TABLE `cmswing_type_optionvalue14`  (
  `tid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `fid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `expiration` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `diannaopeijian` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  INDEX `fid`(`fid`) USING BTREE,
  INDEX `dateline`(`dateline`) USING BTREE,
  INDEX `diannaopeijian`(`diannaopeijian`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_type_optionvalue15
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_type_optionvalue15`;
CREATE TABLE `cmswing_type_optionvalue15`  (
  `tid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `fid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `expiration` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `shojipeijian` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `fuwujiage` int(10) UNSIGNED NOT NULL DEFAULT 0,
  INDEX `fid`(`fid`) USING BTREE,
  INDEX `dateline`(`dateline`) USING BTREE,
  INDEX `shojipeijian`(`shojipeijian`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_type_optionvalue7
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_type_optionvalue7`;
CREATE TABLE `cmswing_type_optionvalue7`  (
  `tid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `fid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `expiration` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `shuzi` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `kongjian` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `jubu` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `fengge` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `wenben` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `xuanze` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `bbb` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `zichuan` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `danxuan` smallint(6) UNSIGNED NOT NULL DEFAULT 0,
  `duoxuan` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  INDEX `fid`(`fid`) USING BTREE,
  INDEX `dateline`(`dateline`) USING BTREE,
  INDEX `kongjian`(`kongjian`) USING BTREE,
  INDEX `jubu`(`jubu`) USING BTREE,
  INDEX `fengge`(`fengge`) USING BTREE,
  INDEX `xuanze`(`xuanze`) USING BTREE,
  INDEX `bbb`(`bbb`) USING BTREE,
  INDEX `danxuan`(`danxuan`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_type_optionvalue8
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_type_optionvalue8`;
CREATE TABLE `cmswing_type_optionvalue8`  (
  `tid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `fid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `expiration` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `aaa` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `bbb` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `kongjian` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  INDEX `fid`(`fid`) USING BTREE,
  INDEX `dateline`(`dateline`) USING BTREE,
  INDEX `bbb`(`bbb`) USING BTREE,
  INDEX `kongjian`(`kongjian`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_type_optionvalue9
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_type_optionvalue9`;
CREATE TABLE `cmswing_type_optionvalue9`  (
  `tid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `fid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `dateline` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `expiration` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `bxilie` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `bjiage` int(10) UNSIGNED NULL DEFAULT 0,
  `cpu` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `neicun` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `yingpan` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `caozuoxitong` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `bjbpmcc` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `wulifenbianl` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `bchangjing` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  INDEX `fid`(`fid`) USING BTREE,
  INDEX `dateline`(`dateline`) USING BTREE,
  INDEX `bxilie`(`bxilie`) USING BTREE,
  INDEX `cpu`(`cpu`) USING BTREE,
  INDEX `neicun`(`neicun`) USING BTREE,
  INDEX `yingpan`(`yingpan`) USING BTREE,
  INDEX `caozuoxitong`(`caozuoxitong`) USING BTREE,
  INDEX `bjbpmcc`(`bjbpmcc`) USING BTREE,
  INDEX `wulifenbianl`(`wulifenbianl`) USING BTREE,
  INDEX `bchangjing`(`bchangjing`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_typeoption
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_typeoption`;
CREATE TABLE `cmswing_typeoption`  (
  `optionid` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  `classid` smallint(6) UNSIGNED NOT NULL DEFAULT 0,
  `displayorder` tinyint(3) NOT NULL DEFAULT 0,
  `expiration` tinyint(1) NOT NULL DEFAULT 0,
  `protect` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `identifier` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `unit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `rules` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `permprompt` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`optionid`) USING BTREE,
  INDEX `classid`(`classid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_typeoptionvar
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_typeoptionvar`;
CREATE TABLE `cmswing_typeoptionvar`  (
  `sortid` smallint(6) UNSIGNED NOT NULL DEFAULT 0,
  `tid` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `fid` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `optionid` smallint(6) UNSIGNED NOT NULL DEFAULT 0,
  `expiration` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `value` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  INDEX `sortid`(`sortid`) USING BTREE,
  INDEX `tid`(`tid`) USING BTREE,
  INDEX `fid`(`fid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_typevar
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_typevar`;
CREATE TABLE `cmswing_typevar`  (
  `sortid` smallint(6) NOT NULL DEFAULT 0,
  `optionid` smallint(6) NOT NULL DEFAULT 0,
  `available` tinyint(1) NOT NULL DEFAULT 0,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `unchangeable` tinyint(1) NOT NULL DEFAULT 0,
  `search` tinyint(1) NOT NULL DEFAULT 0,
  `displayorder` tinyint(3) NOT NULL DEFAULT 0,
  `subjectshow` tinyint(1) NOT NULL DEFAULT 0,
  UNIQUE INDEX `optionid`(`sortid`, `optionid`) USING BTREE,
  INDEX `sortid`(`sortid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cmswing_wx_custom_menu
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_wx_custom_menu`;
CREATE TABLE `cmswing_wx_custom_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `custom_menu` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL COMMENT '自定义菜单数据',
  `personality` int(2) NULL DEFAULT NULL COMMENT '个性菜单筛选条件--->\r\n1、用户分组（开发者的业务需求可以借助用户分组来完成）\r\n2、性别\r\n3、手机操作系统\r\n4、地区（用户在微信客户端设置的地区）\r\n5、语言（用户在微信客户端设置的语言）',
  `create_time` bigint(13) NULL DEFAULT NULL COMMENT '创建时间',
  `web_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_wx_keywords
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_wx_keywords`;
CREATE TABLE `cmswing_wx_keywords`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyword_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `match_type` int(1) NULL DEFAULT 1 COMMENT '1:全匹配，2:模糊',
  `rule_id` int(11) NULL DEFAULT NULL COMMENT '所属规则id',
  `create_time` bigint(13) NULL DEFAULT NULL COMMENT '创建时间',
  `web_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `keyword_name`(`keyword_name`) USING BTREE,
  UNIQUE INDEX `keyword_name_2`(`keyword_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_wx_keywords_rule
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_wx_keywords_rule`;
CREATE TABLE `cmswing_wx_keywords_rule`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rule_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `keywords_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '关键词id',
  `reply_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '自动回复id',
  `web_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` bigint(13) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_wx_masssend
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_wx_masssend`;
CREATE TABLE `cmswing_wx_masssend`  (
  `msg_id` bigint(15) NOT NULL COMMENT '已发送消息ID',
  `mate_id` int(11) NULL DEFAULT NULL COMMENT '素材表ID',
  `create_time` bigint(13) NULL DEFAULT NULL COMMENT '发送时间',
  `sent_count` int(11) NULL DEFAULT NULL COMMENT '发送成功人数',
  `error_count` int(11) NULL DEFAULT NULL COMMENT '发送失败人数',
  `material_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '素材详细内容',
  `material_wx_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '微信素材详细内容',
  `type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发送类型',
  `del_status` int(11) NULL DEFAULT 0 COMMENT '删除状态 0:未删除，1：删除',
  PRIMARY KEY (`msg_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_wx_material
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_wx_material`;
CREATE TABLE `cmswing_wx_material`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `media_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '微信素材media_id',
  `material_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '素材详细内容',
  `material_wx_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '微信同步的素材信息',
  `web_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '该素材所从属的微信公众号id,  0为测试或发生错误的数据',
  `add_time` bigint(13) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_wx_menu
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_wx_menu`;
CREATE TABLE `cmswing_wx_menu`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `m_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '微信菜单ID',
  `sort` tinyint(4) NULL DEFAULT 0 COMMENT '菜单排序字段',
  `pid` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '0: 一级菜单 1：二级菜单',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名',
  `keyword` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联关键词',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联URL',
  `web_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公众号Token',
  `type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'click' COMMENT 'click:点击推送事件 \r\nview：点击跳转URL\r\nscancode_push:扫码推事件\r\nscancode_waitmsg：扫码推事件且弹出“消息接收中”提示框\r\npic_sysphoto：弹出系统拍照发图\r\npic_photo_or_album：弹出拍照或者相册发图\r\npic_weixin：弹出微信相册发图器\r\nlocation_select：弹出地理位置选择器\r\nmedia_id：下发消息（除文本消息）\r\nview_limited：跳转图文消息URL\r\n',
  `status` tinyint(11) NULL DEFAULT NULL,
  `media_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '永久素材ID',
  `key` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 146 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_wx_replylist
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_wx_replylist`;
CREATE TABLE `cmswing_wx_replylist`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` bigint(13) NULL DEFAULT NULL,
  `type` enum('news','music','video','voice','image','text') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `media_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通过素材管理接口上传多媒体文件，得到的id',
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '消息标题',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '消息描述',
  `music_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '音乐链接',
  `hq_music_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '高质量音乐链接，WIFI环境优先使用该链接播放音乐',
  `thumb_media_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '缩略图的媒体id，通过素材管理接口上传多媒体文件，得到的id',
  `article_count` int(2) NULL DEFAULT 0 COMMENT '图文消息个数，限制为10条以内',
  `articles` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '多条图文消息信息，默认第一个item为大图,注意，如果图文数超过10，则将会无响应',
  `pic_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片链接，支持JPG、PNG格式，较好的效果为大图360*200，小图200*200',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '点击图文消息跳转链接',
  `web_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `reply_type` int(11) NULL DEFAULT 0 COMMENT '回复类型 1：关注自动回复 2：消息自动回复 3：关键词自动回复',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 108 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cmswing_wx_user
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_wx_user`;
CREATE TABLE `cmswing_wx_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '粉丝ID',
  `subscribe` int(11) NULL DEFAULT NULL COMMENT '用户是否订阅该公众号标识，值为0时，代表此用户没有关注该公众号，拉取不到其余信息。',
  `openid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户的标识，对当前公众号唯一',
  `nickname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '用户的昵称',
  `sex` int(11) NULL DEFAULT NULL COMMENT '用户的性别，值为1时是男性，值为2时是女性，值为0时是未知',
  `city` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户所在城市',
  `country` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户所在国家',
  `province` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户所在省份',
  `language` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户的语言，简体中文为zh_CN',
  `headimgurl` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '用户头像，最后一个数值代表正方形头像大小（有0、46、64、96、132数值可选，0代表640*640正方形头像），用户没有头像时该项为空。若用户更换头像，原有头像URL将失效。',
  `subscribe_time` bigint(13) NULL DEFAULT NULL COMMENT '用户关注时间，为时间戳。如果用户曾多次关注，则取最后关注时间',
  `unionid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '只有在用户将公众号绑定到微信开放平台帐号后，才会出现该字段。',
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '公众号运营者对粉丝的备注，公众号运营者可在微信公众平台用户管理界面对粉丝添加备注',
  `groupid` int(11) NULL DEFAULT NULL COMMENT '用户所在的分组ID',
  `uid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '微信粉丝表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cmswing_zoning
-- ----------------------------
DROP TABLE IF EXISTS `cmswing_zoning`;
CREATE TABLE `cmswing_zoning`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `provinces` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
