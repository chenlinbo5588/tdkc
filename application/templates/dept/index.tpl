{include file="common/header.tpl"}
            <div class="row-fluid">
                <form action="{url_path('dept')}" method="get" name="deptform">
                    <input type="hidden" value="dept" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>部门名称</strong><input type="text"  name="name" value="{$smarty.get.name}" placeholder="请输入部门姓名"/></label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/><a href="{url_path('dept','add')}">添加部门</a>
                        </li>
                     </ul>
                </form>
            </div>
            
            <div class="span12 clearfix">
                <div class="col2">
                    <h3>组织架构</h3>
                    <div class="alert alert-warning" style="color:#f00;">备注：删除部门时，其下级部门将同样被删除,被删除部门下的员工将自动归入其上级部门</div>
                    <div class="datalist">
                        {foreach from=$data item=item}
                        <div class="dept clearfix" id="row_{$item['id']}">
                        {if $item['id'] != 1}
                            <a class="delete" href="javascript:void(0);" data-title="{$item['name']}" data-id="{$item['id']}" data-href="{url_path('dept','delete','id=')}{$item['id']}">【删除】</a>
                            <a class="deep{$item['level']}" href="{url_path('dept','edit','id=')}{$item['id']}&ajax=1&inlayer=yes">{$item['name']}</a>
                        {else}
                            <a style="width:10%" href="javascript:void(0);"></a><a href="{url_path('dept','edit','id=')}{$item['id']}&ajax=1&inlayer=yes">{$item['name']}</a>
                         {/if}
                        </div>
                        {foreachelse}
                            找不到数据
                        {/foreach}
                    </div>
                </div>
             </div>
            <script>

            </script>
{include file="common/footer.tpl"}