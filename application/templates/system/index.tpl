{include file="common/header.tpl"}
<!-- top menu -->
<div id="topbar" class="navbar navbar-inverse navbar-fixed-top">
    <ul id="topmenu" class="nav nav-tabs  pull-left">
        <li>
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
        <li  class="active">
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
            <li class="active"><a href="#">组织机构</a></li>
            <li><a href="#">角色管理</a></li>
            <li><a href="#">权限管理</a></li>
            <li><a href="#">项目类型设置</a></li>
            <li><a href="#">短信控制</a></li>
        </ul>
    </div>
    
    
    <div style="min-height: 590px;">
        AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
        <div style="height:1000px;"></div>
    
    </div>
</div>
<!--/.fluid-container--> 


{include file="common/footer.tpl"}