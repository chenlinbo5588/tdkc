{include file="common/main_header.tpl"}
            {if $action == 'index'}
            <div class="searchform row-fluid">
                <form action="{url_path('project_gh')}" method="get" name="searchform">
                    <input type="hidden" value="project_gh" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="{$action}" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            {*<label><strong>流水号</strong><input type="text" name="project_no" style="width:150px;" value="{$smarty.get.project_no}" placeholder="请输入流水号"/></label>*}
                            <label><strong>登记名称</strong><input type="text" name="name" style="width:100px;" value="{$smarty.get.name}" placeholder="请输入登记名称"/></label>
                            <label><strong>联系单位</strong><input type="text" name="union_name" style="width:100px;" value="{$smarty.get.union_name}" placeholder="请输入联系单位名称"/></label>
                            <label><strong>登记日期开始</strong><input type="text" name="sdate" style="width:90px;" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.get.sdate}"/></label>
                            <label><strong>登记日期结束</strong><input type="text" name="edate" style="width:90px;" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.get.edate}"/></label>
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
                                    <option value="已通过初审" {if $smarty.get.status == '已通过初审'}selected{/if}>已通过初审</option>
                                    <option value="已提交复审" {if $smarty.get.status == '已提交复审'}selected{/if}>已提交复审</option>
                                    <option value="已通过复审" {if $smarty.get.status == '已通过复审'}selected{/if}>已通过复审</option>
                                    <option value="项目已提交" {if $smarty.get.status == '项目已提交'}selected{/if}>项目已提交</option>
                                    <option value="已收费" {if $smarty.get.status == '已收费'}selected{/if}>已收费</option>
                                    <option value="已归档" {if $smarty.get.status == '已归档'}selected{/if}>已归档</option>
                                </select>
                            </label>
                            {*<label><input type="checkbox" name="view" value="my" {if $smarty.get.view == 'my'}checked{/if}/>我登记的</label>*}
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            <input type="button" name="refresh" class="btn btn-primary" value="刷新" onclick="javascript:location.reload();"/>
                        </li>
                        
                     </ul>
                </form>
            </div>
            {/if}                
            <div class="span12">
                <div class="operator">
                    <a href="javascript:selAll('id[]');" class="coolbg">全选</a>
                    <a href="javascript:noSelAll('id[]');" class="coolbg">取消</a>
                    {auth name="project_gh+delete"}<a href="javascript:deleteSelAll('id[]');" class="coolbg">删除</a>{/auth}
                    {auth name="project_gh+sendone"}<a href="javascript:sendAll('id[]');" class="coolbg">发送</a>{/auth}
                </div>
                <form name="listform" action="" method="post">
                <table class="table">
                    <thead>
                        <tr>
                            {auth name="project_gh+delete"}<th></th>{/auth}
                            <th>登记日期</th>
                            <th>登记人</th>
                            <th>登记名称</th>
                            <th>类型</th>
                            <th>接洽人</th>
                            <th>电话</th>
                            <th>乡镇街道</th>
                            <th>联系单位</th>
                            <th>联系人</th>
                            <th>联系人电话</th>
                            <th>项目负责人</th>
                            <th>当前操作人</th>
                            <th>状态</th>
                            <th>要求完成时间</th>
                            <th>备注</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           {auth name="project_gh+delete"}<td class="center"><input type="checkbox" name="id[]" value="{$item['id']}"/></td>{/auth}
                           <td>{$item['createtime']|date_format:"Y-m-d"}</td>
                           <td>{$item['creator']}</td>
                           <td><a href="{url_path('project_gh','task','id=')}{$item['id']}">{$item['name']|escape}</a></td>
                           <td>{$item['type']}</td>
                           <td>{$item['manager']}</td>
                           <td>{$item['manager_mobile']}</td>
                           <td>{$item['region_name']}</td>
                           <td>{$item['union_name']|escape}</td>
                           <td>{$item['contacter']}</td>
                           <td>{$item['contacter_mobile']}</td>
                           <td>{$item['pm']}</td>
                           <td>{$item['sendor']}</td>
                           <td><a href="javascript:void(0);" class="popwin"  data-title="项目流转历史" data-href="{url_path('search','getghmods','project_id=')}{$item['id']}">{$item['status']}</a></td>
                           <td>{if $item['end_date']}{$item['end_date']|date_format:"Y-m-d"}{/if}</td>
                           <td>{$item['descripton']}</td>
                           <td>
                               <div class="loading" style="display:none;"></div>
                               {auth name="project_gh+edit"}<a href="{url_path('project_gh','edit','id=')}{$item['id']}">编辑</a>{/auth}
                               {auth name="project_gh+dispatch"}
                               {if $item['sendor_id'] == $userProfile['id'] && $item['status'] == '已发送'}
                               <a href="javascript:void(0);" data-href="{url_path('project_gh','dispatch','id=')}{$item['id']}" data-title="项目布置" class="popwin">布置</a>
                               {/if}
                               {/auth}
                               
                               {auth name="project_gh+implement"}
                               {if $item['sendor_id'] == $userProfile['id'] && $item['status'] == '已布置'}
                               <a href="javascript:void(0);" data-href="{url_path('project_gh','implement','id=')}{$item['id']}" data-title="项目实施" class="popwin">实施</a>
                               {/if}
                               {/auth}
                               
                               {auth name="project_gh+complete"}
                               {if $item['sendor_id'] == $userProfile['id'] && $item['status'] == '已实施'}
                               <a href="javascript:void(0);" data-href="{url_path('project_gh','complete','id=')}{$item['id']}" data-title="完成作业" class="popwin">完成作业</a>
                               {/if}
                               {/auth}
                               
                               {auth name="project_gh+check"}
                               {if $item['sendor_id'] == $userProfile['id'] && $item['status'] == '已完成'}
                               <a href="javascript:void(0);" data-href="{url_path('project_gh','check','id=')}{$item['id']}" data-title="提交初审" class="popwin">提交初审</a>
                               {else if $item['sendor_id'] == $userProfile['id'] && $item['status'] == '已通过初审'}
                               <a href="javascript:void(0);" data-href="{url_path('project_gh','check','id=')}{$item['id']}" data-title="提交复审" class="popwin">提交复审</a>    
                               {/if}
                               {/auth}
                               
                               {auth name="project_gh+first_sh"}
                               {if $item['sendor_id'] == $userProfile['id'] && $item['status'] == '已提交初审'}
                               <a href="javascript:void(0);" data-href="{url_path('project_gh','first_sh','id=')}{$item['id']}" data-title="初审" class="popwin">初审</a>
                               {/if}
                               {/auth}
                               
                               {auth name="project_gh+second_sh"}
                               {if $item['sendor_id'] == $userProfile['id'] && $item['status'] == '已提交复审'}
                               <a href="javascript:void(0);" data-href="{url_path('project_gh','second_sh','id=')}{$item['id']}" data-title="复审" class="popwin">复审</a>
                               {/if}
                               {/auth}
                               
                               {auth name="project_gh+second_sh"}
                               {if $item['sendor_id'] == $userProfile['id'] && $item['status'] == '已通过复审'}
                               <a href="javascript:void(0);" data-href="{url_path('project_gh','handle','id=')}{$item['id']}" data-title="项目提交" class="popwin">项目提交</a>
                               {/if}
                               {/auth}
                               
                               {auth name="project_gh+fee"}
                               {if $item['sendor_id'] == $userProfile['id'] && $item['status'] == '项目已提交'}
                               <a href="javascript:void(0);" data-href="{url_path('project_gh','fee','id=')}{$item['id']}" data-title="收费" class="popwin">收费</a>
                               {/if}
                               {/auth}
                               
                               {auth name="project_gh+archive"}
                               {if $item['sendor_id'] == $userProfile['id'] && $item['status'] == '已收费'}
                               <a href="javascript:void(0);" data-href="{url_path('project_gh','archive','id=')}{$item['id']}" data-title="归档" class="popwin">归档</a>
                               {/if}
                               {/auth}
                               
                               {auth name="project_gh+tuihui"}
                               {if $item['sendor_id'] == $userProfile['id'] && $item['status'] != '新增'}
                                    <a href="javascript:void(0);" data-href="{url_path('project_gh','tuihui','id=')}{$item['id']}" data-title="项目退回" class="popwin">退回</a>
                               {/if}
                               {/auth}
                               {auth name="project_gh+log"}<a class="popwin" href="javascript:void(0);" data-id="{$item['id']}" data-title="项目日志"  data-href="{url_path('project_gh','log','id=')}{$item['id']}">添加日志</a>{/auth}
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
                
                $(function(){
                    $("a.popwin").bind("click",function(e){
                        var url = $(e.target).attr("data-href");
                        $.jBox("get:" + url,{ title:$(e.target).attr("data-title"),width:800,height:600,buttons:{ "关闭" : 1}});
                    });
                });
                
             </script>
             
             {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}