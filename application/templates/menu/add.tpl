{include file="common/main_header.tpl"}
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('menu','edit')}" method="post" name="infoform">
                    <input type="hidden" name="id" value="{$menu['id']}"/>
                {else}
                <form action="{url_path('menu','add')}" method="post" name="infoform">
                {/if}
                    <table class="maintain">
                        <tbody>
                        <tr>
                            <td><label class="required"><em>*</em><strong>菜单名称</strong></label></td><td><input type="text" style="width:250px;" name="name" value="{$menu['name']}" placeholder="请输入菜单姓名"/>{form_error('name')}</td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>权限名称</strong></label></td><td><input type="text" style="width:250px;" name="url" value="{$menu['url']}" placeholder="请输入权限名称"/><span class="tip">请按照 c=user&m=edit 这样的格式输入 {form_error('url')}</span></td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>上级菜单</strong></label></td>
                            <td>
                                <select name="pid">
                                <option value="0">无</option>
                                {foreach from=$data item=item}
                                <option value="{$item['id']}" {if $menu['pid'] == $item['id']}selected{/if}>{$item['sep']}{$item['name']}</option>
                                {/foreach}
                                </select>
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
                            location.href = "{url_path('menu','add')}";
                        }else{
                            location.href = "{url_path('menu')}";
                        }
                    {/if}
                    
                    {if $action == 'edit' && $feedMessage}
                        $.jBox.alert('{$feedMessage}', '提示');
                    {/if}
                    });
                </script>
            </div>
{include file="common/main_footer.tpl"}