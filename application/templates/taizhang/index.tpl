{include file="common/main_header.tpl"}
            <div class="row-fluid">
                <div class="searchform row-fluid">
                <form action="{url_path('taizhang')}" method="get" name="searchform">
                    <input type="hidden" value="taizhang" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="{$action}" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>编号</strong><input type="text" name="project_no" style="width:150px;" value="{$smarty.get.project_no}" placeholder="请输入台账号"/></label>
                            <label><strong>单位名称</strong><input type="text" name="name" style="width:200px;" value="{$smarty.get.name}" placeholder="请输入登记名称"/></label>
                            <label><strong>登记日期开始</strong><input type="text" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.get.sdate}"/></label>
                            <label><strong>登记日期结束</strong><input type="text" name="edate" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.get.edate}"/></label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            {auth name="taizhang+add"}<a href="javascript:void(0);" class="addlink">+新增台账</a>{/auth}
                        </li>
                     </ul>
                </form>
            </div>
                        
            <div class="span12">
                {auth name="taizhang+delete"}
                <div class="operator">
                    <a href="javascript:selAll('id[]');" class="coolbg">全选</a>
                    <a href="javascript:noSelAll('id[]');" class="coolbg">取消</a>
                    <a href="javascript:deleteSelAll('id[]');" class="coolbg">删除</a>
                </div>
                {/auth}
                
                <table class="table" id="listtable" >
                    <thead>
                        <tr>
                            {auth name="taizhang+delete"}<th></th>{/auth}
                            <th>时间</th>
                            <th>总编号</th>
                            <th>分编号</th>
                            <th>单位名称</th>
                            <th>土地坐落</th>
                            <th>总面积(M<sup>2</sup>)</th>
                            <th>出让/面积(M<sup>2</sup>)</th>
                            <th>用途</th>
                            <th>联系人</th>
                            <th>联系电话</th>
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
                           {auth name="taizhang+delete"}<td class="center"><input type="checkbox" name="id[]" value="{$item['id']}"/></td>{/auth}
                           <td>{$item['createtime']|date_format:"Y-m-d"}</td>
                           <td>{str_pad($item['master_serial'], 4,'0', STR_PAD_LEFT)}</td>
                           <td>{$item['region_code']}{str_pad($item['region_serial'], 3,'0', STR_PAD_LEFT)}</td>
                           <td>{$item['name']|escape}</td>
                           <td>{$item['address']|escape}</td>
                           <td>{$item['total_area']}</td>
                           <td>{$item['churan_area']}</td>
                           <td>{$item['nature']}</td>
                           <td>{$item['contacter']}</td>
                           <td>{$item['contacter_mobile']}</td>
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
                               {auth name="taizhang+edit"}<a href="javascript:void(0);" class="edit" data-id="{$item['id']}" data-href="{url_path('taizhang','edit','id=')}{$item['id']}">编辑</a>{/auth}
                           </td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
                    
            <form id="delete_form" name="deleteForm" action="{url_path('taizhang','delete')}" method="post" target="post_iframe">
                <div class="inputlist">

                </div>
            </form>
            <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>
                    
            <script type="x-my-template" id="projectAddTemplate">
                 <tr class="newrow">
                     <td></td>
                     <td></td>
                     <td>
                         <input type="text" name="master_serial" value="" placeholder="请输入总编号"/>
                     </td>
                     <td>
                         <select name="region_code">
                            {foreach from=$regionList item=item}
                            <option value="{$item['code']}" {if $info['region_code'] == $item['code']}selected{/if}>{$item['name']}</option>
                            {/foreach}
                        </select>
                         <input type="text" name="region_serial" value="" placeholder="请输入分编号"/>
                     </td>
                     <td>
                         <input type="text" name="name" value="" placeholder="请输入单位名称"/>
                     </td>
                     <td>
                        <input type="text" name="address" value="" placeholder="请输入土地坐落"/>
                    </td>
                    <td>
                        <input type="text" name="total_area" value="" placeholder="请输入总面积"/>
                    </td>
                    <td>
                        <input type="text" name="churan_area" value="0" placeholder="请输入出让面积"/>
                    </td>
                     <td>
                        <select name="nature">
                            {foreach from=$natureList item=item}
                            <option value="{$item['name']}" {if $info['nature'] == $item['name']}selected{/if}>{$item['name']}</option>
                            {/foreach}
                        </select>
                    </td>
                    <td>
                        <input type="text" name="contacter" value="" placeholder="请输入联系人名称"/>
                    </td>
                    <td>
                        <input type="text" name="contacter_mobile" value="" placeholder="请输入联系人号码"/></span>
                    </td>
                    <td>
                        <input type="text" name="pm" value="" placeholder="作业组负责人"/>
                    </td>
                    
                    <td>
                        <select  name="fee_type">
                            <option value="1">挂账</option>
                            <option value="2">票开款收</option>
                            <option value="3">票开款未收</option>
                            <option value="4">票未开款收</option>
                        </select>    
                    </td>
                    <td>
                        <select  name="has_doc">
                            <option value="0">未形成</option>
                            <option value="1">已形成</option>
                        </select>    
                    </td>
                    <td>
                        <input type="text" name="descripton" placeholder="请输入备注" value=""/>
                    </td>
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
                        
                        if(cansubmit && !/^[0-9]+$/.test($("input[name=master_serial]",newrow).val())){
                            alert("请输入正确的总编号");
                            cansubmit = false;
                            $("input[name=master_serial]",newrow).focus();
                        }
                        
                        if(cansubmit && !/^[0-9]+$/.test($("input[name=region_serial]",newrow).val())){
                            alert("请输入正确的分编号");
                            cansubmit = false;
                            $("input[name=region_serial]",newrow).focus();
                        }
                        
                        if(cansubmit && $.trim($("input[name=name]",newrow).val()) == ''){
                            alert("请输入单位名称");
                            cansubmit = false;
                            $("input[name=name]",newrow).focus();
                        }
                        
                        if(cansubmit && $.trim($("input[name=address]",newrow).val()) == ''){
                            alert("请输入宗地坐落");
                            cansubmit = false;
                            $("input[name=address]",newrow).focus();
                        }
                        
                        
                        if(cansubmit && !/^[0-9]+(.[0-9]+)?$/.test($("input[name=total_area]",newrow).val())){
                            $("input[name=total_area]",newrow).focus();
                            alert("请输入正确的总面积",'提示');
                            cansubmit = false;
                        }
                        
                        if(cansubmit && !/^[0-9]+(.[0-9]+)?$/.test($("input[name=churan_area]",newrow).val())){
                            $("input[name=churan_area]",newrow).focus();
                            alert("请输入正确的出让面积",'提示');
                            cansubmit = false;
                        }
                                
                                
                        if(cansubmit && $.trim($("select[name=nature]",newrow).val()) == ''){
                            alert("请选择用途");
                            cansubmit = false;
                            $("select[name=nature]",newrow).focus();
                        }
                        
                        
                        if(cansubmit && $.trim($("input[name=contacter]",newrow).val()) == ''){
                            alert("请输入联系人名称");
                            cansubmit = false;
                            $("input[name=contacter]",newrow).focus();
                        }
                        
                        if(cansubmit && $.trim($("input[name=contacter_mobile]",newrow).val()) == ''){
                            alert("请输入联系人号码");
                            cansubmit = false;
                            $("input[name=contacter_mobile]",newrow).focus();
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
                                url:"{url_path('taizhang','add')}",
                                data : {
                                    isajax:"1",
                                    name:$("input[name=name]",newrow).val(),
                                    master_serial: $("input[name=master_serial]",newrow).val(),
                                    region_code: $("select[name=region_code]",newrow).val(),
                                    region_serial: $("input[name=region_serial]",newrow).val(),
                                    address: $("input[name=address]",newrow).val(),
                                    total_area:$("input[name=total_area]",newrow).val(),
                                    churan_area: $("input[name=churan_area]",newrow).val(),
                                    nature: $("select[name=nature]",newrow).val(),
                                    contacter:$("input[name=contacter]",newrow).val(),
                                    contacter_mobile: $("input[name=contacter_mobile]",newrow).val(),
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
                                $(resp).insertAfter("#row_" + edit_id);
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