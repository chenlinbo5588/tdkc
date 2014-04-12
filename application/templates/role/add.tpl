{include file="common/main_header.tpl"}
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('role','edit')}" method="post" name="roleform">
                    <input type="hidden" name="id" value="{$role['id']}"/>
                {else}
                <form action="{url_path('role','add')}" method="post" name="roleform">
                {/if}
                    <table class="maintain">
                        <tbody>
                        <tr>
                            <td><label class="required"><em>*</em><strong>角色名称</strong></td><td><input type="text" style="width:200px" name="name" value="{$role['name']}" placeholder="请输入角色姓名"/></label>{form_error('name')}</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><input type="submit" name="submit" class="btn btn-sm btn-primary" value="保存"/></td>
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
                        alert('{$feedMessage}');
                    {/if}
                    });
                </script>
            </div>
{include file="common/main_footer.tpl"}