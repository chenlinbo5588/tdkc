{include file="common/main_header.tpl"}
            <div class="row-fluid">
                <div class="searchform row-fluid">
                <form action="{url_path('taizhang')}" method="get" name="searchform">
                    <input type="hidden" value="taizhang" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="{$action}" name="{config_item('function_trigger')}"/>
                    <table class="normal">
                        <tr>
                            <td>
                                <label><strong>业务类型</strong></label>
                            </td>
                            <td>
                                <select name="category" >
                                    <option value="">全部</option>
                                    {foreach from=$projectTypeList key=key item=item}
                                    <option value="{$key}" {if $smarty.get.category == $key}selected{/if}>{$item}</option>
                                    {/foreach}
                                </select>
                            </td>
                            <td><label><strong>镇乡名称</strong></label></td>
                            <td>
                                <select name="region_name">
                                    <option value="">请选择镇街</option>
                                    {foreach from=$regionList item=item}
                                    <option value="{$item['name']}" {if $smarty.get.region_name == $item['name']}selected{/if}>{$item['name']}({$item['code']})</option>
                                    {/foreach}
                                </select>
                            </td>
                            <td><label><strong>编号</strong></label></td>
                            <td>
                                <input type="text" name="project_no"  value="{$smarty.get.project_no}" placeholder="请输入台账号"/>
                            </td>
                            <td colspan="2">
                                <input type="submit" name="submit" class="btn btn-primary" value="查询"/>&nbsp;
                                <label><input type="checkbox" name="inc_del" value="delete" {if $smarty.get.inc_del == 'delete'}checked{/if}/><strong>包含已删除</strong></label>
                                {auth name="taizhang_sh+add"}<a class="addlink" href="{url_path('taizhang_sh','add')}">+添加散活台账</a>{/auth}
                            </td>
                        </tr>
                        <tr>
                            <td><label><strong>单位名称</strong></label></td>
                            <td>
                                <input type="text" name="name" style="width:145px;" value="{$smarty.get.name}" placeholder="请输入登记名称"/>
                            </td>
                            <td>
                                <label><strong>登记日期开始</strong></label>
                            </td>
                            <td><input type="text" name="sdate" id="sdate" style="width:90px;" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.get.sdate}"/></td>
                            <td><label><strong>登记日期结束</strong></label></td>
                            <td><input type="text" name="edate" id="edate" style="width:90px;" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.get.edate}"/></td>
                            <td><label><strong>作业组负责人</strong></label></td>
                            <td>
                                <input type="text" name="pm"  value="{$smarty.get.pm}" placeholder="作业组负责人"/>
                            </td>
                        </tr>
                        <tr>
                            <td><label><strong>收费情况</strong></label></td>
                            <td colspan="3">
                                <label><input type="checkbox" name="fee_type[]" {if $feeGet['f0']}checked{/if} value="f0"/>未收费</label>
                                <label><input type="checkbox" name="fee_type[]" {if $feeGet['f1']}checked{/if} value="f1"/>挂账</label>
                                <label><input type="checkbox" name="fee_type[]" {if $feeGet['f2']}checked{/if} value="f2"/>票开款收</label>
                                <label><input type="checkbox" name="fee_type[]" {if $feeGet['f3']}checked{/if} value="f3"/>票开款未收</label>
                                <label><input type="checkbox" name="fee_type[]" {if $feeGet['f4']}checked{/if} value="f4"/>票未开款收</label>
                                <label><input type="checkbox" name="fee_type[]" {if $feeGet['f5']}checked{/if} value="f5"/>暂挂账</label>
                            </td>
                            <td><label><strong>项目性质</strong></label></td>
                            <td>
                                <select name="nature">
                                    <option value="">全部</option>
                                {foreach from=$natureList item=item}
                                    <option value="{$item['name']}" {if $smarty.get.nature == $item['name']}selected{/if}>{$item['name']}</option>
                                {/foreach}
                                </select>
                            </td>
                            <td><label><strong>领取情况</strong></label></td>
                            <td>
                                <label><input type="checkbox" name="get_doc[]" value="f0" {if $docGet['f0']}checked{/if}/>未领取</label>
                                <label><input type="checkbox" name="get_doc[]" value="f1" {if $docGet['f1']}checked{/if}/>已领取</label>
                            </td>
                        </tr>
                        <tr>
                            <td><label><strong>当前操作人</strong></label></td>
                            <td colspan="7">
                                <input type="text" name="sendor" value="{$smarty.get.sendor}" data-self="{$userProfile['name']}"/>&nbsp;<input type="button" name="setself" value="填入自己"/>
                            </td>
                        </tr>
                     </table>
                </form>
            </div>
                        
            <div class="span12">
                
                <div class="operator">
                    <a href="javascript:selAll('id[]');" class="coolbg">全选</a>
                    <a href="javascript:noSelAll('id[]');" class="coolbg">取消</a>
                    {if $action == 'index'}
                    {auth name="taizhang+delete"}<a href="javascript:deleteSelAll('id[]');" class="coolbg">删除</a>{/auth}
                    {else}
                    {auth name="taizhang+restore"}<a href="javascript:restoreSelAll('id[]');" class="coolbg">重新启用</a>{/auth}
                    {/if}
                </div>
                <table class="table" id="listtable" >
                    <thead>
                        <tr>
                            {if $action == 'index'}
                            {auth name="taizhang+delete"}<th></th>{/auth}
                            {else}
                            {auth name="taizhang+restore"}<th></th>{/auth}
                            {/if}
                            <th>时间</th>
                            <th>台账类型</th>
                            <th>镇街</th>
                            <th>台账编号</th>
                            <th>单位名称</th>
                            <th>土地坐落</th>
                            <th>用途</th>
                            <th>联系人</th>
                            <th>联系电话</th>
                            <th>作业组负责人</th>
                            <th>状态</th>
                            <th>当前经办人</th>
                            <th>经办人</th>
                            <th>收费情况</th>
                            <th>考核金额</th>
                            <th>成果资料</th>
                            <th>备注</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           {if $action == 'index'}
                           {auth name="taizhang+delete"}<td class="center"><input type="checkbox" name="id[]" value="{$item['id']}"/></td>{/auth}
                           {else}
                           {auth name="taizhang+restore"}<td class="center"><input type="checkbox" name="id[]" value="{$item['id']}"/></td>{/auth}
                           {/if}
                           <td>{$item['createtime']|date_format:"Y-m-d"}</td>
                           <td>{$item['category']}</td>
                           <td>{$item['region_name']|escape}</td>
                           <td>{$item['project_no']}</td>
                           <td>
                           {if $item['category'] == $smarty.const.TAIZHANG_TD}
                               <a href="{url_path('taizhang_ch','edit','id=')}{$item['id']}">{$item['name']|escape}</a>
                           {elseif $item['category'] == $smarty.const.TAIZHANG_FG}
                               <a href="{url_path('taizhang_fg','edit','id=')}{$item['id']}">{$item['name']|escape}</a>
                           {elseif $item['category'] == $smarty.const.TAIZHANG_HOUSE}
                               <a href="{url_path('taizhang_house','edit','id=')}{$item['id']}">{$item['name']|escape}</a>
                           {elseif $item['category'] == $smarty.const.TAIZHANG_WF}
                               <a href="{url_path('taizhang_wf','edit','id=')}{$item['id']}">{$item['name']|escape}</a>
                           {elseif $item['category'] == $smarty.const.TAIZHANG_OTHER}
                               <a href="{url_path('taizhang_other','edit','id=')}{$item['id']}">{$item['name']|escape}</a>
                           {elseif $item['category'] == $smarty.const.TAIZHANG_PERSON}
                               <a href="{url_path('taizhang_person','edit','id=')}{$item['id']}">{$item['name']|escape}</a>
                           {elseif $item['category'] == $smarty.const.TAIZHANG_SH}
                               <a href="{url_path('taizhang_sh','edit','id=')}{$item['id']}">{$item['name']|escape}</a>
                           {else}
                            {$item['name']|escape}
                           {/if}
                           </td>
                           <td>{$item['address']|escape}</td>
                           <td>{$item['nature']}</td>
                           <td>{$item['contacter']}</td>
                           <td>{$item['contacter_mobile']}</td>
                           <td>{$item['pm']}</td>
                           <td>{if $item['status'] == '已删除'}<span class="notice">{$item['status']}</span>{else}<span class="success">{$item['status']}</span>{/if}</td>
                           <td>{$item['sendor']}</td>
                           <td>{$item['creator']} {$item['cs_name']} {$item['fs_name']} </td>
                           <td>
                               {if $item['fee_type'] == 0}未收费
                               {elseif $item['fee_type'] == 1}挂账
                                {elseif $item['fee_type'] == 2}票开款收
                                {elseif $item['fee_type'] == 3}票开款未收
                                {elseif $item['fee_type'] == 4}票未开款收
                                {elseif $item['fee_type'] == 5}暂挂账
                                {/if}
                           </td>
                           <td>{$item['kh_amount']}</td>
                           <td>{if $item['get_doc'] == 1}已领取{else}未领取{/if}</td>
                           <td>{$item['descripton']|escape}</td>
                           <td>
                           {if $action == 'index'}{auth name="taizhang+fee"}<a href="javascript:void(0);" class="popwin" data-id="{$item['id']}" data-href="{url_path('taizhang','fee','id=')}{$item['id']}">收费</a>{/auth}{/if}
                            </td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
                {include file="pagination.tpl"}
            </div>
            <form id="delete_form" name="deleteForm" action="{url_path('taizhang','delete')}" method="post" target="post_iframe">
                <div class="inputlist"></div>
            </form>
            <form id="restore_form" name="restoreForm" action="{url_path('taizhang','restore')}" method="post" target="post_iframe">
                <div class="inputlist"></div>
            </form>
                
            <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>
            <script>
                
                function restoreSelAll(name){
                    var checked = false;
                    $("input[name='" +  name + "']").each(function(){
                        if($(this).prop("checked")){
                            checked = true;
                        }
                    });
                    
                    $("#restore_form .inputlist").html('');
                    $("input[name='" + name + "']").each(function(index){
                        if($(this).prop("checked")){
                            checked = true;
                            $('<input type="hidden" name="restore_id[]" value="' + $(this).val() + '"/>').appendTo("#restore_form .inputlist");
                        }
                    });
                    
                    if(!checked){
                        $.jBox.error('至少选择一条记录', '提示');
                    }else{
                        var submit = function (v, h, f) {
                            if (v == true){
                                $("#restore_form").submit();
                            }
                            return true;
                        };

                        $.jBox.confirm("确定要重新启用吗", "提示", submit, { buttons: { '确定': true, '取消': false} });
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
                    $("input[name=setself]").bind("click",function(e){
                        $("input[name=sendor]").val($("input[name=sendor]").attr("data-self"));
                    });
                    
                    $("a.popwin").bind("click",function(e){
                        var url = $(e.target).attr("data-href");
                        $.jBox("get:" + url,{ title:$(e.target).attr("data-title"),width:800,height:650,buttons:{ "关闭" : 1}});
                    });
                
                });
            </script>    
            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}