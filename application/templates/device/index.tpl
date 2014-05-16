{include file="common/main_header.tpl"}

        <div class="searchform row-fluid">
                <form action="{url_path('device')}" method="get" name="searchform">
                    <input type="hidden" value="device" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>设备名称</strong><input type="text" name="name" value="{$smarty.get.name}"/></label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            {auth name="device+add"}<a class="addlink" href="{url_path('device','add')}">添加仪器设备</a>{/auth}
                        </li>
                     </ul>
                </form>
            </div>
            
            <div class="span12">
                <table class="table">
                    <thead>
                        <tr>
                            <th>设备名称</th>
                            <th>设备型号</th>
                            <th>购买日期</th>
                            <th>购买价格</th>
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
                           <td>{$item['buy_time']|date_format:"Y-m-d"}</td>
                           <td>{$item['pay_amout']}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>{$item['updatetime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>
                               {if $item['status'] != '已删除'}
                               {auth name="device+edit"}<a href="{url_path('device','edit','id=')}{$item['id']}">编辑</a>{/auth}
                               {auth name="device+delete"}<a href="javascript:void(0);" data-title="{$item['name']|escape}" data-href="{url_path('device','delete','id=')}{$item['id']}" data-id="{$item['id']}" class="delete">删除</a>{/auth}
                               {/if}
                            </td>
                        </tr>
                        {foreachelse}
                            <tr><td colspan="9">找不到数据</td></tr>
                        {/foreach}
                    </tbody>
                </table>
                {include file="pagination.tpl"}
             </div>

{include file="common/main_footer.tpl"}