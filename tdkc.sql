/*
MySQL Data Transfer
Source Host: localhost
Source Database: tdkc
Target Host: localhost
Target Database: tdkc
Date: 2014/4/4 ������ 16:29:54
*/



SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for ci_sessions
-- ----------------------------
CREATE TABLE `ci_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `last_activity_idx` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_attachment
-- ----------------------------
CREATE TABLE `tb_attachment` (
  `aid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file_name` varchar(200) NOT NULL DEFAULT '',
  `file_size` int(11) NOT NULL DEFAULT '0' COMMENT '字节数',
  `file_suffix` varchar(10) NOT NULL,
  `path_name` varchar(100) NOT NULL,
  `width` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '度宽, 图片、视频',
  `height` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '高度',
  `play_sec` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '播放时间, 视频',
  `refcount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '应用计数',
  `createtime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updatetime` datetime NOT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_contacts
-- ----------------------------
CREATE TABLE `tb_contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT 'url地址',
  `type` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '0 内部通讯录，1 外部通讯路',
  `mobile` varchar(15) NOT NULL DEFAULT '',
  `tel` varchar(20) NOT NULL,
  `fax` varchar(15) NOT NULL,
  `address` varchar(150) NOT NULL DEFAULT '',
  `status` varchar(10) NOT NULL DEFAULT '正常',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_create` (`createtime`),
  KEY `idx_name` (`name`),
  KEY `idx_type` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_dept
-- ----------------------------
CREATE TABLE `tb_dept` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '门部名称',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级机构ID',
  `status` varchar(10) NOT NULL DEFAULT '正常',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_menu
-- ----------------------------
CREATE TABLE `tb_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `auth_key` varchar(32) NOT NULL,
  `name` varchar(30) NOT NULL,
  `url` varchar(50) NOT NULL DEFAULT '' COMMENT 'url地址',
  `pid` int(10) unsigned NOT NULL DEFAULT '0',
  `displayorder` int(11) NOT NULL DEFAULT '0',
  `status` varchar(10) NOT NULL DEFAULT '正常',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_auth_key` (`auth_key`),
  KEY `idx_url` (`url`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_pm_0
-- ----------------------------
CREATE TABLE `tb_pm_0` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` int(10) unsigned NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL DEFAULT '' COMMENT 'url地址',
  `content` text NOT NULL,
  `attachment` varchar(100) NOT NULL DEFAULT '',
  `displayorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` varchar(10) NOT NULL DEFAULT '' COMMENT '已发 , 已收',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_pm_1
-- ----------------------------
CREATE TABLE `tb_pm_1` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` int(10) unsigned NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL DEFAULT '' COMMENT 'url地址',
  `content` text NOT NULL,
  `attachment` varchar(100) NOT NULL DEFAULT '',
  `displayorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` varchar(10) NOT NULL DEFAULT '' COMMENT '已发 , 已收',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_pm_2
-- ----------------------------
CREATE TABLE `tb_pm_2` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` int(10) unsigned NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL DEFAULT '' COMMENT 'url地址',
  `content` text NOT NULL,
  `attachment` varchar(100) NOT NULL DEFAULT '',
  `displayorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` varchar(10) NOT NULL DEFAULT '' COMMENT '已发 , 已收',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_pm_3
-- ----------------------------
CREATE TABLE `tb_pm_3` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` int(10) unsigned NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL DEFAULT '' COMMENT 'url地址',
  `content` text NOT NULL,
  `attachment` varchar(100) NOT NULL DEFAULT '',
  `displayorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` varchar(10) NOT NULL DEFAULT '' COMMENT '已发 , 已收',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_pm_4
-- ----------------------------
CREATE TABLE `tb_pm_4` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` int(10) unsigned NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL DEFAULT '' COMMENT 'url地址',
  `content` text NOT NULL,
  `attachment` varchar(100) NOT NULL DEFAULT '',
  `displayorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` varchar(10) NOT NULL DEFAULT '' COMMENT '已发 , 已收',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_pm_5
-- ----------------------------
CREATE TABLE `tb_pm_5` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` int(10) unsigned NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL DEFAULT '' COMMENT 'url地址',
  `content` text NOT NULL,
  `attachment` varchar(100) NOT NULL DEFAULT '',
  `displayorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` varchar(10) NOT NULL DEFAULT '' COMMENT '已发 , 已收',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_pm_6
-- ----------------------------
CREATE TABLE `tb_pm_6` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` int(10) unsigned NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL DEFAULT '' COMMENT 'url地址',
  `content` text NOT NULL,
  `attachment` varchar(100) NOT NULL DEFAULT '',
  `displayorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` varchar(10) NOT NULL DEFAULT '' COMMENT '已发 , 已收',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_pm_7
-- ----------------------------
CREATE TABLE `tb_pm_7` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` int(10) unsigned NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL DEFAULT '' COMMENT 'url地址',
  `content` text NOT NULL,
  `attachment` varchar(100) NOT NULL DEFAULT '',
  `displayorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` varchar(10) NOT NULL DEFAULT '' COMMENT '已发 , 已收',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_pm_8
-- ----------------------------
CREATE TABLE `tb_pm_8` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` int(10) unsigned NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL DEFAULT '' COMMENT 'url地址',
  `content` text NOT NULL,
  `attachment` varchar(100) NOT NULL DEFAULT '',
  `displayorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` varchar(10) NOT NULL DEFAULT '' COMMENT '已发 , 已收',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_pm_9
-- ----------------------------
CREATE TABLE `tb_pm_9` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from_user_id` int(10) unsigned NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL DEFAULT '' COMMENT 'url地址',
  `content` text NOT NULL,
  `attachment` varchar(100) NOT NULL DEFAULT '',
  `displayorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` varchar(10) NOT NULL DEFAULT '' COMMENT '已发 , 已收',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_project
-- ----------------------------
CREATE TABLE `tb_project` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `proj_no` varchar(20) NOT NULL DEFAULT '' COMMENT '目项登记编号 (年度编号、总编号、分编号)',
  `year` int(10) unsigned NOT NULL COMMENT '年编号',
  `month` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用于项目统计',
  `region_code` varchar(5) NOT NULL DEFAULT '' COMMENT '政行区域名称',
  `region_name` varchar(20) NOT NULL,
  `master_serial` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '总编号 按年 从1开始计数',
  `region_serial` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '行政区域项目编号,按年按行政区域 从1开始计数',
  `name` varchar(150) NOT NULL DEFAULT '' COMMENT '项目记登名称',
  `title` varchar(150) NOT NULL DEFAULT '' COMMENT '成果名称',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '目项登记类型',
  `contacter` varchar(10) NOT NULL,
  `contacter_mobile` varchar(15) NOT NULL DEFAULT '',
  `contacter_tel` varchar(15) NOT NULL DEFAULT '' COMMENT '系联人座机',
  `manager` varchar(10) NOT NULL DEFAULT '' COMMENT '负责人',
  `manager_mobile` varchar(15) NOT NULL,
  `manager_tel` varchar(15) NOT NULL DEFAULT '' COMMENT '责负人座机',
  `address` varchar(100) NOT NULL DEFAULT '',
  `assigned_group` varchar(20) NOT NULL DEFAULT '' COMMENT '被布置的小组',
  `pm` varchar(10) NOT NULL DEFAULT '' COMMENT '目项负责人(公司)',
  `priority` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '先级优',
  `displayorder` tinyint(4) NOT NULL DEFAULT '0',
  `area` double unsigned NOT NULL DEFAULT '0' COMMENT '项目面积',
  `score` tinyint(3) unsigned NOT NULL DEFAULT '60' COMMENT '得分',
  `status` varchar(10) NOT NULL DEFAULT '新增' COMMENT '目项状态',
  `has_archiver` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '否是已归档',
  `has_doc` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '1 = 已形成成果资料',
  `arrange_date` int(11) NOT NULL DEFAULT '0' COMMENT '置布日期',
  `start_date` int(11) NOT NULL DEFAULT '0' COMMENT '要求开始日期',
  `end_date` int(11) NOT NULL COMMENT '要求结束日期',
  `real_startdate` int(11) NOT NULL COMMENT '际实开始日期',
  `real_enddate` int(11) NOT NULL COMMENT '际实结束日期',
  `team_checker` varchar(10) NOT NULL DEFAULT '' COMMENT '检查部检查人',
  `team_checkdate` int(11) unsigned NOT NULL,
  `team_remark` varchar(100) NOT NULL DEFAULT '',
  `team_checkstatus` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '1 表示 小组自查通过',
  `team_checktimes` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '自查次数,大于1表示退回的次数',
  `first_checker` varchar(10) NOT NULL DEFAULT '' COMMENT '审初人名字',
  `first_checkdate` int(11) unsigned NOT NULL COMMENT '审初检查日期',
  `first_remark` varchar(100) NOT NULL,
  `first_checkstatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '1 表示 初审通过',
  `first_checktimes` smallint(6) NOT NULL DEFAULT '0' COMMENT '初审次数,大于1表示退回的次数',
  `second_checker` varchar(10) NOT NULL DEFAULT '' COMMENT '终审者姓名',
  `second_checkdate` int(11) unsigned NOT NULL,
  `second_remark` varchar(100) NOT NULL,
  `second_checkstatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '1 表示 终审通过',
  `has_cj` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否被抽检',
  `cj_checker` varchar(10) NOT NULL DEFAULT '' COMMENT '检抽人',
  `cj_date` int(10) unsigned NOT NULL COMMENT '检抽日期',
  `cj_score` tinyint(3) unsigned NOT NULL DEFAULT '60' COMMENT '检抽得分',
  `cj_remark` varchar(100) NOT NULL DEFAULT '' COMMENT '检抽评价',
  `ys_amount` double NOT NULL DEFAULT '0' COMMENT '收应',
  `ss_amount` double NOT NULL DEFAULT '0' COMMENT '收实',
  `is_owed` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '1 表示欠费',
  `owed_amount` double NOT NULL DEFAULT '0' COMMENT '费欠金额',
  `collect_date` int(11) NOT NULL COMMENT '费收日期',
  `creator` varchar(10) NOT NULL,
  `updator` varchar(10) NOT NULL,
  `createtime` int(10) unsigned NOT NULL,
  `updatetime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ym` (`year`,`month`),
  KEY `idx_region_type` (`region_code`,`type`),
  KEY `idx_pm` (`pm`),
  KEY `idx_type` (`type`),
  KEY `idx_status` (`status`),
  KEY `idx_ctime` (`createtime`),
  KEY `idx_proj_no` (`proj_no`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_project_history
-- ----------------------------
CREATE TABLE `tb_project_history` (
  `id` int(10) unsigned NOT NULL,
  `proj_no` varchar(20) NOT NULL DEFAULT '' COMMENT '目项登记编号 (年度编号、总编号、分编号)',
  `year` int(10) unsigned NOT NULL COMMENT '年编号',
  `month` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用于项目统计',
  `region_code` varchar(5) NOT NULL DEFAULT '' COMMENT '政行区域名称',
  `region_name` varchar(20) NOT NULL,
  `master_serial` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '总编号 按年 从1开始计数',
  `region_serial` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '行政区域项目编号,按年按行政区域 从1开始计数',
  `name` varchar(150) NOT NULL DEFAULT '' COMMENT '项目记登名称',
  `title` varchar(150) NOT NULL DEFAULT '' COMMENT '成果名称',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '目项登记类型',
  `contacter` varchar(10) NOT NULL,
  `contacter_mobile` varchar(15) NOT NULL DEFAULT '',
  `contacter_tel` varchar(15) NOT NULL DEFAULT '' COMMENT '系联人座机',
  `manager` varchar(10) NOT NULL DEFAULT '' COMMENT '负责人',
  `manager_mobile` varchar(15) NOT NULL,
  `manager_tel` varchar(15) NOT NULL DEFAULT '' COMMENT '责负人座机',
  `address` varchar(100) NOT NULL DEFAULT '',
  `assigned_group` varchar(20) NOT NULL DEFAULT '' COMMENT '被布置的小组',
  `pm` varchar(10) NOT NULL DEFAULT '' COMMENT '目项负责人(公司)',
  `priority` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '先级优',
  `displayorder` tinyint(4) NOT NULL DEFAULT '0',
  `area` double unsigned NOT NULL DEFAULT '0' COMMENT '项目面积',
  `score` tinyint(3) unsigned NOT NULL DEFAULT '60' COMMENT '得分',
  `status` varchar(10) NOT NULL DEFAULT '新增' COMMENT '目项状态',
  `has_archiver` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '否是已归档',
  `has_doc` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '1 = 已形成成果资料',
  `arrange_date` int(11) NOT NULL DEFAULT '0' COMMENT '置布日期',
  `start_date` int(11) NOT NULL DEFAULT '0' COMMENT '要求开始日期',
  `end_date` int(11) NOT NULL COMMENT '要求结束日期',
  `real_startdate` int(11) NOT NULL COMMENT '际实开始日期',
  `real_enddate` int(11) NOT NULL COMMENT '际实结束日期',
  `team_checker` varchar(10) NOT NULL DEFAULT '' COMMENT '检查部检查人',
  `team_checkdate` int(11) unsigned NOT NULL,
  `team_remark` varchar(100) NOT NULL DEFAULT '',
  `team_checkstatus` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '1 表示 小组自查通过',
  `team_checktimes` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '自查次数,大于1表示退回的次数',
  `first_checker` varchar(10) NOT NULL DEFAULT '' COMMENT '审初人名字',
  `first_checkdate` int(11) unsigned NOT NULL COMMENT '审初检查日期',
  `first_remark` varchar(100) NOT NULL,
  `first_checkstatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '1 表示 初审通过',
  `first_checktimes` smallint(6) NOT NULL DEFAULT '0' COMMENT '初审次数,大于1表示退回的次数',
  `second_checker` varchar(10) NOT NULL DEFAULT '' COMMENT '终审者姓名',
  `second_checkdate` int(11) unsigned NOT NULL,
  `second_remark` varchar(100) NOT NULL,
  `second_checkstatus` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '1 表示 终审通过',
  `has_cj` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否被抽检',
  `cj_checker` varchar(10) NOT NULL DEFAULT '' COMMENT '检抽人',
  `cj_date` int(10) unsigned NOT NULL COMMENT '检抽日期',
  `cj_score` tinyint(3) unsigned NOT NULL DEFAULT '60' COMMENT '检抽得分',
  `cj_remark` varchar(100) NOT NULL DEFAULT '' COMMENT '检抽评价',
  `ys_amount` double NOT NULL DEFAULT '0' COMMENT '收应',
  `ss_amount` double NOT NULL DEFAULT '0' COMMENT '收实',
  `is_owed` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '1 表示欠费',
  `owed_amount` double NOT NULL DEFAULT '0' COMMENT '费欠金额',
  `collect_date` int(11) NOT NULL COMMENT '费收日期',
  `creator` varchar(10) NOT NULL,
  `updator` varchar(10) NOT NULL,
  `createtime` int(10) unsigned NOT NULL,
  `updatetime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_proj_no` (`proj_no`),
  KEY `idx_ym` (`year`,`month`),
  KEY `idx_region_type` (`region_code`,`type`),
  KEY `idx_pm` (`pm`),
  KEY `idx_type` (`type`),
  KEY `idx_status` (`status`),
  KEY `idx_ctime` (`createtime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_project_mod
-- ----------------------------
CREATE TABLE `tb_project_mod` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `proj_id` int(10) unsigned NOT NULL COMMENT 'project 表中的自增id',
  `action` varchar(5) NOT NULL DEFAULT '',
  `content` varchar(100) NOT NULL DEFAULT '',
  `creator` varchar(10) NOT NULL DEFAULT '',
  `updator` varchar(10) NOT NULL,
  `createtime` int(11) NOT NULL,
  `updatetime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_project_type
-- ----------------------------
CREATE TABLE `tb_project_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT '正常' COMMENT '录记状态',
  `creator` varchar(10) NOT NULL,
  `updator` varchar(10) NOT NULL,
  `createtime` int(10) unsigned NOT NULL,
  `updatetime` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_region
-- ----------------------------
CREATE TABLE `tb_region` (
  `region_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `region_code` varchar(5) NOT NULL DEFAULT '',
  `region_name` varchar(20) NOT NULL DEFAULT '',
  `year` int(10) unsigned NOT NULL,
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`region_id`),
  UNIQUE KEY `u_code_year` (`region_code`,`year`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_role
-- ----------------------------
CREATE TABLE `tb_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '角色名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '1 为系统角色，2 用户角色 系统角色不可删除',
  `status` varchar(10) NOT NULL DEFAULT '正常',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_name_status` (`name`,`status`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_role_menu
-- ----------------------------
CREATE TABLE `tb_role_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL DEFAULT '0',
  `auth_key` varchar(32) NOT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0 表示正常 1 表示已经失效',
  `creator` varchar(20) NOT NULL DEFAULT '' COMMENT '创建者名称',
  `updator` varchar(20) NOT NULL DEFAULT '' COMMENT '更新者名称',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_role_id` (`role_id`),
  KEY `idx_status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_shared_file
-- ----------------------------
CREATE TABLE `tb_shared_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '0 表示是个目录 非0 表示是文件',
  `file_name` varchar(200) NOT NULL DEFAULT '',
  `file_suffix` varchar(10) NOT NULL DEFAULT '',
  `path_name` varchar(100) NOT NULL DEFAULT '',
  `displayorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` varchar(10) NOT NULL DEFAULT '' COMMENT '删除',
  `up_id` int(10) unsigned NOT NULL DEFAULT '0',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
CREATE TABLE `tb_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account` varchar(15) NOT NULL,
  `name` varchar(20) NOT NULL,
  `id_card` varchar(20) NOT NULL DEFAULT '',
  `email` varchar(40) NOT NULL DEFAULT '',
  `alias_name` varchar(20) NOT NULL DEFAULT '' COMMENT '别名',
  `gh` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '工号',
  `psw` varchar(32) NOT NULL DEFAULT '' COMMENT '登陆密码',
  `sex` char(1) NOT NULL DEFAULT 'm',
  `age` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `birthday` datetime NOT NULL,
  `mobile` varchar(15) NOT NULL DEFAULT '' COMMENT '手机号码',
  `tel` varchar(15) NOT NULL DEFAULT '' COMMENT '住宅电话',
  `address` varchar(100) NOT NULL DEFAULT '' COMMENT '家庭地址',
  `sm` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '信短数量配额,暂时没有用',
  `virtual_no` varchar(10) NOT NULL DEFAULT '' COMMENT '拟虚号',
  `dept_id` int(10) unsigned NOT NULL DEFAULT '1',
  `share_role_id` int(1) unsigned NOT NULL DEFAULT '1' COMMENT '公共角色',
  `role_id` int(11) NOT NULL DEFAULT '0',
  `school_name` varchar(80) NOT NULL DEFAULT '' COMMENT '业毕院校',
  `graduation_date` int(11) unsigned NOT NULL COMMENT '业毕时间',
  `major` varchar(30) NOT NULL DEFAULT '' COMMENT '学所专业',
  `job_title` varchar(30) NOT NULL DEFAULT '' COMMENT '职称',
  `current_job` varchar(20) NOT NULL DEFAULT '' COMMENT '当前职位',
  `enter_date` int(11) unsigned NOT NULL COMMENT '院入年月',
  `locked` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '锁定',
  `status` varchar(10) NOT NULL DEFAULT '正常' COMMENT '录记状态',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_account` (`account`),
  UNIQUE KEY `idx_gh` (`gh`),
  KEY `idx_status` (`status`),
  KEY `idx_dept` (`dept_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_user_event
-- ----------------------------
CREATE TABLE `tb_user_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(16) NOT NULL,
  `title` varchar(30) NOT NULL DEFAULT '' COMMENT 'url地址',
  `content` varchar(100) NOT NULL DEFAULT '',
  `isnew` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否未新消息 1=是 0=否',
  `status` varchar(10) NOT NULL DEFAULT '' COMMENT '未处理,已处理',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_user_new` (`user_id`,`isnew`),
  KEY `idx_create` (`createtime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_user_file
-- ----------------------------
CREATE TABLE `tb_user_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `aid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '0 表示是个目录 非0 表示是文件',
  `file_name` varchar(200) NOT NULL DEFAULT '',
  `file_suffix` varchar(10) NOT NULL DEFAULT '',
  `path_name` varchar(100) NOT NULL DEFAULT '',
  `displayorder` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` varchar(10) NOT NULL DEFAULT '' COMMENT '删除',
  `up_id` int(10) unsigned NOT NULL DEFAULT '0',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_user_menu
-- ----------------------------
CREATE TABLE `tb_user_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `auth_key` varchar(32) NOT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0 表示正常 1 表示已经失效',
  `creator` varchar(20) NOT NULL DEFAULT '' COMMENT '创建者名称',
  `updator` varchar(20) NOT NULL DEFAULT '' COMMENT '更新者名称',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_user_schedule
-- ----------------------------
CREATE TABLE `tb_user_schedule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(16) NOT NULL,
  `sdate` int(10) unsigned NOT NULL,
  `edate` int(10) unsigned NOT NULL,
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT 'url地址',
  `content` varchar(100) NOT NULL DEFAULT '',
  `status` varchar(10) NOT NULL DEFAULT '正常',
  `auto_notify` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否自动提醒 1=是 0=否',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_create` (`createtime`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_work_log
-- ----------------------------
CREATE TABLE `tb_work_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(16) NOT NULL,
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT 'url地址',
  `content` varchar(200) NOT NULL DEFAULT '',
  `status` varchar(10) NOT NULL DEFAULT '正常',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_create` (`createtime`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `ci_sessions` VALUES ('170bda462e02fb80a9aa00674a8cb3a9', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36', '1396342038', '');
INSERT INTO `ci_sessions` VALUES ('95d2c5c077437909c6340ac5e300e703', '172.27.35.2', 'Mozilla/4.0 (compatible; MSIE 9.0; Windows NT 5.1; Trident/5.0)', '1396576897', '');
INSERT INTO `ci_sessions` VALUES ('d00705e1b75df2915d67fa909cb73682', '172.27.35.2', 'Mozilla/4.0 (compatible; MSIE 9.0; Windows NT 5.1; Trident/5.0)', '1396577520', '');
INSERT INTO `ci_sessions` VALUES ('6301c578dd61626f05a759da5cefe77c', '127.0.0.1', 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)', '1396581623', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:28:{s:7:\"user_id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:7:\"id_card\";s:1:\"0\";s:5:\"email\";s:1:\"0\";s:10:\"alias_name\";s:0:\"\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"PibPSe5i08ue9a0IXgpIJYzHRwvZV2ZFRNwcNROL3k92OgzrqxrAUGu4vxgreBygF93KYm/zU9lmS0mBbk9k4w==\";s:3:\"sex\";s:1:\"m\";s:3:\"age\";s:1:\"0\";s:8:\"birthday\";s:19:\"0000-00-00 00:00:00\";s:6:\"mobile\";s:0:\"\";s:3:\"tel\";s:0:\"\";s:7:\"address\";s:0:\"\";s:2:\"sm\";s:1:\"0\";s:10:\"virtual_no\";s:0:\"\";s:11:\"school_name\";s:0:\"\";s:15:\"graduation_date\";s:1:\"0\";s:5:\"major\";s:0:\"\";s:9:\"job_title\";s:0:\"\";s:11:\"current_job\";s:0:\"\";s:10:\"enter_date\";s:1:\"0\";s:6:\"locked\";s:1:\"0\";s:6:\"status\";s:6:\"正常\";s:7:\"creator\";s:5:\"admin\";s:7:\"updator\";s:5:\"admin\";s:10:\"createtime\";s:1:\"0\";s:10:\"updatetime\";s:1:\"0\";}}');
INSERT INTO `ci_sessions` VALUES ('d4966e5ba2e6f69d2e358f1721c71ba8', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36', '1396914765', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:7:\"user_id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"wZLzyV4gcXVaG3GC5VABtXuC5JbuffNRXgHK6S7n+HAlWQbQ3KC9WpjlKozcsDdbONL0rScr7LX9nW8oV7JOCg==\";}}');
INSERT INTO `ci_sessions` VALUES ('939579e0f05bc1e8d2e8fb6e985ab9d7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:27.0) Gecko/20100101 Firefox/27.0', '1396596193', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:7:\"user_id\";s:2:\"10\";s:7:\"account\";s:3:\"zwt\";s:4:\"name\";s:9:\"张五天\";s:2:\"gh\";s:2:\"22\";s:3:\"psw\";s:88:\"Et22e3/wIIHWrLrEiBzQSlBGZNlDNZDevuovnWZ8E2aN056Aa/xQPNg97vv0Md2GyztsyXO7qY30XD2l1Saa8w==\";}}');
INSERT INTO `ci_sessions` VALUES ('181b18d65aeed4a98f1da35141886a32', '127.0.0.1', 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR ', '1396595026', '');
INSERT INTO `ci_sessions` VALUES ('114406f7c5f4c4708286ade6241b4215', '172.27.35.2', 'Mozilla/4.0 (compatible; MSIE 9.0; Windows NT 5.1; Trident/5.0)', '1396596959', '');
INSERT INTO `ci_sessions` VALUES ('2bf4588e51b90d2cd8c88a2624cacb6e', '127.0.0.1', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .N', '1396581722', '');
INSERT INTO `ci_sessions` VALUES ('db4f5472e484f6846f2c30e9fe5e8990', '127.0.0.1', 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR ', '1396581725', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:28:{s:7:\"user_id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:7:\"id_card\";s:1:\"0\";s:5:\"email\";s:1:\"0\";s:10:\"alias_name\";s:0:\"\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"NytKviQq73g5SVN1BzHfWmuKuI+W/hgfBy358IPQTPCWgSQuw7np9VXObmr1heZGpb93Sf4gb/XNL4LTgwk7fQ==\";s:3:\"sex\";s:1:\"m\";s:3:\"age\";s:1:\"0\";s:8:\"birthday\";s:19:\"0000-00-00 00:00:00\";s:6:\"mobile\";s:0:\"\";s:3:\"tel\";s:0:\"\";s:7:\"address\";s:0:\"\";s:2:\"sm\";s:1:\"0\";s:10:\"virtual_no\";s:0:\"\";s:11:\"school_name\";s:0:\"\";s:15:\"graduation_date\";s:1:\"0\";s:5:\"major\";s:0:\"\";s:9:\"job_title\";s:0:\"\";s:11:\"current_job\";s:0:\"\";s:10:\"enter_date\";s:1:\"0\";s:6:\"locked\";s:1:\"0\";s:6:\"status\";s:6:\"正常\";s:7:\"creator\";s:5:\"admin\";s:7:\"updator\";s:5:\"admin\";s:10:\"createtime\";s:1:\"0\";s:10:\"updatetime\";s:1:\"0\";}}');
INSERT INTO `ci_sessions` VALUES ('24cc280846cd05cf93edbfab01f72c2f', '127.0.0.1', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .N', '1396584998', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:28:{s:7:\"user_id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:7:\"id_card\";s:1:\"0\";s:5:\"email\";s:1:\"0\";s:10:\"alias_name\";s:0:\"\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"BqTDRUWn9IA4Pd6hzu5LK0JCvmkow9JEX/DhfwpkPe2o0EXMwr4no1HJfMAuU1GO/ZHpkuEQXk9b2HBDA56LEw==\";s:3:\"sex\";s:1:\"m\";s:3:\"age\";s:1:\"0\";s:8:\"birthday\";s:19:\"0000-00-00 00:00:00\";s:6:\"mobile\";s:0:\"\";s:3:\"tel\";s:0:\"\";s:7:\"address\";s:0:\"\";s:2:\"sm\";s:1:\"0\";s:10:\"virtual_no\";s:0:\"\";s:11:\"school_name\";s:0:\"\";s:15:\"graduation_date\";s:1:\"0\";s:5:\"major\";s:0:\"\";s:9:\"job_title\";s:0:\"\";s:11:\"current_job\";s:0:\"\";s:10:\"enter_date\";s:1:\"0\";s:6:\"locked\";s:1:\"0\";s:6:\"status\";s:6:\"正常\";s:7:\"creator\";s:5:\"admin\";s:7:\"updator\";s:5:\"admin\";s:10:\"createtime\";s:1:\"0\";s:10:\"updatetime\";s:1:\"0\";}}');
INSERT INTO `ci_sessions` VALUES ('d79c57d5f807aad029790b5a69b696cd', '127.0.0.1', 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR ', '1396593585', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:28:{s:7:\"user_id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:7:\"id_card\";s:1:\"0\";s:5:\"email\";s:1:\"0\";s:10:\"alias_name\";s:0:\"\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"itK5sxCay3VtKBgwT8csKba7S2rxUM+bosfSQat4Ze+ZaOjlVrPuaBSpokdexlfrliHKPYD38LYI/gvpmLHG7Q==\";s:3:\"sex\";s:1:\"m\";s:3:\"age\";s:1:\"0\";s:8:\"birthday\";s:19:\"0000-00-00 00:00:00\";s:6:\"mobile\";s:0:\"\";s:3:\"tel\";s:0:\"\";s:7:\"address\";s:0:\"\";s:2:\"sm\";s:1:\"0\";s:10:\"virtual_no\";s:0:\"\";s:11:\"school_name\";s:0:\"\";s:15:\"graduation_date\";s:1:\"0\";s:5:\"major\";s:0:\"\";s:9:\"job_title\";s:0:\"\";s:11:\"current_job\";s:0:\"\";s:10:\"enter_date\";s:1:\"0\";s:6:\"locked\";s:1:\"0\";s:6:\"status\";s:6:\"正常\";s:7:\"creator\";s:5:\"admin\";s:7:\"updator\";s:5:\"admin\";s:10:\"createtime\";s:1:\"0\";s:10:\"updatetime\";s:1:\"0\";}}');
INSERT INTO `ci_sessions` VALUES ('b81eaa87485e9089cfa38128a1f2a4b4', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36', '1396590502', '');
INSERT INTO `ci_sessions` VALUES ('a0ced5f8285237f6bef1a1889cc4044e', '127.0.0.1', 'Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_2 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2', '1396914910', '');
INSERT INTO `ci_sessions` VALUES ('ffc00cabed8c5539a5f86805f7817798', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36', '1396939872', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:7:\"user_id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"SbtNzyw8FjFiOejSvZxxmFlLECmqMEPSbS5EtqY7Qgd2cqOAsZb/WF/L27MnwUlL+VvFcZUkPGrbej2VG3Vl3w==\";}}');
INSERT INTO `ci_sessions` VALUES ('33fc7bbe95a2331743a0edeb65c17675', '127.0.0.1', 'Mozilla/5.0 (Linux; U; Android 2.2; en-gb; GT-P1000 Build/FROYO) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobil', '1396941062', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:7:\"user_id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"hqw2+djpU0LzZcvsZ8wNnxDCPcIh9JNhGAEJXrqjkq78ztRZ9361TyaGqtMlwy1Q2hkAmR2FI8ZkhaU9ZHwpqg==\";}}');
INSERT INTO `ci_sessions` VALUES ('8518e1eeb29bde40a59c097c5d9f6e5c', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36', '1396942269', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:7:\"user_id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"apG566ba/RlQ4FV6mnDMz/9MJaRRQTshsRGpTICT/jfjx46LHdmkkwyFG3bt/xLImgqXANc5wxDwQscbqeWvMA==\";}}');
INSERT INTO `ci_sessions` VALUES ('5c7aaa121c0bf4cc57ad6d6d09bb192c', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36', '1397026593', 'a:1:{s:7:\"profile\";a:5:{s:7:\"user_id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:33:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"CpT5giNbpmzj+N7e+bYtHmLZ2DVyrjbNxXRlbECDc6DNSC4bOO5i5BRJ0HU4ow189bD/zHlXJD3h+33v48hF2g==\";}}');
INSERT INTO `ci_sessions` VALUES ('83f323e217af2f247b7a94320d987c60', '127.0.0.1', 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)', '1397004434', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:7:\"user_id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"baLA/MyTJQnnPgrkK627kFfmOtd99KIi+9jMuHapi+j63Bfcr87191LidfDTUmcRjEJzId/cblQscllVIF8Pyg==\";}}');
INSERT INTO `ci_sessions` VALUES ('0b2f688af8cf133d191bde93cc5a0345', '127.0.0.1', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .N', '1397004625', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:7:\"user_id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"KSelTgq4Md3bUARYrBoI4ts94WUZ4UdrZiq4WAVOop+Eq5S2Zl4kd3mBPVXo5kQIBo8TvMpzxQ8VDen4EFd9Pg==\";}}');
INSERT INTO `ci_sessions` VALUES ('9fcd65867cb31cf278592701cfe76d8f', '127.0.0.1', 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR ', '1397016526', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:7:\"user_id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"1FTRCprJ3kB1erR2NFAAjvQzJDMnDZuxj7+fKStAYc6PJIKj7ANxs/Sf7wipjYV0HZT8F1nuRFPTQ/ywYBcWyw==\";}}');
INSERT INTO `ci_sessions` VALUES ('daf3da449e3875391d189a5e2d025d12', '127.0.0.1', 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)', '1397022425', '');
INSERT INTO `ci_sessions` VALUES ('3a21c503dab547199ca8c5cf16f5f13d', '127.0.0.1', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .N', '1397025121', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:7:\"user_id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"rx4puSvt3sPR3FIQLpXuRSK918rdAUar3gA4y+p0mht9j1GHsptgJ+H0ru2hhLFUPwGzgDX0z7yETIhehj/aFA==\";}}');
INSERT INTO `ci_sessions` VALUES ('52470ee8f33e9f7b41cb2bf769ecfc92', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36', '1397105542', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:7:\"user_id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"IObxc0qxGfsSKAYkqBjDs4tGETCKfc3Hxn2PfKIf6V6apBWlxuaUe8Vc/dTpcJ77G6fJG0CGvEzmj2QCSkFFlA==\";}}');
INSERT INTO `ci_sessions` VALUES ('ba554d3df2afd25d8a9b22ab150118d6', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36', '1397119525', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:2:\"11\";s:7:\"account\";s:3:\"t51\";s:4:\"name\";s:9:\"测试是\";s:2:\"gh\";s:2:\"55\";s:3:\"psw\";s:88:\"IYaqE0URZe+feAlr+6VEanp+dpaM7ho58NZtd6wtnIKjwQ+57xFa5GGtEo5igohOPb2ApepMWndk8CzzxrAn0Q==\";}}');
INSERT INTO `ci_sessions` VALUES ('a90179bf512771ce333865b1c3e859bf', '192.168.1.121', 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)', '1397119799', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:7:\"user_id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"FpHC8XqxstVnm3IWTllOue3xR4dVb3rq59HAJkQx6Y4HbN8b9TtFx2jaq+4hk8oXtQG77bpa9tn2oLRtFyQvdA==\";}}');
INSERT INTO `ci_sessions` VALUES ('e381e8df1a19dc8e722317cf0dba6681', '192.168.1.121', 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)', '1397190716', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"joFWJ6jNhLCP7HIQk0lPrE9L+6y4W3PbC9tw3s1DomaFmNdycejD+BU6Qvr4HDo2w+tT90bpYSLH9xUBapPNSA==\";}}');
INSERT INTO `ci_sessions` VALUES ('0139998ef90f97109e032ea627f555b7', '127.0.0.1', 'Mozilla/5.0 (Linux; U; Android 2.3; en-us) AppleWebKit/999+ (KHTML, like Gecko) Safari/999.9', '1397183801', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"0RWFUfDHqh3LMU+4z2C/I7xa/iqhKCU338wQjBpdj3xA26Ax0thMpuoM/9kR/4BlMWjNl8dXcXG78qHNBUiO0g==\";}}');
INSERT INTO `ci_sessions` VALUES ('33e73ad8571afb9b5f2f5c9e01581038', '127.0.0.1', 'Mozilla/5.0 (Linux; U; Android 2.3; en-us) AppleWebKit/999+ (KHTML, like Gecko) Safari/999.9', '1397191591', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"adk3lPwBnVQDe3u5bdCcSHaIg0ivLMun+j/OJ3lW3ZkAI79Vq2/cSKUXc/khASlabvgcqa2Bv3/f2xv6nhLonQ==\";}}');
INSERT INTO `ci_sessions` VALUES ('3c0db6edbf50c0cb02d417064d9d7386', '127.0.0.1', 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)', '1397184967', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"imy6jtHGH+EcC79kPSdE+U3/EUvDfqGmWoUtKxgL6A3NF7gXeG8a0rSdy+EYqUAtNq7Mv9Yt9vciCd02o6mifA==\";}}');
INSERT INTO `ci_sessions` VALUES ('8c9df0cb5b4c3da2c046622b5aa59250', '127.0.0.1', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .N', '1397189718', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"EvEN5QUBtRu5J/LNPpKyHu9ilfiBx1fl8N5zSoPiWJf8RCWiSfD8gtuLf2WKPee5Z4khNkrP2pbqKTmtiAEVfg==\";}}');
INSERT INTO `ci_sessions` VALUES ('9610a1ce9aa02f59d0fe8a7cae80c847', '127.0.0.1', 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR ', '1397189779', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"cmAcCnewkeOgjF6Lvt4w5+6MbKChgYr/l53FKtLaTlPaK8Xmr72LDS55SAp355gPz1PRzir7BNwhl4OFoaUONw==\";}}');
INSERT INTO `ci_sessions` VALUES ('b43e6731ba31216e9411a6b988803b17', '127.0.0.1', 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)', '1397196237', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"JPpCSUkRYFsWx7svHMjAbTe5kXqaRGliwwxCCnjHC2NelT7wYRWmCwFSSM+U7Mq+WezSXX7brkkq+ihqE1ymyQ==\";}}');
INSERT INTO `ci_sessions` VALUES ('ed258c7a4003fc97b143cad79292bfb1', '192.168.1.121', 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)', '1397198391', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"nEIVweE+hA6JPdovg8jkqwxkJMq3njV1YvVycjMCKZJuOhIPxL68HokxVrEevhuRaFfzJXMCohJj2wP4GfYDhg==\";}}');
INSERT INTO `ci_sessions` VALUES ('ffb2ce1506316b85a63e2e20a4a78fd9', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36', '1397205411', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"kRJw2JR6inWlvlhj9KzkZ/8G9AmXmmB13CfErjGHr8ZcYMkdIch9a8THRCl8CoK95+hR+60zb2Cv43Fj4igURg==\";}}');
INSERT INTO `ci_sessions` VALUES ('44c6cc967da3c61c1ce61f2fe30008dd', '127.0.0.1', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .N', '1397197774', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"TylL5/Y8iIIeJxlX1hXsjH0ppArCk/pbpW5q5Gz2YxTByS3S3s6wQp9kDmEWTnP3UAwVr/G1/93RekPzgKOVBQ==\";}}');
INSERT INTO `ci_sessions` VALUES ('ffdb6630abeab9caf1e31740ec3efec9', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36', '1397279546', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"ywNbTQT/baKlWXx8P770fK7S+Q0lQsU6Iq5S5mrNkQL236zjGPMfMoi2PFJsB5TOtFID129C8nZLmC41QPm94w==\";}}');
INSERT INTO `ci_sessions` VALUES ('af1e383c75cfc3dba5d153c8fe969c17', '127.0.0.1', 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)', '1397293623', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"fI14L+vObQwVyeG3aogiM6cQMUncbyhma6Pjy/XEMsv7VcY9G/RK2mWhrajZZR088CH1Eekib2wW1oCSGPPrjw==\";}}');
INSERT INTO `ci_sessions` VALUES ('04666c2717192135538ad97c53528839', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36', '1397293714', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:2:\"11\";s:7:\"account\";s:3:\"t51\";s:4:\"name\";s:9:\"测试是\";s:2:\"gh\";s:2:\"55\";s:3:\"psw\";s:88:\"dS+ICJQPGQU+gyuZxvTsKMfKPdwzbxiASkM6t5G+UDJirAzPWHeIig4l6Qto/kOL8ldaGPbfybg8wzH+E64+bg==\";}}');
INSERT INTO `tb_contacts` VALUES ('1', '我的日程1', '0', '今天去办社保', '', '', '', '正常', '超级管理员', '超级管理员', '1397265793', '1397265793');
INSERT INTO `tb_contacts` VALUES ('2', '我的日程2', '0', '今天下班去接小孩', '', '', '', '正常', '超级管理员', '超级管理员', '1397267173', '1397267173');
INSERT INTO `tb_contacts` VALUES ('3', '我日日程3', '0', '几天能哈哈sas 环境阿莎哈啥', '', '', '', '正常', '超级管理员', '超级管理员', '1397267537', '1397267537');
INSERT INTO `tb_contacts` VALUES ('4', '今天去桥头测量', '0', '问题1：\r\n哈哈是爱上\r\n11', '', '', '', '已删除', '超级管理员', '超级管理员', '1397288917', '1397289147');
INSERT INTO `tb_contacts` VALUES ('5', '陈林波', '0', '12345454541', '232323', '34324-12123', '成寿寺哈哈撒花爱喝啥啥', '已删除', '超级管理员', '超级管理员', '1397293071', '1397293102');
INSERT INTO `tb_dept` VALUES ('1', '慈溪市土地勘测规划设计院有限公司', '0', '正常', '超级管理员', '超级管理员', '1396940368', '1397102570');
INSERT INTO `tb_dept` VALUES ('2', '测绘室', '1', '已删除', '超级管理员', '超级管理员', '1396940709', '1397019054');
INSERT INTO `tb_dept` VALUES ('3', '规划室', '1', '正常', '超级管理员', '超级管理员', '1396940729', '1396940729');
INSERT INTO `tb_dept` VALUES ('4', '规划小组1', '3', '正常', '超级管理员', '超级管理员', '1396943952', '1396945961');
INSERT INTO `tb_dept` VALUES ('5', '规划小组1-1', '3', '正常', '超级管理员', '超级管理员', '1396944491', '1396945590');
INSERT INTO `tb_dept` VALUES ('6', '规划小组23', '2', '已删除', '超级管理员', '超级管理员', '1396945623', '1397007158');
INSERT INTO `tb_dept` VALUES ('7', '我的部门', '1', '正常', '超级管理员', '超级管理员', '1396945686', '1397005414');
INSERT INTO `tb_dept` VALUES ('8', '我的部门1', '2', '已删除', '超级管理员', '超级管理员', '1396945711', '1397016491');
INSERT INTO `tb_dept` VALUES ('9', '我的,部门', '1', '已删除', '超级管理员', '超级管理员', '1397003617', '1397003617');
INSERT INTO `tb_dept` VALUES ('10', '规划室3', '3', '正常', '超级管理员', '超级管理员', '1397024764', '1397024764');
INSERT INTO `tb_dept` VALUES ('11', '测量组', '1', '正常', '超级管理员', '超级管理员', '1397102762', '1397102762');
INSERT INTO `tb_dept` VALUES ('12', '测量1组', '11', '正常', '超级管理员', '超级管理员', '1397102772', '1397102772');
INSERT INTO `tb_dept` VALUES ('13', '测量2组', '11', '已删除', '超级管理员', '超级管理员', '1397102781', '1397102781');
INSERT INTO `tb_dept` VALUES ('14', '测量3组', '11', '已删除', '超级管理员', '超级管理员', '1397195082', '1397197246');
INSERT INTO `tb_menu` VALUES ('7', '134f34825e4f179f4355bb8bc369ead0', '系统管理', 'c=system&m=index', '0', '0', '正常', '超级管理员', '超级管理员', '1397093146', '1397099842');
INSERT INTO `tb_menu` VALUES ('8', '970ee07bcf77cf54e167c83a5e6d3c27', '用户管理', 'c=user&m=index', '7', '0', '正常', '超级管理员', '超级管理员', '1397093444', '1397099915');
INSERT INTO `tb_menu` VALUES ('9', 'e8543ad4a081e16686be51317b888f00', '添加用户', 'c=user&m=add', '8', '0', '正常', '超级管理员', '超级管理员', '1397093473', '1397097714');
INSERT INTO `tb_menu` VALUES ('10', '28486ff59f3c7e2001da304c6bfda91c', '删除用户', 'c=user&m=delete', '8', '0', '正常', '超级管理员', '超级管理员', '1397097650', '1397097650');
INSERT INTO `tb_menu` VALUES ('11', '313dc71ee986826273e9a75df4eefd8d', '修改用户', 'c=user&m=edit', '8', '0', '正常', '超级管理员', '超级管理员', '1397097669', '1397097669');
INSERT INTO `tb_menu` VALUES ('12', 'f607c898371146232b4fd31ce8b8c0b9', '设置用户权限', 'c=user&m=auth', '8', '0', '正常', '超级管理员', '超级管理员', '1397097750', '1397097750');
INSERT INTO `tb_role` VALUES ('1', '公共权限角色', '1', '正常', '超级管理员', '超级管理员', '1396596593', '1396596593');
INSERT INTO `tb_role` VALUES ('2', '系统管理员', '1', '正常', '超级管理员', '超级管理员', '1396596746', '1396596746');
INSERT INTO `tb_role` VALUES ('3', '角色3修改', '0', '正常', '超级管理员', '超级管理员', '1396596772', '1396597289');
INSERT INTO `tb_role` VALUES ('4', '人事角色', '0', '正常', '超级管理员', '超级管理员', '1396597337', '1396597337');
INSERT INTO `tb_role` VALUES ('5', '数据录入员', '0', '正常', '超级管理员', '超级管理员', '1396597346', '1396597346');
INSERT INTO `tb_role` VALUES ('6', '财务人员', '0', '已删除', '超级管理员', '超级管理员', '1396597353', '1396597353');
INSERT INTO `tb_role` VALUES ('7', '测量组人员修改', '0', '已删除', '超级管理员', '超级管理员', '1396597362', '1396597425');
INSERT INTO `tb_role` VALUES ('8', '再来一个', '0', '已删除', '超级管理员', '超级管理员', '1396932672', '1396932672');
INSERT INTO `tb_role_menu` VALUES ('1', '5', '970ee07bcf77cf54e167c83a5e6d3c27', '1', '测试是', '测试是', '1397118589', '1397287917');
INSERT INTO `tb_role_menu` VALUES ('2', '5', '134f34825e4f179f4355bb8bc369ead0', '1', '测试是', '测试是', '1397118589', '1397287917');
INSERT INTO `tb_role_menu` VALUES ('3', '5', '970ee07bcf77cf54e167c83a5e6d3c27', '1', '测试是', '测试是', '1397118617', '1397287917');
INSERT INTO `tb_role_menu` VALUES ('4', '5', '134f34825e4f179f4355bb8bc369ead0', '1', '测试是', '测试是', '1397118617', '1397287917');
INSERT INTO `tb_role_menu` VALUES ('5', '5', 'e8543ad4a081e16686be51317b888f00', '1', '测试是', '测试是', '1397118617', '1397287917');
INSERT INTO `tb_role_menu` VALUES ('6', '5', '28486ff59f3c7e2001da304c6bfda91c', '1', '测试是', '测试是', '1397118617', '1397287917');
INSERT INTO `tb_role_menu` VALUES ('25', '5', '970ee07bcf77cf54e167c83a5e6d3c27', '0', '测试是', '测试是', '1397287917', '1397287917');
INSERT INTO `tb_role_menu` VALUES ('7', '5', '970ee07bcf77cf54e167c83a5e6d3c27', '1', '超级管理员', '测试是', '1397193680', '1397287917');
INSERT INTO `tb_role_menu` VALUES ('8', '5', '134f34825e4f179f4355bb8bc369ead0', '1', '超级管理员', '测试是', '1397193680', '1397287917');
INSERT INTO `tb_role_menu` VALUES ('9', '5', 'f607c898371146232b4fd31ce8b8c0b9', '1', '超级管理员', '测试是', '1397193680', '1397287917');
INSERT INTO `tb_role_menu` VALUES ('10', '5', 'e8543ad4a081e16686be51317b888f00', '1', '超级管理员', '测试是', '1397193680', '1397287917');
INSERT INTO `tb_role_menu` VALUES ('11', '5', '313dc71ee986826273e9a75df4eefd8d', '1', '超级管理员', '测试是', '1397193680', '1397287917');
INSERT INTO `tb_role_menu` VALUES ('12', '5', '28486ff59f3c7e2001da304c6bfda91c', '1', '超级管理员', '测试是', '1397193680', '1397287917');
INSERT INTO `tb_role_menu` VALUES ('13', '1', '970ee07bcf77cf54e167c83a5e6d3c27', '1', '测试是', '测试是', '1397287691', '1397287761');
INSERT INTO `tb_role_menu` VALUES ('14', '1', '134f34825e4f179f4355bb8bc369ead0', '1', '测试是', '测试是', '1397287691', '1397287761');
INSERT INTO `tb_role_menu` VALUES ('15', '1', 'f607c898371146232b4fd31ce8b8c0b9', '1', '测试是', '测试是', '1397287691', '1397287761');
INSERT INTO `tb_role_menu` VALUES ('16', '1', 'e8543ad4a081e16686be51317b888f00', '1', '测试是', '测试是', '1397287691', '1397287761');
INSERT INTO `tb_role_menu` VALUES ('17', '1', '313dc71ee986826273e9a75df4eefd8d', '1', '测试是', '测试是', '1397287691', '1397287761');
INSERT INTO `tb_role_menu` VALUES ('18', '1', '28486ff59f3c7e2001da304c6bfda91c', '1', '测试是', '测试是', '1397287691', '1397287761');
INSERT INTO `tb_role_menu` VALUES ('19', '1', '970ee07bcf77cf54e167c83a5e6d3c27', '0', '测试是', '测试是', '1397287761', '1397287761');
INSERT INTO `tb_role_menu` VALUES ('20', '1', '134f34825e4f179f4355bb8bc369ead0', '0', '测试是', '测试是', '1397287761', '1397287761');
INSERT INTO `tb_role_menu` VALUES ('21', '1', 'f607c898371146232b4fd31ce8b8c0b9', '0', '测试是', '测试是', '1397287761', '1397287761');
INSERT INTO `tb_role_menu` VALUES ('22', '1', 'e8543ad4a081e16686be51317b888f00', '0', '测试是', '测试是', '1397287761', '1397287761');
INSERT INTO `tb_role_menu` VALUES ('23', '1', '313dc71ee986826273e9a75df4eefd8d', '0', '测试是', '测试是', '1397287761', '1397287761');
INSERT INTO `tb_role_menu` VALUES ('24', '1', '28486ff59f3c7e2001da304c6bfda91c', '0', '测试是', '测试是', '1397287761', '1397287761');
INSERT INTO `tb_role_menu` VALUES ('26', '5', '134f34825e4f179f4355bb8bc369ead0', '0', '测试是', '测试是', '1397287917', '1397287917');
INSERT INTO `tb_role_menu` VALUES ('27', '5', 'f607c898371146232b4fd31ce8b8c0b9', '0', '测试是', '测试是', '1397287917', '1397287917');
INSERT INTO `tb_role_menu` VALUES ('28', '5', 'e8543ad4a081e16686be51317b888f00', '0', '测试是', '测试是', '1397287917', '1397287917');
INSERT INTO `tb_role_menu` VALUES ('29', '5', '313dc71ee986826273e9a75df4eefd8d', '0', '测试是', '测试是', '1397287917', '1397287917');
INSERT INTO `tb_role_menu` VALUES ('30', '5', '28486ff59f3c7e2001da304c6bfda91c', '0', '测试是', '测试是', '1397287917', '1397287917');
INSERT INTO `tb_user` VALUES ('1', 'admin', '超级管理员', '0', '0', '', '0', 'ea021abea3e9ac7a0f172f65336c0250', 'm', '0', '0000-00-00 00:00:00', '', '', '', '0', '', '11', '1', '0', '', '1397347200', '', '', '', '1398384000', '0', '正常', 'admin', 'admin', '1396515367', '1396515367');
INSERT INTO `tb_user` VALUES ('2', 'admin1', '爱上dsadsa', '', '', '', '1', 'dd1f73c3a84bee119fd6cd206a5ace31', 'm', '0', '0000-00-00 00:00:00', '13795467940', '', '', '0', '', '11', '1', '4', '', '1397347200', '', '', '', '1398384000', '0', '正常', '超级管理员', '超级管理员', '1396515367', '1396515367');
INSERT INTO `tb_user` VALUES ('3', 'hh12', '测试名字', '', '', '', '2', 'dd1f73c3a84bee119fd6cd206a5ace31', 'm', '0', '0000-00-00 00:00:00', '13795467940', '', '', '0', '', '11', '1', '0', '', '1397347200', '', '', '', '1398384000', '0', '正常', '超级管理员', '超级管理员', '1396515457', '1396515457');
INSERT INTO `tb_user` VALUES ('4', 'h122', '测试名字1', '', '', '', '3', 'dd1f73c3a84bee119fd6cd206a5ace31', 'f', '0', '0000-00-00 00:00:00', '13795467940', '', '', '0', '', '11', '1', '0', '', '1397347200', '', '', '', '1398384000', '0', '正常', '超级管理员', '超级管理员', '1396515749', '1396515749');
INSERT INTO `tb_user` VALUES ('5', '23123', '就爱上哈都是', '', '', '', '4', 'dd1f73c3a84bee119fd6cd206a5ace31', 'm', '0', '0000-00-00 00:00:00', '13795467940', '', '', '0', '', '11', '1', '0', '', '1397347200', '', '', '', '1398384000', '0', '正常', '超级管理员', '超级管理员', '1396572758', '1396572758');
INSERT INTO `tb_user` VALUES ('6', '323', '我的姓名', '', '', '', '5', 'dd1f73c3a84bee119fd6cd206a5ace31', 'm', '0', '0000-00-00 00:00:00', '13795467940', '', '', '0', '', '11', '1', '0', '', '1397347200', '', '', '', '1398384000', '0', '已删除', '就爱上哈都是', '就爱上哈都是', '1396573128', '1396573128');
INSERT INTO `tb_user` VALUES ('7', '554', '说得很好', '', '', '', '6', 'd91976a8add1886a83b6bd7cc7a6632d', 'f', '0', '0000-00-00 00:00:00', '13795467940', '', '', '0', '', '11', '1', '0', '', '1397347200', '', '', '', '1398384000', '0', '已删除', '就爱上哈都是', '超级管理员', '1396578418', '1397108268');
INSERT INTO `tb_user` VALUES ('8', 'ddff', 'hjasdr23', '', '', '', '7', 'd91976a8add1886a83b6bd7cc7a6632d', 'f', '0', '0000-00-00 00:00:00', '13795467942', '', '', '0', '', '11', '1', '0', '', '1397347200', '', '', '', '1397347200', '0', '正常', '就爱上哈都是', '超级管理员', '1396579538', '1397097107');
INSERT INTO `tb_user` VALUES ('9', 'czb', '陈暂波', '', '', '', '12', 'd91976a8add1886a83b6bd7cc7a6632d', 'm', '0', '0000-00-00 00:00:00', '15195467940', '', '', '0', '', '11', '1', '0', '', '1271116800', '', '助理工程师', '', '1398816000', '0', '已删除', '就爱上哈都是', '超级管理员', '1396588781', '1397024664');
INSERT INTO `tb_user` VALUES ('10', 'zwt', '张五天', '', '', '', '22', 'd91976a8add1886a83b6bd7cc7a6632d', 'm', '0', '0000-00-00 00:00:00', '13795467840', '', '', '0', '', '11', '1', '0', '', '1397433600', '', '', '', '1398384000', '0', '已删除', '就爱上哈都是', '超级管理员', '1396589286', '1397007924');
INSERT INTO `tb_user` VALUES ('11', 't51', '测试是', '', '', '', '55', '641003ad022f3b62ba2ef7273d1a17a6', 'm', '0', '0000-00-00 00:00:00', '13795467941', '', '', '0', '', '11', '1', '5', '', '1397001600', '', '', '', '1398470400', '0', '正常', '超级管理员', '测试是', '1397109730', '1397118975');
INSERT INTO `tb_user` VALUES ('12', 'my1', '我的名字', '', '', '', '234', 'dd1f73c3a84bee119fd6cd206a5ace31', 'm', '0', '0000-00-00 00:00:00', '13795467940', '', '', '0', '', '1', '1', '0', '', '1240963200', '', '', '', '1396310400', '0', '正常', '超级管理员', '超级管理员', '1397198001', '1397292999');
INSERT INTO `tb_user_menu` VALUES ('1', '11', '970ee07bcf77cf54e167c83a5e6d3c27', '1', '超级管理员', '测试是', '1397114183', '1397117741');
INSERT INTO `tb_user_menu` VALUES ('2', '11', '134f34825e4f179f4355bb8bc369ead0', '1', '超级管理员', '测试是', '1397114183', '1397117741');
INSERT INTO `tb_user_menu` VALUES ('3', '11', 'f607c898371146232b4fd31ce8b8c0b9', '1', '超级管理员', '测试是', '1397114183', '1397117741');
INSERT INTO `tb_user_menu` VALUES ('4', '11', 'e8543ad4a081e16686be51317b888f00', '1', '超级管理员', '测试是', '1397114183', '1397117741');
INSERT INTO `tb_user_menu` VALUES ('5', '11', '313dc71ee986826273e9a75df4eefd8d', '1', '超级管理员', '测试是', '1397114183', '1397117741');
INSERT INTO `tb_user_menu` VALUES ('6', '11', '28486ff59f3c7e2001da304c6bfda91c', '1', '超级管理员', '测试是', '1397114183', '1397117741');
INSERT INTO `tb_user_menu` VALUES ('7', '11', '970ee07bcf77cf54e167c83a5e6d3c27', '1', '超级管理员', '测试是', '1397114805', '1397117741');
INSERT INTO `tb_user_menu` VALUES ('8', '11', '134f34825e4f179f4355bb8bc369ead0', '1', '超级管理员', '测试是', '1397114805', '1397117741');
INSERT INTO `tb_user_menu` VALUES ('9', '11', 'f607c898371146232b4fd31ce8b8c0b9', '1', '超级管理员', '测试是', '1397114805', '1397117741');
INSERT INTO `tb_user_menu` VALUES ('10', '11', 'e8543ad4a081e16686be51317b888f00', '1', '超级管理员', '测试是', '1397114805', '1397117741');
INSERT INTO `tb_user_menu` VALUES ('11', '11', '313dc71ee986826273e9a75df4eefd8d', '1', '超级管理员', '测试是', '1397114805', '1397117741');
INSERT INTO `tb_user_menu` VALUES ('12', '11', '28486ff59f3c7e2001da304c6bfda91c', '1', '超级管理员', '测试是', '1397114805', '1397117741');
INSERT INTO `tb_user_menu` VALUES ('13', '8', 'e8543ad4a081e16686be51317b888f00', '1', '测试是', '测试是', '1397116820', '1397117244');
INSERT INTO `tb_user_menu` VALUES ('14', '8', '28486ff59f3c7e2001da304c6bfda91c', '1', '测试是', '测试是', '1397116820', '1397117244');
INSERT INTO `tb_user_menu` VALUES ('15', '8', '970ee07bcf77cf54e167c83a5e6d3c27', '1', '测试是', '测试是', '1397116963', '1397117244');
INSERT INTO `tb_user_menu` VALUES ('16', '8', 'e8543ad4a081e16686be51317b888f00', '1', '测试是', '测试是', '1397116963', '1397117244');
INSERT INTO `tb_user_menu` VALUES ('17', '8', '28486ff59f3c7e2001da304c6bfda91c', '1', '测试是', '测试是', '1397116963', '1397117244');
INSERT INTO `tb_user_menu` VALUES ('18', '8', '134f34825e4f179f4355bb8bc369ead0', '1', '测试是', '测试是', '1397117157', '1397117244');
INSERT INTO `tb_user_menu` VALUES ('19', '8', 'e8543ad4a081e16686be51317b888f00', '1', '测试是', '测试是', '1397117157', '1397117244');
INSERT INTO `tb_user_menu` VALUES ('20', '8', '28486ff59f3c7e2001da304c6bfda91c', '1', '测试是', '测试是', '1397117157', '1397117244');
INSERT INTO `tb_user_menu` VALUES ('21', '8', '970ee07bcf77cf54e167c83a5e6d3c27', '1', '测试是', '测试是', '1397117230', '1397117244');
INSERT INTO `tb_user_menu` VALUES ('22', '8', '134f34825e4f179f4355bb8bc369ead0', '1', '测试是', '测试是', '1397117230', '1397117244');
INSERT INTO `tb_user_menu` VALUES ('23', '8', 'e8543ad4a081e16686be51317b888f00', '1', '测试是', '测试是', '1397117230', '1397117244');
INSERT INTO `tb_user_menu` VALUES ('24', '8', '28486ff59f3c7e2001da304c6bfda91c', '1', '测试是', '测试是', '1397117230', '1397117244');
INSERT INTO `tb_user_menu` VALUES ('25', '8', '970ee07bcf77cf54e167c83a5e6d3c27', '0', '测试是', '测试是', '1397117244', '1397117244');
INSERT INTO `tb_user_menu` VALUES ('26', '8', '134f34825e4f179f4355bb8bc369ead0', '0', '测试是', '测试是', '1397117244', '1397117244');
INSERT INTO `tb_user_menu` VALUES ('27', '8', 'e8543ad4a081e16686be51317b888f00', '0', '测试是', '测试是', '1397117244', '1397117244');
INSERT INTO `tb_user_menu` VALUES ('28', '8', '313dc71ee986826273e9a75df4eefd8d', '0', '测试是', '测试是', '1397117244', '1397117244');
INSERT INTO `tb_user_menu` VALUES ('29', '8', '28486ff59f3c7e2001da304c6bfda91c', '0', '测试是', '测试是', '1397117244', '1397117244');
INSERT INTO `tb_user_menu` VALUES ('30', '11', '134f34825e4f179f4355bb8bc369ead0', '0', '测试是', '测试是', '1397117741', '1397117741');
INSERT INTO `tb_user_menu` VALUES ('31', '11', 'f607c898371146232b4fd31ce8b8c0b9', '0', '测试是', '测试是', '1397117741', '1397117741');
INSERT INTO `tb_user_menu` VALUES ('32', '11', 'e8543ad4a081e16686be51317b888f00', '0', '测试是', '测试是', '1397117741', '1397117741');
INSERT INTO `tb_user_menu` VALUES ('33', '11', '313dc71ee986826273e9a75df4eefd8d', '0', '测试是', '测试是', '1397117741', '1397117741');
INSERT INTO `tb_user_menu` VALUES ('34', '11', '28486ff59f3c7e2001da304c6bfda91c', '0', '测试是', '测试是', '1397117741', '1397117741');
INSERT INTO `tb_user_menu` VALUES ('35', '2', '970ee07bcf77cf54e167c83a5e6d3c27', '0', '超级管理员', '超级管理员', '1397287094', '1397287094');
INSERT INTO `tb_user_menu` VALUES ('36', '2', '134f34825e4f179f4355bb8bc369ead0', '0', '超级管理员', '超级管理员', '1397287094', '1397287094');
INSERT INTO `tb_user_menu` VALUES ('37', '2', 'f607c898371146232b4fd31ce8b8c0b9', '0', '超级管理员', '超级管理员', '1397287094', '1397287094');
INSERT INTO `tb_user_menu` VALUES ('38', '2', 'e8543ad4a081e16686be51317b888f00', '0', '超级管理员', '超级管理员', '1397287094', '1397287094');
INSERT INTO `tb_user_menu` VALUES ('39', '2', '313dc71ee986826273e9a75df4eefd8d', '0', '超级管理员', '超级管理员', '1397287094', '1397287094');
INSERT INTO `tb_user_menu` VALUES ('40', '2', '28486ff59f3c7e2001da304c6bfda91c', '0', '超级管理员', '超级管理员', '1397287094', '1397287094');
INSERT INTO `tb_user_schedule` VALUES ('1', '1', '1397260800', '1397692800', '我的日程1', '今天去办社保 版里了', '正常', '1', '超级管理员', '超级管理员', '1397265793', '1397288857');
INSERT INTO `tb_user_schedule` VALUES ('2', '1', '1397520000', '1397779200', '我的日程2', '今天下班去接小孩,去接好了', '已删除', '1', '超级管理员', '超级管理员', '1397267173', '1397280758');
INSERT INTO `tb_user_schedule` VALUES ('3', '1', '1397520000', '1397606400', '我日日程32323', '几天能哈哈sas ，再次修噶', '已删除', '1', '超级管理员', '超级管理员', '1397267537', '1397280317');
INSERT INTO `tb_user_schedule` VALUES ('4', '1', '1397260800', '1398297600', '12号到24好', '12号到24好12号到24好12号到24好12号到24好', '正常', '1', '超级管理员', '超级管理员', '1397283072', '1397283072');
INSERT INTO `tb_work_log` VALUES ('1', '1', '我的日程1', '今天去办社保', '正常', '超级管理员', '超级管理员', '1397265793', '1397265793');
INSERT INTO `tb_work_log` VALUES ('2', '1', '我的日程2', '今天下班去接小孩', '正常', '超级管理员', '超级管理员', '1397267173', '1397267173');
INSERT INTO `tb_work_log` VALUES ('3', '1', '我日日程3', '几天能哈哈sas 环境阿莎哈啥', '正常', '超级管理员', '超级管理员', '1397267537', '1397267537');
INSERT INTO `tb_work_log` VALUES ('4', '1', '今天去桥头测量', '问题1：\r\n哈哈是爱上\r\n问题2\r\nhashash\r\n问题3\r\n与哈市', '已删除', '超级管理员', '超级管理员', '1397288917', '1397289147');
INSERT INTO `tb_work_log` VALUES ('5', '1', '测试测试', '爱喝啥啥爱上哈啥是撒', '正常', '超级管理员', '超级管理员', '1397293478', '1397293478');

