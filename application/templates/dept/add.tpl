{include file="common/main_header.tpl"}
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('dept','edit')}" method="post" name="deptform">
                    <input type="hidden" name="id" value="{$dept['id']}"/>
                {else}
                <form action="{url_path('dept','add')}" method="post" name="deptform">
                {/if}
                    <table class="maintain">
                        <tbody>
                        <tr>
                            <td><label class="required"><em>*</em><strong>部门名称</strong></label></td>
                            <td><input type="text" style="width:350px;" name="name" value="{$dept['name']}" placeholder="请输入部门姓名"/>{form_error('name')}</td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>上级部门</strong></label></td>
                            <td>
                                <select name="pid">
                                {foreach from=$data item=item}
                                <option value="{$item['id']}" {if $dept['pid'] == $item['id']}selected{/if}>{$item['sep']}{$item['name']}</option>
                                {foreachelse}
                                    <option value="">尚未添加任何部门</option>
                                {/foreach}
                                </select>
                            </td>
                        </tr>
                        <tr><td></td><td><input type="submit" name="submit" class="btn btn-sm btn-primary" value="保存"/></td></tr>
                        {if $action == 'edit'}
                        <tr>
                            <td></td>
                            <td>
                                <div class="zzjg clearfix" >
                                    <h3><span>成员列表</span>&nbsp;<a class="goback" href="{url_path('dept')}">【返回】</a></h3>
                                    <div class="datalist">
                                        <ol id="dept_employ_list" class="style_decimal">
                                            {foreach from=$employs['data'] item=item}
                                            <li><a href="{url_path('user','edit','id=')}{$item['id']}">{$item['name']}</a></li>
                                            {foreachelse}
                                            <li>还没有成员</li>
                                            {/foreach}
                                        </ol>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        {/if}
                        </tbody>
                     </table>
                </form>
                <script>
                    $(function(){
                    {if $feedback == 'success' && $action != 'edit'}
                        if(confirm('{$feedMessage}')){
                            location.href = "{url_path('dept','add')}";
                        }else{
                            location.href = "{url_path('dept')}";
                        }
                    {/if}
                    
                    {if $action == 'edit' && $feedMessage}
                        $.jBox.alert('{$feedMessage}', '提示');
                    {/if}
                    });
                </script>
            </div>
{include file="common/main_footer.tpl"}