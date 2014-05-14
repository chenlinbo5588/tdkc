{include file="common/main_header.tpl"}
            <div class="row-fluid">
                <form action="{url_path('salary','adjust')}" method="post" name="addform">
                    <input type="hidden" name="user_id" value="{$userProfile['id']}"/>
                    <table class="maintain">
                        <tbody>
                            {foreach from=$salaryTypeList item=item}
                            <tr>
                                <td><label class="required"><em>*</em><strong>{$item['name']|escape}</strong></label></td>
                                <td>
                                    <input type="text" class="amount" name="salary_{$item['id']}" value="{if $userSalaryList[$item['id']]}{$userSalaryList[$item['id']]}{/if}"/>{form_error('amount[]')}
                                </td>
                            </tr>
                            {foreachelse}
                                <td colspan="2">尚未添加薪资结构，<a class="notice" href="{url_path('salary_type','add')}">点击添加</a></td>
                            {/foreach}
                            <tr>
                                <td></td>
                                <td><input type="submit" name="submit" class="btn btn-sm btn-primary" value="保存"/></td>
                            </tr>
                        </tbody>
                     </table>
                </form>
                <script>
                    $(function(){
                    
                    {if $feedMessage}
                        $.jBox.alert('{$feedMessage}', '提示');
                    {/if}
                    
                    {if $feedback == 'success'}
                        if(confirm('{$feedMessage}')){
                            location.href = "{url_path('salary','adjust')}";
                        }else{
                            location.href = "{url_path('salary')}";
                        }
                    {/if}
                    });
                </script>
            </div>
{include file="common/main_footer.tpl"}