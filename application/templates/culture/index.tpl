{include file="common/main_header.tpl"}
        <div class="searchform row-fluid">
                <form action="{url_path('culture')}" method="get" name="searchform">
                    <input type="hidden" value="culture" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>开始日期</strong><input type="text" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.get.sdate}"/></label>
                            <label><strong>结束日期</strong><input type="text" name="edate" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.get.edate}"/></label>
                            <label><strong>标题</strong><input type="text" name="title" value="{$smarty.get.title}"/></label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            <a class="addlink" href="{url_path('culture','add')}">添加新闻</a>
                        </li>
                     </ul>
                </form>
            </div>
            <div class="operator">
                <a href="javascript:selAll('id[]');" class="coolbg">全选</a>
                <a href="javascript:noSelAll('id[]');" class="coolbg">取消</a>
                <a href="javascript:deleteSelAll('id[]');" class="coolbg">删除</a>
                <a href="javascript:publish('id[]');" class="coolbg">发布</a>
                <a href="javascript:publish('id[]','un');" class="coolbg">取消发布</a>
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
                            <th>是否发布</th>
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
                           <td><a href="javascript:void(0);" class="item_detail" data-href="{url_path('culture','detail','id=')}{$item['id']}">{$item['title']|escape}</a></td>
                           <td>{if $item['is_publish'] == 1}已发布{else}未发布{/if}</td>
                           <td>{$item['status']}</td>
                           <td>{$item['creator']}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               <a href="{url_path('culture','edit','id=')}{$item['id']}">编辑</a>
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
             <form id="delete_form" name="deleteForm" action="{url_path('culture','delete')}" method="post" target="post_iframe">
                <div class="inputlist"></div>
            </form>
            <form id="publish_form" name="publishForm" action="{url_path('culture','publish')}" method="post" target="post_iframe">
                <div class="inputlist"></div>
            </form>
                
            <form id="unpublish_form" name="unpublishForm" action="{url_path('culture','unpublish')}" method="post" target="post_iframe">
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

                function publish(name,prefix){
                    var checked = false;
                    $("input[name='" +  name + "']").each(function(){
                        if($(this).prop("checked")){
                            checked = true;
                        }
                    });
                    var text = '发布';
                    if(typeof(prefix) == 'undefined'){
                        prefix = '';
                    }else{
                        text = '取消发布';
                    }

                    $("#" + prefix + "publish_form .inputlist").html('');
                    $("input[name='" + name + "']").each(function(index){
                        if($(this).prop("checked")){
                            checked = true;
                            $('<input type="hidden" name="opid[]" value="' + $(this).val() + '"/>').appendTo("#" + prefix + "publish_form .inputlist");
                        }
                    });


                    if(!checked){
                        $.jBox.error('至少选择一条记录', '提示');
                    }else{

                        var submit = function (v, h, f) {
                            if (v == true){
                                $("#" + prefix + "publish_form").submit();
                            }
                            return true;
                        };

                        $.jBox.confirm("确定要" + text + "吗", "提示", submit, { buttons: { '确定': true, '取消': false} });
                    }
                }
                    
                $(function(){
                    {if $message}
                        $.jBox.tip('{$message}');
                    {/if}
                    
                    $(".item_detail").bind("click",function(e){
                        var that = $(e.target);
                        
                        $.jBox("get:" + that.attr("data-href"),{ title:"新闻详情",width:750 });
                    });
                });
             </script>
            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}