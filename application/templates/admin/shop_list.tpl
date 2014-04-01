
          <h1 class="page-header">店铺管理</h1>

          <div class="row placeholders">
            <ul class="nav nav-pills">
                <li><a href="{url_path('shop','add',array(),true)}">+增加店铺</a></li>
             </ul>
          </div>

          <h2 class="sub-header">店铺列表</h2>
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>店铺名称</th>
                  <th>店铺地址</th>
                  <th>店铺负责人</th>
                  <th>手机号码</th>
                  <th>固定电话</th>
                  <th>当前状态</th>
                  <th>创建时间</th>
                  <th>更新时间</th>
                  <th>操作</th>
                </tr>
              </thead>
              <tbody>
               {foreach from=$list item=item}
                <tr>
                  <td>{$item['shop_id']}</td>
                  <td>{$item['shop_name']}</td>
                  <td>{$item['address']}</td>
                  <td>{$item['manager']}</td>
                  <td>{$item['mobile']}</td>
                  <td>{$item['tel']}</td>
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
