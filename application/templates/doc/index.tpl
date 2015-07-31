{include file="common/main_header.tpl"}
        <div class="searchform row-fluid">
                <form action="{url_path('doc')}" method="get" name="searchform">
                    <input type="hidden" value="doc" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>排序</strong>
                                <select name="sort">
                                    <option value="title ASC" {if $smarty.get.sort == 'title ASC'}selected{/if}>名称</option>
                                    <option value="title DESC" {if $smarty.get.sort == 'title DESC'}selected{/if}>名称倒序</option>
                                    <option value="sign_time ASC" {if $smarty.get.sort == 'sign_time ASC'}selected{/if}>签订时间</option>
                                    <option value="sign_time DESC" {if $smarty.get.sort == 'sign_time DESC'}selected{/if}>签订时间倒序</option>
                                </select>
                            </label>
                            <label><strong>开始日期</strong><input type="text" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.get.sdate}"/></label>
                            <label><strong>结束日期</strong><input type="text" name="edate" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.get.edate}"/></label>
                            <label><strong>项目名称</strong><input type="text" name="title" value="{$smarty.get.title|escape}"/></label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            <input type="submit" name="excel" class="btn btn-primary" value="导出Excel"/>
                            {auth name="doc+add"}<a class="addlink" href="{url_path('doc','add')}">添加合同</a>{/auth}
                        </li>
                     </ul>
                </form>
            </div>
            <div class="operator">
                <a href="javascript:selAll('id[]');" class="coolbg">全选</a>
                <a href="javascript:noSelAll('id[]');" class="coolbg">取消</a>
                {auth name="doc+delete"}<a href="javascript:deleteSelAll('id[]');" class="coolbg">删除</a>{/auth}
                {auth name="doc+complete"}<a href="javascript:setcomplete('id[]');" class="coolbg">完成</a>{/auth}
            </div>
            <div class="span12">
                {if $data['data']}
                <table class="table">
                    <colgroup>
                        <col style="width:30px;"/>
                        <col style="width:300px;"/>
                        <col style="width:100px;"/>
                        <col style="width:100px;"/>
                        <col style="width:100px;"/>
                        <col style="width:80px;"/>
                        <col style="width:200px;"/>
                        <col style="width:80px;"/>
                        <col style="width:80px;"/>
                        <col style="width:100px;"/>
                        <col style="width:80px;"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th></th>
                            <th>项目名称</th>
                            <th>签订日期</th>
                            <th>合同金额</th>
                            <th>联系人</th>
                            <th>是否完成</th>
                            <th>电子档</th>
                            <th>状态</th>
                            <th>创建人</th>
                            <th>创建日期</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           <td class="center"><input type="checkbox" name="id[]" value="{$item['id']}"/></td>
                           <td>{$item['title']|escape}</td>
                           <td>{$item['sign_time']|date_format:"Y-m-d"}</td>
                           <td>{$item['amount']}</td>
                           <td>{$item['linkman']}</td>
                           <td>{if $item['is_comp'] == 1}已{else}未{/if}完成</td>
                           <td>{if $item['file_id']}<a href="{url_path('attachment','download','id=')}{$item['file_id']}" title="点击下载">{$item['file_name']|escape}</a>{/if}</td>
                           <td>{$item['status']}</td>
                           <td>{$item['creator']}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               {auth name="doc+edit"}<a href="{url_path('doc','edit','id=')}{$item['id']}">编辑</a>{/auth}
                           </td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
                {include file="pagination.tpl"}
                {else}
                    <p>无记录</p>
                {/if}
             </div>
             <form id="delete_form" name="deleteForm" action="{url_path('doc','delete')}" method="post" target="post_iframe">
                <div class="inputlist"></div>
            </form>
                
            <form id="comp_form" name="compForm" action="{url_path('doc','complete')}" method="post" target="post_iframe">
                <div class="inputlist"></div>
            </form>
                
            <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>
             <script>
                 
                 function setcomplete(name){
                    var checked = false;
                    $("input[name='" +  name + "']").each(function(){
                        if($(this).prop("checked")){
                            checked = true;
                        }
                    });

                    $("#comp_form .inputlist").html('');
                    $("input[name='" + name + "']").each(function(index){
                        if($(this).prop("checked")){
                            checked = true;
                            $('<input type="hidden" name="opid[]" value="' + $(this).val() + '"/>').appendTo("#comp_form .inputlist");
                        }
                    });

                    if(!checked){
                        $.jBox.error('至少选择一条记录', '提示');
                    }else{
                        var submit = function (v, h, f) {
                            if (v == true){
                                $("#comp_form").submit();
                            }
                            return true;
                        };

                        $.jBox.confirm("确定要删除吗", "提示", submit, { buttons: { '确定': true, '取消': false} });
                    }
                }
                 
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
                            $('<input type="hidden" name="opid[]" value="' + $(this).val() + '"/>').appendTo("#delete_form .inputlist");
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

                $(function(){
                    {if $message}
                        $.jBox.tip('{$message}');
                    {/if}
                    
                });
             </script>
            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}