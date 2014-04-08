{include file="common/header.tpl"}
            <div class="row-fluid">
                <form action="{url_path('dept')}" method="get" name="deptform">
                    <input type="hidden" value="dept" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>部门名称</strong><input type="text" name="name" value="{$smarty.get.name}" placeholder="请输入部门姓名"/></label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/><a href="{url_path('dept','add')}">添加部门</a>
                        </li>
                     </ul>
                </form>
            </div>
            
            <div class="span12 clearfix">
                <div class="col2">
                    <h3>部门列表</h3>
                    <div id="dept_list">
                        {foreach from=$data item=item}
                        <div class="dept deep{$item['level']}"><a href="{url_path('dept','edit','id=')}{$item['id']}&ajax=1&inlayer=yes">{$item['name']}</a></div>
                        {foreachelse}
                            找不到数据
                        {/foreach}
                    </div>
                </div>
                
             </div>
            <script>

            </script>
{include file="common/footer.tpl"}