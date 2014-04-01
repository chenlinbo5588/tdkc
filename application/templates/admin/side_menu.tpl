    <div class="col-sm-3 col-md-2 sidebar">
                {*
                <ul class="nav nav-sidebar">
                <li class="active"><a href="#">Overview</a></li>
                <li><a href="#">Reports</a></li>
                <li><a href="#">Analytics</a></li>
                <li><a href="#">Export</a></li>
                </ul>
                *}
                <ul class="nav nav-sidebar">
                {*<li {if $sideMenuName == '店铺管理'}class="active"{/if}><a href="{url_path('shop','index',array(),true)}">店铺管理</a></li>*}
                <li {if $sideMenuName == '新闻公告管理'}class="active"{/if}><a href="{url_path('news','index',array(),true)}">新闻公告管理</a></li>
                <li {if $sideMenuName == '轮播图片管理'}class="active"{/if}><a href="{url_path('image','index',array(),true)}">轮播图片管理</a></li>
                </ul>

            </div>