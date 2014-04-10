{include file="common/header.tpl"}
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('menu','edit')}" method="post" name="deptform">
                    <input type="hidden" name="id" value="{$menu['id']}"/>
                {else}
                <form action="{url_path('menu','add')}" method="post" name="menuform">
                {/if}
                    <ul class="formarea">
                        <li>
                            <label class="required"><em>*</em><strong>菜单名称</strong><input type="text" style="width:350px;" name="name" value="{$menu['name']}" placeholder="请输入菜单姓名"/></label>{form_error('name')}
                        </li>
                        <li>
                            <label class="required"><em>*</em><strong>权限名称</strong><input type="text" style="width:350px;" name="url" value="{$menu['url']}" placeholder="请输入权限名称"/></label><span class="tip">请按照 c=user&m=edit 这样的格式输入 {form_error('url')}</span>
                        </li>
                        <li>
                            <label class="required"><em>*</em><strong>上级菜单</strong></label>
                            <select name="pid" style="width:350px;">
                            <option value="0">无</option>
                            {foreach from=$data item=item}
                            <option value="{$item['id']}" {if $menu['pid'] == $item['id']}selected{/if}>{$item['sep']}{$item['name']}</option>
                            {/foreach}
                            </select>
                        </li>
                        <li><input type="submit" name="submit" class="btn btn-sm btn-primary" value="保存"/></label>
                        
                     </ul>
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
                        alert('{$feedMessage}');
                    {/if}
                    });
                </script>
            </div>
{include file="common/footer.tpl"}