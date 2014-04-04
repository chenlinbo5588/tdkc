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
-- Table structure for tb_dept
-- ----------------------------
CREATE TABLE `tb_dept` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '门部名称',
  `up_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级机构ID',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_menu
-- ----------------------------
CREATE TABLE `tb_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `auth_key` varchar(16) NOT NULL,
  `name` varchar(20) NOT NULL,
  `url` varchar(30) NOT NULL DEFAULT '' COMMENT 'url地址',
  `up_id` int(10) unsigned NOT NULL DEFAULT '0',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

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
  `status` varchar(10) NOT NULL DEFAULT '正常',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_name_status` (`name`,`status`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_role_menu
-- ----------------------------
CREATE TABLE `tb_role_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(10) unsigned NOT NULL DEFAULT '0',
  `auth_key` varchar(16) NOT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0 表示正常 1 表示已经失效',
  `creator` varchar(20) NOT NULL DEFAULT '' COMMENT '创建者名称',
  `updator` varchar(20) NOT NULL DEFAULT '' COMMENT '更新者名称',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

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
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
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
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `idx_account` (`account`),
  UNIQUE KEY `idx_gh` (`gh`),
  KEY `idx_status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tb_user_event
-- ----------------------------
CREATE TABLE `tb_user_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(16) NOT NULL,
  `title` varchar(30) NOT NULL DEFAULT '' COMMENT 'url地址',
  `content` varchar(100) NOT NULL DEFAULT '',
  `status` varchar(10) NOT NULL DEFAULT '' COMMENT '未处理,已处理',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
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
  `auth_key` varchar(16) NOT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0 表示正常 1 表示已经失效',
  `creator` varchar(20) NOT NULL DEFAULT '' COMMENT '创建者名称',
  `updator` varchar(20) NOT NULL DEFAULT '' COMMENT '更新者名称',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `ci_sessions` VALUES ('170bda462e02fb80a9aa00674a8cb3a9', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36', '1396342038', '');
INSERT INTO `ci_sessions` VALUES ('95d2c5c077437909c6340ac5e300e703', '172.27.35.2', 'Mozilla/4.0 (compatible; MSIE 9.0; Windows NT 5.1; Trident/5.0)', '1396576897', '');
INSERT INTO `ci_sessions` VALUES ('d00705e1b75df2915d67fa909cb73682', '172.27.35.2', 'Mozilla/4.0 (compatible; MSIE 9.0; Windows NT 5.1; Trident/5.0)', '1396577520', '');
INSERT INTO `ci_sessions` VALUES ('6301c578dd61626f05a759da5cefe77c', '127.0.0.1', 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)', '1396581623', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:28:{s:7:\"user_id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:7:\"id_card\";s:1:\"0\";s:5:\"email\";s:1:\"0\";s:10:\"alias_name\";s:0:\"\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"PibPSe5i08ue9a0IXgpIJYzHRwvZV2ZFRNwcNROL3k92OgzrqxrAUGu4vxgreBygF93KYm/zU9lmS0mBbk9k4w==\";s:3:\"sex\";s:1:\"m\";s:3:\"age\";s:1:\"0\";s:8:\"birthday\";s:19:\"0000-00-00 00:00:00\";s:6:\"mobile\";s:0:\"\";s:3:\"tel\";s:0:\"\";s:7:\"address\";s:0:\"\";s:2:\"sm\";s:1:\"0\";s:10:\"virtual_no\";s:0:\"\";s:11:\"school_name\";s:0:\"\";s:15:\"graduation_date\";s:1:\"0\";s:5:\"major\";s:0:\"\";s:9:\"job_title\";s:0:\"\";s:11:\"current_job\";s:0:\"\";s:10:\"enter_date\";s:1:\"0\";s:6:\"locked\";s:1:\"0\";s:6:\"status\";s:6:\"正常\";s:7:\"creator\";s:5:\"admin\";s:7:\"updator\";s:5:\"admin\";s:10:\"createtime\";s:1:\"0\";s:10:\"updatetime\";s:1:\"0\";}}');
INSERT INTO `ci_sessions` VALUES ('a61e7b141711eec56459ca7418a5e72a', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36', '1396600087', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:7:\"user_id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"wZLzyV4gcXVaG3GC5VABtXuC5JbuffNRXgHK6S7n+HAlWQbQ3KC9WpjlKozcsDdbONL0rScr7LX9nW8oV7JOCg==\";}}');
INSERT INTO `ci_sessions` VALUES ('939579e0f05bc1e8d2e8fb6e985ab9d7', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; rv:27.0) Gecko/20100101 Firefox/27.0', '1396596193', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:5:{s:7:\"user_id\";s:2:\"10\";s:7:\"account\";s:3:\"zwt\";s:4:\"name\";s:9:\"张五天\";s:2:\"gh\";s:2:\"22\";s:3:\"psw\";s:88:\"Et22e3/wIIHWrLrEiBzQSlBGZNlDNZDevuovnWZ8E2aN056Aa/xQPNg97vv0Md2GyztsyXO7qY30XD2l1Saa8w==\";}}');
INSERT INTO `ci_sessions` VALUES ('181b18d65aeed4a98f1da35141886a32', '127.0.0.1', 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR ', '1396595026', '');
INSERT INTO `ci_sessions` VALUES ('114406f7c5f4c4708286ade6241b4215', '172.27.35.2', 'Mozilla/4.0 (compatible; MSIE 9.0; Windows NT 5.1; Trident/5.0)', '1396596959', '');
INSERT INTO `ci_sessions` VALUES ('2bf4588e51b90d2cd8c88a2624cacb6e', '127.0.0.1', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .N', '1396581722', '');
INSERT INTO `ci_sessions` VALUES ('db4f5472e484f6846f2c30e9fe5e8990', '127.0.0.1', 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR ', '1396581725', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:28:{s:7:\"user_id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:7:\"id_card\";s:1:\"0\";s:5:\"email\";s:1:\"0\";s:10:\"alias_name\";s:0:\"\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"NytKviQq73g5SVN1BzHfWmuKuI+W/hgfBy358IPQTPCWgSQuw7np9VXObmr1heZGpb93Sf4gb/XNL4LTgwk7fQ==\";s:3:\"sex\";s:1:\"m\";s:3:\"age\";s:1:\"0\";s:8:\"birthday\";s:19:\"0000-00-00 00:00:00\";s:6:\"mobile\";s:0:\"\";s:3:\"tel\";s:0:\"\";s:7:\"address\";s:0:\"\";s:2:\"sm\";s:1:\"0\";s:10:\"virtual_no\";s:0:\"\";s:11:\"school_name\";s:0:\"\";s:15:\"graduation_date\";s:1:\"0\";s:5:\"major\";s:0:\"\";s:9:\"job_title\";s:0:\"\";s:11:\"current_job\";s:0:\"\";s:10:\"enter_date\";s:1:\"0\";s:6:\"locked\";s:1:\"0\";s:6:\"status\";s:6:\"正常\";s:7:\"creator\";s:5:\"admin\";s:7:\"updator\";s:5:\"admin\";s:10:\"createtime\";s:1:\"0\";s:10:\"updatetime\";s:1:\"0\";}}');
INSERT INTO `ci_sessions` VALUES ('24cc280846cd05cf93edbfab01f72c2f', '127.0.0.1', 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; .N', '1396584998', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:28:{s:7:\"user_id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:7:\"id_card\";s:1:\"0\";s:5:\"email\";s:1:\"0\";s:10:\"alias_name\";s:0:\"\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"BqTDRUWn9IA4Pd6hzu5LK0JCvmkow9JEX/DhfwpkPe2o0EXMwr4no1HJfMAuU1GO/ZHpkuEQXk9b2HBDA56LEw==\";s:3:\"sex\";s:1:\"m\";s:3:\"age\";s:1:\"0\";s:8:\"birthday\";s:19:\"0000-00-00 00:00:00\";s:6:\"mobile\";s:0:\"\";s:3:\"tel\";s:0:\"\";s:7:\"address\";s:0:\"\";s:2:\"sm\";s:1:\"0\";s:10:\"virtual_no\";s:0:\"\";s:11:\"school_name\";s:0:\"\";s:15:\"graduation_date\";s:1:\"0\";s:5:\"major\";s:0:\"\";s:9:\"job_title\";s:0:\"\";s:11:\"current_job\";s:0:\"\";s:10:\"enter_date\";s:1:\"0\";s:6:\"locked\";s:1:\"0\";s:6:\"status\";s:6:\"正常\";s:7:\"creator\";s:5:\"admin\";s:7:\"updator\";s:5:\"admin\";s:10:\"createtime\";s:1:\"0\";s:10:\"updatetime\";s:1:\"0\";}}');
INSERT INTO `ci_sessions` VALUES ('d79c57d5f807aad029790b5a69b696cd', '127.0.0.1', 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR ', '1396593585', 'a:2:{s:9:\"user_data\";s:0:\"\";s:7:\"profile\";a:28:{s:7:\"user_id\";s:1:\"1\";s:7:\"account\";s:5:\"admin\";s:4:\"name\";s:15:\"超级管理员\";s:7:\"id_card\";s:1:\"0\";s:5:\"email\";s:1:\"0\";s:10:\"alias_name\";s:0:\"\";s:2:\"gh\";s:1:\"0\";s:3:\"psw\";s:88:\"itK5sxCay3VtKBgwT8csKba7S2rxUM+bosfSQat4Ze+ZaOjlVrPuaBSpokdexlfrliHKPYD38LYI/gvpmLHG7Q==\";s:3:\"sex\";s:1:\"m\";s:3:\"age\";s:1:\"0\";s:8:\"birthday\";s:19:\"0000-00-00 00:00:00\";s:6:\"mobile\";s:0:\"\";s:3:\"tel\";s:0:\"\";s:7:\"address\";s:0:\"\";s:2:\"sm\";s:1:\"0\";s:10:\"virtual_no\";s:0:\"\";s:11:\"school_name\";s:0:\"\";s:15:\"graduation_date\";s:1:\"0\";s:5:\"major\";s:0:\"\";s:9:\"job_title\";s:0:\"\";s:11:\"current_job\";s:0:\"\";s:10:\"enter_date\";s:1:\"0\";s:6:\"locked\";s:1:\"0\";s:6:\"status\";s:6:\"正常\";s:7:\"creator\";s:5:\"admin\";s:7:\"updator\";s:5:\"admin\";s:10:\"createtime\";s:1:\"0\";s:10:\"updatetime\";s:1:\"0\";}}');
INSERT INTO `ci_sessions` VALUES ('b81eaa87485e9089cfa38128a1f2a4b4', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36', '1396590502', '');
INSERT INTO `tb_role` VALUES ('1', '测试角色', '正常', '超级管理员', '超级管理员', '1396596593', '1396596593');
INSERT INTO `tb_role` VALUES ('2', '我的', '正常', '超级管理员', '超级管理员', '1396596746', '1396596746');
INSERT INTO `tb_role` VALUES ('3', '角色3修改', '正常', '超级管理员', '超级管理员', '1396596772', '1396597289');
INSERT INTO `tb_role` VALUES ('4', '系统管理员', '正常', '超级管理员', '超级管理员', '1396597337', '1396597337');
INSERT INTO `tb_role` VALUES ('5', '数据录入员', '正常', '超级管理员', '超级管理员', '1396597346', '1396597346');
INSERT INTO `tb_role` VALUES ('6', '财务人员', '正常', '超级管理员', '超级管理员', '1396597353', '1396597353');
INSERT INTO `tb_role` VALUES ('7', '测量组人员修改', '已删除', '超级管理员', '超级管理员', '1396597362', '1396597425');
INSERT INTO `tb_user` VALUES ('1', 'admin', '超级管理员', '0', '0', '', '0', 'ea021abea3e9ac7a0f172f65336c0250', 'm', '0', '0000-00-00 00:00:00', '', '', '', '0', '', '', '0', '', '', '', '1398384000', '0', '正常', 'admin', 'admin', '0', '0');
INSERT INTO `tb_user` VALUES ('2', 'admin1', '爱上dsadsa', '', '', '', '1', 'dd1f73c3a84bee119fd6cd206a5ace31', 'm', '0', '0000-00-00 00:00:00', '13795467940', '', '', '0', '', '', '0', '', '', '', '1398384000', '0', '正常', '超级管理员', '超级管理员', '1396515367', '1396515367');
INSERT INTO `tb_user` VALUES ('3', 'hh12', '测试名字', '', '', '', '2', 'dd1f73c3a84bee119fd6cd206a5ace31', 'm', '0', '0000-00-00 00:00:00', '13795467940', '', '', '0', '', '', '1397347200', '', '', '', '1398384000', '0', '正常', '超级管理员', '超级管理员', '1396515457', '1396515457');
INSERT INTO `tb_user` VALUES ('4', 'h122', '测试名字1', '', '', '', '3', 'dd1f73c3a84bee119fd6cd206a5ace31', 'f', '0', '0000-00-00 00:00:00', '13795467940', '', '', '0', '', '', '0', '', '', '', '1398384000', '0', '正常', '超级管理员', '超级管理员', '1396515749', '1396515749');
INSERT INTO `tb_user` VALUES ('5', '23123', '就爱上哈都是', '', '', '', '4', 'dd1f73c3a84bee119fd6cd206a5ace31', 'm', '0', '0000-00-00 00:00:00', '13795467940', '', '', '0', '', '', '1397347200', '', '', '', '1398384000', '0', '正常', '超级管理员', '超级管理员', '1396572758', '1396572758');
INSERT INTO `tb_user` VALUES ('6', '323', '我的姓名', '', '', '', '5', 'dd1f73c3a84bee119fd6cd206a5ace31', 'm', '0', '0000-00-00 00:00:00', '13795467940', '', '', '0', '', '', '1397347200', '', '', '', '1398384000', '0', '正常', '就爱上哈都是', '就爱上哈都是', '1396573128', '1396573128');
INSERT INTO `tb_user` VALUES ('7', '554', '说得很好', '', '', '', '6', 'dd1f73c3a84bee119fd6cd206a5ace31', 'm', '0', '0000-00-00 00:00:00', '13795467940', '', '', '0', '', '', '0', '', '', '', '1398384000', '0', '已删除', '就爱上哈都是', '就爱上哈都是', '1396578418', '1396578418');
INSERT INTO `tb_user` VALUES ('8', 'ddff', 'hjasdr23', '', '', '', '7', 'd91976a8add1886a83b6bd7cc7a6632d', 'f', '0', '0000-00-00 00:00:00', '13795467942', '', '', '0', '', '', '1397347200', '', '', '', '1397347200', '0', '正常', '就爱上哈都是', '就爱上哈都是', '1396579538', '1396588631');
INSERT INTO `tb_user` VALUES ('9', 'czb', '陈暂波', '', '', '', '12', 'd91976a8add1886a83b6bd7cc7a6632d', 'm', '0', '0000-00-00 00:00:00', '13795467941', '', '', '0', '', '', '1397347200', '', '', '', '1398816000', '0', '正常', '就爱上哈都是', '就爱上哈都是', '1396588781', '1396589163');
INSERT INTO `tb_user` VALUES ('10', 'zwt', '张五天', '', '', '', '22', 'dd1f73c3a84bee119fd6cd206a5ace31', 'm', '0', '0000-00-00 00:00:00', '13795467940', '', '', '0', '', '', '1398384000', '', '', '', '1398384000', '0', '正常', '就爱上哈都是', '就爱上哈都是', '1396589286', '1396589286');
