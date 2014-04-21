{include file="common/main_header.tpl"}
            <div class="searchform row-fluid">
                <form action="{url_path('project_ch')}" method="get" name="searchform">
                    <input type="hidden" value="project_ch" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>登记名称</strong><input type="text" name="name" style="width:200px;" value="{$smarty.get.name}" placeholder="请输入登记名称"/></label>
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
                            <label><input type="checkbox" name="view" value="my" {if $smarty.get.view == 'my'}checked{/if}/>我登记的</label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                        </li>
                        
                     </ul>
                </form>
                
               
            </div>
            
            <div class="span12">
                <div class="operator">
                    <a href="javascript:selAll('id[]');" class="coolbg">全选</a>
                    <a href="javascript:noSelAll('id[]');" class="coolbg">取消</a>
                    <a href="javascript:deleteSelAll('id[]');" class="coolbg">删除</a>
                    <a href="javascript:sendAll('id[]');" class="coolbg">发送</a>
                </div>
                
                <table class="table">
                    <thead>
                        <tr>
                            <th>操作</th>
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
                           <td class="center"><input type="checkbox" name="id[]" value="{$item['id']}"/></td>
                           <td>{$item['project_no']}</td>
                           <td><a href="javascript:void(0);" class="info" data-id="{$item['id']}">{$item['name']|escape}</a></td>
                           <td>{$item['type']}</td>
                           <td>{$item['status']}</td>
                           <td>{$item['creator']}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>{$item['updator']}</td>
                           <td>{$item['updatetime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               {if $item['status'] == '新增' && $item['user_id'] == $userProfile['id']}
                               <a href="{url_path('project_ch','edit','id=')}{$item['id']}">编辑</a>
                               <a href="{url_path('project_ch','send','id=')}{$item['id']}">发送</a>
                               {/if}
                            </td>
                        </tr>
                        {foreachelse}
                            <tr>
                                <td colspan="10">找不到数据</td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
                {include file="pagination.tpl"}
                
                <form id="delete_form" name="delete_form" action="{url_path('project_ch','delete')}" method="post">
                    <input type="hidden" name="page" value="{$smarty.get.page}"/>
                    <div class="inputlist">
                    </div>
                </form>
                    
                <form id="send_form" name="send_form" action="{url_path('project_ch','send')}" method="post">
                    <div class="inputlist">
                    </div>
                </form>
                
                
             </div>
             <script>
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
                
                function sendAll(name){
                    var checked = false;
                    $("#send_form .inputlist").html('');
                    $("input[name='" +  name + "']").each(function(){
                        if($(this).prop("checked")){
                            checked = true;
                            $('<input type="hidden" name="id[]" value="' + $(this).val() + '"/>').appendTo("#send_form .inputlist");
                        }
                    });
                    
                    if(!checked){
                        $.jBox.error('至少选择一条记录', '提示');
                    }else{
                        var param = $("form[name=send_form]").serialize();
                        $.jBox("get:{url_path('project_ch','send')}" + '&' + param,{ title:"发送",width:500,height:400});
                    }
                }
                
                $("a.info").bind("click",function(e){
                    $.jBox("get:{url_path('project_ch','detail','id=')}" + $(e.target).attr("data-id"),{ title:"测绘项目详情",width:800,height:600});
                });
             </script>
             
             {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}