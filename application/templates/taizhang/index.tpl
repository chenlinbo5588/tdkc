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
                            <td colspan="5">
                                <label class="notice"><input type="checkbox" name="category_all"  data-checkall="category[]" {if empty($category) || $smarty.get.category_all}checked="checked"{/if}>全选/取消</label>
                                {foreach from=$projectTypeList key=key item=item}
                                 <label><input type="checkbox" name="category[]" value="{$item}" {if empty($category) || $category[$item]}checked="checked"{/if}/>{$item}</label>&nbsp;
                                {/foreach}
                            </td>
                            <td colspan="2">
                                <input type="submit" name="submit" class="btn btn-primary" value="查询"/>&nbsp;
                                <label><input type="checkbox" name="inc_del" value="delete" {if $smarty.get.inc_del == 'delete'}checked{/if}/><strong>包含已删除</strong></label>
                                {auth name="taizhang_sh+add"}<a class="addlink" href="{url_path('taizhang_sh','add')}">+添加散活台账</a>{/auth}
                            </td>
                        </tr>
                        <tr>
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
                            <td><label><strong>状态</strong></label></td>
                            <td colspan="3">
                                <select name="status" >
                                    <option value="" {if $smarty.get.status == ''}selected{/if}>全部</option>
                                    <option value="新增" {if $smarty.get.status == '新增'}selected{/if}>新增</option>
                                    <option value="已提交初审" {if $smarty.get.status == '已提交初审'}selected{/if}>已提交初审</option>
                                    <option value="已提交复审" {if $smarty.get.status == '已提交复审'}selected{/if}>已提交复审</option>
                                    <option value="已通过复审" {if $smarty.get.status == '已通过复审'}selected{/if}>已通过复审</option>
                                </select>
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
                                <label class="notice"><input type="checkbox" name="fee_type_all" data-checkall="fee_type[]" {if $smarty.get.fee_type_all}checked="checked"{/if}/>全选/取消</label>
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
                            <td><label><strong>当前经办人为</strong></label></td>
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
                    {auth name="taizhang+delete"}<a href="javascript:deleteSelAll('id[]');" class="coolbg">删除</a>{/auth}
                    {if $action == 'recyclebin'}{auth name="taizhang+restore"}<a href="javascript:restoreSelAll('id[]');" class="coolbg">重新启用</a>{/auth}{/if}
                    <a href="javascript:amountSum('id[]');" class="coolbg">金额统计</a>
                </div>
                <table class="table" id="listtable" >
                    <thead>
                        <tr>
                            <th>勾选</th>
                            <th>时间</th>
                            <th>台账类型</th>
                            <th>镇街</th>
                            <th>台账编号</th>
                            <th>单位名称</th>
                            <th>土地坐落</th>
                            <th>用途</th>
                            <th>面积(m2)<br/>或点数</th>
                            <th>联系人<br/>电话</th>
                            <th>作业组<br/>负责人</th>
                            <th>状态</th>
                            <th>当前<br/>经办人</th>
                            <th>经办人</th>
                            <th>收费<br/>情况</th>
                            <th>考核<br/>金额</th>
                            {if $hasFeeAuth}<th>实收<br/>金额</th>{/if}
                            <th>资料<br/>领取</th>
                            <th>备注</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           <td class="center"><input type="checkbox" name="id[]" value="{$item['id']}"/></td>
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
                           <td>{$item['address']|escape|cutText:10}</td>
                           <td>{$item['nature']}</td>
                           <td>{if $item['nature'] == '放线'}{$item['point_cnt']}个点{else}{$item['total_area']}{/if}</td>
                           <td>{$item['contacter']}{if $item['contacter_mobile']}<br/>{$item['contacter_mobile']}{/if}</td>
                           <td>{$item['pm']}</td>
                           <td class="{if $item['status'] == '已删除'}notice{elseif $item['status'] == '已通过复审'}success{/if}">{$item['status']}</td>
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
                           <td class="col_amount kh_amount" data-amount-name="kh" data-amount-title="考核金额">{$item['kh_amount']}</td>
                           {if $hasFeeAuth}<td class="col_amount ss_amount" data-amount-name="ss" data-amount-title="实收金额">{$item['ss_amount']}</td>{/if}
                           <td>{if $item['get_doc'] == 1}已领取{else}未领取{/if}</td>
                           <td><div title="{$item['descripton']|escape}">{$item['descripton']|escape|cutText:8}</div></td>
                           <td>
                           {if $action == 'index'}{if $hasFeeAuth}<a href="javascript:void(0);" class="popwin" data-id="{$item['id']}" data-href="{url_path('taizhang','fee','id=')}{$item['id']}">收费</a>{/if}{/if}
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
                
                
                function amountSum(name){
                    var checked = false;
                    $("input[name='" +  name + "']").each(function(){
                        if($(this).prop("checked")){
                            checked = true;
                        }
                    });
                    
                    if(!checked){
                        $.jBox.error('至少选择一条记录', '提示');
                    }else{
                        var amount = {};
                        $("input[name='" +  name + "']").each(function(){
                            var tr = $(this).closest("tr");
                            var amount_name = "";
                            var amount_title = "";
                            var amount_v = "";
                            if($(this).prop("checked")){
                                var amountTd = tr.find(".col_amount");
                                
                                $(amountTd).each(function(){
                                    amount_name = $(this).attr("data-amount-name");
                                    amount_title = $(this).attr("data-amount-title");
                                    amount_v = parseFloat($(this).html());
                                    
                                    if(typeof(amount[amount_name]) == "undefined"){
                                        amount[amount_name] = { title: amount_title , amount: amount_v};
                                    }else{
                                        amount[amount_name].amount += amount_v;
                                    }
                                });
                            }
                        });
                        
                        var str = "";
                        for(var a in  amount){
                            str += amount[a].title + " : " + amount[a].amount + "<br/>";
                        }
                        
                        $.jBox.alert(str, '金额统计');
                    }
                }
                
                $(function(){
                
                    $("input[data-checkall]").each(function(){
                        $(this).bind("click",function(){
                            var groupname = $(this).attr("data-checkall");
                            var allcheck = $(this);
                            $("input[name='" + groupname + "']").prop("checked",$(this).prop("checked"));
                        });
                    });
                    
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