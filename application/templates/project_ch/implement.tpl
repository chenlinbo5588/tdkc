{include file="common/main_header.tpl"}
            
            <div class="span12">
                <form name="listform" action="" method="post">
                <table class="table">
                    <thead>
                        <tr>
                            <th>登记编号</th>
                            <th>登记名称</th>
                            <th>类型</th>
                            <th>状态</th>
                            <th>创建人</th>
                            <th>创建时间</th>
                            <th>最后修改人</th>
                            <th>最后修改时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           <td>{$item['project_no']}</td>
                           <td><a href="{url_path('project_ch','task','id=')}{$item['id']}">{$item['name']|escape}</a></td>
                           <td>{$item['type']}</td>
                           <td>{$item['status']}</td>
                           <td>{$item['creator']}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>{$item['updator']}</td>
                           <td>{$item['updatetime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               <a class="addlog" href="javascript:void(0);" data-id="{$item['id']}" data-href="{url_path('project_ch','log','id=')}{$item['id']}">添加日志</a>
                            </td>
                        </tr>
                        {foreachelse}
                            <tr>
                                <td colspan="9">找不到数据</td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
                </form>
                {include file="pagination.tpl"}
                
             </div>
             
            <script>
                $(function(){
                    $("a.addlog").bind("click",function(e){
                        $.jBox("get:{url_path('project_ch','log','id=')}" + $(e.target).attr("data-id"),{ title:"添加项目日志",width:600,height:600});
                    });
                    
                });
                
             </script>
             
{include file="common/main_footer.tpl"}