{include file="common/main_header.tpl"}
            <div class="searchform row-fluid">
                <form action="{url_path('project_ch')}" method="get" name="searchform">
                    <input type="hidden" value="project_ch" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="{$action}" name="{config_item('function_trigger')}"/>
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
                            <label><strong>状态</strong>
                                <select name="type" >
                                    <option value="">全部</option>
                                    <option value="新增">新增</option>
                                    <option value="已发送">已发送</option>
                                    <option value="已指派">已指派</option>
                                    <option value="已实施">已实施</option>
                                    <option value="已完成">已完成</option>
                                    <option value="审核中-初审">审核中-初审</option>
                                    <option value="审核中-二审">审核中-二审</option>
                                    <option value="已提交">已提交</option>
                                </select>
                            </label>
                            {*<label><input type="checkbox" name="view" value="my" {if $smarty.get.view == 'my'}checked{/if}/>我登记的</label>*}
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                        </li>
                        
                     </ul>
                </form>
            </div>
            <div class="span12">
                
                {if $action == 'send' }
                <div class="operator">
                    <a href="javascript:selAll('id[]');" class="coolbg">全选</a>
                    <a href="javascript:noSelAll('id[]');" class="coolbg">取消</a>
                    <a href="javascript:deleteSelAll('id[]');" class="coolbg">删除</a>
                    <a href="javascript:sendAll('id[]');" class="coolbg">发送</a>
                    {*<a href="javascript:tuihuiSelAll('id[]');" class="coolbg">退回</a>*}
                </div>
                {/if}
                <form name="listform" action="" method="post">
                <table class="table">
                    <thead>
                        <tr>
                            {if $action == 'send' }<th></th>{/if}
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
                           {if $action == 'send' }
                           <td class="center"><input type="checkbox" name="id[]" value="{$item['id']}"/></td>
                           {/if}
                           <td>{$item['project_no']}</td>
                           <td>
                           {if $action}
                           <a href="{url_path('project_ch','task','id=')}{$item['id']}">{$item['name']|escape}</a>
                           {else}
                           <a href="javascript:void(0);" class="info" data-id="{$item['id']}">{$item['name']|escape}</a>
                           {/if}
                           </td>
                           <td>{$item['type']}</td>
                           <td>{$item['status']}</td>
                           <td>{$item['creator']}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>{$item['updator']}</td>
                           <td>{$item['updatetime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               {if $action == 'send' }
                                {if $item['status'] == '新增' && $item['user_id'] == $userProfile['id']}
                                <a href="{url_path('project_ch','edit','id=')}{$item['id']}">编辑</a>
                                {/if}
                               {/if}
                            </td>
                            
                        </tr>
                        {foreachelse}
                            <tr>
                                <td colspan="{if $action == 'send' }9{else}8{/if}">找不到数据</td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
                </form>
                {include file="pagination.tpl"}
                
             </div>
             <script>
                 function deleteSelAll(name){
                    var checked = false;
                    $("input[name='" +  name + "']").each(function(){
                        if($(this).prop("checked")){
                            checked = true;
                        }
                    });
                    
                    if(!checked){
                        $.jBox.error('至少选择一条记录', '提示');
                    }else{
                        
                    }
                }
                
                {*
                function tuihuiSelAll(name){
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
                        $.jBox("get:{url_path('project_ch','tuihui')}" + '&' + param,{ title:"退回",width:500,buttons:{ } });
                    }
                }
                *}
                
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
                        $.jBox("get:{url_path('project_ch','sendOne')}" + '&' + param,{ title:"发送",width:300,buttons:{ } });
                    }
                }
                
                $(function(){
                    $("a.info").bind("click",function(e){
                        $.jBox("get:{url_path('project_ch','detail','id=')}" + $(e.target).attr("data-id"),{ title:"测绘项目详情",width:800,height:600});
                    });
                });
                
             </script>
             
             {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}