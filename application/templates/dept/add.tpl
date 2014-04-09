{include file="common/header.tpl"}
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('dept','edit')}" method="post" name="deptform">
                    <input type="hidden" name="id" value="{$dept['id']}"/>
                {else}
                <form action="{url_path('dept','add')}" method="post" name="deptform">
                {/if}
                    <ul class="formarea">
                        <li>
                            <label class="required"><em>*</em><strong>部门名称</strong><input type="text" style="width:350px;" name="name" value="{$dept['name']}" placeholder="请输入部门姓名"/></label>
                        </li>
                        <li>{form_error('name')}</li>
                        <li>
                            <label class="required"><em>*</em><strong>上级部门</strong></label>
                            <select name="pid" style="width:350px;">
                            {foreach from=$data item=item}
                            <option value="{$item['id']}" {if $dept['pid'] == $item['id']}selected{/if}>{$item['title']}</div>
                            {foreachelse}
                                <option value="">尚未添加任何部门</option>
                            {/foreach}
                            </select>
                        </li>
                        <li><input type="submit" name="submit" class="btn btn-sm btn-primary" value="保存"/></label>
                        {if $action == 'edit'}
                        <li>
                            <div class="col2" >
                                <h3><span>成员列表</span>&nbsp;<a class="goback" href="javascript:history.go(-1);">【返回】</a></h3>
                                <div class="datalist">
                                    <ol id="dept_employ_list" class="style_decimal">
                                        {foreach from=$employs['data'] item=item}
                                        <li><a href="{url_path('user','edit','id=')}{$item['user_id']}">{$item['name']}</a></li>
                                        {foreachelse}
                                        <li>还没有员工</li>
                                        {/foreach}
                                    </ol>
                                 </div>
                            </div>
                        </li>
                        {/if}
                     </ul>
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
                        alert('{$feedMessage}');
                    {/if}
                    });
                </script>
            </div>
{include file="common/footer.tpl"}