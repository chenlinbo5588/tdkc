{include file="common/main_header.tpl"}
            <div class="searchform row-fluid">
                {auth name="menu+add"}<a href="{url_path('menu','add')}">添加菜单</a>{/auth}
            </div>
            
            <div class="span12">
                <table class="table">
                    <thead>
                        <tr>
                            <th>菜单名称</th>
                            <th>权限名称</th>
                            <th>状态</th>
                            <th>创建人</th>
                            <th>创建时间</th>
                            <th>最后修改人</th>
                            <th>最后修改时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data item=item}
                        <tr id="row_{$item['id']}">
                           <td>{$item['sep']}{$item['name']}</td>
                           <td>{$item['url']}</td>
                           <td>{$item['status']}</td>
                           <td>{$item['creator']}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>{$item['updator']}</td>
                           <td>{$item['updatetime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               {auth name="menu+add"}<a href="{url_path('menu','edit','id=')}{$item['id']}">编辑</a>{/auth}
                               {auth name="menu+delete"}<a href="javascript:void(0);" data-title="{$item['name']}" data-href="{url_path('menu','delete','id=')}{$item['id']}" data-id="{$item['id']}" class="delete">删除</a>{/auth}
                           </td>
                        </tr>
                        {foreachelse}
                            <tr>
                                <td colspan="8">找不到数据</td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
            
            <script>

            </script>
{include file="common/main_footer.tpl"}