/*
 Navicat Premium Data Transfer

 Source Server         : loan
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : loan

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 24/06/2022 15:12:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_logs
-- ----------------------------
DROP TABLE IF EXISTS `admin_logs`;
CREATE TABLE `admin_logs`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `admin_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '操作员ID',
  `method` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '方式，GET,POST,DELETE,PUT...',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '路由地址',
  `params` json NULL COMMENT '参数 ,json格式，文件为空',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_logs
-- ----------------------------

-- ----------------------------
-- Table structure for admin_permissions
-- ----------------------------
DROP TABLE IF EXISTS `admin_permissions`;
CREATE TABLE `admin_permissions`  (
  `permission_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单(权限)名称',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `slug` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '唯一标识',
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `path` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '请求路径',
  `order` int(11) NOT NULL DEFAULT 0 COMMENT '排序，',
  `parent_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '父类id,权限和顶级菜单为0',
  `is_menu` tinyint(255) NULL DEFAULT 1 COMMENT '是否是菜单，1-是 2-否 默认1',
  `update_time` int(11) NULL DEFAULT 0,
  `create_time` int(11) NULL DEFAULT 0,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`permission_id`) USING BTREE,
  UNIQUE INDEX `admin_permissions_slug_unique`(`slug`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_permissions
-- ----------------------------
INSERT INTO `admin_permissions` VALUES (1, '系统设置', 'icon-dashboard', 'system', 'menu.system', '/system', 1, 0, 1, NULL, 0, NULL);
INSERT INTO `admin_permissions` VALUES (2, '用户管理', NULL, 'user', 'menu.system.user', 'user', 30, 1, 1, NULL, 0, NULL);
INSERT INTO `admin_permissions` VALUES (3, '角色管理', NULL, 'role', 'menu.system.role', '', 3, 1, 1, NULL, 0, NULL);
INSERT INTO `admin_permissions` VALUES (4, '权限管理', NULL, 'permission', 'menu.system.permission', '', 4, 1, 1, NULL, 0, NULL);
INSERT INTO `admin_permissions` VALUES (5, '菜单管理', NULL, 'menu', 'menu.system.menu', '', 5, 1, 1, NULL, 0, NULL);
INSERT INTO `admin_permissions` VALUES (6, 'Extension', NULL, 'extension', NULL, '', 6, 1, 0, NULL, 0, NULL);
INSERT INTO `admin_permissions` VALUES (7, '工作台', 'icon-dashboard', 'dashboard', 'menu.dashboard', '/dashboard', 7, 0, 1, 0, 0, NULL);
INSERT INTO `admin_permissions` VALUES (8, '添加用户', NULL, 'add-user', NULL, '/system/user/create', 9, 2, 0, 0, 0, NULL);
INSERT INTO `admin_permissions` VALUES (9, '删除用户', NULL, 'delete-user', NULL, '/system/user/delete', 0, 2, 0, 0, 0, NULL);
INSERT INTO `admin_permissions` VALUES (10, '编辑用户', NULL, 'edit-user', NULL, '/system/user/edit', 0, 2, 0, 0, 0, NULL);
INSERT INTO `admin_permissions` VALUES (11, '添加角色', NULL, 'add-role', NULL, '/system/role/create', 0, 3, 0, 0, 0, NULL);
INSERT INTO `admin_permissions` VALUES (12, '删除角色', NULL, 'delete-role', NULL, '/system/role/delete', 0, 3, 0, 0, 0, NULL);
INSERT INTO `admin_permissions` VALUES (13, '编辑角色', NULL, 'edit-role', NULL, '/system/role/edit', 0, 3, 0, 0, 0, NULL);
INSERT INTO `admin_permissions` VALUES (14, '添加权限', NULL, 'add-permission', NULL, '/system/permission/add', 0, 4, 0, 0, 0, NULL);
INSERT INTO `admin_permissions` VALUES (15, '编辑权限', NULL, 'edit-permission', NULL, '/system/permission/edit', 0, 4, 0, 0, 0, NULL);
INSERT INTO `admin_permissions` VALUES (16, '删除权限', NULL, 'delete-permission', NULL, '/system/permission/delete', 0, 4, 0, 0, 0, NULL);
INSERT INTO `admin_permissions` VALUES (17, '添加菜单', NULL, 'add-menu', NULL, '/system/menu/add', 0, 5, 0, 0, 0, NULL);
INSERT INTO `admin_permissions` VALUES (18, '编辑菜单', NULL, 'edit-menu', NULL, '/system/menu/edit', 0, 5, 0, 0, 0, NULL);
INSERT INTO `admin_permissions` VALUES (19, '删除菜单', NULL, 'delete-menu', NULL, '/system/menu/delete', 0, 5, 0, 0, 0, NULL);
INSERT INTO `admin_permissions` VALUES (20, '菜单列表', NULL, 'user-menus', NULL, '/admin/menus', 0, 0, 0, 0, 0, NULL);
INSERT INTO `admin_permissions` VALUES (21, '仪表盘', NULL, 'Workeplace', 'menu.dashboard.workplace', 'workplace', 0, 7, 1, 0, 0, NULL);

-- ----------------------------
-- Table structure for admin_role_permissions
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_permissions`;
CREATE TABLE `admin_role_permissions`  (
  `role_id` bigint(20) NOT NULL,
  `permission_id` bigint(20) NOT NULL,
  `create_time` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `update_time` bigint(20) UNSIGNED NULL DEFAULT NULL,
  UNIQUE INDEX `admin_role_permissions_role_id_permission_id_unique`(`role_id`, `permission_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_role_permissions
-- ----------------------------
INSERT INTO `admin_role_permissions` VALUES (1, 1, NULL, NULL);
INSERT INTO `admin_role_permissions` VALUES (1, 2, NULL, NULL);

-- ----------------------------
-- Table structure for admin_role_users
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_users`;
CREATE TABLE `admin_role_users`  (
  `role_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `create_time` bigint(20) UNSIGNED NULL DEFAULT 0,
  `update_time` bigint(20) UNSIGNED NULL DEFAULT 0,
  `delete_time` bigint(20) UNSIGNED NULL DEFAULT NULL,
  UNIQUE INDEX `admin_role_users_role_id_user_id_unique`(`role_id`, `user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_role_users
-- ----------------------------
INSERT INTO `admin_role_users` VALUES (1, 1, 1, 1, 1);

-- ----------------------------
-- Table structure for admin_roles
-- ----------------------------
DROP TABLE IF EXISTS `admin_roles`;
CREATE TABLE `admin_roles`  (
  `role_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_time` bigint(20) UNSIGNED NULL DEFAULT 0,
  `update_time` bigint(20) UNSIGNED NULL DEFAULT 0,
  `delete_time` bigint(20) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`role_id`) USING BTREE,
  UNIQUE INDEX `admin_roles_slug_unique`(`slug`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_roles
-- ----------------------------
INSERT INTO `admin_roles` VALUES (1, 'Administrator', 'administrator', 20220424174752, 20220424174752, NULL);
INSERT INTO `admin_roles` VALUES (2, 'Collection', 'collection', 162131231231, 123123123123123, NULL);

-- ----------------------------
-- Table structure for admin_settings
-- ----------------------------
DROP TABLE IF EXISTS `admin_settings`;
CREATE TABLE `admin_settings`  (
  `slug` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`slug`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_settings
-- ----------------------------

-- ----------------------------
-- Table structure for admin_users
-- ----------------------------
DROP TABLE IF EXISTS `admin_users`;
CREATE TABLE `admin_users`  (
  `admin_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `salt` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `create_time` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `update_time` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `delete_time` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`admin_id`) USING BTREE,
  UNIQUE INDEX `admin_users_username_unique`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_users
-- ----------------------------
INSERT INTO `admin_users` VALUES (1, 'admin', 'b605e86d02eef8bfd0646f6a704c17c9', '1234', 'Administrator', NULL, 'Aww4X9wRjvvOGi2g9QghN7X7ieF4QPwGiI5KdKSpQ0sf9iyUA5VrCAAV55sb', 20220424174752, 20220424174752, NULL);

-- ----------------------------
-- Table structure for black
-- ----------------------------
DROP TABLE IF EXISTS `black`;
CREATE TABLE `black`  (
  `black_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(255) UNSIGNED NULL DEFAULT 0 COMMENT '用户ID,',
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户姓名',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机号码',
  `IMEI` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '个人标识',
  `id_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '个人身份唯一标识',
  `credit_amount` bigint(255) UNSIGNED NULL DEFAULT 0 COMMENT '初始授信额度',
  `mac` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'mac地址',
  `android_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '安卓标识',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL,
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL,
  `delete_time` int(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`black_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of black
-- ----------------------------

-- ----------------------------
-- Table structure for collection
-- ----------------------------
DROP TABLE IF EXISTS `collection`;
CREATE TABLE `collection`  (
  `collection_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '订单ID',
  `user_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '用户ID',
  `current_collection_user_id` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '当前催收人员ID',
  `before_collection_user_id` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '上一次催收人员iD',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '状态， 0-新案子，20-催收中， 30-出催',
  `collection_amount` int(1) UNSIGNED NULL DEFAULT 0 COMMENT '催回金额,',
  `collection_status` tinyint(1) NULL DEFAULT NULL COMMENT '催收状态',
  `in_amount` int(255) UNSIGNED NULL DEFAULT 0 COMMENT '入催金额',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`collection_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collection
-- ----------------------------

-- ----------------------------
-- Table structure for collection_company
-- ----------------------------
DROP TABLE IF EXISTS `collection_company`;
CREATE TABLE `collection_company`  (
  `collection_company_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '催收公司名称',
  `company_admin_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '催收管理人员ID',
  `create_time` int(11) UNSIGNED NULL DEFAULT 0,
  `update_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`collection_company_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collection_company
-- ----------------------------

-- ----------------------------
-- Table structure for collection_flow_log
-- ----------------------------
DROP TABLE IF EXISTS `collection_flow_log`;
CREATE TABLE `collection_flow_log`  (
  `collection_flow_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '订单ID',
  `type` tinyint(1) NULL DEFAULT NULL COMMENT '类型，1-入催， 2-流转， 3-出催',
  `flow_type` tinyint(1) NULL DEFAULT NULL COMMENT '1-自动，2-管理员操作',
  `before_collection_user_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '上一次催收人员',
  `after_collection_user_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '之后分配人员',
  `before_collection_stage_id` int(11) NULL DEFAULT 0,
  `before_collection_group_id` int(11) NULL DEFAULT 0,
  `before_collection_company_id` int(11) NULL DEFAULT 0,
  `after_collection_stage_id` int(11) NULL DEFAULT 0,
  `after_collection_group_id` int(11) NULL DEFAULT 0,
  `after_collection_company_id` int(11) NULL DEFAULT 0,
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL,
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL,
  `delete_time` int(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`collection_flow_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collection_flow_log
-- ----------------------------

-- ----------------------------
-- Table structure for collection_group
-- ----------------------------
DROP TABLE IF EXISTS `collection_group`;
CREATE TABLE `collection_group`  (
  `collection_group_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '催收小组名称',
  `group_admin_id` int(255) UNSIGNED NULL DEFAULT 0 COMMENT '催收小组管理员ID',
  `stage_id` int(11) NULL DEFAULT NULL COMMENT '小组所属阶段ID',
  `collection_company_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '催收公司ID',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`collection_group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collection_group
-- ----------------------------

-- ----------------------------
-- Table structure for collection_stage
-- ----------------------------
DROP TABLE IF EXISTS `collection_stage`;
CREATE TABLE `collection_stage`  (
  `stage_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '催收阶段描述',
  `sign` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '阶段标识',
  `start_day` int(255) NULL DEFAULT 0 COMMENT '订单逾期天数起始 默认为0',
  `end_day` int(255) NULL DEFAULT 0 COMMENT '订单逾期天数结束 默认为0',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`stage_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collection_stage
-- ----------------------------

-- ----------------------------
-- Table structure for collection_user
-- ----------------------------
DROP TABLE IF EXISTS `collection_user`;
CREATE TABLE `collection_user`  (
  `collection_user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '催收人员姓名',
  `collection_stage_id` int(11) NULL DEFAULT NULL COMMENT '催收员阶段',
  `collection_group_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '催收员组',
  `collection_company_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '催收员公司',
  `total_cases` int(255) UNSIGNED NULL DEFAULT 0 COMMENT '案件总数',
  `collected_cases` int(255) NULL DEFAULT NULL COMMENT '催回案件',
  `current_cases` int(255) UNSIGNED NULL DEFAULT 0 COMMENT '当前案子总数',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL,
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL,
  `delete_time` int(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`collection_user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collection_user
-- ----------------------------

-- ----------------------------
-- Table structure for contract_agreement
-- ----------------------------
DROP TABLE IF EXISTS `contract_agreement`;
CREATE TABLE `contract_agreement`  (
  `contract_agreement_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `type` tinyint(1) NULL DEFAULT NULL COMMENT '类型。1:隐私协议 2:全授权协议 3:借款合同 4:隐私政策',
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`contract_agreement_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '合同协议' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of contract_agreement
-- ----------------------------
INSERT INTO `contract_agreement` VALUES (5, 'APP首次启动时隐私协议', '<p class=\"MsoNormal\"><strong><span style=\"color:#000000\">Privacy Policy</span></strong></p><p class=\"MsoNormal\"><span style=\"color:#000000\">Updated at 2020-11-10</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">testdn. (&quot;we,&quot; &quot;our,&quot; or &quot;us&quot;) is committed to protecting your privacy. This Privacy Policy explains how your personal information is collected, used, and disclosed by testdn.</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">This Privacy Policy applies to our application named testdn, and its associated subdomains (collectively, our &quot;Service&quot;). By accessing or using our Service, you signify that you have read, understood, and agree to our collection, storage, use, and disclosure of your personal information as described in this Privacy Policy and our Terms of Service.</span></p><p class=\"MsoNormal\"> </p><p class=\"MsoNormal\"><strong><span style=\"color:#000000\">Definitions and key terms</span></strong></p><p class=\"MsoNormal\"><span style=\"color:#000000\">To help explain things as clearly as possible in this Privacy Policy, every time any of these terms are referenced, are strictly defined as:</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●Company: when this policy mentions &quot;Company,&quot; &quot;we,&quot;“us,&quot; or“our,&quot; it refers to TESTDM NIGERIA LIMITED, Plot 169, Karimu Kotun Street, Victoria Island, Lagos, Nigeria that is responsible for your information under this Privacy Policy.</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●Country: where testdn or the owners/founders of testdn are based, in this case is Nigeria.</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●Customer: refers to the company, organization or person that signs up to use the testdn Service to manage the relationships with your consumers or service users.</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●Device: any internet connected device such as a phone, tablet, computer or any other device that can be used to visit testdn and use the services.</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●IP address: Every device connected to the Internet is assigned a number known as an Internet protocol (IP) address. These numbers are usually assigned in geographic blocks. An IP address can often be used to identify the location from which a device is connecting to the Internet.</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●Personal Data: any information that directly, indirectly, or in connection with other information一including a personal identification number - allows for the identification or identifiability of a natural person.</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●Service: refers to the service provided by testdn as described in the relative terms (if available) and on this platform.</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●Third-party service: refers to advertisers, contest sponsors, promotional and marketing partners, and others who provide our content or whose products or services we think may interest you.</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●Website: testdn&#x27;s site, which can be accessed via this URL: https://testdn.ng</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●You: a person or entity that is registered with testdn to use the Services.</span></p><p class=\"MsoNormal\"> </p><p class=\"MsoNormal\"><strong><span style=\"color:#000000\">What Information Do We Collect?</span></strong></p><p class=\"MsoNormal\"><span style=\"color:#000000\">We collect information from you when you visit our service, register, place an order, subscribe to our newsletter, respond to a survey or fill out a form.</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●Name/Username</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●Phone Numbers</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●Email Addresses</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●Job Titles .</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●Debit/credit card numbers</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●Age</span></p><p class=\"MsoNormal\"> </p><p class=\"MsoNormal\"><span style=\"color:#000000\">We also collect information from mobile devices for a better user experience, although these features are completely optional:</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●Location (GPS): Location data Location data helps to create an accurate representation of your interests, and this can be used to bring more targeted and relevant ads to potential customers.</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●Phone book (contact list):  <span style=\"font-size:14ptpx\">Your permission</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">allows</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">us to collect</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">and store your contact details in order to verify your identity and create a credit score . We encrypt the data you authorized to share with us in order to protect your privacy.</span></span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●Financial SMS (SMS): We only collect and monitor your financial transactional SMS about transactions, the names of sender and recipient, a description of the transaction and the amount of the transaction, in order to perform the credit risk assessment. This credit risk assessment enables us to perform a quicker loan disbursal. No personal SMS data is collected, read or stored.</span></p><p class=\"MsoNormal\"> </p><p class=\"MsoNormal\"><span style=\"color:#000000\">●Storage：We require the storage information permission to enable the App to enable you to upload photos and/or documents to complete the application form during your loan application journey.</span></p><p class=\"MsoNormal\"> </p><p class=\"MsoNormal\"><strong><span style=\"color:#000000\">How Do We Use The Information We Collect?</span></strong></p><p class=\"MsoNormal\"><span style=\"color:#000000\">Any of the information we collect from you may be used in one of the following ways:</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●To personalize your experience (your information helps us to better respond to your individual needs)</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●To improve our service (we continually strive to improve our service offerings based on the information and feedback we receive from you)</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●To improve customer service (your information helps us to more effectively respond to your customer service requests and support needs)</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●To process transactions</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●To administer a contest, promotion, survey or other site feature</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">●To send periodic emails</span></p><p class=\"MsoNormal\"> </p><p class=\"MsoNormal\"> </p><p class=\"MsoNormal\"><strong><span style=\"color:#000000\">Where and when is information collected from customers?</span></strong></p><p class=\"MsoNormal\"><span style=\"color:#000000\">We will collect personal information that you submit to us. </span></p><p class=\"MsoNormal\"> </p><p class=\"MsoNormal\"><strong><span style=\"color:#000000\">How Long Do We Keep Your Information?</span></strong></p><p class=\"MsoNormal\"><span style=\"color:#000000\">We keep your information only so long as we need it to provide service to you and fulfill the purposes described in this policy. This is also the case for anyone that we share your information with and who carries out services on our behalf. When we no longer need to use your information and there is no need for us to keep it to comply with our legal or regulatory obligations, we&#x27;ll either remove it from our systems or depersonalize it so that we can&#x27;t identify you.</span></p><p class=\"MsoNormal\"> </p><p class=\"MsoNormal\"><strong><span style=\"color:#000000\">How Do We Protect Your Information?</span></strong></p><p class=\"MsoNormal\"><span style=\"color:#000000\">We implement a variety of security measures to maintain the safety of your personal information when you place an order or enter, submit, or access your personal information. We offer the use of a secure server. All supplied sensitive/credit information is</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">transmitted via Secure Socket Layer (SSL) technology and then encrypted into our Payment gateway providers database only to be accessible by those authorized with special access rights to such systems, and are required to keep the information confidential. After a transaction, your private information (credit cards, social security numbers, financials, etc.) is never kept on file. We cannot,</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">however, ensure or warrant the absolute security of any information you transmit to us or guarantee that your information on theService may not be accessed, disclosed, altered, or destroyed by a breach of any of our physical, technical, or managerial</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">safeguards.</span></p><p class=\"MsoNormal\"> </p><p class=\"MsoNormal\"><strong><span style=\"color:#000000\">Governing Law</span></strong></p><p class=\"MsoNormal\"><span style=\"color:#000000\">The laws of Nigeria, excluding its conflicts of law rules, shall govern this Agreement and your use of our service. Your use of our service may also be subject to other local, state, national, or international laws.</span></p><p class=\"MsoNormal\"><strong><span style=\"color:#000000\">Your Consent</span></strong></p><p class=\"MsoNormal\"><span style=\"color:#000000\">By using our service, registering an account, or making a purchase, you consent to this Privacy Policy.</span></p><p class=\"MsoNormal\"> </p><p class=\"MsoNormal\"><strong><span style=\"color:#000000\">Kids&#x27; Privacy</span></strong></p><p class=\"MsoNormal\"><span style=\"color:#000000\">We do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from our servers.</span></p><p></p><p><span style=\"color:#000000\"><strong>Advertisements on the website</strong></span> </p><p><span style=\"color:#000000\">We use third-party advertising companies to serve ads when you visit our Website. These companies may use information (not including your name, address, email address, or telephone number) about your visits to our Website and other websites in order to provide advertisements about goods and services of interest to you. </span></p><p class=\"MsoNormal\"> </p><p class=\"MsoNormal\"><strong><span style=\"color:#000000\">Changes To Our Privacy Policy</span></strong></p><p class=\"MsoNormal\"><span style=\"color:#000000\">If we decide to change our privacy policy, we will post those changes on this page, and/or update the Privacy Policy modification date.</span></p><p class=\"MsoNormal\"> </p><p class=\"MsoNormal\"><strong><span style=\"color:#000000\">Tracking Technologies</span></strong></p><p class=\"MsoNormal\"><span style=\"color:#000000\">● Local Storage</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">Local Storage sometimes known as DOM storage, provides web apps with methods and protocols for storing client-side data. Web storage supports persistent data storage, similar to cookies but with a greatly enhanced capacity and no information stored in the HTTP request header.</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">● Sessions</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">testdn uses &quot;Sessions&quot; to identify the areas of our website that you have visited. A Session is a small piece of data stored on your computer or mobile device by your web browser.</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">Contact Us</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">Don&#x27;t hesitate to contact us if you have any questions.</span></p><p><span style=\"color:#000000\">Via Email: </span><span style=\"color:#222222\"><span style=\"font-size:12px\"><span style=\"background-color:#ffffff\">service@testdn.ng</span></span></span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">Via Phone Number:</span> <span style=\"color:#000000\">+234 805 061 5631</span></p><p class=\"MsoNormal\"><span style=\"color:#000000\">Via this Address: Plot 169, Karimu Kotun Street, Victoria Island, Lagos, Nigeria</span></p>', 1, 1558157138, 1619140898, NULL);
INSERT INTO `contract_agreement` VALUES (6, 'APP首次启动时全授权说明', '<p><strong><span style=\"font-size:30px\">Permissions</span></strong></p><p class=\"MsoNormal\"> </p><p class=\"MsoNormal\"><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">Hi There,</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">for the purpose of your credit risk assessment and to facilitate faster loan disbursal, we require the following data permissions from YOU: </span></span></p><p class=\"MsoNormal\"><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">User Personal Information</span></span></p><p class=\"MsoNormal\"><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">Our app collects user account data which includes email address and user public profile information like name, gender, photo, BVN.</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">This information is required as a part of registration process to access our service and it&#x27;s also used to auto-populate relevant</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">fields in the course of the interface of our app.</span></span></p><p class=\"MsoNormal\"><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">Our app also collects mobile number for</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">verification to check the active SIM status on the device, uniquely identify you and prevent frauds and unauthorized access.</span></span></p><p class=\"MsoNormal\"> </p><p class=\"MsoNormal\"><strong><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">1.</span></span></strong> <strong><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">Financial SMS</span></span></strong></p><p class=\"MsoNormal\"><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">We collect and monitor only your financial transactional</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">SMS about bank related transactions, the names of the transacting parties, a description of the transaction and the amount of the transaction for the purpose of performing credit risk assessment. This credit risk assessment enables us to perform a quicker loan disbursal. No personal SMS data is collected, read or stored.</span></span></p><p class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">2.</span></span></strong> <strong><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">Phone</span></span></strong></p><p class=\"MsoNormal\"><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">Our app collects</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">and monitors</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">specific information about your device including your hardware model, build model, RAM, storage; unique device identifiers like IMEI,</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">serial number,</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">SSAID; SIM information includes network operator, roaming state, MNC and MCC codes, WIFI</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">information includes MAC address and mobile network information to uniquely identify the devices and ensure that no unauthorized device act on your behalf to prevent frauds. This also helps us in assessing credit worthiness for credit profile enrichment.</span></span></p><p style=\"text-align:left;\" class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">3. Installed Applications</span></span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">We collect each installed applications&#x27; metadata information which includes the application name, package name,</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">installed time,</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">updated time, version name and version code of each installed application on your device to assess your credit worthiness and provide you with pre-approved</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">customized loan offers.</span></span></p><p style=\"text-align:left;\" class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">4.</span></span></strong> <strong><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">Contacts</span></span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">Our app requires this permission to detect</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">references and to auto fill the data during your loan application process for seamless user journey. Also,</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">app</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">collects</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">and monitors</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">your contacts information including name, phone numbers, account type,</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">contact last modified, favorites and other options</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">which includes relationship, structural address, if available to enrich your financial profile and helps us determining the loan eligibility and risk assessment.</span></span></p><p class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">5. Location</span></span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">We collect and monitor the information about the location of your device to provide serviceability of your loan application, to reduce risk associated with your loan application and to provide pre-approved</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">customized loan offers. This also helps us to verify the address, make a better credit risk decision and expedite your KYC process.</span></span></p><p class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">6. Third party accounts</span></span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">We collect and monitor the list of accounts</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">configured in the device to verify the information, such as your email address and basic profile details, provided by you. This also helps us to enrich your profile information and provide you with pre-approved customized loan offers.</span></span></p><p class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">7. Camera</span></span></strong></p><p class=\"MsoNormal\"><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">We require camera access so that you can easily scan,</span></span> <span style=\"color:#000000\"><span style=\"font-size:14ptpx\">or capture required KYC documents and save time by allowing us to auto-fill relevant data. This ensures that you are provided with a seamless experience while using the application. </span></span></p><p class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">8.</span></span></strong> <strong><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">Storage</span></span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">We require storage permission so that your KYC and other relevant documents can be securely downloaded and saved on your phone. You can then easily upload the right KYC related documents for faster loan application details filling and disbursal process. This ensures that you are provided with a seamless experience while using the application.</span></span></p><p class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">9.</span></span></strong> <strong><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">MEDIA&amp;PHOTOS&amp;FILES</span></span></strong></p><p class=\"MsoNormal\"><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">We require the media, photos, and files permission that allows the App to enable you to upload photos or documents to complete the application form during your loan application journey.</span></span></p><p class=\"MsoNormal\"><span style=\"color:#000000\"><span style=\"font-size:14ptpx\">Please note that certain information that is required mandatorily to perform your credit risk assessment is securely shared with our registered third-party service provider, For more information on your permissions please refer to the Privacy Policy.</span></span></p>', 2, 1558157181, 1619140504, NULL);
INSERT INTO `contract_agreement` VALUES (7, '产品借款合同', '<p style=\"text-align:center;\" class=\"MsoNormal\"><strong><span style=\"font-size:15ptpx\">Loan Contract</span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">Loan Agreement no 1.0 (including all attachments, addendums and any amendments thereto, all of which will be referred to as &quot;Agreements&quot;) were made on and implemented by and between:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">(1)</span> <span style=\"font-size:12ptpx\">Mr / Mr with the registration number; (&quot;Borrower&quot;) with (2) Lenders with registration numbers; (&quot;Lenders&quot;) and Lenders and Borrowers are collectively referred to as &quot;The Parties&quot; and respectively as &quot;Parties&quot;.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"font-size:12ptpx\">Section 1. Definition and Interpretation</span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">1. Definition: For the purposes of this Agreement and in addition to any other definitions set forth in this Agreement, the following terms have the meanings as specified for those terms, unless the context clearly specifies otherwise:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">2. &quot;Borrowing Bank Account&quot; means the specified bank account designated by the Borrower for the purpose of receiving the loan disbursement.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">3. &quot;Borrower Data&quot; means personal data and information submitted by the Borrower on the Platform to be verified by the Company on behalf of the Lender.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">4. &quot;Borrower Platform ID&quot; means the Borrower&#x27;s username and / or registration number on the Platform that is attached to, represents and relates to the Borrower Data that has been submitted and registered on the Platform. &quot;Company&quot; means our company.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">5. &quot;Company Services&quot; means services provided by the Company to Borrowers in accordance with CSA.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">6. &quot;CSA&quot; means the service agreement to be entered into between the Company and the Borrower in connection with the provision of Company Services.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">7. &quot;Full Debt Amount&quot; means the aggregate amount of the principal amount of the Loan, administrative costs (maintenance costs, risk fees, management fees and transfer fees) thereof and other accumulated costs. Before the loan is issued several parts of the loan will first be deducted with some of these costs</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">8. &quot;Bank Account&quot; means the Company&#x27;s bank account designated for the purpose of disbursing the Loans to the Borrower and receiving payment of the principal amount of the Loan, and / or other fees or amounts owed from the Borrower to the Lender or to the Company.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">9. &quot;Lender Data&quot; means personal lender identification information provided by the Lender to the Company and / or Platform.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">10. &quot;Lender Platform ID&quot; means the lender&#x27;s username and / or registration number on the Platform attached to, representing and related to the Lender Data that has been submitted and registered on the Platform.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">11. &quot;Loans&quot; means financing services in the form of loans provided by the Lender to the Borrower, which will only be used for personal purposes, such as education, health etc.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">12. &quot;Loan Request&quot; means an application submitted electronically by the Borrower through the Platform to obtain a Loan, including supporting documents and information required by the Platform.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">13. &quot;Loan Disbursement Date&quot; means the date when the Lender or third party on behalf of the Lender, including the Company, carries out the wire transfer of the Loan to the Borrower&#x27;s Bank Account.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">14. &quot;Loan Financing Details&quot; means the terms and conditions of the Loan material as set out in the attached Loan Financing Details.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">15. &quot;Platform&quot; means an internet-based peer-to-peer lending platform owned and operated by the Company, including application</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">16. &quot;Letter of interest&quot; &quot;Terms and Conditions&quot; means the terms and conditions set out in Section 3. 2.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">17. Interpretation: In this Agreement unless the context otherwise requires:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">a. Each recital and attachment will form part of this Agreement and references to this Agreement will include recitals and attachments; b. References to this Agreement or other documents are to this Agreement or other documents which are in effect for the time being and as amended from time to time in accordance with this Agreement or the document (as the case may be); c. Words that use gender include every gender, references to the singular include the plural and vice versa and words that indicate people including individuals and legal entities, partnerships, associations without legal entities and other bodies (in each case, wherever located and for any purpose) and vice versa; d. The titles and contents of the tables in this Agreement are for convenience only and do not affect interpretation; e. If there is a conflict or discrepancy between the clauses, and any attachments in this Agreement, the clause will apply. For this purpose, negligence (whether intentional or unintentional) does not, by itself, be regarded as causing conflict or non-compliance; and f. In this Agreement the words &quot;other&quot;, &quot;including&quot; and &quot;in particular&quot; do not limit the generality of the previous word and the words that follow will not be interpreted as limited to the scope for the same class as the previous words where a wider arrangement is possible .</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"font-size:12ptpx\">Section 2. Application for Loans</span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">1. The Borrower has applied for a Loan by submitting a Loan Request to the Company through the Platform.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">2. The Borrower agrees that:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">1. The Lender will have the right to charge fees for the Loan as detailed in the Loan Financing Details and the Company will have the right to charge the Borrower for Company Services in accordance with CSA and that the Borrower must pay all such amounts at maturity under this Agreement and based on CSA, as applicable, and</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">2. Borrowers are required to pay debts in accordance with the Loan Financing Details and must pay the Full Amount of Debt at maturity under this Agreement and without delay to the Bank Account as stated in the Loan Financing Details.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">3. The Borrower agrees and understands that:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">1. The Lender has appointed the Company as a party to:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">I. manage and process Loan Requests from Borrowers, including but not limited to verifying and / or validating Borrower data contained in Loan Requests or submitted to Lenders through the Company or Platform;</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">II. supervise the collection of the full amount of debt at maturity and costs associated with it including but not limited to the issuance of warning letters and text messages to, and telephone calls to the Borrower; and</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">III. disburse Loans to the Borrowing Bank Account and receive all payments from the Loan and in connection with Company Services in the Bank Account; on behalf of the Lender.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">3. The loan application will be processed in accordance with the criteria specified by the Lender in Section 4 and verification thereof by the Company, and is the basis on which the Company will disburse the Loan to the Borrower, on behalf of the Lender.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">4. Approval of Loan Requests will be based entirely on the absolute evaluation of the Lender and is dependent on the Borrower&#x27;s implementation of the required legal documents and other formalities as required by the Lender.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">5. The Borrower hereby grants full power and authority to the Lender and the Company through the Platform, each employee, agent and company or third party authorized by the Company, to copy, share and use the Borrower&#x27;s Data for any actions taken related to the Request Loans and Loans as one of the competent persons deems necessary.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">6. The Borrower understands that the Company is not a party to this Agreement even though the Company has the authority to act on behalf of the Lender under this Agreement. The terms and obligations contained in this Agreement and / or arising from this Agreement will not in any way bind the Company or Platform and any legal issues that arise will be a problem between the Borrower and the Lender. Each Lender and Borrower hereby exempts the Company from any obligations relating to or arising from the Loan Application process and will jointly compensate the Company for any claims, losses, costs, expenses, damage or liabilities incurred or experienced by the Company relating to the implementation of activities delegated to the Company under this Agreement or the implementation of the obligations of each Borrower and Lender based on this Agreement. This exemption and indemnification obligation will survive even if the termination or termination of this Agreement is valid and binding on the Lender and Borrower even if the loan application is rejected and the loan is not given to the borrower.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">7. The Borrower declares and guarantees and agrees with the Lender that:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">I. The Borrower has fulfilled the minimum criteria as specified in Section 4.1;</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">II. Borrower Data and all other information provided to the Company and / or Platform is complete and correct data and information from the Borrower and is not misleading in any case;</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">III. The Borrower will be legally responsible for any falsification, and unauthorized use of, Borrower Data provided by or on behalf of the Borrower to the Company or Platform; IV. The Borrower signs this Agreement in good faith and without the intention to violate applicable rules and regulations including but not limited to money laundering, tax avoidance and anti-terrorism regulations;</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">V. The Borrower signs this Agreement for and on his own behalf, free and of his own free will without coercion or intimidation from any party and knows and understands the contents and consequences thereof; VI. the Borrower&#x27;s electronic signature in the Agreement is valid and this Agreement is a legal, legal and binding obligation towards the Borrower, and can be implemented against it in accordance with applicable law;</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">VII. The Borrower is not required to withhold taxes or other amounts from each loan payment, whether for principal, fees or other amounts; and</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">VIII. Proceeds from the Loan will be used solely for personal use, not for commercial or business purposes.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">7. The Lender declares and guarantees to the Borrower that:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">I. The Lender&#x27;s electronic signature in this Agreement is valid and this Agreement is a legal, legal and binding obligation towards the Lender, which can be implemented against him in accordance with applicable law;</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">II. Lenders sign this Agreement in good faith and without the intention to violate applicable rules and regulations including but not limited to money laundering, tax avoidance and anti-terrorism regulations;</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">III. The Lender signs this Agreement for and on his own behalf, free and of his own free will without coercion or intimidation from any party and knows and understands the contents and consequences thereof;</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">8.</span> <span style=\"font-size:12ptpx\">The Borrower agrees and understands that Borrower Data submitted to the Company and / or Platform will be disclosed to the Lender and used by the Company and the Lender to process the Loan Request and by the Company to manage the Loan and in connection with the provision of services by the Company to the Lender and Borrowers are in accordance with CSA.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">9. The Lender agrees and understands that the Borrower Data submitted to the Company and / or Platform will be used by the Company to process the Loan Request and manage the Loan and in connection with providing Company services to the Lender.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">10. The Parties acknowledge and agree that the implementation of this Agreement together with the Loan Financing Details and other attachments thereof may be carried out using digital or electronic signatures which will be deemed as valid signatures of each Party. Each Party must provide a physical signature for this Agreement if requested by the Company.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">11. Each Party has read and understood the contents, and therefore fully understands the rights and obligations arising from this Agreement and CSA.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">12. The Borrower agrees and acknowledges that after receiving the Loan, the Borrower will owe the Lender for the amount of funds disbursed to the Borrower&#x27;s Bank Account in accordance with this Agreement and the terms and conditions stated in the Loan Financing Details of this Agreement plus other costs to be paid by Borrowers to Lenders based on this Agreement.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">13. The Lender hereby authorizes the Company to disburse the Loan to the Borrower&#x27;s Bank Account after fulfilling the following conditions:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">I. Implementation of this Agreement by the Borrower and implementation of CSA by the Borrower and the Company;</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">II. The Company has verified the information provided by the Borrower as stated in the Loan Request, including Borrower Data; and</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">III. The Borrower has fulfilled the minimum criteria determined by the Lender, based on its sole and absolute policy.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">14. The Borrower fully understands that his Lending Application may be refused by the Lender without the obligation of the Lender, the Company and / or the Platform to disclose the reason for the refusal. The Borrower is not entitled to request a review, re-evaluation, or request in any other form to reassess rejected loan applications.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">15. The Parties will not communicate, interact or connect, directly or indirectly, with one another, other than in the manner provided on the Platform.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">16. By completing the Loan Request, the Borrower will be deemed to have signed this Agreement electronically and this Agreement is valid and binding on the Borrower when the Loan Request is approved by the Lender.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">17. Lenders hereby authorize the Company to exercise Lenders &#x27;rights under this Agreement and the Borrower acknowledges that the Company has been permitted to exercise Lenders&#x27; rights under this Agreement without the need for additional or separate authorization by the Lender</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"font-size:12ptpx\">Section 3. Use of the Platform</span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">1. Borrowers are required to register themselves on the Platform by meeting the following requirements and procedures:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">I. Provision of Borrower Data by filling out electronic forms provided on the Platform; and II. Complete the loan application by filling out electronic forms provided on the platform.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">2. After completing the registration process as referred to in Article 3.1 and set forth herein, the Borrower will be deemed to have agreed to the terms of use of the Platform, from which the Platform will then issue the Borrower&#x27;s Platform ID.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">3. The Lender hereby authorizes the Company and / or Platform to remind the Borrower of the date of loan repayment and in the event of default.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">4. The Borrower agrees to provide hard copies of documents submitted in electronic form in accordance with Section 3.1 or required by the Company to validate Borrower Data.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"font-size:12ptpx\">Section 4. Verification of Borrower Data</span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">1. The Borrower agrees and understands that the Loan will only be given to loan applicants who meet the following minimum criteria and the Borrower hereby declares and guarantees to the Lender that the Borrower meets or will meet these minimum criteria:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">I. The age of the loan applicant is 18-55 years when applying for a loan;</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">II. The loan applicant&#x27;s monthly income must be equal to or more than Rs. 15，000</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">III. The residential address of the loan applicant must be within the India</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">IV. The Loan Applicant receives a one-time confirmation code within 60 seconds of being sent by the Platform;</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">V. The principal amount of the loan given to the applicant is Rs @ borrow_amount @ (the deadline for the loan is @ borrow_days @ day)</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">VI. The Loan Applicant answers telephone calls made by the Company and verifies his identity in accordance with Company regulations; VII. the loan applicant&#x27;s reference will verify the information provided by the loan applicant.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">2. The Borrower agrees and understands that the Company has carried out and / or will verify data on behalf of the Lender, which will include but is not limited to:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">I. Verification by telephone call to the Borrower and references given by the Borrower and Borrower&#x27;s Employees if deemed necessary by the Company; II. Verify Phones that use a one-time password; and III. Data processing from social network profiles provided by the Borrower during the loan application process.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">3. The Borrower agrees that the Company has contacted or may contact the Borrower or third party on behalf of the Lender through various means, including but not limited to:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">I. telephone text messages; II. e-mail; III. voice call; and IV. automatic voice dialing</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">4.</span> <span style=\"font-size:12ptpx\">The Borrower will be responsible for the accuracy of information provided by third parties to the Company in the verification process.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"font-size:12ptpx\">Section 5. Borrower Data Protection</span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">1. The Borrower hereby grants full power and authority to the Lender and its authorized representatives and / or third parties appointed by the Lender including the Company and Platform for, at any time, without further notice to the Borrower, to carry out all or any of the actions and functions the following in accordance with all applicable laws and regulations:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">i. collection, storage, use, maintenance, analysis and dissemination of Borrower Data; ii. conduct data checks, reference checks, ask questions and verify based on data and information provided to, or obtained by, the Company or Platform if and when it is deemed necessary by the Company in connection with Borrower Data; and iii. share, obtain and / or disclose Borrower Data to government authorities or other authorized third parties appointed or authorized by the Lender for the purposes of proper verification and assessment of Borrower information and data.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">2. The Borrower agrees and understands that the Lender may provide Borrower Data to consultants and service providers, including but not limited to, legal advisors, financial and tax advisors, as well as government authorities, supervisory and court institutions, for the following purposes:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">I. carry out this Agreement; II. enforce the implementation of this Agreement; III. carry out the objectives of the Lender&#x27;s business activities; IV. carry out the obligations required by law applicable to the Loan; and V. responding to requests made by government authorities, regulatory bodies or courts.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">3.</span> <span style=\"font-size:12ptpx\">The Borrower agrees, understands and hereby grants the full power and authority to the Lender to instruct the Company and / or Platform to make and store a copy of the Borrower&#x27;s Data. The Borrower also agrees that the Company and / or Platform can use Borrower Data for the purpose of protecting the rights and interests of the Lender. The Borrower acknowledges that the Company and the Lender can maintain Borrower Data if the Loan Request is not approved or after the termination or termination of this Agreement. 4. The Borrower agrees, and hereby grants full power and authority to the Lender, employees, agents and affiliated companies, to share and use Borrower Data for various financing schemes, offer or promotion schemes, financing schemes or other promotions, which can be offered and provided by or on behalf of the Lender.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"font-size:12ptpx\">Section 6. Loan Terms and Conditions</span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">1. Loan terms and conditions as agreed by the Parties that will take effect after the Lender&#x27;s approval of the Loan Request is specified in the Loan Financing Details which includes the following terms and conditions:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">I. The loan amount will be stated in Rupiah; II. Loan tenure will be stated in calendar days; III. Against the Date of Loan Disbursement: the following will apply:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">i. Wire transfer Loans must be made by transferring bank money to the Borrower&#x27;s Bank Account; and ii. The Borrower will be deemed to have confirmed his approval of the terms of the Loan as set forth in this Agreement and the Loan Financing Details, if the Borrower has not paid the principal amount of the Loan one day after the Loan Disbursement Date.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">IV. The Loan Repayment Date which is the Repayment Date Amount must be received in the Bank Account, which the following conditions will apply:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">i. Early repayment is allowed; ii. Late payments will be subject to a late fee of 1.5 percent per day from the day of the initial delay of the loan amount. iii. Partial payment of late payment fees is not permitted; and iv. Repayment will be considered complete if the funds paid have been entered in the Bank Account listed in the Loan Financing Details of this Agreement.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">V. Types of loans are unsecured personal loans; VI. The Borrowing Fee that must be paid to the Borrower (Borrower Fee) is equal to.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"font-size:12ptpx\">Section 7. Consent to Pay</span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">1. The Borrower hereby agrees that the Borrower truly and legally owes the Lender the Full Amount of Debt after receiving it and agrees to pay the Full Amount at maturity in accordance with the provisions of this Agreement and the Loan Financing Details without counter-charges, set off , or reduction in any form.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">2. 2. Notwithstanding anything to the contrary contained in this Agreement, all payments made or collected by the Lender based on this Agreement must be applied by the Lender for his own benefit in the following priority order, (1) for any amount that is then due and is payable to the Lender based on the Agreement that is not listed in this Section, (2) for any costs that are later due and payable, (3) for any outstanding defaults or late fees which are later due and payable, (4 ) for costs which are then due and payable, and (5) for principal that is later due and payable.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">3. 3. The Lender, through the Company, will open and maintain books and records showing the loan, repayment, pre-payment, calculation and payment of fees and other amounts that must be paid and the amount paid according to this Agreement. Such books and records must be final and binding on the Borrower in relation to the amount that is owed at any time from the Borrower, with no real errors in calculation.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">4. 4. The Borrower must fully replace the Lender immediately upon request for all costs and expenses, including, but not limited to, legal counsel fees and out-of-pocket costs, which are incurred or will be incurred by the Lender in connection with the implementation every right and power granted by the Lender based on this Agreement.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"font-size:12ptpx\">Section 8. Breach of contract</span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">1. The Borrower will be considered for breach of contract if any of the following events occur:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">I. The Borrower fails to pay the amount due at this time (the due date which must take into account the borrower&#x27;s renewal rights under this Agreement) or fails to fulfill one or more of the other obligations as stipulated in this Agreement; or II. The Borrower has been declared bankrupt based on a court decision authorized; or III. The Borrower is proven guilty by a final and binding court decision from any jurisdiction or related to criminal activities including but not limited to money laundering and / or terrorism activities; or IV. The Borrower has submitted data that is falsified, incorrect and or misrepresented as Borrower Data. The Lender has the full right to determine whether the submission has been made.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">2.</span> <span style=\"font-size:12ptpx\">After the breach of contract, the Lender then has the right to expedite and demand payment of all amounts owed under this Agreement, immediately and in full, including, but not limited to, the principal balance along with late payment fees and any other costs. In addition, the Lender will have the right to terminate this Agreement and exercise any and all other rights and legal remedies for breach of contract. 3. Termination of this Agreement shall not affect the rights of any of the Parties arising before and including the termination date under this Agreement.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">9. Others</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">1. This agreement can only be changed by the Lender and the Borrower who signed the written amendment, which signature can be in electronic form.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">2. The Borrower must notify the Lender in writing of any changes to the Borrower&#x27;s Data, including, but not limited to, any changes to the Borrower&#x27;s residential address.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">3. The Borrower agrees that, without prior notification, the Lender has the right to transfer or transfer all or part of his rights and obligations under this Agreement to a third party. The Borrower is not entitled to transfer or transfer some of his rights or obligations under this Agreement to any party.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">IN WITNESS WHEREOF, the Parties have carried out this Agreement through electronic or physical signatures as evidenced by the Giving Platform IDs to each Party. This agreement can be executed with separate copies that are signed electronically or physically, each of which when implemented and delivered will be considered original, and all together will be one and the same instrument.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"font-size:12ptpx\">Section 1. Definition and Interpretation</span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">1. Definitions: For the purposes of this Agreement and in addition to any other definitions set forth in this Agreement, the following terms have the meanings as specified for those terms, unless the context clearly stipulates otherwise: &quot;Additional Service Fees&quot; are the service fees payable by the Borrower to the Company for the provision of Services during the extension of the Loan, which is calculated in accordance with Article 7.1.2. &quot;Approved Borrower Criteria&quot; means criteria set by the Lender that must be met by the Borrower in order to be considered as a potential Borrower. &quot;Approved Loan Terms&quot; means the Loan material terms agreed upon by the Lender. &quot;Bank Account&quot; means a bank account that must be opened by the Company to hold funds owned by the Lender and other lenders who use the Company&#x27;s Platform and services for the purpose of disbursing the Loans to the Borrower and managing the repayment of loans by the Borrower. &quot;Borrower Data&quot; means personally identifiable information and other data from Borrowers obtained and verified by the Company on behalf of the Lender. &quot;Borrower Platform ID&quot; means the Borrower&#x27;s username and / or registration number on the Platform that is attached to, represents and relates to the Borrower Data that has been submitted and registered on the Platform. &quot;Borrower&quot; means the Borrower and any other borrowers who obtain funding by submitting an Application through the Platform. &quot;Lender&quot; means an individual who provides all or part of the Loan to the Borrower under the Loan Agreement to be signed by the Borrower and Lender through the Platform service. &quot;Lenders&quot; means Lenders who will lend to one or more Borrowers and other individuals who provide financing to Borrowers through the Platform. &quot;Loan&quot; means a loan given by the Lender to the Borrower in accordance with the terms of the Loan Agreement. &quot;Loan Request&quot; means the loan agreement signed between the Lender and the Borrower, both electronically or physically, which explains the terms and conditions of the Loan, including all attachments, addendums and any amendments thereto. &quot;Loan Agreements&quot; means Loan Agreements and all other similar agreements between one Borrower and one of the Lenders. &quot;Loan Applicant&quot; means an individual Indonesian citizen who has applied for a Loan through the Platform. &quot;Loan Request&quot; means an application submitted electronically by the Loan Applicant through the Platform for obtaining a Loan, including supporting documents and information required by the Platform. &quot;Platform&quot; means an internet-based peer-to-peer lending platform that is owned and operated by the Company / &quot;Services&quot; means services provided by the Company to Borrowers through the Platform, as specified in this Agreement. &quot;Service Fees&quot; are service fees payable by the Borrower to the Company for the provision of Services during the initial tenure of each Loan Agreement, which is calculated in accordance with Article 7.1.1. \\\\</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">2. Interpretation: In this Agreement unless the context otherwise requires: a. Each recital and attachment will form part of this Agreement and references to this Agreement will include recitals and attachments; b. References to this Agreement or other documents are to this Agreement or other documents which are in effect for the time being and as amended from time to time in accordance with this Agreement or the document (as the case may be); c. Words that use gender include every gender, references to the singular include the plural and vice versa and words that indicate people including individuals and legal entities, partnerships, associations without legal entities and other bodies (in each case, wherever located and for any purpose) and vice versa; d. The titles and contents of the tables in this Agreement are for convenience only and do not affect interpretation; e. If there is a conflict or discrepancy between the clauses, and any attachments in this Agreement, the clause will apply. For this purpose, negligence (whether intentional or unintentional) does not, by itself, be regarded as causing conflict or non-compliance; and f. In this Agreement the words &quot;other&quot;, &quot;including&quot; and &quot;in particular&quot; do not limit the generality of the previous word and the words that follow will not be interpreted as limited to the scope for the same class as the previous words where a wider arrangement is possible .</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"font-size:12ptpx\">Section 2. Application for Loans and Service Provision</span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">1. The Company has created a Platform to facilitate lending by Lenders to Borrowers and has established a system of ownership where prospective Lenders can be introduced to Loan Applicants and Loan Applicants can be introduced to Loan candidates.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">2. The Borrower can apply for one or more Loan Requests through the Platform to apply for one or more Loans from one or more Lenders.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">3. The Borrower hereby retains the Company to provide Services to the Borrower in accordance with the terms and conditions of this Agreement and the Company hereby agrees to provide Services to the Borrower.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">4. Based on consideration of providing Company Services, the Borrower agrees to pay the Company Service Fees, Additional Service Fees and Extension Administrative Fees as further described in Section 7 below. The Borrower expressly acknowledges that: I. The Lender will have the right to charge fees for the Loan as detailed in the Loan Financing Details and the Company will have the right to charge the Borrower for Company Services in accordance with CSA and that the Borrower must pay all such amounts when they fall tempo based on this Agreement and based on CSA, as applicable, and II. The Borrower is required to pay debts in accordance with the Loan Financing Details and must pay the Full Amount of Debt at maturity under this Agreement and without delay to the Bank Account as stated in the Loan Financing Details. III. The Company is not responsible for any decisions made by the Lender (i) in connection with any Loan or Loan Request or (ii) based on a Loan Agreement or otherwise.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">5. The company will not be a party to any Loan Agreement. The terms and obligations contained therein and / or arising therefrom will not be binding on the Company or Platform. Notwithstanding this, the Borrower acknowledges and agrees that the Company acts on behalf of the Lender (but not as an agent of the Lender) in the manner specified in the Loan Agreement. Specifically, the Borrower acknowledges that the Company can exercise Lenders&#x27; rights under the Loan Agreement.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">6. The Borrower hereby confirms that the Company has not provided the Borrower with advice regarding the eligibility of loan funds from the Lender or its ability to repay the Loans and that he has made his own decisions regarding the receipt of the Loans on the terms and conditions offered by the Lender. The Borrower hereby, now and forever exempts the Company from all responsibilities in the event that the Borrower experiences adverse consequences arising from the Loans received by the Borrower under this Loan Agreement or this Agreement.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">7. The Parties agree that the Company will act independently with regard to providing Services. Nothing in this Agreement is intended to create a relationship between the lender and the power of attorney between the Borrower and the Company or impose fiduciary obligations or other obligations towards the Company.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">8. The Borrower declares and guarantees to the Company that: I. All information provided to the Company and / or Platform by the Borrower is complete and correct data and Borrower information is not misleading in any case; II. The Borrower will be legally responsible for any counterfeiting, and unauthorized use of, data provided to the Company or Platform; misleading in any case; III. The Borrower signs this Agreement in good faith and without the intention to violate applicable rules and regulations including but not limited to money laundering regulations, tax avoidance regulations and anti-terrorism regulations; IV. The Borrower signs this Agreement for and on its own behalf, free and of its own free will without coercion or intimidation from any party and knows and understands the contents and consequences thereof including the amount of Service Fees, Additional Service Fees and Extension Administration fees to be paid in accordance with Section 7.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">9. The Borrower hereby grants the full power and authority to the Company, its affiliates and their respective employees and agents to copy, share and use Borrower Data obtained by the Company on behalf of the Lender for any actions taken relating to the provision of services or carrying out its obligations on behalf of Lenders based on the Loan Agreement. In this regard, the Borrower hereby confirms that the provisions of Section 2.4 of the Loan Agreement, relating to the Borrower, become part of this Agreement through mention.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">10. The Borrower hereby expressly acknowledges and agrees that the Company is not responsible for the accuracy and validity of the information or data provided to it by the Borrower or Lender or is responsible for the performance of the Borrower or Lender for its obligations under the Loan Agreement.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">11. The Borrower understands that a new Loan Request will need to be submitted for each Loan requested by the Borrower and that Borrower Data and other information required by the Lender or Company must be submitted and verified for each Loan Request.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"font-size:12ptpx\">Part 3. Particular Obligations of the Parties</span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">1. Borrowers are required to register themselves on the Platform by meeting the following requirements and procedures: I. Providing Borrower data by filling out electronic forms provided on the Platform; and II. Provision of data or information required by the Government Authority.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">2. After completing the registration process referred to in Section 3.1 above, the Borrower will be deemed to have agreed with I. if the Borrower has not signed this Agreement prior to registration, the terms and conditions of this Agreement and II. terms of use of the Platform, from which the Platform will then issue the Borrower Platform ID. The Borrower must afterward provide a physical signature for this Agreement if requested by the Company. This agreement will enter into force and bind the Parties when signed, electronically (through, in the case of the Borrower, the registration process described above) or physically, by both Parties. The Company will be deemed to have signed this Agreement electronically if it has created and established a registration number for the Borrower through the Platform.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">3. The Borrower must: I. Provide Borrower Data in each Loan Request he submits to the Platform. II. Provide further information requested by the Company in connection with each Loan Request. III. If the Loan Request is approved by the Lender, sign the Loan Agreement with the Lender who has agreed to provide the Loan in a coordinated manner by the Company. IV. Carry out its obligations under the Loan Agreement where it is a Party and this Agreement.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">4. The Company must provide services to the Borrower, which include: I. Collection, validation and verification of Borrower Data and other information that must be provided by the Borrower and reviewing the Loan Request on behalf of the Lender.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">II. Forward Loan Requests to prospective Lenders listed on the Platform if the Borrower meets the Approved Borrower&#x27;s Criteria and the Credit Terms Approved by the Lender.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">III. Inform the Borrower if the Lender agrees to provide the Loan to the Borrower on the terms and conditions specified in the Loan Request and the Loan Agreement.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">IV. Creation and operation of a Platform that will, at a minimum, contain the information referred to in Section 5, and the preparation of a Loan Application and Loan Agreement template.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">V. Making and maintaining a Bank Account where the Lender will deposit funds transferred by the Company to the Borrower in accordance with the Loan Agreement and where the Borrower will make all payments made under the Loan Agreement and this Agreement. The Borrower expressly acknowledges and agrees that the Bank Account is an account where all Lenders and Borrowers who use the Company&#x27;s Platform and services will pay every money and from which all loans will be transferred to the Borrower.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">VI. Carry out a wire transfer of the principal amount of the Loan to the Borrower after meeting all the conditions set out in Section 4.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">VII. Collect all outstanding amounts from the Borrower. The Company is responsible for paying the Lender all amounts owed to him from the amount the Company receives from the Borrower. The Borrower acknowledges that the Company has the right to engage licensed third party debt collection service providers for billing purposes.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">VIII. Providing other services that may be offered and explained from time to time on the Platform.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">5.</span> <span style=\"font-size:12ptpx\">The Borrower may not communicate, interact or connect, directly or indirectly, with the Lender, other than in the manner provided on the Platform in accordance with this Agreement.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">Section 4. Facilitation of Loan Disbursement</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">1. The company must make a wire transfer of the principal amount of the Loan to the Borrower after fulfilling the following conditions:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">I. The Lender has provided the Approved Borrower Criteria and the Approved Credit Terms and agreed to provide the Loan with the conditions requested in the Loan Application.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">II. The Lender must have entered the funds required by the Company and sufficient funds must be available in the Bank Account for the Loans to be given.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">III. The Borrower and Lender must have signed a Loan Agreement which, in the case of the Lender, can be done by including the digital code of the Lender by the Company in the Loan Agreement;</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">IV. The Company has verified the provisions provided by the Loan Applicant as stated in the Loan Request and has been able to contact the Loan Applicant&#x27;s reference who has verified the information provided by the Loan Applicant; and</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">V. The Loan Applicant meets the minimum criteria determined by the Lender based on which Platform will be authorized to disburse the Loan.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">Section 5. Loan Information Services</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">1. The Company must ensure that the Platform containing the following information is accessible to Borrowers:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">I. Calculation of loan parameters;</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">II. information regarding the status of the Loan Applicant;</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">III. information about new services and products provided by the Platform. IV. Information regarding the amount of the Borrower&#x27;s debt to the Lender based on the Loan Agreement in connection with the Services rendered.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">Section 6. Borrower Verification</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">1. The Borrower agrees that the Platform will receive a Loan Request that matches the criteria given by the Lender.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">2. The Company has the right to take any action deemed appropriate by the Company to validate the data submitted by the Borrower in the Borrower&#x27;s Loan Request. Any and all actions to confirm and validate the data in the Borrower&#x27;s Loan Request will be carried out on behalf of the Lender.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">3. The Company does not conduct a credit risk assessment of the Borrower and will only verify data on behalf of the Lender, which will include but is not limited to:</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">I. Verification by telephone call;</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">II. Verify Phones that use a one-time password; and</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">III. Data processing from social network profiles provided by the Borrower during the loan application process.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">4. The Company may, at its own expense but without the obligation to do so, engage a third party to conduct the Borrower&#x27;s credit risk assessment.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">5. The Company is not responsible for the authenticity, accuracy or correctness of the data in the Borrower&#x27;s Loan Request before and after verification conducted by the Company.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">6. The company has the right to contact the Borrower or person, who is stated as in the Borrower&#x27;s Loan Request, on behalf of the Lender through various means, including but not limited to: 1. telephone text messages; 2. email; 3. voice calls; and 4. automatic voice calls.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"font-size:12ptpx\">Section 7. Costs</span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">1. In connection with the provision of Services to the Borrower by the Company, the Borrower must pay the following fees to the Company: The admin fee that must be paid by the borrower is 16% of the loan amount.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">2. All fees and other amounts owed under this Agreement must be made free from countermeasures, set offs or other deductions, including deductions for taxes. In the event that a Borrower is legally prohibited from making payments without deduction as specified in Section 7.2, the payment owed to the Company under this Agreement will be increased to the amount required so that the net amount received by the Company after the deduction or suspension is equal to the amount that should have been received if the deduction or suspension is not carried out.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"font-size:12ptpx\">Section 8. Borrower Data Protection</span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">1. The Company promises that the Borrower Data collection and processing will be in accordance with applicable laws and regulations in Indonesia. Personal data will include but will not be limited to, full name, e-mail, date of birth, telephone number, home address, bank account number.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">2. The Company has the right and the Borrower hereby gives the Company the right to disclose data of the Lenders in part or in full to third parties which the Company considers in its sole discretion to regulate, process and manage all Loan Requests and Loan Processes, including but not limited to disclosure information to third parties determined to assist in the collection of loan repayments.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">3. The Company is not permitted to further use and process Borrower data that it has obtained other than for the purpose of providing the Services, including for managing and processing Loans.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"font-size:12ptpx\">Section 9. Force Majeure</span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">1. The Borrower and the Company are not responsible for any loss or damage suffered by other Parties arising from late implementation or non-implementation of obligations of either Party due to force majeure events; provided that, however, the occurrence of a force majeure event will not excuse or delay the Borrower&#x27;s payment obligations under this Agreement.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">2. Conditions that qualify as force majeure include but are not limited to, war, operations such as war, hostilities, civil war and riots, rebellions, riots, legislative actions or other legally binding actions or imposed by domestic or foreign authorities , strikes (not including those limited to Party employees or controlled partners or companies), closures, difficulties in supplying raw materials, prolonged shortages or restrictions on utility materials, blocked by ice, fire, computer system virus attacks or other unexpected circumstances that prevent wrong one Party to perform its obligations under this Agreement.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"font-size:12ptpx\">Section 10. Breach of contract</span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">One of the Parties will be considered as a breach of contract if one of the following events occurs: a. fail to fulfill one or more of its obligations as stipulated in this Agreement; or b. he was declared bankrupt based on a court decision authorized; or c. he is proven guilty by a final and binding court decision from any jurisdiction or related to criminal activities including but not limited to money laundering and / or terrorism activities; or d. related to the Borrower, he has submitted incorrect data, falsified, and / or misrepresentation as Borrower data. The company has full authority to determine whether the submission has been made.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"> </p><p style=\"text-align:left;\" class=\"MsoNormal\"><strong><span style=\"font-size:12ptpx\">Section 11. Termination</span></strong></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">1. The company can terminate this Agreement for any reason immediately at any time by giving written notice and the borrower is obliged to complete all loans plus the agreed cost burden at the beginning of the agreement.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">2. From and after termination under Section 10.1 and receipt of termination notice under Section 10.2, no Loan will be received by the Borrower. After all loans and outstanding fees outstanding to the Company have been paid on the effective termination date, the Company will terminate the Agreement</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">3. Termination of the Agreement will not affect the rights of any of the Parties arising before and including the termination date under this Agreement. In the event that one of the Contractual Parties breaches according to this Agreement, the breach of the contract has not been fixed within ten (10) days of receipt of the notification of the contract breach from the other Party, the Non-contracted Party has the right to terminate this Agreement upon the expiration of the 10 (ten) period ) that day and, in addition, has the right to exercise any and all legal rights and remedies available to non-breach parties under Indian law; provided that, however, the Company&#x27;s maximum liability to the Borrower under this Agreement is the fees paid by the Borrower to the Company under this Agreement.</span></p><p style=\"text-align:left;\" class=\"MsoNormal\"><span style=\"font-size:12ptpx\">4. Notwithstanding anything to the contrary in this Agreement, no Party shall be liable for indirect or consequential damages suffered by other Parties, including final benefits (other than those obtained or that will be obtained by the Company under this Agreement), lost opportunities or punitive compensation.</span></p>', 3, 1558157457, 1558157457, NULL);
INSERT INTO `contract_agreement` VALUES (8, '条款及细则', '<p style=\"text-align:center;\" class=\"MsoNormal\"><strong>Terms &amp; Conditions</strong></p><p class=\"MsoNormal\">TESTDM NIGERIA LIMITED, whose registered office is situated at Plot 169, Karimu Kotun Street, Victoria Island, Lagos, Nigeria (hereinafter shall be referred to as &quot; TESTDM &quot; or &quot;Company&quot; or &quot;us&quot; or &quot;we&quot; are the owner of the mobile application by the name testdn (&quot;App&quot;) and website at www.testdn.ng (&quot;Website&quot;) (App and Website are hereinafter together referred to as the &quot;Platform&quot;).</p><p>As a user (&quot;User&quot; or &quot;You&quot;) of the Platform, You understand that Platform provides access between multiple Users in the form of consumers, financial institutions, data partners and other partners lenders, borrowers, service providers, etc. with a view to facilitate lending and borrowing activities, including providing other financial products i.e. insurance products, credit cards, etc. between the Users.</p><p>It is hereby clarified that the term &quot;Users&quot; shall mean any person using the Platform i.e. consumers, financial institutions, regulated entities, data partners, and other partners. Your use of this Platform implies that You have read, understood, and agreed to abide by the following, disclaimer, terms &amp; conditions (&quot;Terms &amp; Conditions&quot;).</p><p class=\"MsoNormal\">These Terms &amp; Conditions read together with our privacy policy govern Your usage of the Platform and the terms for the purchase of the Products from the Platform (“Product”). If You disagree with any part of these Terms &amp; Conditions, please do not use the Platform.</p><p class=\"MsoNormal\">Please read these Terms &amp; Conditions carefully before accessing or using our Platform. By accessing or using any part of the Platform, You agree to be bound by these Terms &amp; Conditions. If You do not agree to all the terms and conditions of this agreement, then You may not access the Platform or use any services provided by Us.</p><p class=\"MsoNormal\">1. GENERAL</p><p>The App provides access to an online platform bringing together consumers, financial institutions, data partners, and other partners willing to abide by the Terms &amp; Conditions herein. TESTDM is merely a facilitator providing the Platform for any person in need of financial products. TESTDM provides various kinds of personal loan products as specifically detailed under Clause 2 to its Users.</p><p class=\"MsoNormal\">TESTDM merely facilitates a transaction between two such persons (i.e. Users). TESTDM is not an organization registered with the Reserve Bank of Nigeria and does not hold any license to engage in any activities relating to lending or borrowing. TESTDM is not a Financial Institution under the Companies Act, 2013 or the Banking Regulation Act, 1949 or any other laws for the time being in force in Nigeria. TESTDM is also not a deposit taking company or a chit fund or a company offering any investment schemes as per the rules and regulations for the time being in force in Nigeria.</p><p class=\"MsoNormal\">TESTDM is a service provider facilitating the access between financial institutes and non-banking finance companies willing to lend and person in need of borrowing. The final decision as regards lending and borrowing is also subject to the choice of the respective Users in their respective capacities as lenders / borrowers / users of other financial products as set out in the Platform. TESTDM, through its Platform displays various products provided by its partners or third parties. In addition to the foregoing, TESTDM also provides certain other services with respect to data analytics subject to these Terms &amp; Conditions.</p><p class=\"MsoNormal\">In the event You wish to avail any of the Products displayed on the Platform, You will be required to provide certain information and our representatives may contact You through phone or email to understand Your requirements.</p><p class=\"MsoNormal\">TESTDM provides various services, including but not limited to (“Services”): a. Facilitating purchase and sale of Product between the Users on its Platform; b. Assisting its customers to obtain a Product from various banks who are partnered with TESTDM; c. Assisting its Users to obtain their credit report through authorized agents partnered with TESTDM. TESTDM will monitor and update the credit report obtained by the customer through the use of the Platform as and when TESTDM receives such report from the authorized agents; d. Provision of support to the Users in verifying the financial capabilities of Users; e. TESTDM will also provide You with spend analysis which analyses Your income and expenses which is obtained by TESTDM by way of bank SMS scraping and through its integration with service provider. f. Provision of a social score based on User’s Facebook, Twitter, Linkedin or any other social media accounts that are linked with User’s account on the Platform. g. In the event You have registered Your phone number on the ‘Do Not Disturb’ registers with Your network provider, You shall ensure to take all steps to enable the Company’s representative’s to contact You via phone to provide details about different financial products and You shall ensure that such calls received by You are pursuant to You providing Us with information and You shall not register a compliant with the relevant authorities for the same. For the provision of the above mentioned Services, TESTDM will be using and sharing the information of the User with multiple financial institutions and other parties, as may be required for the purpose mentioned above and TESTDM shall also run multiple credit checks to be able to get the best available offers to suit the needs of the Users. The collection, storing, use and transfer of information shared by the User shall be governed in accordance with the Privacy Policy.</p><p class=\"MsoNormal\">2. ELIGIBILITY</p><p class=\"MsoNormal\">The User of this Platform unequivocally declares and agrees that the User is a natural / legal person who has attained the age of at least 18 years and is legally allowed to enter into a contract in Nigeria. The User is allowed to utilize the Services in accordance with the terms and conditions detailed hereinafter. By registering on the Platform, the User hereby undertakes to agree and abide by the Terms &amp; Conditions detailed herein. If the User violates any of these Terms &amp; Conditions, or otherwise violates an agreement entered into through the medium of the Platform, TESTDM may terminate the User’s membership, delete his/her profile and any content or information posted online by the User on the Platform and / or prohibit the User from using or accessing the Platform at any time in its sole discretion, with or without notice, including without limitation if TESTDM believes that User is under the age of 18 years.</p><p class=\"MsoNormal\">3. ACCEPTANCE OF TERMS AND CONDITIONS</p><p class=\"MsoNormal\">As a User of this Platform, You have agreed to the Terms &amp; Conditions provided hereunder or anywhere else on this Platform including but not limited to disclaimers on this Platform. You are advised to read and understand the said Terms &amp; Conditions and in case You do not wish to agree to these Terms &amp; Conditions, please refrain from using the Platform. TESTDM reserves the right, at its sole discretion, to change, modify, add or remove portions of these Terms &amp; Conditions, at any time without any prior written notice to the User. It is the User’s responsibility to review these Terms &amp; Conditions periodically for any updates/ changes. User’s continued use of the App or Website following the modification of these Terms and Conditions will imply the acceptance by the User of the revisions.</p><p>Note that we charge fees and interest upfront, so that you only need to repay the   principal amount at the due day. <br/>In addition, we charge a minimum 10 NGN to ensure you can easily repay the loan,   this fee is NOT REFUNDABLE.<br/>    </p><p></p><p class=\"MsoNormal\">4. YOUR ACCOUNT</p><p class=\"MsoNormal\">If You wish to use the Platform, You are required to maintain an account and will be required to furnish certain information and details, including Your name, email id, contact number and any other information deemed necessary by TESTDM and as further detailed in the Privacy Policy. You are responsible for maintaining the confidentiality and security of Your account, password, activities that occur in or through Your account and for restricting access to Your computer to prevent unauthorized access to Your account. You agree to accept responsibility for all activities that occur under Your account or password. You should take all necessary steps to ensure that the password is kept confidential and secure and should inform us immediately if You have any reason to believe that Your password has become known to anyone else, or if the password is being, or is likely to be, used in an unauthorized manner. Please ensure that the details You provide Us with are true, correct, accurate and complete. Upon TESTDM gaining knowledge of having any reasonable suspicion that the information provided by You is wrong, inaccurate or incorrect, TESTDM shall immediately terminate Your account without any notice to You in this regard. In the event of any changes to the information shared by You at the time of registering Yourself on the Platform, You shall be responsible for forthwith notifying the said changes to Us. You can access and update most of the information You provided us on the ‘dashboard’ area of Your account after You log-in or by writing to Us at help@TESTDM.in. The right to use this Platform is personal to the User and is not transferable to any other person or entity. You shall at all times abide by the Terms and Conditions stated herein and any breach of these conditions may also lead to TESTDM terminating Your account and appropriate civil and criminal remedies will be sought against You as provided under the laws of Nigeria.</p><p class=\"MsoNormal\">5. PRIVACY</p><p class=\"MsoNormal\">TESTDM collects certain information from You in order to provide the Services. TESTDM’s use of Your personal information is governed in accordance with the Privacy Policy.</p><p class=\"MsoNormal\">6. LICENSE AND ACCESS</p><p class=\"MsoNormal\">TESTDM grants You a limited license to access and use the Platform for availing the Services, but not to download any material from it (other than page caching) or modify it, or any portion of it, except with express written consent of TESTDM and / or its affiliates, as may be applicable. Any unauthorized access to the Platform or any networks, servers or computer systems connected to Platform and any attempt to modify, adapt, translate or reverse engineer any part of the Platform or re-format or frame any portion of the pages of the Platform, save to the extent expressly permitted by these Terms &amp; Conditions, is not permitted. This license is non-transferable and does not permit any resale or commercial use of this Platform or its contents; any downloading or copying of account information for the benefit of anyone other than Your use; or any use of data mining, robots, or similar data gathering and extraction tools. The Platform or any portion of the Platform (including but not limited to any copyrighted material, trademarks, or other <a href=\"https://www.testdn.ng/console/\" target=\"\">proprietary</a> information) may not be reproduced, duplicated, copied, sold, resold, visited, distributed or otherwise exploited for any commercial purpose without express written consent of TESTDM and / or its affiliates, as may be applicable. Any unauthorized use of the Platform shall terminate the permission or revoke the license granted by TESTDM. You are permitted to use content delivered to You through the Service only on the Service. You may not copy, reproduce, distribute, or create derivative works from this content. Further, You agree not to reverse engineer or reverse compile any of the Service technology, including but not limited to, any Java applets associated with the Service.</p><p class=\"MsoNormal\">7. MONITORING OF THE PLATFORM AND YOUR ACCOUNT</p><p class=\"MsoNormal\">TESTDM has the right and liberty to monitor the content of the Platform at all times which shall include information provided in Your account. The monitoring of the Platform / Platform is important to determine the veracity of the information provided by You and that every User remains in consonance with the Terms &amp; Conditions provided herein. Subject to the Terms &amp; Conditions mentioned herein, TESTDM shall also have the liberty to remove any objectionable content which is in contravention of the Terms &amp; Conditions herein or share such information with any governmental authority as per procedures laid down by the law for the time being in force in Nigeria.</p><p class=\"MsoNormal\">8. SERVICE SUSPENSION</p><p class=\"MsoNormal\">TESTDM may wish to stop providing the Services, and may terminate use of it at any time without giving notice of termination to You. Unless TESTDM informs the User otherwise, upon any termination, (a) the rights and licenses granted to You in these terms will end; and (b) User must stop using the Platform forthwith. TESTDM reserves the right to suspend or cease providing any Service and shall have no liability or responsibility to the User in any manner whatsoever if it chooses to do so.</p><p class=\"MsoNormal\">9. PROHIBITED USES</p><p class=\"MsoNormal\">In addition to other prohibitions as set forth in the Terms &amp; Conditions, You are prohibited from using the Platform: (a) for any unlawful purpose; (b) to solicit others to perform or participate in any unlawful acts; (c) to violate any international, federal, provincial or state regulations, rules, laws, or local ordinances; (d) to infringe upon or violate our intellectual property rights or the intellectual property rights of others; (e) to harass, abuse, insult, harm, defame, slander, disparage, intimidate, or discriminate based on gender, sexual orientation, religion, ethnicity, race, age, national origin, or disability; (f) to submit false or misleading information; (g) to upload or transmit viruses or any other type of malicious code that will or may be used in any way that will affect the functionality or operation of the Service or of any related website, other websites, or the Internet; (h) to collect or track the personal information of others; (i) to spam, phish, pharm, pretext, spider, crawl, or scrape; (j) for any obscene or immoral purpose; or (k) to interfere with or circumvent the security features of the Service or any related website, other websites, or the Internet. We reserve the right to terminate Your use of the Service or any related website for violating any of the prohibited uses.</p><p class=\"MsoNormal\">10. LIMITATION OF LIABILITY AND DISCLAIMER OF WARRANTIES</p><p class=\"MsoNormal\">Notwithstanding anything to the contrary contained herein, neither TESTDM nor its affiliated companies, subsidiaries, officers, directors, employees or any related party shall have any liability to You or to any third party for any indirect, incidental, special or consequential damages or any loss of revenue or profits arising under or relating to these Terms &amp; Conditions. To the maximum extent permitted by law, You waive, release, discharge and hold harmless TESTDM, its affiliated and subsidiary companies, and each of their directors, officers, employees, and agents, from any and all claims, losses, damages, liabilities, expenses and causes of action arising out of Your use of the Platform. As a User, You also acknowledge that TESTDM has maintained and carried out all possible checks and balances to assure the credibility of the Users as listed on the Platform. The information provided on the Platform is based on the information that is provided to TESTDM. In case the User does not disclose any information to TESTDM, and the same is not found out at the first instance by TESTDM despite all measures adopted to certify the ratings or credibility of a User, TESTDM shall not be responsible for any claims or liabilities. TESTDM in any event is not responsible for any default in return of money that is borrowed from the lender and the lender shall have the exclusive right to initiate proceedings against the defaulter borrower. TESTDM shall to the best of its abilities aid the concerned User in terms of provision of information to initiate any legal proceedings. However, TESTDM shall not be responsible for any default on behalf of the User. TESTDM is an information platform and the User is entitled to conduct its own diligence before taking any steps to initiate the processes outlined in the Website. TESTDM does not make any representations or warranties on behalf of the financial service providers, banks or NBFCs partnered with TESTDM with respect to the financial products / loans provided by such partners. TESTDM shall be responsible only to the extent of providing the Services and all liabilities and obligations of the customers / User with respect to the financial products provided by the partners shall be governed by the separate agreement executed between such financial partners and the customers and TESTDM shall have no liability in this regard whatsoever. TESTDM makes no representations or warranties about the accuracy, reliability, completeness, current-ness and/or timeliness of any content, information, software, text, graphics, links or communications provided on or through the use of the Platform or that the operation of the Platform will be error free and/or uninterrupted. Consequently, TESTDM assumes no liability whatsoever for any monetary or other damage suffered by You on account of the delay, failure, interruption, or corruption of any data or other information transmitted in connection with use of the Platform; and/or any interruption or errors in the operation of the Platform. This limitation of liability clause shall prevail over any conflicting or inconsistent provision contained in any of the documents / content comprising this Terms &amp; Conditions. It is up to You to take precautions to ensure that whatever You select for Your use is free of such items as viruses, worms, malware, Trojan horses and other items of a destructive nature. YOUR USE OF THE SERVICE AND ALL INFORMATION, PRODUCTS AND OTHER CONTENT (INCLUDING THAT OF THIRD PARTIES) INCLUDED IN OR ACCESSIBLE FROM THE SERVICE IS AT YOUR SOLE RISK. THE SERVICE IS PROVIDED ON AN &quot;AS IS&quot; AND &quot;AS AVAILABLE&quot; BASIS. COMPANY EXPRESSLY DISCLAIM ALL WARRANTIES OF ANY KIND AS TO THE SERVICE AND ALL INFORMATION, PRODUCTS AND OTHER CONTENT (INCLUDING THAT OF THIRD PARTIES) INCLUDED IN OR ACCESSIBLE FROM THE SERVICE, WHETHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. COMPANY MAKE NO WARRANTY THAT: (i) THE SERVICE WILL MEET YOUR REQUIREMENTS, (ii) THE SERVICE WILL BE UNINTERRUPTED, TIMELY, SECURE, OR ERROR-FREE, (iii) THE RESULTS THAT MAY BE OBTAINED FROM THE USE OF THE SERVICE WILL BE ACCURATE OR RELIABLE, (iv) THE QUALITY OF ANY PRODUCTS, SERVICES, INFORMATION, OR OTHER MATERIAL PURCHASED OR OBTAINED BY YOU THROUGH THE SERVICE WILL MEET YOUR EXPECTATIONS, OR (V) ANY ERRORS IN THE TECHNOLOGY WILL BE CORRECTED AND YOU ARE SOLELY RESPONSIBLE FOR ANY DAMAGE TO YOUR COMPUTER SYSTEM OR LOSS OF DATA THAT RESULTS FROM THE DOWNLOAD OF ANY SUCH MATERIAL. NO ADVICE OR INFORMATION, WHETHER ORAL OR WRITTEN, OBTAINED BY YOU FROM COMPANY OR SERVICE PROVIDER THROUGH OR FROM THE SERVICE WILL CREATE ANY WARRANTY NOT EXPRESSLY STATED IN THESE TERMS. YOU FURTHER AGREE THAT NEITHER COMPANY OR THIRD PARTY SERVICE PROVIDER NOR ANY OF THEIR AFFILIATES, ACCOUNT PROVIDERS OR ANY OF THEIR AFFILIATES WILL BE LIABLE FOR ANY HARMS, WHICH LAWYERS AND COURTS OFTEN CALL DIRECT, INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL OR EXEMPLARY DAMAGES, INCLUDING, BUT NOT LIMITED TO, DAMAGES FOR LOSS OF PROFITS, GOODWILL, USE, DATA OR OTHER INTANGIBLE LOSSES, EVEN IF COMPANY OR SERVICE PROVIDER HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES, RESULTING FROM: (i) THE USE OR THE INABILITY TO USE THE SERVICE / PLATFORM; (ii) THE COST OF GETTING SUBSTITUTE GOODS AND SERVICES, (iii) ANY PRODUCTS, DATA, INFORMATION OR SERVICES PURCHASED OR OBTAINED OR MESSAGES RECEIVED OR TRANSACTIONS ENTERED INTO, THROUGH OR FROM THE SERVICE; (iv) UNAUTHORIZED ACCESS TO OR ALTERATION OF YOUR TRANSMISSIONS OR DATA; (v) STATEMENTS OR CONDUCT OF ANYONE ON THE SERVICE; EVEN IF THE PROVIDER HAS BEEN ADVISED PREVIOUSLY OF THE POSSIBILITY OF SUCH DAMAGES; OR (vii) ANY OTHER MATTER RELATING TO THE SERVICE. THE MAXIMUM LIABILITY OF TESTDM SHALL BE LIMITED TO THE AMOUNT ACTUALLY PAID BY YOU TO THE COMPANY FOR THE SERVICE.</p><p class=\"MsoNormal\">11. INDEMNITY</p><p class=\"MsoNormal\">You agree to indemnify, save, and hold TESTDM, its affiliates, contractors, employees, officers, directors, agents and its third party associates, licensors, and partners harmless from any and all claims, demands, losses, damages, and liabilities, costs and expenses, including without limitation legal fees and expenses, arising out of or related to Your use or misuse of the Services or of the Website or App or Platform, any violation by You of these Terms &amp; Conditions, or any breach of the representations, warranties, and covenants made by You herein or Your infringement of any intellectual property or other right of any person or entity, or as a result of any threatening, libelous, obscene, harassing or offensive material posted/ transmitted by You on the Platform. TESTDM reserves the right, at Your expense, to assume the exclusive defense and control of any matter for which You are required to indemnify TESTDM, including rights to settle, and You agree to cooperate with TESTDMs’ defense and settlement of these claims. TESTDM will use reasonable efforts to notify You of any claim, action, or proceeding brought by a third party that is subject to the foregoing indemnification upon becoming aware of it. This paragraph shall survive termination of this Terms &amp; Conditions.</p><p class=\"MsoNormal\">12. ADVERTISERS/ THIRD PARTY LINKS ON THE PLATFORM</p><p class=\"MsoNormal\">TESTDM accepts no responsibility for advertisements contained within the Platform. TESTDM has no control over and accepts no responsibility for the content of any website or mobile application to which a link from the Platform exists. Such linked websites and mobile applications are provided “as is” for User’s convenience only with no warranty, express or implied, for the information provided within them. TESTDM does not provide any endorsement or recommendation of any third party website or mobile application to which the Platform provides a link. Further, the Users consent and agree that the content provided in the Website and the App shall be synced and shall be available in both mediums.</p><p class=\"MsoNormal\">13. USER COMMENTS, FEEDBACK AND OTHER SUBMISSIONS</p><p class=\"MsoNormal\">If, at TESTDM’s request, You send certain specific submissions (for example contest entries) or without a request from Us, You send creative ideas, suggestions, proposals, plans, or other materials, whether online, by email, by postal mail, or otherwise (collectively, &#x27;comments&#x27;), You agree that We may, at any time, without restriction, edit, copy, publish, distribute, translate and otherwise use in any medium any comments that You forward to Us. We are and shall be under no obligation (1) to maintain any comments in confidence; (2) to pay compensation for any comments; or (3) to respond to any comments. You agree that Your comments will not violate any right of any third-party, including copyright, trademark, privacy, personality or other personal or proprietary right. You further agree that Your comments will not contain libelous or otherwise unlawful, abusive or obscene material, or contain any computer virus or other malware that could in any way affect the operation of the Service or any related website. You may not use a false e-mail address, pretend to be someone other than Yourself, or otherwise mislead Us or third-parties as to the origin of any comments. You are solely responsible for any comments You make and their accuracy. We take no responsibility and assume no liability for any comments posted by You or any third-party. You are licensing to the Company and its service providers, any information, data, passwords, materials or other content (collectively, “Content”) You provide through or to the Service. Company and service provider of Company may use, modify, display, distribute and create new material using such Content to provide the Service to You. Company and Service Provider may also use, sell, license, reproduce, distribute and disclose aggregate, non-personally identifiable information that is derived through Your use of the Service. By submitting Content, You automatically agree, or promise that the owner of such Content has expressly agreed that, without any particular time limit, and without the payment of any fees, Company and its third party service provider may use the Content for the purposes set out above. As between Company and third party service provider, Company owns Your confidential account information.</p><p class=\"MsoNormal\">14. ACKNOWLEDGEMENTS</p><p class=\"MsoNormal\">You acknowledge that TESTDM is a platform bringing Users together and that the TESTDM is not engaged in either grant of loan or borrowing any money or assistance for any financial products from any member using the TESTDM Platform. You acknowledge that the use of the financial products is entirely based on the negotiations between the Users and third party and neither TESTDM nor its affiliates, contractors, employees, officers, directors, agents and their third party associates, licensors and partners have any interest with regard to any financial products assistance procured by or to a registered User. You acknowledge that TESTDM will not be responsible for any claim or damage in case of use of the financial products. TESTDM in no manner warrants or guarantees the performance of a third party service provider that is providing services through the App. You acknowledge that TESTDM in no manner guarantees that the Users have provided all the information on this App which is true and correct including his address, phone numbers etc. You acknowledge that it is Your responsibility to verify the information about the person on the Platform and TESTDM is in no manner liable if the information provided on this App is untrue or incorrect. You acknowledge that TESTDM is in no manner responsible for any claim of money or damages in the event one person fails to either grant loan or a person fails to repay the loan or misrepresents his financial status or commits a fraud or cheating or any other such illegal act.</p><p class=\"MsoNormal\">15. APPLICABLE LAWS</p><p class=\"MsoNormal\">Your use of this Platform and any Term &amp; Conditions stated in this agreement is subject to laws of Nigeria. In case of any disputes arising out of the use of the Website, Courts of Bangalore will have exclusive jurisdiction.</p><p class=\"MsoNormal\">17. GRIEVANCES</p><p class=\"MsoNormal\">Users have complete authority to file a complaint/ share feedback if they are disappointed by services rendered by TESTDM. They can give their complaint/ feedback in writing or by way of an email to the following:</p><p class=\"MsoNormal\">Email: service@testdn.ng</p><p class=\"MsoNormal\"> </p>', 4, 1557108489, 1610331385, NULL);

-- ----------------------------
-- Table structure for educ
-- ----------------------------
DROP TABLE IF EXISTS `educ`;
CREATE TABLE `educ`  (
  `educ_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `default_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '默认描述',
  `extra` json NULL,
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL,
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`educ_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of educ
-- ----------------------------

-- ----------------------------
-- Table structure for help_center
-- ----------------------------
DROP TABLE IF EXISTS `help_center`;
CREATE TABLE `help_center`  (
  `help_center_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `weight` int(11) NULL DEFAULT NULL COMMENT '权重',
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`help_center_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '帮助中心' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of help_center
-- ----------------------------
INSERT INTO `help_center` VALUES (7, 'What\'s testdn?', 'testdn is an Instant Personal Loan Platform for individuals. XXX acts as a technology intermediary and facilitates this Personal Loans from regulated lenders to individuals. The documentation is very minimal, and the entire process starting from registration to disbursement does not take more than 15 minutes. The application process is completely online, and on approval, the cash is immediately transferred to the bank account of the user.', 1, 1558234818, 1612754140, NULL);
INSERT INTO `help_center` VALUES (8, 'How to contact testdn?', 'You can contact us at service@testdn.ng\n', 2, 1558234876, 1605776216, NULL);
INSERT INTO `help_center` VALUES (9, 'Who can apply for a loan from testdn?', '1.Nigeria Individual\n2.18-50 years old\n3.Have a monthly source of income.', 3, 1558234891, 1605773555, NULL);
INSERT INTO `help_center` VALUES (10, 'How does testdn work?', '1.Download the testdn app from store\n2.You just have to fill some basic information\n3.Get your BVN ready\n4.Instant assesment of your application.\n5.Money will be deposited in the bank account you have provided', 4, 1558234905, 1605773618, NULL);
INSERT INTO `help_center` VALUES (11, 'Which cities are testdn currently in?', 'testdn is now only available  in Lagos and Abuja.', 27, 1558234932, 1612753312, NULL);
INSERT INTO `help_center` VALUES (12, 'What products does testdn offer？', 'A portfolio of products with different maturities and amounts.', 28, 1558234947, 1612753589, NULL);
INSERT INTO `help_center` VALUES (13, 'What is the basis for reviewing testdn?', 'Based on the basic information you submitted. Among them, we need your BVN to verify your identity.', 7, 1558234972, 1605773826, NULL);
INSERT INTO `help_center` VALUES (14, 'Why is my application not approved?', 'When we review a loan, we will review it from multiple dimensions. If your loan is not approved, this will not affect your credit. It may just be because your situation does not match our rules and credit model. If you are rejected by the review, we will let you know when you can apply again on the homepage.', 8, 1558234988, 1576752589, NULL);
INSERT INTO `help_center` VALUES (15, 'What are the documents I must submit for the loan?', 'Each user who applies for a personal loan will be required to submit three kinds of document:\na. Proof of Identity: We collect your BVN\nb. Proof of Address.\nc. Your selfie', 9, 1558235027, 1605774038, NULL);
INSERT INTO `help_center` VALUES (16, 'Why didn\'t I receive the audit result?', 'Because the review data takes a certain amount of time, the audit result will be given at the latest 1 working day. If it exceeds 1 working day, please contact customer service in time: service@testdn.ng', 10, 1558235044, 1605776228, NULL);
INSERT INTO `help_center` VALUES (17, 'Why is my bank account not verified?', 'Please confirm that your bank account number is yours. Please confirm that your bank account are not filled in incorrectly. Make sure your account is a savings account and not a fixed asset account, credit account or virtual account.', 11, 1558235066, 1605774193, NULL);
INSERT INTO `help_center` VALUES (18, 'Why should I e-sign the Loan Agreement?', 'The Loan Agreement is a legally binding agreement that you need to sign before availing a Loan. The agreement states that once a loan is disbursed to you, you are liable to pay back the entire amount with interest and other charges as applicable within the maturity of the Loan.', 12, 1558235079, 1576752640, NULL);
INSERT INTO `help_center` VALUES (19, 'How will I receive the loan?', 'When you fill out your personal information, we will ask you to provide your bank account and we will verify your account. After you sign the agreement, we will directly transfer the money into your bank account.', 13, 1558235092, 1576752649, NULL);
INSERT INTO `help_center` VALUES (20, 'Why didn\'t I receive the loan?', 'Your account may be incorrect. Please re-verify.\nIf the account is correct, the loan delay is no more than 1 working day. If you have not received the payment after more than one working day, this may be due to the banking system. Please contact us at: service@testdn.ng', 14, 1576752661, 1605776239, NULL);
INSERT INTO `help_center` VALUES (21, 'I did not receive the loan on time, will the repayment date be recalculated?', 'We will start to calculate interest when the money is successfully transferred.', 15, 1576752671, 1576752671, NULL);
INSERT INTO `help_center` VALUES (22, 'What is the amount of my repayment?', 'You can see your due amount on the app homepage and we will also notify you the repayment amount by sms.', 16, 1576752681, 1576752681, NULL);
INSERT INTO `help_center` VALUES (23, 'When do I need to repay?', 'You can log in to the app to see your repayment date.', 17, 1576752693, 1576752693, NULL);
INSERT INTO `help_center` VALUES (24, 'What happens if I don\'t pay back on time?', 'We will charge a 3.5% penalty fee per day. Your Credit score will be updated as a defaulter with credit rating agencies which will make it difficult for you to take loans with any bank or financial institution in the future. Companies also check an individual\'s credit score and may not offer you employment if your credit score is bad.', 18, 1576752706, 1605775144, NULL);
INSERT INTO `help_center` VALUES (25, 'Can I repay in advance?', 'You can pay back in advance at any time. No prepayment fee.', 19, 1576752719, 1576752719, NULL);
INSERT INTO `help_center` VALUES (26, 'Have difficulties to repay on time?', 'If you have difficulties to repay on time, you can contact our customer service to apply for an extension or you can pay partially', 20, 1576752730, 1612752936, NULL);
INSERT INTO `help_center` VALUES (27, 'Can I extend the loan period?', 'Yes, you can contact our customer service and apply for loan extend service authorization.', 21, 1576752740, 1605773324, NULL);
INSERT INTO `help_center` VALUES (28, 'How can I confirm that I have repaid successfully?', 'When you pay off, we will notify you by text message. At the same time, log in to the app to see the records you have repaid.', 22, 1576752752, 1576752752, NULL);
INSERT INTO `help_center` VALUES (29, 'When I borrow again, do I still need to fill in my personal information?', 'You do not need to submit your information again, but if your information changes, please update your information in My Profile on app in time or contact customer service to change. In this regard, we will re-review.', 23, 1576752764, 1576752764, NULL);
INSERT INTO `help_center` VALUES (30, 'I can not receive the verification code for registration or login.', 'Please make sure your mobile phone number is correct. If you still can\'t receive the verification code, your phone number might be on the DND list, please contact the phone service provider or try the following methods.\n\nText START to 2442 on your ETISALAT number that has stopped receiving Bulk SMS.\nText ALLOW to 2442 on your MTN number that has stopped receiving Bulk SMS.\nText CANCEL to 2442 on your GLO number that has stopped receiving Bulk SMS.\nText ALLOW to 2442 on your AIRTEL number that has stopped receiving Bulk SMS.', 24, 1576752775, 1605777396, NULL);
INSERT INTO `help_center` VALUES (31, 'Why can\'t I apply for a higher amount?', 'You need to apply from the most basic products. According to your credit and repayment records, your credit will gradually accumulate and the amount will gradually increase.', 25, 1576752785, 1576752785, NULL);
INSERT INTO `help_center` VALUES (32, 'Can I cancel my loan?', 'Once the loan application has been submitted, the loan can\'t be cancelled.', 26, 1576752794, 1576752794, NULL);
INSERT INTO `help_center` VALUES (33, 'Why am I not able to receive OTP SMS?', 'Mostly because your current phone service provider has turned on the DND mode for your number. You may contact your phone service provider to turn off the DND mode or click on the Voice OTP inside the testdn and be aware of the incoming call.', 5, 1612753276, 1612753321, NULL);
INSERT INTO `help_center` VALUES (34, 'I don\'t know my BVN. What do I do?', 'To find out your BVN you can dial *565*0#. Please note that this will only work if you are making the request from the same phone number that is currently linked to your bank account.', 6, 1612753573, 1612753579, NULL);
INSERT INTO `help_center` VALUES (35, 'Why do you need permission to my mobile device?', 'testdn uses data from your mobile device, including (but not limited to) location, contacts and notifications to provide you with the best possible loan offer. It\'s an important part of our evaluation process and allows us to provide you with loans most suitable for you.', 29, 1612753658, 1612753658, NULL);
INSERT INTO `help_center` VALUES (36, 'Why was my loan application rejected?', 'There are a few reasons behind loan application rejections. The most likely reason is that our system did not receive sufficient data to score your application. Please ensure you are signed into testdn using your main mobile device, and also keep your data on while using the app in order for us to determine the best possible loan offer for you.\n\nAnother possible reason is that you may not have shared all of the information required in the application or provided invalid details.\n\nHowever, there can be other reasons. As a responsible lender, we take steps to ensure we only extend credit to applicants who can afford it, so that our clients won\'t become too indebted. It is possible that at this time, you don\'t match the profile of individual we normally lend money to.\n\nNegative repayment patterns on previous obligations (including testdn loans) can also limit access to credit, or make it more expensive to obtain.\n\nWhatever the situation, we recommend keeping the app installed and retrying in 1-2 months, as the criteria of these decisions are constantly refined.', 30, 1612753687, 1612753687, NULL);

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2016_01_04_173148_create_admin_tables', 1);
INSERT INTO `migrations` VALUES (2, '2020_09_07_090635_create_admin_settings_table', 1);
INSERT INTO `migrations` VALUES (3, '2020_09_22_015815_create_admin_extensions_table', 1);
INSERT INTO `migrations` VALUES (4, '2020_11_01_083237_update_admin_menu_table', 1);

-- ----------------------------
-- Table structure for order_amount_change_log
-- ----------------------------
DROP TABLE IF EXISTS `order_amount_change_log`;
CREATE TABLE `order_amount_change_log`  (
  `order_log_id` int(11) NOT NULL,
  `order_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '订单id',
  `type` tinyint(2) NULL DEFAULT NULL COMMENT '1-减免罚息，2-核销 3-平帐 4-减免服务费 5-减免利息 6-减免本金 7-减免违约金',
  `amount` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '变动金额*100',
  `admin_id` int(11) NULL DEFAULT 0 COMMENT '操作人',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` int(11) UNSIGNED NULL DEFAULT 0,
  `update_time` int(10) UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`order_log_id`) USING BTREE,
  INDEX `idx_order_id`(`order_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_amount_change_log
-- ----------------------------

-- ----------------------------
-- Table structure for order_assignments
-- ----------------------------
DROP TABLE IF EXISTS `order_assignments`;
CREATE TABLE `order_assignments`  (
  `assign_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` int(10) UNSIGNED NULL DEFAULT 0,
  `audit_admin_id` int(10) UNSIGNED NULL DEFAULT 0,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` tinyint(255) UNSIGNED NULL DEFAULT 0 COMMENT '0-待审核，1-审核通过，2-审核拒绝',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`assign_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_assignments
-- ----------------------------

-- ----------------------------
-- Table structure for order_decrease_apply
-- ----------------------------
DROP TABLE IF EXISTS `order_decrease_apply`;
CREATE TABLE `order_decrease_apply`  (
  `apply_id` int(11) NOT NULL,
  `order_id` int(11) NULL DEFAULT NULL COMMENT '订单ID',
  `admin_id` int(255) UNSIGNED NULL DEFAULT NULL COMMENT '审核人员ID',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '1 待审核 2-审核通过 3-审核拒绝',
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `amount` int(255) UNSIGNED NULL DEFAULT NULL COMMENT '减免总额',
  `extra` json NULL COMMENT '额外信息 JSON',
  `create_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`apply_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户减免申请' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_decrease_apply
-- ----------------------------

-- ----------------------------
-- Table structure for order_loan_logs
-- ----------------------------
DROP TABLE IF EXISTS `order_loan_logs`;
CREATE TABLE `order_loan_logs`  (
  `loan_log_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `loan_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '放款id',
  `loan_amount` int(255) UNSIGNED NULL DEFAULT 0 COMMENT '放款金额，*100',
  `borrow_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '订单id',
  `outer_sn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '第三方订单号',
  `pay_sn` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '放款单号',
  `return_code` tinyint(255) UNSIGNED NULL DEFAULT 0 COMMENT '0-待处理，10-同步处理成功，20-同步处理失败',
  `callback_code` tinyint(255) UNSIGNED NULL DEFAULT 0 COMMENT '异步状态码',
  `extra` json NULL COMMENT '其它信息',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`loan_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_loan_logs
-- ----------------------------

-- ----------------------------
-- Table structure for order_loans
-- ----------------------------
DROP TABLE IF EXISTS `order_loans`;
CREATE TABLE `order_loans`  (
  `loan_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `borrow_id` int(11) NULL DEFAULT NULL COMMENT '订单id',
  `payment_channle` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '放款渠道',
  `loan_time` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '放款时间',
  `currency` tinyint(255) NULL DEFAULT 1 COMMENT '币种 1-人名币',
  `status` tinyint(4) NULL DEFAULT 0 COMMENT '0-放款中，10-放款成功，20-放款失败',
  `loan_account_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '放款客户名',
  `loan_bank_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '银行卡号名',
  `loan_account_number` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '放款银行卡号',
  `loan_bank_code` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '放款银行code',
  `create_time` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`loan_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_loans
-- ----------------------------

-- ----------------------------
-- Table structure for order_repay_log
-- ----------------------------
DROP TABLE IF EXISTS `order_repay_log`;
CREATE TABLE `order_repay_log`  (
  `repay_log_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `borrow_id` int(11) NULL DEFAULT NULL COMMENT '订单id',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `outer_sn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '第三方订单号',
  `pay_sn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '支付单号',
  `repay_type` tinyint(255) NULL DEFAULT NULL COMMENT '还款类型，1-偿还本金，2-展期',
  `repay_amount` int(11) NULL DEFAULT NULL COMMENT '支付金额',
  `payment_channel` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '第三方支付方式',
  `payment_method` tinyint(30) UNSIGNED NULL DEFAULT 1 COMMENT '支付通道，1-va,2-card,3-ussd',
  `repay_borrow_amount` int(255) NULL DEFAULT NULL COMMENT '还款本金',
  `repay_fee_amount` int(255) NULL DEFAULT NULL COMMENT '还款利息',
  `remain_borrow_amount` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '剩余本金',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`repay_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_repay_log
-- ----------------------------

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `order_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '用户id',
  `product_id` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '贷款产品ID',
  `sn` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '订单编号',
  `borrow_amount` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '借款金额，*100 名义贷款',
  `need_repay_amount` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '应还总额 * 100',
  `interest_amount` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '利息*100',
  `decrease_amount` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '减免金额*100',
  `repay_amount` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '还款金额，已还金额总和*100',
  `loan_amount` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '放款金额',
  `break_amount` int(11) NULL DEFAULT 0 COMMENT '违约金',
  `extend_amount` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '展期费',
  `faxi` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '罚息',
  `borrow_count` int(10) UNSIGNED NULL DEFAULT 1 COMMENT '第几次借款',
  `service_fee` int(255) NULL DEFAULT NULL COMMENT '服务费用',
  `status` tinyint(11) UNSIGNED NULL DEFAULT 0 COMMENT '订单状态',
  `create_time` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '更新时间',
  `delete_time` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '删除时间',
  `settle_time` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '结清时间',
  `loan_time` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '放款时间',
  `extend_time` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '展期时间',
  `expect_repay_time` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '到期时间',
  `channel` tinyint(1) NULL DEFAULT NULL COMMENT '渠道',
  `last_status` tinyint(11) UNSIGNED NULL DEFAULT 0 COMMENT '订单上一次状态',
  `extra` json NULL COMMENT '额外信息',
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE,
  INDEX `idx_sn`(`sn`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 1, NULL, 'BVN23123123123S', 10000, 10000, NULL, 0, 0, 9500, 0, 0, 0, 1, NULL, 40, 1650865580, 1650865580, 0, 0, 1650866580, NULL, 1651506558, 1, 0, '{\"product\": {\"name\": \"1\", \"rate\": 2, \"type\": 3, \"status\": 0, \"faxi_rate\": 2, \"is_default\": 1, \"product_id\": 1, \"create_time\": 0, \"delete_time\": 0, \"extend_rate\": 2, \"service_fee\": 2, \"update_time\": 1651215131, \"borrow_period_days\": 7, \"need_settle_number\": 1}}');

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment`  (
  `payment_id` int(11) NOT NULL,
  `channel` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '通道， paystack,monnify',
  `repay_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '还款类型，放款类型此字段为空 VA,CARD,USSD',
  `type` tinyint(255) NULL DEFAULT NULL COMMENT '类型，1-放款， 2-还款',
  PRIMARY KEY (`payment_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of payment
-- ----------------------------

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `product_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '产品名称',
  `borrow_period_days` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '贷款周期',
  `rate` int(11) UNSIGNED NULL DEFAULT 1 COMMENT '利率*100',
  `extend_rate` int(11) UNSIGNED NULL DEFAULT 1 COMMENT '展期利率*100',
  `faxi_rate` int(11) UNSIGNED NULL DEFAULT 1 COMMENT '罚息利率*100',
  `service_fee` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '服务费*100',
  `type` tinyint(2) UNSIGNED NULL DEFAULT 1 COMMENT '付费方式 1-先收取利息和服务费 2-先收取服务费 3-到期收取',
  `need_settle_number` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '需要结清天数',
  `is_default` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '是否默认  0-否 1-是',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '状态 1-启用 0 禁用',
  `create_time` int(11) UNSIGNED NULL DEFAULT 0,
  `update_time` int(11) UNSIGNED NULL DEFAULT 0,
  `delete_time` int(11) UNSIGNED NULL DEFAULT 1,
  PRIMARY KEY (`product_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, '1', 0, 2, 2, 2, 2, 3, 1, 1, 0, 0, 1651219560, 1651219560);
INSERT INTO `products` VALUES (2, 'test_product', 9, 2, 1, 1, 1, 3, 1, 1, 0, 0, 1651219582, 0);
INSERT INTO `products` VALUES (3, 'Saas后台管理系统', 2, 1, 1, 1, 1, 3, 1, 1, 0, 1651215121, 1651215121, 0);

-- ----------------------------
-- Table structure for profeesion
-- ----------------------------
DROP TABLE IF EXISTS `profeesion`;
CREATE TABLE `profeesion`  (
  `profession_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `defalut_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '默认名称',
  `pid` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '父类ID',
  `extra` json NULL,
  `create_time` int(11) UNSIGNED NULL DEFAULT 0,
  `update_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`profession_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of profeesion
-- ----------------------------

-- ----------------------------
-- Table structure for salary
-- ----------------------------
DROP TABLE IF EXISTS `salary`;
CREATE TABLE `salary`  (
  `salary_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `default_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '默认描述',
  `extra` json NULL,
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL,
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`salary_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of salary
-- ----------------------------

-- ----------------------------
-- Table structure for statistics_assets_age
-- ----------------------------
DROP TABLE IF EXISTS `statistics_assets_age`;
CREATE TABLE `statistics_assets_age`  (
  `assets_age_id` int(11) NOT NULL AUTO_INCREMENT,
  `analysis_date` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日期',
  `current_pending_assets` int(11) NULL DEFAULT 0,
  `current_pending_number` int(11) NULL DEFAULT 0 COMMENT '未到期笔数',
  `current_overdue_1_7_days_assets` int(11) NULL DEFAULT 0 COMMENT '逾期1-7天资产',
  `current_overdue_1_7_days_number` int(11) NULL DEFAULT 0 COMMENT '逾期1-7天笔数',
  `current_overdue_8_14_days_assets` int(11) NULL DEFAULT 0 COMMENT '逾期8-14资产',
  `current_overdue_8_14_days_number` int(11) NULL DEFAULT 0 COMMENT '逾期8-14笔数',
  `current_overdue_15_30_days_assets` int(11) NULL DEFAULT 0 COMMENT '逾期15-30天资产',
  `current_overdue_15_30_days_number` int(11) NULL DEFAULT 0 COMMENT '逾期15-30天笔数',
  `current_overdue_30_days_assets` int(11) NULL DEFAULT 0 COMMENT '逾期30+资产',
  `current_overdue_30_days_number` int(11) NULL DEFAULT 0 COMMENT '逾期30+笔数',
  `total_colletion_pending_assets` int(11) NULL DEFAULT 0 COMMENT '待收总资产',
  `total_colletion_pending_number` int(11) NULL DEFAULT 0 COMMENT '待收总笔数',
  `current_overdue_0_days_assets` int(11) NULL DEFAULT 0 COMMENT '当日资产',
  `current_overdue_0_days_number` int(11) NULL DEFAULT 0 COMMENT '当日笔数',
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`assets_age_id`) USING BTREE,
  UNIQUE INDEX `idx_analysis_date`(`analysis_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '资产账龄统计' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of statistics_assets_age
-- ----------------------------

-- ----------------------------
-- Table structure for statistics_daily_cashflow
-- ----------------------------
DROP TABLE IF EXISTS `statistics_daily_cashflow`;
CREATE TABLE `statistics_daily_cashflow`  (
  `daily_cashflow_id` int(11) NOT NULL AUTO_INCREMENT,
  `analysis_date` date NULL DEFAULT NULL COMMENT '日期',
  `truely_loan_amount` int(10) UNSIGNED NULL DEFAULT 0,
  `truely_repay_principal` int(10) UNSIGNED NULL DEFAULT 0,
  `truely_repay_service_fee` int(10) UNSIGNED NULL DEFAULT 0,
  `truely_repay_interest` int(10) UNSIGNED NULL DEFAULT 0,
  `truely_repay_default_fee` int(10) UNSIGNED NULL DEFAULT 0,
  `truely_repay_penalty_fee` int(10) UNSIGNED NULL DEFAULT 0,
  `truely_repay_extended_fee` int(10) NULL DEFAULT 0,
  `truely_repay_total_amount` int(10) NULL DEFAULT NULL,
  `daily_net_income` int(10) NULL DEFAULT 0,
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`daily_cashflow_id`) USING BTREE,
  UNIQUE INDEX `idx_analysis_date`(`analysis_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日流水分析' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of statistics_daily_cashflow
-- ----------------------------

-- ----------------------------
-- Table structure for statistics_daily_ledger
-- ----------------------------
DROP TABLE IF EXISTS `statistics_daily_ledger`;
CREATE TABLE `statistics_daily_ledger`  (
  `daily_ledger_id` int(11) NOT NULL AUTO_INCREMENT,
  `analysis_date` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日期',
  `times_of_loan` int(11) NULL DEFAULT 0,
  `total_loan_amount` int(11) NULL DEFAULT 0,
  `disburse_amount` int(11) NULL DEFAULT 0,
  `number_of_settled_on_due_day` int(11) NULL DEFAULT 0,
  `settled_amount_on_due_day` int(11) NULL DEFAULT 0,
  `number_of_repay_on_due_day` int(11) NULL DEFAULT 0,
  `repay_amount_on_due_day` int(11) NULL DEFAULT 0,
  `number_of_settled_today` int(11) NULL DEFAULT 0,
  `number_of_partial_repay_today` int(11) NULL DEFAULT 0,
  `number_of_extension_today` int(11) NULL DEFAULT 0,
  `total_amount_today` int(11) NULL DEFAULT 0,
  `truely_repay_principal` int(11) NULL DEFAULT 0 COMMENT '收本金',
  `truely_repay_service_fee` int(11) NULL DEFAULT 0 COMMENT '后收服务费',
  `truely_repay_interest` int(11) NULL DEFAULT 0 COMMENT '后收利息',
  `truely_repay_default_fee` int(11) NULL DEFAULT 0 COMMENT '收违约金',
  `truely_repay_penalty_fee` int(11) NULL DEFAULT 0 COMMENT '收罚息',
  `truely_repay_extended_fee` int(11) NULL DEFAULT 0 COMMENT '收展期费',
  `truely_repay_total_amount` int(11) NULL DEFAULT 0 COMMENT '实收总额',
  `daily_net_income` int(11) NULL DEFAULT 0 COMMENT '资金净流入',
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`daily_ledger_id`) USING BTREE,
  UNIQUE INDEX `idx_analysis_date`(`analysis_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '台账日报分析' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of statistics_daily_ledger
-- ----------------------------

-- ----------------------------
-- Table structure for statistics_daily_pl
-- ----------------------------
DROP TABLE IF EXISTS `statistics_daily_pl`;
CREATE TABLE `statistics_daily_pl`  (
  `daily_cashflow_id` int(11) NOT NULL AUTO_INCREMENT,
  `analysis_date` date NULL DEFAULT NULL COMMENT '日期',
  `loan_count` int(11) NULL DEFAULT 0 COMMENT '放款单量',
  `borrow_amount` int(11) NULL DEFAULT 0,
  `truely_loan_amount` int(11) NULL DEFAULT 0,
  `truely_repay_principal` int(11) NULL DEFAULT 0,
  `truely_repay_service_fee` int(11) NULL DEFAULT 0,
  `truely_repay_interest` int(11) NULL DEFAULT 0,
  `truely_repay_default_fee` int(11) NULL DEFAULT 0,
  `truely_repay_penalty_fee` int(11) NULL DEFAULT 0,
  `truely_repay_extended_fee` int(11) NULL DEFAULT 0,
  `truely_repay_total_amount` int(11) NULL DEFAULT 0,
  `disburse_daily_pl` int(11) NULL DEFAULT 0,
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`daily_cashflow_id`) USING BTREE,
  UNIQUE INDEX `idx_analysis_date`(`analysis_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日损益分析' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of statistics_daily_pl
-- ----------------------------

-- ----------------------------
-- Table structure for statistics_operation_data
-- ----------------------------
DROP TABLE IF EXISTS `statistics_operation_data`;
CREATE TABLE `statistics_operation_data`  (
  `operation_data_id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` int(11) NULL DEFAULT NULL COMMENT '渠道ID',
  `channel_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '渠道名称',
  `analysis_date` date NULL DEFAULT NULL COMMENT '日期',
  `installation_number` int(11) NULL DEFAULT 0 COMMENT '安装数',
  `registered` int(11) NULL DEFAULT 0 COMMENT '注册数',
  `authentication_completed` int(11) NULL DEFAULT 0 COMMENT '认证完成数',
  `bound_card` int(11) NULL DEFAULT 0 COMMENT '绑卡数',
  `applications` int(11) NULL DEFAULT 0 COMMENT '申贷数',
  `approved` int(11) NULL DEFAULT 0 COMMENT '机审通过',
  `loan_disbursed` int(11) NULL DEFAULT 0 COMMENT '放款数',
  `firstloan_apply_nums` int(11) NULL DEFAULT 0 COMMENT '首贷申请数',
  `firstloan_loan_nums` int(11) NULL DEFAULT 0 COMMENT '首贷放款数',
  `firstloan_sign` int(11) NULL DEFAULT 0 COMMENT '首贷签约数',
  `firstloan_approved` int(11) NULL DEFAULT 0 COMMENT '首贷机审通过',
  `firstloan_human` int(11) NULL DEFAULT 0 COMMENT '首贷人审',
  `firstloan_approved_rate` int(11) NULL DEFAULT 0 COMMENT '首贷机审通过率',
  `firstloan_rate` int(11) NULL DEFAULT 0 COMMENT '首贷转化率',
  `reloan_apply_nums` int(11) NULL DEFAULT 0 COMMENT '复贷申请数',
  `reloan_loan_nums` int(11) NULL DEFAULT 0 COMMENT '复贷放款数',
  `reloan_sign` int(11) NULL DEFAULT 0 COMMENT '复贷签约',
  `reloan_human` int(11) NOT NULL DEFAULT 0 COMMENT '复贷人审通过 ',
  `reloan_approved` int(11) NULL DEFAULT 0 COMMENT '复贷机审通过',
  `reloan_approved_rate` int(11) NULL DEFAULT 0 COMMENT '复贷机审通过率',
  `reloan_rate` int(11) NULL DEFAULT 0 COMMENT '复贷转化率',
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`operation_data_id`) USING BTREE,
  UNIQUE INDEX `idx_analysis_date`(`analysis_date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '运营数据日报' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of statistics_operation_data
-- ----------------------------

-- ----------------------------
-- Table structure for user_app_list
-- ----------------------------
DROP TABLE IF EXISTS `user_app_list`;
CREATE TABLE `user_app_list`  (
  `app_list_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `app_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `package` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `create_time` int(11) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`app_list_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_app_list
-- ----------------------------

-- ----------------------------
-- Table structure for user_contacts
-- ----------------------------
DROP TABLE IF EXISTS `user_contacts`;
CREATE TABLE `user_contacts`  (
  `contact_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NULL DEFAULT 0,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `phone` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '',
  `create_time` int(10) UNSIGNED NULL DEFAULT 0,
  `update_time` int(10) UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`contact_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_contacts
-- ----------------------------
INSERT INTO `user_contacts` VALUES (1, 1, 'sadas', '1213123123', 0, 0);

-- ----------------------------
-- Table structure for user_counts
-- ----------------------------
DROP TABLE IF EXISTS `user_counts`;
CREATE TABLE `user_counts`  (
  `user_count_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `create_time` int(10) UNSIGNED NULL DEFAULT 0,
  `update_time` int(10) UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`user_count_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_counts
-- ----------------------------

-- ----------------------------
-- Table structure for user_credit_change_log
-- ----------------------------
DROP TABLE IF EXISTS `user_credit_change_log`;
CREATE TABLE `user_credit_change_log`  (
  `user_credit_change_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户ID',
  `amount` int(255) NULL DEFAULT 0 COMMENT '变动额度 <0减额 >0 提额',
  `after_amount` int(255) NULL DEFAULT NULL COMMENT '变动之后额度',
  `type` tinyint(255) NULL DEFAULT NULL COMMENT '1-自动 2-人工',
  `create_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`user_credit_change_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户额度变更记录' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of user_credit_change_log
-- ----------------------------

-- ----------------------------
-- Table structure for user_extends
-- ----------------------------
DROP TABLE IF EXISTS `user_extends`;
CREATE TABLE `user_extends`  (
  `user_extend_id` int(11) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户ID',
  `from` tinyint(2) NULL DEFAULT NULL COMMENT '注册设备类型,1-web 2-android 3-ios',
  `unique` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '设备唯一标识',
  `ip` int(255) NULL DEFAULT NULL COMMENT '注册ip',
  `lat` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '纬度',
  `lng` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '经度',
  `os_version` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '系统版本',
  `birth_day` date NULL DEFAULT NULL,
  `gender` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '性别,0-未知 1-男 2-女',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `marriage_status` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '婚姻状态 1-已婚 2-未婚',
  `unique_number` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '唯一身份标识,身份证，驾照',
  `card_front_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '身份证正面图片',
  `card_backend_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '身份证反面图片路径',
  `address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '居住地址',
  `prov_id` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '省ID',
  `city_id` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '市ID',
  `area_id` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '区ID',
  `educ_id` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '学历',
  `profession_id` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '职业ID',
  `employer_name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '雇佣者全名',
  `salary_id` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '薪资水平',
  PRIMARY KEY (`user_extend_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_extends
-- ----------------------------

-- ----------------------------
-- Table structure for user_increase_coupons
-- ----------------------------
DROP TABLE IF EXISTS `user_increase_coupons`;
CREATE TABLE `user_increase_coupons`  (
  `coupon_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户ID',
  `amount` int(255) UNSIGNED NULL DEFAULT NULL COMMENT '提额额度',
  `from` tinyint(255) UNSIGNED NULL DEFAULT 1 COMMENT '来源，1-系统发放，2-邀请用户，3-购买',
  `is_use` tinyint(255) UNSIGNED NULL DEFAULT 0 COMMENT '是否使用，0-未使用 1-使用',
  `relation_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '关联ID',
  `expire_time` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '过期时间',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`coupon_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户提额券' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of user_increase_coupons
-- ----------------------------

-- ----------------------------
-- Table structure for user_login_history
-- ----------------------------
DROP TABLE IF EXISTS `user_login_history`;
CREATE TABLE `user_login_history`  (
  `user_login_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '用户id',
  `from` tinyint(2) NULL DEFAULT NULL COMMENT '登录来源,1-web 2-android 3-ios',
  `version` char(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户客户端版本',
  `os` char(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '系统制造商',
  `login_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '登录类型',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`user_login_id`) USING BTREE,
  INDEX `idx_user_from`(`user_id`, `from`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_login_history
-- ----------------------------

-- ----------------------------
-- Table structure for user_sms_log
-- ----------------------------
DROP TABLE IF EXISTS `user_sms_log`;
CREATE TABLE `user_sms_log`  (
  `sms_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '用户ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '对方名称',
  `phone` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '对方号码',
  `time` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '短信收发时间',
  `content` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '短信内容',
  `content_md5` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '短信名称+content的MD5值',
  `type` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '短信类型,1-发送 2-接受',
  `create_time` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`sms_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_sms_log
-- ----------------------------
INSERT INTO `user_sms_log` VALUES (1, 1, 'HELLO', '13546788767', 16457812, '12312312312312', '12132', 1, 0, 0);

-- ----------------------------
-- Table structure for user_va_account
-- ----------------------------
DROP TABLE IF EXISTS `user_va_account`;
CREATE TABLE `user_va_account`  (
  `va_account_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '用户ID',
  `reference` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `channel` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '渠道',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '状态',
  `account_number` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'va账号',
  `account_bank` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'va银行',
  `extra` json NULL COMMENT '其它信息，返回参数信息',
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`va_account_id`) USING BTREE,
  UNIQUE INDEX `idx_user_channel_status`(`user_id`, `channel`, `status`) USING BTREE,
  INDEX `idx_reference`(`reference`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_va_account
-- ----------------------------

-- ----------------------------
-- Table structure for user_verify
-- ----------------------------
DROP TABLE IF EXISTS `user_verify`;
CREATE TABLE `user_verify`  (
  `user_verify_id` int(11) NOT NULL,
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `middle_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `birth_date` date NULL DEFAULT NULL,
  `gender` tinyint(255) NULL DEFAULT NULL,
  `martial_status` tinyint(255) NULL DEFAULT NULL,
  `number_of_children` tinyint(4) NULL DEFAULT NULL,
  `family_contact_id` int(10) UNSIGNED NULL DEFAULT 0,
  `other_contact_id` int(10) UNSIGNED NULL DEFAULT 0,
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `educ_id` int(11) NULL DEFAULT NULL,
  `employment_status_id` int(11) NULL DEFAULT NULL,
  `employer_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `employer_period` int(255) UNSIGNED NULL DEFAULT 0,
  `salary` int(10) NULL DEFAULT NULL,
  `payDay` tinyint(1) UNSIGNED NULL DEFAULT 0,
  `id_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bank_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bank_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bank_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `face_live_verify` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_verify_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_verify
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `real_full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户姓名',
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名字首',
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名字尾',
  `middle_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名字中',
  `phone` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机号码',
  `passwd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户登录密码',
  `salt` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户登录盐值',
  `email` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户邮箱',
  `invite_user_id` int(11) NULL DEFAULT NULL COMMENT '邀请用户ID\r\n邀请人',
  `gender` tinyint(255) NULL DEFAULT NULL COMMENT '性别 0-未知 1-男 2-女',
  `birth_day` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '出生年月',
  `from` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户来源 注册设备类型,1-web 2-android 3-ios',
  `last_login_time` int(11) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '最近登录时间',
  `last_login_type` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户最近登录类型',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '注册时间',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '禁用时间',
  `current_verify_step` tinyint(255) NULL DEFAULT 1 COMMENT '当前认证第几部默认为1',
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `idx_phone`(`phone`) USING BTREE,
  INDEX `idx_full_name`(`real_full_name`) USING BTREE,
  INDEX `idx_create_time`(`create_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'lan yu guo', 'lan', 'guo', 'yu', '15198276178', '123123123', '1234', '14423123@qq.com', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for white
-- ----------------------------
DROP TABLE IF EXISTS `white`;
CREATE TABLE `white`  (
  `white_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(255) UNSIGNED NULL DEFAULT 0 COMMENT '用户ID,',
  `first_name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户姓名',
  `last_name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户姓名尾部',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机号码',
  `id_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '个人身份唯一标识',
  `credit_amount` bigint(255) UNSIGNED NULL DEFAULT 0 COMMENT '初始授信额度',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL,
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL,
  `delete_time` int(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`white_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of white
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
