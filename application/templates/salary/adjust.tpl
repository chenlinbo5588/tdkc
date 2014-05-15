{include file="common/main_header.tpl"}
            <div class="row-fluid">
                <form action="{url_path('salary','adjust')}" method="post" name="infoform">
                    <input type="hidden" name="user_id" value="{$user['id']}"/>
                    <table class="maintain">
                        <tbody>
                            <tr>
                                <td><label class="optional"><em></em><strong>姓名</strong></label></td>
                                <td>{$user['name']}</td>
                            </tr>
                            {foreach from=$salaryTypeList item=item}
                            <tr>
                                <td><label class="required"><em>*</em><strong>{$item['name']|escape}</strong></label></td>
                                <td>
                                    <input type="text" class="amount" name="salary_{$item['id']}" data-title="{$item['name']|escape}" value="{if $userSalary['salary'][$item['name']]}{$userSalary['salary'][$item['name']]}{/if}"/>{form_error("salary_{$item['id']}")}
                                </td>
                            </tr>
                            {foreachelse}
                                <td colspan="2">尚未添加薪资结构，<a class="notice" href="{url_path('salary_type','add')}">点击添加</a></td>
                            {/foreach}
                            <tr>
                                <td></td>
                                <td>
                                    {if $salaryTypeList}
                                    <input type="submit" name="submit" class="btn btn-sm btn-primary" value="调整"/>
                                    <input type="reset" name="rst" class="btn btn-sm btn-default" value="重置"/>
                                    {/if}
                                    {if $gobackUrl }<input type="hidden" name="gobackUrl" value="{$gobackUrl}"/><a class="goback" href="{$gobackUrl}">返回</a>{/if}
                                </td>
                            </tr>
                        </tbody>
                     </table>
                </form>
                            
                            
                <div class="project_detail">
                    <table class="maintain border1">
                        <caption>薪资变更记录</caption>
                        <colgroup>
                            <col width="100">
                            <col width="100">
                            <col width="800">
                        </colgroup>
                        <thead>
                            <tr>
                                <td>日期</td>
                                <td>操作人员</td>
                                <td>历史薪资</td>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$userSalaryHistory item=item}
                            <tr>
                                <td>{$item['createtime']|date_format:"Y-m-d H:i"}</td>
                                <td>{$item['creator']}</td>
                                <td>{$item['salary_text']}</td>
                            </tr>
                            {foreachelse}
                            <tr><td colspan="3">还没有日志</td></tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>    
                <script>
                    $(function(){
                        $("form[name=addform]").bind("submit",function(e){
                            var cansubmit = true;
                            $(".amount").each(function(index){
                                if(!/^[0-9]+(.[0-9]+)?$/.test($(this).val())){
                                    $.jBox.tip($(this).attr("data-title") + "不符号格式",'提示');
                                    $(this).focus();
                                    cansubmit = false;
                                    return false;
                                }
                            });
                            return cansubmit;
                        });
                        
                    {if $feedMessage}
                        $.jBox.alert('{$feedMessage}', '提示');
                    {/if}
                    
                    });
                </script>
            </div>
{include file="common/main_footer.tpl"}