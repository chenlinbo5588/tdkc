{include file="common/main_header.tpl"}
            <div class="row-fluid">
                <div class="searchform row-fluid">
                <form action="{url_path('taizhang_person')}" method="get" name="searchform">
                    <input type="hidden" value="taizhang_person" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="{$action}" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>编号</strong><input type="text" name="project_no" style="width:150px;" value="{$smarty.get.project_no}" placeholder="请输入台账号"/></label>
                            <label><strong>单位名称</strong><input type="text" name="name" style="width:200px;" value="{$smarty.get.name}" placeholder="请输入登记名称"/></label>
                            <label><strong>登记日期开始</strong><input type="text" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.get.sdate}"/></label>
                            <label><strong>登记日期结束</strong><input type="text" name="edate" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.get.edate}"/></label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            {auth name="taizhang_person+add"}<a href="javascript:void(0);" class="addlink">+新增个人建房台账</a>{/auth}
                        </li>
                     </ul>
                </form>
            </div>
                        
            <div class="span12">
                {auth name="taizhang_person+delete"}
                <div class="operator">
                    <a href="javascript:selAll('id[]');" class="coolbg">全选</a>
                    <a href="javascript:noSelAll('id[]');" class="coolbg">取消</a>
                    <a href="javascript:deleteSelAll('id[]');" class="coolbg">删除</a>
                </div>
                {/auth}
                
                <table class="table" id="listtable" >
                    <thead>
                        <tr>
                            {auth name="taizhang_person+delete"}<th></th>{/auth}
                            <th>时间</th>
                            <th>编号</th>
                            <th>名称</th>
                            <th>土地坐落</th>
                            <th>作业组负责人</th>
                            <th>收费情况</th>
                            <th>成果资料</th>
                            <th>备注</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           {auth name="taizhang_person+delete"}<td class="center"><input type="checkbox" name="id[]" value="{$item['id']}"/></td>{/auth}
                           <td>{$item['createtime']|date_format:"Y-m-d"}</td>
                           <td>{$item['project_no']}</td>
                           <td>{$item['name']|escape}</td>
                           <td>{$item['address']|escape}</td>
                           <td>{$item['pm']}</td>
                           <td>
                               {if $item['fee_type'] == 1}挂账
                                {elseif $item['fee_type'] == 2}票开款收
                                {elseif $item['fee_type'] == 3}票开款未收
                                {elseif $item['fee_type'] == 4}票未开款收
                                {/if}
                           </td>
                           <td>{if $item['has_doc'] == 1}已形成{else}未形成{/if}</td>
                           <td>{$item['descripton']}</td>
                           <td>
                               {auth name="taizhang_person+edit"}<a href="javascript:void(0);" class="edit" data-id="{$item['id']}" data-href="{url_path('taizhang_person','edit','id=')}{$item['id']}">编辑</a>{/auth}
                               {auth name="taizhang_person+fee"}<a href="javascript:void(0);" class="popwin" data-id="{$item['id']}" data-href="{url_path('taizhang_person','fee','id=')}{$item['id']}">收费</a>{/auth}
                           </td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
                    
            <form id="delete_form" name="deleteForm" action="{url_path('taizhang_person','delete')}" method="post" target="post_iframe">
                <div class="inputlist">

                </div>
            </form>
            <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>
                    
            <script type="x-my-template" id="projectAddTemplate">
                 <tr class="newrow">
                     <td></td>
                     <td></td>
                     {include file="taizhang_person/fields_list.tpl"}
                    <td>
                        {* 操作 *}
                        <div class="loading" style="display:none;"></div>
                        <div>
                            <input type="button" name="saveRow" class="op_save" value="保存"/>
                            <input type="button" name="cancelRow" class="op_cancel" value="取消"/>
                        </div>
                    </td>
                    
                 </tr>
             </script>      
             
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
                 
                 
                 $(function(){
                    $("a.popwin").bind("click",function(e){
                        var url = $(e.target).attr("data-href");
                        $.jBox("get:" + url,{ title:$(e.target).attr("data-title"),width:800,height:650,buttons:{ "关闭" : 1}});
                    });
                    
                    $("a.addlink").bind("click",function(e){
                        if($("tr.newrow").size() > 0){
                            return ;
                        }
                    
                        var addrow = $($("#projectAddTemplate").html());
                        $("#listtable tbody").prepend(addrow);
                    });
                    
                    $("#listtable").delegate(".op_save","click",function(e){
                        var that = $(e.target);
                        var cansubmit = true;
                        var newrow = $(".newrow");
                        
                        if(cansubmit && !/^[0-9]+$/.test($("input[name=region_serial]",newrow).val())){
                            alert("请输入正确的编号");
                            cansubmit = false;
                            $("input[name=region_serial]",newrow).focus();
                        }
                        
                        if(cansubmit && $.trim($("input[name=name]",newrow).val()) == ''){
                            alert("请输入名称");
                            cansubmit = false;
                            $("input[name=name]",newrow).focus();
                        }
                        
                        if(cansubmit && $.trim($("input[name=address]",newrow).val()) == ''){
                            alert("请输入土地坐落");
                            cansubmit = false;
                            $("input[name=address]",newrow).focus();
                        }
                        
                        if(cansubmit && $.trim($("input[name=pm]",newrow).val()) == ''){
                            alert("请输入作业组负责人名称");
                            cansubmit = false;
                            $("input[name=pm]",newrow).focus();
                        }
                        
                        if(cansubmit){
                            that.prop("disabled",true);
                            
                            $(".loading",newrow).show();
                            $.ajax({
                                type:"POST",
                                url:"{url_path('taizhang_person','add')}",
                                data : {
                                    isajax:"1",
                                    name:$("input[name=name]",newrow).val(),
                                    region_name: $("select[name=region_name]",newrow).val(),
                                    region_serial: $("input[name=region_serial]",newrow).val(),
                                    address: $("input[name=address]",newrow).val(),
                                    pm:$("input[name=pm]",newrow).val(),
                                    fee_type:$("select[name=fee_type]",newrow).val(),
                                    has_doc:$("select[name=has_doc]",newrow).val(),
                                    descripton:$("input[name=descripton]",newrow).val()
                                },
                                dataType:"json",
                                success:function(resp){
                                    alert(resp.body.text);
                                    if(resp.code == 'success'){
                                        location.reload();
                                    }
                                },
                                complete:function(){
                                    that.prop("disabled",false);
                                    $(".loading",newrow).hide();
                                },
                                error:function(){
                                    that.prop("disabled",false);
                                    $(".loading",newrow).hide();
                                }
                            });
                        }
                    });
                    
                    $("#listtable").delegate(".op_cancel","click",function(e){
                        var tr = $(e.target).closest("tr").remove();
                    });
                    
                    $("a.edit").bind("click",function(e){
                        var that = $(e.target);
                        var edit_id = that.attr("data-id");
                        that.hide();
                        that.closest("td").find(".loading").show();
                        
                        $.ajax({
                            type:"GET",
                            url: that.attr("data-href") + '&isajax=1',
                            success:function(resp){
                                $("#row_" + edit_id).hide();
                                $("#listtable tbody").prepend($(resp));
                                
                                $("input[name=master_serial]").focus();
                                //$(resp).insertAfter("#row_" + edit_id);
                            },
                            complete:function(){
                                that.show();
                                that.closest("td").find(".loading").hide();
                            },
                            error:function(){
                                that.show();
                                that.closest("td").find(".loading").hide();
                            }
                        });
                        
                    });
                 });
                 
             </script>
            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}