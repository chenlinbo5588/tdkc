{include file="common/main_header.tpl"}
        <div class="searchform row-fluid">
                <form action="{url_path('inst')}" method="get" name="searchform">
                    <input type="hidden" value="inst" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>开始日期</strong><input type="text" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.get.sdate}"/></label>
                            <label><strong>结束日期</strong><input type="text" name="edate" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.get.edate}"/></label>
                            <label><strong>标题</strong><input type="text" name="title" value="{$smarty.get.title}"/></label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            {auth name="inst+add"}<a class="addlink" href="{url_path('inst','add')}">添加规章制度</a>{/auth}
                        </li>
                     </ul>
                </form>
            </div>
            <div class="operator">
                <a href="javascript:selAll('id[]');" class="coolbg">全选</a>
                <a href="javascript:noSelAll('id[]');" class="coolbg">取消</a>
                {auth name="inst+delete"}<a href="javascript:deleteSelAll('id[]');" class="coolbg">删除</a>{/auth}
            </div>
            <div class="span12">
                {if $data['data']}
                <table class="table">
                    <colgroup>
                        <col style="width:30px;"/>
                        <col style="width:300px;"/>
                        <col style="width:80px;"/>
                        <col style="width:100px;"/>
                        <col style="width:200px;"/>
                        <col style="width:200px;"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th></th>
                            <th>标题</th>
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
                           <td><a href="{url_path('attachment','download','id=')}{$item['id']}" title="点击下载">{$item['title']|escape}</a></td>
                           <td>{$item['status']}</td>
                           <td>{$item['creator']}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               {auth name="inst+edit"}<a href="{url_path('inst','edit','id=')}{$item['id']}">编辑</a>{/auth}
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
             <form id="delete_form" name="deleteForm" action="{url_path('inst','delete')}" method="post" target="post_iframe">
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

                $(function(){
                    {if $message}
                        $.jBox.tip('{$message}');
                    {/if}
                });
             </script>
            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}