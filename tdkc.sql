/*
MySQL Data Transfer
Source Host: 192.168.171.128
Source Database: tdkc
Target Host: 192.168.171.128
Target Database: tdkc
Date: 2014/4/13 20:54:16
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
-- Table structure for tb_announces
-- ----------------------------
CREATE TABLE `tb_announces` (
  `annid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `show_order` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_hidden` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_expand` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `in_time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`annid`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

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
-- Table structure for tb_files
-- ----------------------------
CREATE TABLE `tb_files` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0',
  `file_name` varchar(510) NOT NULL,
  `file_key` char(8) NOT NULL DEFAULT '',
  `file_short_url` char(6) NOT NULL DEFAULT '',
  `file_extension` varchar(10) NOT NULL DEFAULT '',
  `is_image` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_dir` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `file_mime` varchar(50) NOT NULL DEFAULT '',
  `file_description` text NOT NULL,
  `file_store_path` varchar(50) NOT NULL DEFAULT '',
  `file_real_name` varchar(255) NOT NULL DEFAULT '',
  `file_md5` char(32) NOT NULL DEFAULT '',
  `file_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '如果是目录，则表示该目录下包含的文件大小的合计',
  `thumb_size` int(10) unsigned NOT NULL DEFAULT '0',
  `file_views` int(10) unsigned NOT NULL DEFAULT '0',
  `file_downs` int(10) unsigned NOT NULL DEFAULT '0',
  `in_share` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_locked` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_checked` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_public` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `status` varchar(10) NOT NULL DEFAULT '正常',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '0 表示不过期 大于0 到期时间戳',
  `cate_id` int(10) unsigned NOT NULL DEFAULT '0',
  `subcate_id` int(10) unsigned NOT NULL DEFAULT '0',
  `in_recycle` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL,
  `updatetime` int(10) unsigned NOT NULL,
  `ip` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

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
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

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
  `title` varchar(200) NOT NULL DEFAULT '' COMMENT '标题',
  `content` text NOT NULL,
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
  `title` varchar(200) NOT NULL DEFAULT '' COMMENT '标题',
  `content` text NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT '正常',
  `auto_notify` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否自动提醒 1=是 0=否',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_create` (`createtime`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_title` (`title`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_work_log
-- ----------------------------
CREATE TABLE `tb_work_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(16) NOT NULL,
  `title` varchar(200) NOT NULL DEFAULT '' COMMENT '标题',
  `content` text NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT '正常',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_create` (`createtime`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_title` (`title`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

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
INSERT INTO `ci_sessions` VALUES ('4ef0d5863c0d319cc28246c26d349700', '192.168.1.121', 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)', '1397452526', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"kCANfuBVJ4eszTRYRfRdVUYuh6ak6KsVnIGFSbJyxPLKb608IwN0umAAIAwZ7Ux5AZd5PbxkCTn26vBdeBiLnQ==\";}}');
INSERT INTO `ci_sessions` VALUES ('ffb2ce1506316b85a63e2e20a4a78fd9', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36', '1397205411', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"kRJw2JR6inWlvlhj9KzkZ/8G9AmXmmB13CfErjGHr8ZcYMkdIch9a8THRCl8CoK95+hR+60zb2Cv43Fj4igURg==\";}}');
INSERT INTO `ci_sessions` VALUES ('44c6cc967da3c61c1ce61f2fe30008dd', '127.0.0.1', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .N', '1397197774', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"TylL5/Y8iIIeJxlX1hXsjH0ppArCk/pbpW5q5Gz2YxTByS3S3s6wQp9kDmEWTnP3UAwVr/G1/93RekPzgKOVBQ==\";}}');
INSERT INTO `ci_sessions` VALUES ('ffdb6630abeab9caf1e31740ec3efec9', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36', '1397279546', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"ywNbTQT/baKlWXx8P770fK7S+Q0lQsU6Iq5S5mrNkQL236zjGPMfMoi2PFJsB5TOtFID129C8nZLmC41QPm94w==\";}}');
INSERT INTO `ci_sessions` VALUES ('af1e383c75cfc3dba5d153c8fe969c17', '127.0.0.1', 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)', '1397293623', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"fI14L+vObQwVyeG3aogiM6cQMUncbyhma6Pjy/XEMsv7VcY9G/RK2mWhrajZZR088CH1Eekib2wW1oCSGPPrjw==\";}}');
INSERT INTO `ci_sessions` VALUES ('04666c2717192135538ad97c53528839', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36', '1397293714', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:2:\"11\";s:7:\"account\";s:3:\"t51\";s:4:\"name\";s:9:\"测试是\";s:2:\"gh\";s:2:\"55\";s:3:\"psw\";s:88:\"dS+ICJQPGQU+gyuZxvTsKMfKPdwzbxiASkM6t5G+UDJirAzPWHeIig4l6Qto/kOL8ldaGPbfybg8wzH+E64+bg==\";}}');
INSERT INTO `ci_sessions` VALUES ('67a9aa2f10b58cffd92b32026903f9c4', '192.168.171.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36', '1397393509', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"VWAEPFRgBjpcPAdtBjYMYVdlAjBXMF42VWBQYlNnBGcLZ1RnVjAPPFEzBTpTYVNoXD4AOFA0WjFUNwY1BzBUNQ==\";}}');
INSERT INTO `ci_sessions` VALUES ('c35791a225c2b53749bbbdc1e1437ddf', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36', '1397466872', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"FsYNbdOveR00or4dCo2JUnNSPGHd31KaCxMFHf/ohh1uSymub+hMV8smbCBWe5sd/VMPRjI4CYfbbbm9QqZDZg==\";}}');
INSERT INTO `ci_sessions` VALUES ('3c1799e30654de5d7edd1ed92050006b', '192.168.1.121', 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)', '1397453315', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"1m8Fd+b3JAwzTadk8DqZQZiGviv9++9RP1rIs8J62GTGoKTh2yCw6ZewQd+bo5DXDQv+mbRNKRQlBhU42SRgUQ==\";}}');
INSERT INTO `ci_sessions` VALUES ('f4e3188715d1ce07b4585508795e467e', '192.168.1.121', 'Shockwave Flash', '1397453365', '');
INSERT INTO `ci_sessions` VALUES ('10a362fc36a14e09da357ac7c5eaf3a5', '192.168.1.121', 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)', '1397453394', '');
INSERT INTO `ci_sessions` VALUES ('530ce66251b6a755905b55b752bf1334', '192.168.1.121', 'Shockwave Flash', '1397453415', '');
INSERT INTO `ci_sessions` VALUES ('83f0357b9d1eec52abcc2f9683a81ff7', '192.168.1.121', 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)', '1397457213', 'a:1:{s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"IRHpDDB6YaBHY3bX93aUVhxY34bptpFw3S6k+rt8CBTLuqhsIUN50cZWSQWyU3sHuz5FUJbAE/zhgQix0fyu5A==\";}}');
INSERT INTO `ci_sessions` VALUES ('8b005a6ad7f19d18fb90d77fe0363b3f', '192.168.1.121', 'Shockwave Flash', '1397457222', '');
INSERT INTO `ci_sessions` VALUES ('ffc871692d4c6c4ed257408a1529a776', '192.168.1.121', 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)', '1397457267', '');
INSERT INTO `ci_sessions` VALUES ('1bbe25f41c2004158d82405c8a4aaba5', '192.168.1.121', 'Shockwave Flash', '1397457272', '');
INSERT INTO `ci_sessions` VALUES ('161a8391dc19bbd8f790b1f166434b30', '192.168.1.121', 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)', '1397457287', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:2:\"id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"fp6CjNZfPRobldkfnamEAff/HuceBqSdTxzOxg66TxIjoVXLd2ZPl8wSWhV76od8etVp11sSdxtup17ThM9jIA==\";}}');
INSERT INTO `ci_sessions` VALUES ('a0ffd077fed616e31a9445daafdb7e03', '192.168.1.121', 'Shockwave Flash', '1397457303', '');
INSERT INTO `ci_sessions` VALUES ('c52c961d0a50c3402bf017dea3ca477b', '192.168.1.121', 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)', '1397459201', '');
INSERT INTO `ci_sessions` VALUES ('e991873bb97a78580c1e93de980eb689', '192.168.1.121', 'Shockwave Flash', '1397459204', '');
INSERT INTO `tb_announces` VALUES ('2', '1', 'PHPDISK v5.1 新增功能与修正列表', '[新增]分布式服务器管理员可自行添加ID作为FTP与文件的对应标识。<br>[新增]公共文件,缩短地址，网盘文件的直接显示外链地址。<br>[新增]如果是共享文件/公共文件，点击后有下载页面，私人文件直接下载。<br>[新增]文件管理添加目录显示。<br>[新增]充值选项，自动转化为积分。<br>[新增]MYSQL数据库类提交错误时，输入email，处理完发邮件通知用户。<br>[修正]整合，在linux下无法整合UC，通信不成功问题。<br>[修正]GBK上传添加描述、标签出现乱码问题。<br>[修正]Mysql类出错时在linux主机下的目录问题。<br>[修正]只能设置为共享的文件才能使用提取码功能。<br>[修正]使用代码广告会令页面不断跳转。', '0', '0', '1', '1286171569');
INSERT INTO `tb_announces` VALUES ('3', '1', 'PHPDISK v5.3.0新增功能与改进', '[新增]支持PHPWIND论坛整合。<br>[新增]新增几种广告管理，让管理员更好的投放广告。<br>[新增]支持常用的文件在线浏览，如mp3播放，flash播放等支持。<br>[新增]PHPDISK可实现在线检测自动升级，比起传统手动升级更加便捷。<br>[新增]标题排序，用户可以直接点击表头，对网盘中的文件进行排序，如，按大小、按日期等。<br>[新增]引入用户经验等级模式，用户使用网盘，帐号会自动升级。<br>[新增]增加首页幻灯片展示效果，可以让网盘更具个性效果。<br>[新增]用户充值方式支持使用网银接口与易宝支付接口。<br>[修正]公告模式的改进，阅读、显示更加人性化。<br>[修正]改进结构系统布局UI，引入更华丽的ajax效果，大大提升用户交互体验。<br>[修正]在生成外链的[img]代码直接变成&lt;IMG src=\"\"&gt;  代码，多一种模式的显示。<br>[修正]修正UCenter整合时出现用户重复记录问题。<br>[修正]修正搜索引擎直接收录文件问题，而不能通过文件展示页下载的问题。<br>[修正]分布服务器插件，可支持子程序配置，同时可支持FTP中转上传与子程序直接上传的形式。大大减少主服务器资源消耗。<br>[修正]外链，提取码等可由管理员设定，后台使用了大部分的开关形式。<br>[修正]SEO插件nginx修正。<br>[修正]移动文件到二级公共文件时文件无法显示问题。<br>[修正]管理员后台更加精细的分类。<br>[修正]修正公共文件显示文件空间不正确问题。', '0', '0', '0', '1288057490');
INSERT INTO `tb_announces` VALUES ('4', '1', 'PHPDisk v5.5.0 新增功能与改进说明', '[增加]添加一键设置所有文件共享。<br>[增加]后台搜索缓存管理。<br>[增加]语言包在线切换功能。<br>[增加]文件替换功能，替换后原文件地址不变，适合做永久链接。<br>[增加]模板SQL 标签{sql[xxx][$v]}{/sql}调用，用户可以通过修改模板，实现对数据库进行个性化的调用。<br>[增加]JS数据调用。<br>[增加]数组调用。<br>[增加]分享工具功能，用户可以通过工具将网盘上的文件资源分享到其他的网站中。<br>[增加]添加后台sitemap功能，管理员可以更快捷定位到管理功能。<br>[增加]添加后台快捷操作面板，整合了后台配置面板，管理员可定义自己常用快捷功能。<br>[优化]优化精简程序核心架构代码，系统运行更快更稳定。<br>[优化]优化下载出现“外链未开启提示”。<br>[优化]将大部分常用的插件集成到系统后台，免去反复安装的麻烦。<br>[修正]分布式服务器出现显示乱码问题。<br>[修正]部分接口无法进行充值转换问题。<br>[修正]充值接口空白问题。<br>[修正]文件浏览页标题，附加上网站标题，方便SEO。<br>[改进]下载提示，更加友好显示文件下载。', '0', '0', '0', '1301419754');
INSERT INTO `tb_announces` VALUES ('5', '1', 'PHPDisk 6.5.0 V-Core系列', '1、引入国际化语言包功能(po , mo)，让系统维护语言包更简洁，进一步向国际化的方向跨进。<br>2、为了兼容所有的浏览器，系统全面放弃iframe 框架结构。<br>3、系统上多处页面上的细节改动，更加合理地布局。<br>4、进一步改进缓存及程序架构底层，速度运营更稳定更快速。<br>5、同一套内核将会针对不同的方向及领域，专业化的方向发展。<br>6、v-core首先将推出FMS(File Manage System) 文件管理系统方向，站长可以将此做成WEB2.0模式的下载站，而内容可以由网站的用户上传。<br>7、公共文件部分的改进，激发此部分的效能。<br>\n8、可自定配置网站后台的管理员入口，增加网站管理员安全。', '0', '0', '0', '1338516732');
INSERT INTO `tb_announces` VALUES ('6', '1', 'PHPDisk 6.8.0 V-Core系列', '新增客户端支持<br>改进分布服务配置<br>修正现有版本存在的BUG<br>优化程序架构<br>改进缓存体系，修正共享文件无法操作', '0', '0', '0', '1357737649');
INSERT INTO `tb_contacts` VALUES ('1', '我的日程1', '0', '今天去办社保', '', '', '', '已删除', '超级管理员', '超级管理员', '1397265793', '1397265793');
INSERT INTO `tb_contacts` VALUES ('2', '我的日程2', '0', '今天下班去接小孩', '', '', '', '正常', '超级管理员', '超级管理员', '1397267173', '1397267173');
INSERT INTO `tb_contacts` VALUES ('3', '我日日程3', '0', '几天能哈哈sas 环境阿莎哈啥', '', '', '', '已删除', '超级管理员', '超级管理员', '1397267537', '1397267537');
INSERT INTO `tb_contacts` VALUES ('4', '今天去桥头测量', '0', '问题1：\r\n哈哈是爱上\r\n11', '', '', '', '已删除', '超级管理员', '超级管理员', '1397288917', '1397289147');
INSERT INTO `tb_contacts` VALUES ('5', '陈林波', '0', '12345454541', '232323', '34324-12123', '成寿寺哈哈撒花爱喝啥啥', '已删除', '超级管理员', '超级管理员', '1397293071', '1397293102');
INSERT INTO `tb_dept` VALUES ('1', '慈溪市土地勘测规划设计院有限公司', '0', '正常', '超级管理员', '超级管理员', '1396940368', '1397102570');
INSERT INTO `tb_dept` VALUES ('2', '测绘室', '1', '正常', '超级管理员', '超级管理员', '1396940709', '1397019054');
INSERT INTO `tb_dept` VALUES ('3', '规划室', '1', '正常', '超级管理员', '超级管理员', '1396940729', '1396940729');
INSERT INTO `tb_dept` VALUES ('4', '规划小组1', '3', '正常', '超级管理员', '超级管理员', '1396943952', '1396945961');
INSERT INTO `tb_dept` VALUES ('5', '规划小组1-1', '3', '正常', '超级管理员', '超级管理员', '1396944491', '1396945590');
INSERT INTO `tb_dept` VALUES ('6', '规划小组23', '2', '正常', '超级管理员', '超级管理员', '1396945623', '1397007158');
INSERT INTO `tb_dept` VALUES ('7', '我的部门', '1', '正常', '超级管理员', '超级管理员', '1396945686', '1397005414');
INSERT INTO `tb_dept` VALUES ('8', '我的部门1', '2', '正常', '超级管理员', '超级管理员', '1396945711', '1397016491');
INSERT INTO `tb_dept` VALUES ('9', '我的,部门', '1', '正常', '超级管理员', '超级管理员', '1397003617', '1397003617');
INSERT INTO `tb_dept` VALUES ('10', '规划室3', '3', '正常', '超级管理员', '超级管理员', '1397024764', '1397024764');
INSERT INTO `tb_dept` VALUES ('11', '测量组', '1', '正常', '超级管理员', '超级管理员', '1397102762', '1397102762');
INSERT INTO `tb_dept` VALUES ('12', '测量1组', '11', '正常', '超级管理员', '超级管理员', '1397102772', '1397102772');
INSERT INTO `tb_dept` VALUES ('13', '测量2组', '11', '正常', '超级管理员', '超级管理员', '1397102781', '1397102781');
INSERT INTO `tb_dept` VALUES ('14', '测量3组', '11', '正常', '超级管理员', '超级管理员', '1397195082', '1397197246');
INSERT INTO `tb_files` VALUES ('1', '0', '新建文本文档 (3)', 'LGyVO3AH', '', 'txt', '0', '0', 'application/octet-stream', '', '2014/04/13/', '8e9fe03ce8b4a8d598236404d9b8bb0c', '', '161', '0', '0', '0', '0', '0', '1', '0', '1', '正常', '0', '0', '0', '0', '', '', '0', '0', '192.168.171.1');
INSERT INTO `tb_files` VALUES ('2', '0', '办公暂存.txt', 'Oe7TKFbo', '', '.txt', '0', '0', 'application/octet-stream', '', '2014/04/14/', 'e340395175141a5c32cec8a63a582f8a', 'e340395175141a5c32cec8a63a582f8a', '5094', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397445426', '1397445426', '');
INSERT INTO `tb_files` VALUES ('3', '0', '新建 WPS文字 文档.doc', 'V4lFbfjs', '', '.doc', '0', '0', 'application/octet-stream', '', '2014/04/14/', '436124ca56abdd0054a7d8fbff28754a', '436124ca56abdd0054a7d8fbff28754a', '29184', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397445583', '1397445583', '127.0.0.1');
INSERT INTO `tb_files` VALUES ('4', '0', 'jquery.min.js', 'zsAyVyoC', '', '.js', '0', '0', 'application/octet-stream', '', '2014/04/14/', 'b612e5635e5f880b04c8a25d5b7a91a8', 'b612e5635e5f880b04c8a25d5b7a91a8', '94840', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397445714', '1397445714', '127.0.0.1');
INSERT INTO `tb_files` VALUES ('5', '0', 'Noname2.txt', 'NF9O0LpB', '', '.txt', '0', '0', 'application/octet-stream', '', '2014/04/14/', 'b48a1385f917adf5f625290f98e0aef5', 'b48a1385f917adf5f625290f98e0aef5', '135', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397445965', '1397445965', '127.0.0.1');
INSERT INTO `tb_files` VALUES ('6', '0', '首页1.jpg', 'jrUZYoNG', '', '.jpg', '1', '0', 'application/octet-stream', '', '2014/04/14/', '6679ae4a132b42e6854b97eacb0a7732', '6679ae4a132b42e6854b97eacb0a7732', '45344', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397446337', '1397446337', '127.0.0.1');
INSERT INTO `tb_files` VALUES ('7', '0', '开发摘要.txt', '7rnzqdXd', '', '.txt', '0', '0', 'application/octet-stream', '', '2014/04/14/', 'ff035980f0980e627bff22684ecf2b6c', 'ff035980f0980e627bff22684ecf2b6c', '97', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397449363', '1397449363', '127.0.0.1');
INSERT INTO `tb_files` VALUES ('8', '0', '临时.txt', '18oNXPZw', '', '.txt', '0', '0', 'application/octet-stream', '', '2014/04/14/', 'cef170a4afd89d955d2bbc00e037a41e', 'cef170a4afd89d955d2bbc00e037a41e', '10899', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397449363', '1397449363', '127.0.0.1');
INSERT INTO `tb_files` VALUES ('9', '0', 'tdkc.sql', 'aULYNMRc', '', '.sql', '0', '0', 'application/octet-stream', '', '2014/04/14/', '60d54cde55619d86aa23a1b459c5bb96', '60d54cde55619d86aa23a1b459c5bb96', '70772', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397450219', '1397450219', '127.0.0.1');
INSERT INTO `tb_files` VALUES ('10', '0', '办公暂存.txt', 'X8HeCxbm', '', '.txt', '0', '0', 'application/octet-stream', '', '2014/04/14/', 'ef1a24eda7532e2f947aea0c081e0853', 'ef1a24eda7532e2f947aea0c081e0853', '5094', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397450267', '1397450267', '127.0.0.1');
INSERT INTO `tb_files` VALUES ('11', '0', 'forums.txt', 'f54SpSan', '', '.txt', '0', '0', 'application/octet-stream', '', '2014/04/14/', '94666df8bfc5165b7f08d38c19ccdc23', '94666df8bfc5165b7f08d38c19ccdc23', '24861', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397450500', '1397450500', '127.0.0.1');
INSERT INTO `tb_files` VALUES ('12', '0', 'Noname1.txt', '8fjlZtRj', '', '.txt', '0', '0', 'application/octet-stream', '', '2014/04/14/', '96fca9b22a98a24d4cda73330d0a820d', '96fca9b22a98a24d4cda73330d0a820d', '1331', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397450566', '1397450566', '127.0.0.1');
INSERT INTO `tb_files` VALUES ('13', '0', 'Noname11.txt', 'dxkJ9xNw', '', '.txt', '0', '0', 'application/octet-stream', '', '2014/04/14/', '52b3724460660949435cf66b2cb3d730', '52b3724460660949435cf66b2cb3d730', '155', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397450566', '1397450566', '127.0.0.1');
INSERT INTO `tb_files` VALUES ('14', '0', 'Water lilies.jpg', 'WyCzMQHf', '', '.jpg', '1', '0', 'application/octet-stream', '', '2014/04/14/', 'd7be908d509d97b3fc2b651668706495', 'd7be908d509d97b3fc2b651668706495', '83794', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397453365', '1397453365', '192.168.1.121');
INSERT INTO `tb_files` VALUES ('15', '0', 'Winter.jpg', 'tU9I7YnD', '', '.jpg', '1', '0', 'application/octet-stream', '', '2014/04/14/', '3145136fa0065fd91df551fec584d6cd', '3145136fa0065fd91df551fec584d6cd', '105542', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397453365', '1397453365', '192.168.1.121');
INSERT INTO `tb_files` VALUES ('16', '0', 'Blue hills.jpg', 'YS6okMbh', '', '.jpg', '1', '0', 'application/octet-stream', '', '2014/04/14/', 'fd4cc9ad7d77b319077823fc31005c8f', 'fd4cc9ad7d77b319077823fc31005c8f', '28521', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397453415', '1397453415', '192.168.1.121');
INSERT INTO `tb_files` VALUES ('17', '0', 'Sunset.jpg', 'c8a4oBhq', '', '.jpg', '1', '0', 'application/octet-stream', '', '2014/04/14/', 'fa86ce74dbef8a19599e1d35c8d99d1d', 'fa86ce74dbef8a19599e1d35c8d99d1d', '71189', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397453415', '1397453415', '192.168.1.121');
INSERT INTO `tb_files` VALUES ('18', '0', 'Water lilies.jpg', 'NYgWWDcv', '', '.jpg', '1', '0', 'application/octet-stream', '', '2014/04/14/', 'eae30044fd3d6bc3d9c74164af5f2978', 'eae30044fd3d6bc3d9c74164af5f2978', '83794', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397453415', '1397453415', '192.168.1.121');
INSERT INTO `tb_files` VALUES ('19', '0', 'Winter.jpg', 'FPV4VGvY', '', '.jpg', '1', '0', 'application/octet-stream', '', '2014/04/14/', 'b1487e1ff5bacfd04c7533fe200ff50d', 'b1487e1ff5bacfd04c7533fe200ff50d', '105542', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397453415', '1397453415', '192.168.1.121');
INSERT INTO `tb_files` VALUES ('20', '0', 'Sunset.jpg', 'qeIeW172', '', '.jpg', '1', '0', 'application/octet-stream', '', '2014/04/14/', '28792b672f561632acb73bb521365326', '28792b672f561632acb73bb521365326', '71189', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397457222', '1397457222', '192.168.1.121');
INSERT INTO `tb_files` VALUES ('21', '0', 'Water lilies.jpg', 'A7Sq2pMy', '', '.jpg', '1', '0', 'application/octet-stream', '', '2014/04/14/', '3837e469a3bda810247f30aadc2e2524', '3837e469a3bda810247f30aadc2e2524', '83794', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397457222', '1397457222', '192.168.1.121');
INSERT INTO `tb_files` VALUES ('22', '0', 'Winter.jpg', 'VN0GhOuF', '', '.jpg', '1', '0', 'application/octet-stream', '', '2014/04/14/', '08d7d7f765d9d0f2f2c21614f6c3a07c', '08d7d7f765d9d0f2f2c21614f6c3a07c', '105542', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397457222', '1397457222', '192.168.1.121');
INSERT INTO `tb_files` VALUES ('23', '0', 'Water lilies.jpg', 'DUTBEfaU', '', '.jpg', '1', '0', 'application/octet-stream', '', '2014/04/14/', '12bb1152d0cdef5356ae57b90893e028', '12bb1152d0cdef5356ae57b90893e028', '83794', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397457272', '1397457272', '192.168.1.121');
INSERT INTO `tb_files` VALUES ('24', '0', 'Winter.jpg', 'eFWL94D9', '', '.jpg', '1', '0', 'application/octet-stream', '', '2014/04/14/', 'be93c8bb40d10e3af881490f53ceed56', 'be93c8bb40d10e3af881490f53ceed56', '105542', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397457303', '1397457303', '192.168.1.121');
INSERT INTO `tb_files` VALUES ('25', '0', 'Sunset.jpg', 'qSr2aOkT', '', '.jpg', '1', '0', 'application/octet-stream', '', '2014/04/14/', '91f1db55c02d309268d6f18d581e5fc5', '91f1db55c02d309268d6f18d581e5fc5', '71189', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397457327', '1397457327', '192.168.1.121');
INSERT INTO `tb_files` VALUES ('26', '0', 'Water lilies.jpg', 'X7Sxl0n7', '', '.jpg', '1', '0', 'application/octet-stream', '', '2014/04/14/', 'f8e2a93f665d3a36dfbb5fe870bce405', 'f8e2a93f665d3a36dfbb5fe870bce405', '83794', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397457327', '1397457327', '192.168.1.121');
INSERT INTO `tb_files` VALUES ('27', '0', 'Winter.jpg', 'lfMvxwZl', '', '.jpg', '1', '0', 'application/octet-stream', '', '2014/04/14/', '90976f88e0f7b31c48b941d854ed71c5', '90976f88e0f7b31c48b941d854ed71c5', '105542', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397457327', '1397457327', '192.168.1.121');
INSERT INTO `tb_files` VALUES ('28', '0', 'Winter.jpg', 'eYugGtTl', '', '.jpg', '1', '0', 'application/octet-stream', '', '2014/04/14/', 'b398f8fae2e3a6be3829766af9a5189a', 'b398f8fae2e3a6be3829766af9a5189a', '105542', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397459204', '1397459204', '192.168.1.121');
INSERT INTO `tb_files` VALUES ('29', '0', '新建 WPS文字 文档.doc', 'fQU4iX2Q', '', '.doc', '0', '0', 'application/octet-stream', '', '2014/04/14/', '47e1551b828b7ab20bafdf624eab3a2f', '47e1551b828b7ab20bafdf624eab3a2f', '29184', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397459378', '1397459378', '127.0.0.1');
INSERT INTO `tb_files` VALUES ('30', '0', 'html5shiv.js', 'SkXR6AQ5', '', '.js', '0', '0', 'application/octet-stream', '', '2014/04/14/', '29afce6305f0d932ee3c60e968c77dd4', '29afce6305f0d932ee3c60e968c77dd4', '2380', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397459411', '1397459411', '127.0.0.1');
INSERT INTO `tb_files` VALUES ('31', '0', '办公暂存.txt', '2U7QUef2', '', '.txt', '0', '0', 'application/octet-stream', '', '2014/04/14/', '4a3a005577c5b78000311eef8b31b9bd', '4a3a005577c5b78000311eef8b31b9bd', '5094', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397459434', '1397459434', '127.0.0.1');
INSERT INTO `tb_files` VALUES ('32', '0', '我的图片', '', '', '', '0', '1', '', '', '', '', '', '106987', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '超级管理员', '超级管理员', '1397463501', '1397463501', '127.0.0.1');
INSERT INTO `tb_files` VALUES ('33', '0', '96181024.jpg', 'CGInwO24', '', '.jpg', '1', '0', 'application/octet-stream', '', '2014/04/14/', 'd66246874aa6d4d61931fdb5b5170af1', 'd66246874aa6d4d61931fdb5b5170af1', '102484', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397465319', '1397465319', '127.0.0.1');
INSERT INTO `tb_files` VALUES ('34', '32', '首页1.jpg', 'PxNYDaXC', '', '.jpg', '1', '0', 'application/octet-stream', '', '2014/04/14/', '64cca7e5b9c74b58aece647720504524', '64cca7e5b9c74b58aece647720504524', '45344', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397466146', '1397466146', '127.0.0.1');
INSERT INTO `tb_files` VALUES ('35', '32', '首页2.jpg', 'ZQhuc9td', '', '.jpg', '1', '0', 'application/octet-stream', '', '2014/04/14/', 'aee47fe5d6caf121bb5d2771f0ec2b84', 'aee47fe5d6caf121bb5d2771f0ec2b84', '49991', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397466146', '1397466146', '127.0.0.1');
INSERT INTO `tb_files` VALUES ('36', '32', 'discuz备份.txt', 'qz105N1R', '', '.txt', '0', '0', 'application/octet-stream', '', '2014/04/14/', 'e270652b5dbdad6f9f17c8f2b6a6d66a', 'e270652b5dbdad6f9f17c8f2b6a6d66a', '15031', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397466884', '1397466884', '127.0.0.1');
INSERT INTO `tb_files` VALUES ('37', '32', '临时2.txt', 'CV5jrpMg', '', '.txt', '0', '0', 'application/octet-stream', '', '2014/04/14/', '518f653436900b8971872813eb85ae74', '518f653436900b8971872813eb85ae74', '3473', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397466899', '1397466899', '127.0.0.1');
INSERT INTO `tb_files` VALUES ('38', '32', '96181024.jpg', 'TijpHbEO', '', '.jpg', '1', '0', 'application/octet-stream', '', '2014/04/14/', '2b5986ab95b985bc333373e8cfac1228', '2b5986ab95b985bc333373e8cfac1228', '102484', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397466995', '1397466995', '127.0.0.1');
INSERT INTO `tb_files` VALUES ('39', '32', 'config_global.php', 'eTFdVXbR', '', '.php', '0', '0', 'application/octet-stream', '', '2014/04/14/', 'f3b0094de5a77abb9f246972bf443817', 'f3b0094de5a77abb9f246972bf443817', '4503', '0', '0', '0', '0', '0', '0', '0', '1', '正常', '0', '0', '0', '0', '', '', '1397466995', '1397466995', '127.0.0.1');
INSERT INTO `tb_menu` VALUES ('7', '134f34825e4f179f4355bb8bc369ead0', '系统管理', 'c=system&m=index', '0', '0', '正常', '超级管理员', '超级管理员', '1397093146', '1397099842');
INSERT INTO `tb_menu` VALUES ('8', '970ee07bcf77cf54e167c83a5e6d3c27', '用户管理', 'c=user&m=index', '7', '0', '正常', '超级管理员', '超级管理员', '1397093444', '1397099915');
INSERT INTO `tb_menu` VALUES ('9', 'e8543ad4a081e16686be51317b888f00', '添加用户', 'c=user&m=add', '8', '0', '正常', '超级管理员', '超级管理员', '1397093473', '1397097714');
INSERT INTO `tb_menu` VALUES ('10', '28486ff59f3c7e2001da304c6bfda91c', '删除用户', 'c=user&m=delete', '8', '0', '正常', '超级管理员', '超级管理员', '1397097650', '1397097650');
INSERT INTO `tb_menu` VALUES ('11', '313dc71ee986826273e9a75df4eefd8d', '修改用户', 'c=user&m=edit', '8', '0', '正常', '超级管理员', '超级管理员', '1397097669', '1397097669');
INSERT INTO `tb_menu` VALUES ('12', 'f607c898371146232b4fd31ce8b8c0b9', '设置用户权限', 'c=user&m=auth', '8', '0', '正常', '超级管理员', '超级管理员', '1397097750', '1397462577');
INSERT INTO `tb_menu` VALUES ('13', '1abecad3711029b404d0aeae6ad221d5', '角色管理', 'c=role&m=index', '7', '0', '正常', '超级管理员', '超级管理员', '1397463403', '1397463472');
INSERT INTO `tb_menu` VALUES ('14', '09ec56ee1ce3b4350edaf65e386cc483', '添加角色', 'c=role&m=add', '13', '0', '正常', '超级管理员', '超级管理员', '1397463444', '1397463444');
INSERT INTO `tb_role` VALUES ('1', '公共权限角色', '1', '正常', '超级管理员', '超级管理员', '1396596593', '1396596593');
INSERT INTO `tb_role` VALUES ('2', '系统管理员', '1', '正常', '超级管理员', '超级管理员', '1396596746', '1396596746');
INSERT INTO `tb_role` VALUES ('3', '角色3修改', '0', '正常', '超级管理员', '超级管理员', '1396596772', '1396597289');
INSERT INTO `tb_role` VALUES ('4', '人事角色', '0', '正常', '超级管理员', '超级管理员', '1396597337', '1396597337');
INSERT INTO `tb_role` VALUES ('5', '数据录入员', '0', '正常', '超级管理员', '超级管理员', '1396597346', '1396597346');
INSERT INTO `tb_role` VALUES ('6', '财务人员', '0', '正常', '超级管理员', '超级管理员', '1396597353', '1396597353');
INSERT INTO `tb_role` VALUES ('7', '测量组人员修改', '0', '正常', '超级管理员', '超级管理员', '1396597362', '1396597425');
INSERT INTO `tb_role` VALUES ('8', '再来一个', '0', '正常', '超级管理员', '超级管理员', '1396932672', '1396932672');
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
INSERT INTO `tb_user` VALUES ('6', '323', '我的姓名', '', '', '', '5', 'dd1f73c3a84bee119fd6cd206a5ace31', 'm', '0', '0000-00-00 00:00:00', '13795467940', '', '', '0', '', '11', '1', '0', '', '1397347200', '', '', '', '1398384000', '0', '正常', '就爱上哈都是', '就爱上哈都是', '1396573128', '1396573128');
INSERT INTO `tb_user` VALUES ('7', '554', '说得很好', '', '', '', '6', 'd91976a8add1886a83b6bd7cc7a6632d', 'f', '0', '0000-00-00 00:00:00', '13795467940', '', '', '0', '', '11', '1', '0', '', '1397347200', '', '', '', '1398384000', '0', '正常', '就爱上哈都是', '超级管理员', '1396578418', '1397108268');
INSERT INTO `tb_user` VALUES ('8', 'ddff', 'hjasdr23', '', '', '', '7', 'd91976a8add1886a83b6bd7cc7a6632d', 'f', '0', '0000-00-00 00:00:00', '13795467942', '', '', '0', '', '11', '1', '0', '', '1397347200', '', '', '', '1397347200', '0', '正常', '就爱上哈都是', '超级管理员', '1396579538', '1397097107');
INSERT INTO `tb_user` VALUES ('9', 'czb', '陈暂波', '', '', '', '12', 'd91976a8add1886a83b6bd7cc7a6632d', 'm', '0', '0000-00-00 00:00:00', '15195467940', '', '', '0', '', '11', '1', '0', '', '1271116800', '', '助理工程师', '', '1398816000', '0', '正常', '就爱上哈都是', '超级管理员', '1396588781', '1397024664');
INSERT INTO `tb_user` VALUES ('10', 'zwt', '张五天', '', '', '', '22', 'd91976a8add1886a83b6bd7cc7a6632d', 'm', '0', '0000-00-00 00:00:00', '13795467840', '', '', '0', '', '11', '1', '0', '', '1397433600', '', '', '', '1398384000', '0', '正常', '就爱上哈都是', '超级管理员', '1396589286', '1397007924');
INSERT INTO `tb_user` VALUES ('11', 't51', '测试是', '', '', '', '55', '641003ad022f3b62ba2ef7273d1a17a6', 'm', '0', '0000-00-00 00:00:00', '13795467941', '', '', '0', '', '11', '1', '5', '', '1397001600', '', '', '', '1398470400', '0', '正常', '超级管理员', '测试是', '1397109730', '1397118975');
INSERT INTO `tb_user` VALUES ('12', 'my1', '我的名字', '', '', '', '234', 'dd1f73c3a84bee119fd6cd206a5ace31', 'm', '0', '0000-00-00 00:00:00', '13795467940', '', '', '0', '', '11', '1', '0', '', '1240963200', '', '', '', '1396310400', '0', '正常', '超级管理员', '超级管理员', '1397198001', '1397292999');
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
INSERT INTO `tb_user_schedule` VALUES ('2', '1', '1397520000', '1397779200', '我的日程2', '今天下班去接小孩,去接好了', '正常', '1', '超级管理员', '超级管理员', '1397267173', '1397280758');
INSERT INTO `tb_user_schedule` VALUES ('3', '1', '1397520000', '1397606400', '我日日程32323', '几天能哈哈sas ，再次修噶', '正常', '1', '超级管理员', '超级管理员', '1397267537', '1397280317');
INSERT INTO `tb_user_schedule` VALUES ('4', '1', '1397260800', '1398297600', '12号到24好', '12号到24好12号到24好12号到24好12号到24好', '正常', '1', '超级管理员', '超级管理员', '1397283072', '1397283072');
INSERT INTO `tb_work_log` VALUES ('1', '1', '我的日程1', '今天去办社保', '正常', '超级管理员', '超级管理员', '1397265793', '1397265793');
INSERT INTO `tb_work_log` VALUES ('2', '1', '我的日程2', '今天下班去接小孩', '正常', '超级管理员', '超级管理员', '1397267173', '1397267173');
INSERT INTO `tb_work_log` VALUES ('3', '1', '我日日程3', '几天能哈哈sas 环境阿莎哈啥', '正常', '超级管理员', '超级管理员', '1397267537', '1397267537');
INSERT INTO `tb_work_log` VALUES ('4', '1', '今天去桥头测量', '问题1：\r\n哈哈是爱上\r\n问题2\r\nhashash\r\n问题3\r\n与哈市', '正常', '超级管理员', '超级管理员', '1397288917', '1397289147');
INSERT INTO `tb_work_log` VALUES ('5', '1', '测试测试', '爱喝啥啥爱上哈啥是撒', '正常', '超级管理员', '超级管理员', '1397293478', '1397293478');
INSERT INTO `tb_work_log` VALUES ('6', '1', '我介绍的或多或少的是速度', '哈哈撒花花洒撒是', '正常', '超级管理员', '超级管理员', '1397383274', '1397383274');

