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
                            <label class="required"><em>*</em><strong>部门名称</strong><input type="text" name="name" value="{$dept['name']}" placeholder="请输入部门姓名"/></label><input type="submit" name="submit" class="btn btn-sm btn-primary" value="保存"/>
                        </li>
                        <li>{form_error('name')}</li>
                        <li>
                            <label class="required"><em>*</em><strong>上级部门</strong></label>
                            <select name="pid">
                            {foreach from=$data item=item}
                            <option value="{$item['id']}" {if $dept['id'] == $item['id']}selected{/if}>{$item['title']}</div>
                            {foreachelse}
                                <option value="">尚未添加任何部门</option>
                            {/foreach}
                            </select>
                        </li>
                     
                        <li>
                            <div class="col2" >
                                <h3>员工列表</h3>
                                <div id="dept_employ_list">

                                </div>
                            </div>
                        </li>
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