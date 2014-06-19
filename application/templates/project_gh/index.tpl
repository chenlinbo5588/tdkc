{include file="common/main_header.tpl"}
            {if $action == 'index'}
            <div class="searchform row-fluid">
                <form action="{url_path('project_gh')}" method="get" name="searchform">
                    <input type="hidden" value="project_gh" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="{$action}" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            {*<label><strong>流水号</strong><input type="text" name="project_no" style="width:150px;" value="{$smarty.get.project_no}" placeholder="请输入流水号"/></label>*}
                            <label><strong>登记名称</strong><input type="text" name="name" style="width:200px;" value="{$smarty.get.name}" placeholder="请输入登记名称"/></label>
                            <label><strong>联系单位名称</strong><input type="text" name="union_name" style="width:200px;" value="{$smarty.get.union_name}" placeholder="请输入联系单位名称"/></label>
                            <label><strong>登记日期开始</strong><input type="text" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.get.sdate}"/></label>
                            <label><strong>登记日期结束</strong><input type="text" name="edate" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.get.edate}"/></label>
                            <label><strong>项目类型</strong>
                                <select name="type" >
                                    <option value="">全部</option>
                                    {foreach from=$projectTypeList item=item}
                                    <option value="{$item['name']}" {if $smarty.get.type == $item['name']}selected{/if}>{$item['name']}</option>
                                    {/foreach}
                                </select>
                            </label>
                            <label><strong>状态</strong>
                                <select name="status" >
                                    <option value="" {if $smarty.get.status == ''}selected{/if}>全部</option>
                                    <option value="新增" {if $smarty.get.status == '新增'}selected{/if}>新增</option>
                                    <option value="已发送" {if $smarty.get.status == '已发送'}selected{/if}>已发送</option>
                                    <option value="已布置" {if $smarty.get.status == '已布置'}selected{/if}>已布置</option>
                                    <option value="已实施" {if $smarty.get.status == '已实施'}selected{/if}>已实施</option>
                                    <option value="已完成" {if $smarty.get.status == '已完成'}selected{/if}>已完成</option>
                                    <option value="已提交初审" {if $smarty.get.status == '已提交初审'}selected{/if}>已提交初审</option>
                                    <option value="已提交复审" {if $smarty.get.status == '已提交复审'}selected{/if}>已提交复审</option>
                                    <option value="已提交" {if $smarty.get.status == '已提交'}selected{/if}>已提交</option>
                                    <option value="项目已提交" {if $smarty.get.status == '项目已提交'}selected{/if}>项目已提交</option>
                                    <option value="已收费" {if $smarty.get.status == '已收费'}selected{/if}>已收费</option>
                                    <option value="已归档" {if $smarty.get.status == '已归档'}selected{/if}>已归档</option>
                                </select>
                            </label>
                            {*<label><input type="checkbox" name="view" value="my" {if $smarty.get.view == 'my'}checked{/if}/>我登记的</label>*}
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                        </li>
                        
                     </ul>
                </form>
            </div>
            {/if}                
            <div class="span12">
                
                {if $action == 'send' }
                <div class="operator">
                    <a href="javascript:selAll('id[]');" class="coolbg">全选</a>
                    <a href="javascript:noSelAll('id[]');" class="coolbg">取消</a>
                    {auth name="project_gh+delete"}<a href="javascript:deleteSelAll('id[]');" class="coolbg">删除</a>{/auth}
                    {auth name="project_gh+sendone"}<a href="javascript:sendAll('id[]');" class="coolbg">发送</a>{/auth}
                </div>
                {/if}
                <form name="listform" action="" method="post">
                <table class="table">
                    <thead>
                        <tr>
                            {if $action == 'send' }<th></th>{/if}
                            <th>登记名称</th>
                            <th>类型</th>
                            <th>联系单位</th>
                            <th>负责人</th>
                            <th>当前操作人</th>
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
                           {if $action == 'send' }
                           <td class="center"><input type="checkbox" name="id[]" value="{$item['id']}"/></td>
                           {/if}
                           <td>
                           {if $action}
                           <a href="{url_path('project_gh','task','id=')}{$item['id']}">{$item['name']|escape}</a>
                           {else}
                           <a href="javascript:void(0);" class="info" data-id="{$item['id']}">{$item['name']|escape}</a>
                           {/if}
                           </td>
                           <td>{$item['type']}</td>
                           <td>{$item['union_name']|escape}</td>
                           <td>{$item['pm']}</td>
                           <td>{$item['sendor']}</td>
                           <td>{$item['status']}</td>
                           <td>{$item['creator']}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>{$item['updator']}</td>
                           <td>{$item['updatetime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               {if $action == 'send' }
                                {if $item['status'] == '新增' && $item['user_id'] == $userProfile['id']}
                                {auth name="project_gh+edit"}<a href="{url_path('project_gh','edit','id=')}{$item['id']}">编辑</a>{/auth}
                                {/if}
                               {/if}
                               
                               {if $action == 'implement'}
                               {auth name="project_gh+log"}<a class="addlog" href="javascript:void(0);" data-id="{$item['id']}" data-href="{url_path('project_gh','log','id=')}{$item['id']}">添加日志</a>{/auth}
                               {/if}
                            </td>
                            
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
                </form>
                {include file="pagination.tpl"}
                <form id="delete_form" name="deleteForm" action="{url_path('project_gh','delete')}" method="post" target="post_iframe">
                    <div class="inputlist">
                        
                    </div>
                </form>
                <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>
             </div>
             <script>
                {if $action == 'send' }
                 function deleteSelAll(name){
                    var checked = false;
                    $("input[name='" +  name + "']").each(function(){
                        if($(this).prop("checked")){
                            checked = true;
                        }
                    });
                    
                    $("#delete_form .inputlist").html('');
                    $("input[name='" + name + "']").each(function(index){
                        if($(this).prop("checked")){
                            checked = true;
                            $('<input type="hidden" name="delete_id[]" value="' + $(this).val() + '"/>').appendTo("#delete_form .inputlist");
                        }
                    });
                    
                    if(!checked){
                        $.jBox.error('至少选择一条记录', '提示');
                    }else{
                        var submit = function (v, h, f) {
                            if (v == true){
                                $("#delete_form").submit();
                            }
                            return true;
                        };

                        $.jBox.confirm("确定要删除吗", "提示", submit, { buttons: { '确定': true, '取消': false} });
                    }
                }
                
                function sendAll(name){
                    var checked = false;
                    $("input[name='" +  name + "']").each(function(){
                        if($(this).prop("checked")){
                            checked = true;
                        }
                    });
                    
                    if(!checked){
                        $.jBox.error('至少选择一条记录', '提示');
                    }else{
                        var param = $("form[name=listform]").serialize();
                        $.jBox("get:{url_path('project_gh','sendone')}" + '&' + param,{ title:"发送",width:300,buttons:{ } });
                    }
                }
                {/if}
                
                $(function(){
                    $("a.addlog").bind("click",function(e){
                        $.jBox("get:{url_path('project_gh','log','id=')}" + $(e.target).attr("data-id"),{ title:"添加项目日志",width:600,height:600});
                    });
                    
                    
                    $("a.info").bind("click",function(e){
                        $.jBox("get:{url_path('project_gh','detail','id=')}" + $(e.target).attr("data-id"),{ title:"规划项目详情",width:800,height:600});
                    });
                });
                
             </script>
             
             {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}