{include file="common/main_header.tpl"}

        <div class="searchform row-fluid">
                <form action="{url_path('user')}" method="get" name="searchform">
                    <input type="hidden" value="my_event" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>开始日期</strong><input type="text" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.get.sdate}"/></label>
                            <label><strong>结束日期</strong><input type="text" name="edate" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.get.edate}"/></label>
                            <label><strong>标题</strong><input type="text" name="title" value="{$smarty.get.title}"/></label>
                            <label><strong>待办类型</strong>
                                <select name="status">
                                   <option value="">全部</option>
                                   <option value="未处理" {if $smarty.get.status == '未处理'}selected=""{/if}>未处理</option>
                                   <option value="已处理" {if $smarty.get.status == '已处理'}selected=""{/if}>已处理</option>
                                </select>
                            </label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                        </li>
                     </ul>
                </form>
            </div>
            <div class="operator">
                <a href="javascript:selAll('id[]');" class="coolbg">全选</a>
                <a href="javascript:noSelAll('id[]');" class="coolbg">取消</a>
                {auth name="my_event+delete"}<a href="javascript:deleteSelAll('id[]');" class="coolbg">删除</a>{/auth}
                {auth name="my_event+deal"}<a href="javascript:dealAll('id[]');" class="coolbg">设为已处理</a>{/auth}
                {*<a href="javascript:tuihuiSelAll('id[]');" class="coolbg">退回</a>*}
            </div>
            <div class="span12">
                <table class="table">
                    <colgroup>
                        <col width="30px"/>
                        <col width="70px"/>
                        <col width="200px"/>
                        <col width="100px"/>
                        <col width="80px"/>
                        <col width="150px"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th></th>
                            <th>类型</th>
                            <th>标题</th>
                            <th>状态</th>
                            <th>创建人</th>
                            <th>创建时间</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           <td align="center"><input type="checkbox" name="id[]" value="{$item['id']}"/></td>
                           <td>{$projectTypeName[$item['project_type']]}{if $item['project_type'] == 2}&gt;&gt;{$projectList[$item['project_id']]['status']}({$projectList[$item['project_id']]['sendor']}){/if}</td>
                           <td><a href="{$item['url']}&event_id={$item['id']}">{$item['title']}</a></td>
                           <td>{$item['status']}</td>
                           <td>{$item['creator']}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                        </tr>
                        {foreachelse}
                            <tr><td colspan="6">找不到数据</td></tr>
                        {/foreach}
                    </tbody>
                </table>
                {include file="pagination.tpl"}
             </div>

            <form id="delete_form" name="deleteForm" action="{url_path('my_event','delete')}" method="post" target="post_iframe">
                <div class="inputlist"></div>
            </form>
                
            <form id="setdeal_form" name="setdealForm" action="{url_path('my_event','deal')}" method="post" target="post_iframe">
                <div class="inputlist"></div>
            </form>
            <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>
                
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
                
                function dealAll(name){
                    var checked = false;
                    $("input[name='" +  name + "']").each(function(){
                        if($(this).prop("checked")){
                            checked = true;
                        }
                    });
                    
                    $("#setdeal_form .inputlist").html('');
                    $("input[name='" + name + "']").each(function(index){
                        if($(this).prop("checked")){
                            checked = true;
                            $('<input type="hidden" name="opid[]" value="' + $(this).val() + '"/>').appendTo("#setdeal_form .inputlist");
                        }
                    });
                    
                    
                    if(!checked){
                        $.jBox.error('至少选择一条记录', '提示');
                    }else{
                    
                        var submit = function (v, h, f) {
                            if (v == true){
                                $("#setdeal_form").submit();
                            }
                            return true;
                        };

                        $.jBox.confirm("确定要设为已处理吗", "提示", submit, { buttons: { '确定': true, '取消': false} });
                    }
                }
             </script>
             
            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}