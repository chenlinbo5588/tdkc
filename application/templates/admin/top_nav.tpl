    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">网站后台管理</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="{url_path('admin','change_password',array(),true)}">修改密码</a></li>
            <li><a href="{url_path('logout','index',array(),true)}">{$userProfile['account']} 退出</a></li>
          </ul>
          <form class="navbar-form navbar-right">
            {*<input type="text" class="form-control" placeholder="Search...">*}
          </form>
        </div>
      </div>
    </div>