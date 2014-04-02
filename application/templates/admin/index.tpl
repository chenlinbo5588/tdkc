<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="{$KEYWORDS}">
<meta name="description" content="{$DESCRIPTION}">
<meta name="author" content="linbo.chen">
<link rel="shortcut icon" href="/favicon.ico">
<title>{$TITLE}</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/layoutit.css" rel="stylesheet">

<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
<![endif]-->

<!-- Fav and touch icons -->
<link rel="shortcut icon" href="img/favicon.png">
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
</head>

<body>
<!-- top menu -->
<div id="topbar" class="navbar navbar-inverse navbar-fixed-top">
    <ul id="topmenu" class="nav nav-tabs  pull-left">
        <li class="active">
            <a href="{url_path('admin')}">首页</a>
        </li>
        <li>
            <a href="#">个人办公</a>
        </li>
        <li>
            <a href="#">测绘项目</a>
        </li>
        <li>
            <a href="#">规划项目</a>
        </li>
        <li>
            <a href="#">办公室</a>
        </li>
        <li>
            <a href="#">信息中心</a>
        </li>
        <li>
            <a href="{url_path('system')}">系统管理</a>
        </li>
    </ul>
    
    <ul id="profile" class="nav nav-tabs pull-right">
        <li><a href="/">{$userProfile['name']}</a></li>
        <li><a href="#">修改密码</a></li>
        <li><a href="#">退出</a></li>
    </ul>
</div>
<!-- /top_menu end -->
<div class="container-fluid">
    <div class="sidebar-nav">
        <ul class="nav nav-list accordion-group">
            <li class="active first"><a href="#">待办事宜</a></li>
            <li><a href="#">点对点消息</a></li>
            <li><a href="#">日程安排</a></li>
            <li><a href="#">我的文件</a></li>
            <li><a href="#">文件共享</a></li>
            <li><a href="#">个人助理</a></li>
            <li><a href="#">个人助理</a></li>
            <li><a href="#">通讯录</a></li>
        </ul>
        
        <ul class="nav nav-list accordion-group">
            <li class="active"><a href="#">人事管理</a></li>
            <li><a href="#">测绘合同</a></li>
            <li><a href="#">文件管理</a></li>
            <li><a href="#">考勤管理</a></li>
            <li><a href="#">工资变动</a></li>
            <li><a href="#">仪器设备</a></li>
            <li><a href="#">耗材库存</a></li>
        </ul>
        
        <ul class="nav nav-list accordion-group">
            <li class="active"><a href="#">人事管理</a></li>
            <li><a href="#">测绘合同</a></li>
            <li><a href="#">文件管理</a></li>
            <li><a href="#">考勤管理</a></li>
            <li><a href="#">工资变动</a></li>
            <li><a href="#">仪器设备</a></li>
            <li><a href="#">耗材库存</a></li>
        </ul>
        
        <ul class="nav nav-list accordion-group">
            <li class="active"><a href="#">组织机构</a></li>
            <li><a href="#">角色管理</a></li>
            <li><a href="#">权限管理</a></li>
            <li><a href="#">项目类型设置</a></li>
            <li><a href="#">短信控制</a></li>
        </ul>
        
        
        
    </div>
    
    
    <div style="min-height: 590px;">
        
        
    </div>
</div>
<!--/.fluid-container--> 


<!--
<div class="navbar navbar-default navbar-fixed-bottom" role="navigation">
  底部
</div>
-->


</body>
</html>