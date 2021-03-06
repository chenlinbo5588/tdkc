{include file="common/main_header.tpl"}
            <div class="searchform row-fluid">
                {auth name="dept+add"}<a href="{url_path('dept','add')}">添加部门</a>{/auth}
            </div>
            
            <div class="span12 clearfix">
                <table class="table">
                    <thead>
                        <tr>
                            <th>组织架构 <b style="color:#f00;">备注：删除部门时，其下级部门将同时被删除,被删除部门下的员工将自动归入其上级部门</b></th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data item=item}
                        <tr id="row_{$item['id']}">
                        {if $item['id'] != 1}
                            <td>
                                {auth name="dept+delete"}<a class="delete" href="javascript:void(0);" data-title="{$item['name']}" data-id="{$item['id']}" data-href="{url_path('dept','delete','id=')}{$item['id']}">【删除】</a>{/auth}
                                {auth name="dept+edit"}<a class="tree_item" href="{url_path('dept','edit','id=')}{$item['id']}">{$item['sep']}{$item['name']}</a>{/auth}
                            </td>
                        {else}
                            <td>{auth name="dept+edit"}<a href="{url_path('dept','edit','id=')}{$item['id']}">{$item['name']}</a>{/auth}</td>
                         {/if}
                        </div>
                        {foreachelse}
                            <td></td>
                        {/foreach}
                        </tr>
                    </tbody>
                </table>
             </div>
{include file="common/main_footer.tpl"}