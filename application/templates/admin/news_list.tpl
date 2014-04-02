
          <h1 class="page-header">新闻公告管理</h1>

          <div class="row placeholders">
            <ul class="nav nav-pills">
                <li><a href="{url_path('news','add','',true)}">+增加新闻公告</a></li>
             </ul>
          </div>

          <!--<h2 class="sub-header">新闻公告列表</h2>-->
          <div class="table-responsive">
            <form role="form" class="form-inline" name="searchForm" action="{url_path('news','search','',true)}" method="get">
                <input type="hidden" name="c" value="news"/>
                <input type="hidden" name="m" value="search"/>
                <div class="form-group">
                    <label for="title">标题</label>
                    <input type="text" class="form-control" name="title" value="{$title}" style="width:300px;" placeholder="搜索:请输入新闻标题"/>
                    <button type="submit" class="btn btn-primary">搜索</button>
                </div>
            </form>
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>标题</th>
                  <th>状态</th>
                  <th>创建时间</th>
                  <th>更新时间</th>
                  <th>操作</th>
                </tr>
              </thead>
              <tbody>
               {foreach from=$list item=item}
                <tr>
                  <td>{$item['news_id']}</td>
                  <td>
                      <p>{$item['title']}</p>
                      <p>{$item['title2']}</p>
                  </td>
                  <td>{$item['status']}</td>
                  <td>{$item['createtime']}</td>
                  <td>{$item['updatetime']}</td>
                  <td>{foreach from=$item['op'] item=op}{$op}{/foreach}</td>
                </tr>
                {/foreach}
              </tbody>
            </table>
            {include file="pagination.tpl"}
            
            <script>
            $(function(){
                $("a.delete").bind("click",function(e){
                    if(confirm("确定要删除改记录吗")){
                        location.href= $(e.target).attr("data-href");
                    }
                });
            });
            </script>
          </div>
