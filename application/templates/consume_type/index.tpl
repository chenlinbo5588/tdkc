{include file="common/main_header.tpl"}

        <div class="searchform row-fluid">
                <form action="{url_path('consume_type')}" method="get" name="searchform">
                    <input type="hidden" value="consume_type" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>耗材名称</strong><input type="text" name="name" value="{$smarty.get.name}"/></label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            {auth name="consume_type+add"}<a class="addlink" href="{url_path('consume_type','add')}">添加耗材</a>{/auth}
                        </li>
                     </ul>
                </form>
            </div>
            
            <div class="span12">
                <table class="table">
                    <thead>
                        <tr>
                            <th>耗材名称</th>
                            <th>耗材型号</th>
                            <th>计算单位</th>
                            <th>使用该耗材的设备</th>
                            <th>数量</th>
                            <th>创建时间</th>
                            <th>最后修改时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           <td>{$item['name']|escape}</td>
                           <td>{$item['type']|escape}</td>
                           <td>{$item['unit_name']|escape}</td>
                           <td>{$item['machine']|escape}</td>
                           <td>{$item['quantity']|escape}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>{$item['updatetime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               {if $item['status'] != '已删除'}
                               {auth name="consume_type+edit"}<a href="{url_path('consume_type','edit','id=')}{$item['id']}">编辑</a>{/auth}
                               {auth name="consume_type+delete"}<a href="javascript:void(0);" data-title="{$item['name']|escape}" data-href="{url_path('consume_type','delete','id=')}{$item['id']}" data-id="{$item['id']}" class="delete">删除</a>{/auth}
                               {/if}
                            </td>
                        </tr>
                        {foreachelse}
                            <tr><td colspan="6">找不到数据</td></tr>
                        {/foreach}
                    </tbody>
                </table>
                {include file="pagination.tpl"}
             </div>

{include file="common/main_footer.tpl"}