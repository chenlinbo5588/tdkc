<!-- top menu -->
<div id="topbar" class="navbar navbar-inverse navbar-fixed-top">
    <ul id="topmenu" class="nav nav-tabs  pull-left">
        <li {if $smarty.get.c == 'admin'}class="active"{/if}>
            <a href="{url_path('admin')}">首页</a>
        </li>
        <li {if $smarty.get.c == 'personal'}class="active"{/if}>
            <a href="#">个人办公</a>
        </li>
        <li {if $smarty.get.c == 'project_ch'}class="active"{/if}>
            <a href="#">测绘项目</a>
        </li>
        <li {if $smarty.get.c == 'project_gh'}class="active"{/if}>
            <a href="#">规划项目</a>
        </li>
        <li {if $smarty.get.c == 'office'}class="active"{/if}>
            <a href="#">办公室</a>
        </li>
        <li {if $smarty.get.c == 'info'}class="active"{/if}>
            <a href="#">信息中心</a>
        </li>
        <li {if in_array($smarty.get.c,array('system','user','role','dept'))}class="active"{/if}>
            <a href="{url_path('system')}">系统管理</a>
        </li>
    </ul>
    
    <ul id="profile" class="nav nav-tabs pull-right">
        <li><a href="#">{$userProfile['name']}</a></li>
        <li><a href="#">修改密码</a></li>
        <li><a href="{url_path('logout')}">退出</a></li>
    </ul>
</div>
<!-- end of top menu -->
<!-- side menu -->
<div class="sidebar-nav">
    
    <ul class="nav nav-list" {if $smarty.get.c != 'personal'}style="display:none;"{/if}>
        <li class="first"><a href="#">待办事宜</a></li>
        <li><a href="#">点对点消息</a></li>
        <li><a href="#">日程安排</a></li>
        <li><a href="#">我的文件</a></li>
        <li><a href="#">文件共享</a></li>
        <li><a href="#">个人助理</a></li>
        <li><a href="#">个人助理</a></li>
        <li><a href="#">通讯录</a></li>
    </ul>
    <ul class="nav nav-list" {if $smarty.get.c != 'office'}style="display:none;"{/if}>
        <li class="first"><a href="#">人事管理</a></li>
        <li><a href="#">测绘合同</a></li>
        <li><a href="#">文件管理</a></li>
        <li><a href="#">考勤管理</a></li>
        <li><a href="#">工资变动</a></li>
        <li><a href="#">仪器设备</a></li>
        <li><a href="#">耗材库存</a></li>
    </ul>
    <ul class="nav nav-list" {if !in_array($smarty.get.c,array('system','user','role','dept')) }style="display:none;"{/if}>
        <li class="first {if $smarty.get.c == 'user'}active{/if}"><a href="{url_path('user')}">用户管理</a></li>
        <li class="{if $smarty.get.c == 'role'}active{/if}"><a href="{url_path('role')}">角色管理</a></li>
        <li class="{if $smarty.get.c == 'menu'}active{/if}"><a href="{url_path('menu')}">菜单管理</a></li>
        <li class="{if $smarty.get.c == 'dept'}active{/if}"><a href="{url_path('dept')}">组织机构</a></li>
        <li><a href="#">项目类型设置</a></li>
        {*<li><a href="#">短信控制</a></li>*}
    </ul>
</div>
<!-- side menu end -->
<div class="container-fluid" style="margin: 16px 0 0 0;">
    <div style="min-height: 590px;padding:20px;">
        {include file="common/breadcrumb.tpl"}