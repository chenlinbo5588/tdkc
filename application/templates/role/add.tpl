{include file="common/main_header.tpl"}
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('role','edit')}" method="post" name="infoform">
                    <input type="hidden" name="id" value="{$role['id']}"/>
                {else}
                <form action="{url_path('role','add')}" method="post" name="infoform">
                {/if}
                    <table class="maintain">
                        <tbody>
                        <tr>
                            <td><label class="required"><em>*</em><strong>角色名称</strong></label></td>
                            <td><input type="text" style="width:200px" name="name" value="{$role['name']}" placeholder="请输入角色姓名"/>{form_error('name')}</td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>角色类型</strong></label></td>
                            <td>
                                <select style="width:200px" name="type">
                                    <option value="2" {if $role['type'] == 2}selected{/if}>用户角色</option>
                                    <option value="1" {if $role['type'] == 1}selected{/if}>系统角色</option>
                                </select>{form_error('type')}
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <input type="submit" name="submit" class="btn btn-sm btn-primary" value="保存"/>
                                <input type="reset" name="rst" class="btn btn-sm btn-default" value="重置"/>
                                {if $gobackUrl }<input type="hidden" name="gobackUrl" value="{$gobackUrl}"/><a class="goback" href="{$gobackUrl}">返回</a>{/if}
                            </td>
                        </tr>
                        </tbody>
                     </table>
                </form>
                <script>
                    $(function(){
                    {if $feedback == 'success' && $action != 'edit'}
                        if(confirm('{$feedMessage}')){
                            location.href = "{url_path('role','add')}";
                        }else{
                            location.href = "{url_path('role')}";
                        }
                    {/if}
                    
                    {if $action == 'edit' && $feedMessage}
                        $.jBox.alert('{$feedMessage}', '提示');
                    {/if}
                    });
                </script>
            </div>
{include file="common/main_footer.tpl"}