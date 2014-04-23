{include file="common/main_header.tpl"}
        {include file="project_ch/modlist.tpl"}
        <div>
            <form name="saveForm" action="{url_path('project_ch','dispatchOne')}" method="post">
                <input type="hidden" name="event_id" value="{$info['event_id']}"/>
                <input type="hidden" name="id" value="{$info['id']}"/>
                <table class="maintain">
                    <tbody>
                    <tr>
                        <td><label class="required"><em></em><strong>当前状态</strong></label></td>
                        <td><b class="notice">{$info['status']}{$info['sub_status']}</b></td>
                    </tr>
                    
                    <tr>
                        <td><label class="required"><em></em><strong>项目编号</strong></label></td>
                        <td>{$info['project_no']}</td>
                    </tr>
                    <tr>
                        <td><label class="required"><em></em><strong>录入类型</strong></label></td>
                        <td>{if $info['input_type'] == 0}正常登记{elseif $info['input_type'] == 1}补录登记{/if}</td>
                    </tr>
                    <tr>
                        <td><label class="required"><em></em><strong>登记年月</strong></label></td>
                        <td>{$info['year']}年{$info['month']}月份</td>
                    </tr>
                    <tr>
                        <td><label class="required"><em></em><strong>区域</strong></label></td>
                        <td>{$info['region_name']}</td>
                    </tr>
                    <tr>
                        <td><label class="required"><em></em><strong>登记类型</strong></label></td>
                        <td>{$info['type']}</td>
                    </tr>
                    <tr>
                        <td><label class="required"><em></em><strong>登记名称</strong></label></td>
                        <td>{$info['name']|escape}</td>
                    </tr>
                    <tr>
                        <td><label class="required"><em></em><strong>地址</strong></label></td>
                        <td>{$info['address']|escape}</td>
                    </tr>
                    <tr>
                        <td><label class="optional"><em></em><strong>村名</strong></label></td>
                        <td>{$info['village']|escape}</td>
                    </tr>
                    <tr>
                        <td><label class="required"><em></em><strong>联系人信息</strong></label></td>
                        <td>姓名:{$info['contacter']|escape} 手机号码:{$info['contacter_mobile']} 固定电话:{$info['contacter_tel']}</td>
                    </tr>
                    
                    <tr>
                        <td><label class="required"><em></em><strong>接洽人信息</strong></label></td>
                        <td>姓名:{$info['manager']|escape} 手机号码:{$info['manager_mobile']} 固定电话:{$info['manager_tel']}</td>
                    </tr>
                    <tr>
                        <td><label class="optional"><em></em><strong>备注</strong></label></td>
                        <td>{$info['descripton']}</td>
                    </tr>
                    <tr>
                        <td><label class="optional"><em></em><strong>优先级</strong></label></td>
                        <td>{$info['displayorder']}</td>
                    </tr>
                    <tr>
                        <td><label class="optional"><em></em><strong>登记信息</strong></label></td>
                        <td>登记人姓名:{$info['creator']} 登记时间：{$info['createtime']|date_format:"Y-m-d H:i:s"}</td>
                    </tr>
                    {*
                    <tr>
                        <td><label class="optional"><em></em><strong>最后修改</strong></label></td>
                        <td>修改人：{$info['updator']} 修改时间:{$info['updatetime']|date_format:"Y-m-d H:i:s"}</td>
                    </tr>
                    *}
                    {if $info['sendor_id'] == $userProfile['id']}
                    <tr>
                        <td>流程选择</td>
                        <td>
                            <select name="workflow">
                                <option value="分派">指派</option>
                                <option value="退回">退回</option>
                            </select>
                        </td>
                    </tr>
                    {/if}
                    <tr id="assignTo">
                        <td>指派给</td>
                        <td>
                            {if $info['sendor_id'] == $userProfile['id']}
                                {if $userSendorList}
                                <div class="userlist clearfix">
                                    {foreach  from=$userSendorList item=item}
                                    <label class="item"><input type="radio" name="sendor" value="{$item['sendor_id']}" >{$item['sendor']}</label>
                                    {/foreach}
                                </div>
                                {/if}
                            {else}
                                {$info['sendor']}
                            {/if}
                            <div>没有找到你要发送的人？，请点击<a class="notice" href="{url_path('sendor','add')}">这里</a>进行添加</a></div>
                            <div>{form_error('sendor')}</div>
                        </td>
                    </tr>
                    <tr id="tuihui" style="display: none;">
                        <td>退回原因</td>
                        <td>
                            <textarea name="reason" rows="8" cols="50"></textarea>
                            <br/>
                            {form_error('reason')}
                        </td>
                    </tr>
                    <tr id="timeReq">
                        <td>时间要求</td>
                        <td>
                            {if $info['sendor_id'] != $userProfile['id']}
                            <label>开始<input type="text" name="start_date" id="sdate" class="Wdate" readonly value="{if $info['start_date']}{$info['start_date']|date_format:"Y-m-d"}{/if}"/>{form_error('start_date')}</label>
                            <label>结束<input type="text" name="end_date" id="edate" class="Wdate" readonly value="{if $info['end_date']}{$info['end_date']|date_format:"Y-m-d"}{/if}"/>{form_error('end_date')}</label>
                            {else}
                            <label>开始<input type="text" name="start_date" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{if $info['start_date']}{$info['start_date']|date_format:"Y-m-d"}{/if}"/>{form_error('start_date')}</label>
                            <label>结束<input type="text" name="end_date" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{if $info['end_date']}{$info['end_date']|date_format:"Y-m-d"}{/if}"/>{form_error('end_date')}</label>
                            {/if}
                       </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            {if $info['sendor_id'] == $userProfile['id']}
                            <input type="submit" name="submit" class="btn btn-sm btn-primary" value="确定"/>
                            {/if}
                            
                            {if $gobackUrl }<input type="hidden" name="gobackUrl" value="{$gobackUrl}"/><a class="goback" href="{$gobackUrl}">返回</a>{/if}
                        </td>
                    </tr>
                    </tbody>
                </table>
             </form>
                <script>
                    $(function(){
                        {if $message}
                            $.jBox.tip('{$message}');
                        {/if}
                        
                        $(".userlist label").bind("click",function(e){
                            //console.log(e);
                            $(".userlist label").removeClass("selected");
                            $(e.target).closest("label").addClass("selected");
                        });
                        
                        $("select[name=workflow]").bind("change",function(e){
                            var select = $(e.target);
                            if(select.val() == '退回'){
                                $("#assignTo").hide();
                                $("#timeReq").hide();
                                $("#tuihui").show();
                                $("textarea[name=reason]").focus();
                            }else{
                                $("#assignTo").show();
                                $("#timeReq").show();
                                $("#tuihui").hide();
                            }
                        });
                        
                        
                        $("form[name=saveForm]").bind('submit',function(e){
                            if($("select[name=workflow]").val() == '退回' && $.trim($("textarea[name=reason]").val()).length == 0){
                                $("textarea[name=reason]").focus();
                                $.jBox.tip("请填写退回原因",'提示');
                                return false;
                            }
                            
                            if($("select[name=workflow]").val() == '指派'){
                                var checked = false;
                                if($("#sdate").val() == '' || $("#edate").val() == ''){
                                    $.jBox.tip("请选择时间要求",'提示');
                                    return false;
                                }
                                
                                $(".userlist input[type=radio]").each(function(index){
                                    if($(this).prop("checked")){
                                        checked = true;
                                        return false;
                                    }
                                });
                                
                                if(!checked){
                                    $.jBox.tip("请选择指派人",'提示');
                                }
                                return checked;
                            }
                            
                            return true;
                        });
                    });
                </script>
            </div>
            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}