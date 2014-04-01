/*
MySQL Data Transfer
Source Host: localhost
Source Database: tdkc
Target Host: localhost
Target Database: tdkc
Date: 2014/4/1 ���ڶ� 16:49:03
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for attachment
-- ----------------------------
CREATE TABLE `attachment` (
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
  `role_name` varchar(20) NOT NULL DEFAULT '' COMMENT '角色名称',
  `status` varchar(10) NOT NULL DEFAULT '正常',
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

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
  `name` varchar(10) NOT NULL,
  `id_card` varchar(20) NOT NULL DEFAULT '',
  `email` varchar(40) NOT NULL DEFAULT '',
  `alias_name` varchar(20) NOT NULL DEFAULT '' COMMENT '别名',
  `psw` varchar(32) NOT NULL DEFAULT '' COMMENT '登陆密码',
  `sex` char(2) NOT NULL DEFAULT '男',
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
  `creator` varchar(20) NOT NULL DEFAULT '',
  `updator` varchar(20) NOT NULL DEFAULT '',
  `createtime` int(10) unsigned NOT NULL DEFAULT '0',
  `updatetime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

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
