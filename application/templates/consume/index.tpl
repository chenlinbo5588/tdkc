{include file="common/main_header.tpl"}
        
        {include file="consume/consume_header.tpl"}

        <div class="searchform row-fluid">
                <form action="{url_path('consume')}" method="get" name="searchform">
                    <input type="hidden" value="consume" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>耗材名称</strong><input type="text" name="name" value="{$smarty.get.name}"/></label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
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
                            <th>剩余数量</th>
                            <th>创建时间</th>
                            <th>最后修改时间</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           <td>{$item['name']|escape}</td>
                           <td>{$item['type']|escape}</td>
                           <td>{$item['unit_name']|escape}</td>
                           <td>{if $item['quantity'] < 10}<span class="notice">{$item['quantity']}</span>{else}{$item['quantity']}{/if}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>{$item['updatetime']|date_format:"Y-m-d H:i:s"}</td>
                        </tr>
                        {foreachelse}
                            <tr><td colspan="6">找不到数据</td></tr>
                        {/foreach}
                    </tbody>
                </table>
                {include file="pagination.tpl"}
             </div>

{include file="common/main_footer.tpl"}