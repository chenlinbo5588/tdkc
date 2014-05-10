{include file="common/main_header.tpl"}
        <div class="filebar" >
            <a href="{url_path('pm','receive')}" class="btn"><img src="/img/pm/yd.png" align="top"/>收消息</a>
            <a href="{url_path('pm','send')}" class="btn"><img src="/img/wp/upload_file_icon.gif" align="absmiddle"/>已发消息</a>
            <a href="{url_path('pm','trash')}"class="btn"><img src="/img/wp/folder.gif" align="absmiddle"/>垃圾箱</a>
        </div>
        
        
        
        <div class="searchform row-fluid">
                <form action="{url_path('pm')}" method="get" name="searchform">
                    <input type="hidden" value="pm" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="{$action}" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>开始日期</strong><input type="text" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.get.sdate}"/></label>
                            <label><strong>结束日期</strong><input type="text" name="edate" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.get.edate}"/></label>
                            <label><strong>标题</strong><input type="text" name="title" value="{$smarty.get.title}"/></label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            <a class="addlink" href="{url_path('pm','add')}">添加消息</a>
                        </li>
                     </ul>
                </form>
            </div>
            
            <div class="span12">
                
                <div class="operator">
                    {if $action != 'trash'}
                    <a href="javascript:selAll('id[]');" class="coolbg">全选</a>
                    <a href="javascript:noSelAll('id[]');" class="coolbg">取消</a>
                    {/if}
                    {if $action == 'receive'}
                    <a href="javascript:readedSelAll('id[]');" class="coolbg">设置已读</a>
                    {/if}
                    {if $action != 'trash'}
                    <a href="javascript:deleteSelAll('id[]');" class="coolbg">删除</a>
                    {/if}
                </div>
                {if $data['data']}
                <table class="table">
                    <colgroup>
                        {if $action != 'trash'}<col style="width:25px;"/>{/if}
                        {if $action == 'receive'}<col style="width:40px;"/>{/if}
                        <col style="width:300px;"/>
                        <col style="width:80px;"/>
                        <col style="width:100px;"/>
                        <col style="width:200px;"/>
                    </colgroup>
                    <thead>
                        <tr>
                            {if $action != 'trash'}<th></th>{/if}
                            {if $action == 'receive'}<th>状态</th>{/if}
                            <th>标题</th>
                            <th>发送者</th>
                            <th>接搜者</th>
                            <th>发送时间</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           {if $action != 'trash'}<th class="center"><input type="checkbox" name="id[]" value="{$item['id']}"/></th>{/if}
                           {if $action == 'receive'}<td>{if $item['isnew']}<span class="notice">未读</span>{else}<span class="readed">已读</span>{/if}</td>{/if}
                           <td><a href="javascript:void(0);" class="pm_detail" data-href="{url_path('pm','detail','id=')}{$item['id']}">{$item['title']}</a></td>
                           <td>{$item['creator']}</td>
                           <td>{$item['receivor']}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
                {else}
                    <p>无记录</p>
                {/if}
                {include file="pagination.tpl"}
                
                <form id="delete_form" name="delete_form" action="{url_path('pm','delete')}" method="post">
                    <input type="hidden" name="action" value="{$action}"/>
                    <input type="hidden" name="page" value="{$smarty.get.page}"/>
                    <div class="inputlist">
                    </div>
                </form>
                    
                <form id="setread_form" name="setread_form" action="{url_path('pm','setread')}" method="post">
                    <input type="hidden" name="action" value="{$action}"/>
                    <input type="hidden" name="page" value="{$smarty.get.page}"/>
                    <div class="inputlist">
                    </div>
                </form>
             </div>
             <script>
                function readedSelAll(name){
                    var checked = false;
                    $("#setread_form .inputlist").html('');
                    $("input[name='" +  name + "']").each(function(){
                        if($(this).prop("checked")){
                            checked = true;
                            $('<input type="hidden" name="id[]" value="' + $(this).val() + '"/>').appendTo("#setread_form .inputlist");
                        }
                    });
                    
                    if(!checked){
                        $.jBox.error('至少选择一条记录', '提示');
                    }else{
                        $("#setread_form").submit();
                    }
                }
                
                function deleteSelAll(name){
                    var checked = false;
                    $("#delete_form .inputlist").html('');
                    $("input[name='" +  name + "']").each(function(){
                        if($(this).prop("checked")){
                            checked = true;
                            $('<input type="hidden" name="id[]" value="' + $(this).val() + '"/>').appendTo("#delete_form .inputlist");
                        }
                    });
                    
                    if(!checked){
                        $.jBox.error('至少选择一条记录', '提示');
                    }else{
                        $("#delete_form").submit();
                    }
                }
                
                $(function(){
                    {if $message}
                        $.jBox.tip('{$message}');
                    {/if}
                        
                    $(".pm_detail").bind("click",function(e){
                        var that = $(e.target);
                        
                        $.jBox("get:" + that.attr("data-href"),{ title:"消息详情",width:600 });
                    });
                });
                 
             </script>
            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}