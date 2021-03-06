{include file="common/main_header.tpl"}
        {include file="consume/consume_header.tpl"}
        <div class="searchform row-fluid">
                <form action="{url_path('consume')}" method="get" name="searchform">
                    <input type="hidden" value="consume" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="in" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>开始日期</strong><input type="text" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.get.sdate}"/></label>
                            <label><strong>结束日期</strong><input type="text" name="edate" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.get.edate}"/></label>
                            <label><strong>耗材名称</strong><input type="text" name="name" value="{$smarty.get.name}"/></label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            {auth name="consume+addin"}<a class="addlink" href="{url_path('consume','addin')}">增加库存</a>{/auth}
                        </li>
                     </ul>
                </form>
            </div>
            
            <div class="span12">
                {if $data['data']}
                <table class="table">
                    <thead>
                        <tr>
                            <th>耗材名称</th>
                            <th>耗材型号</th>
                            <th>计算单位</th>
                            <th>入库数量</th>
                            <th>入口时间</th>
                            <th>操作人</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           <td>{$item['name']|escape}</td>
                           <td>{$item['type']|escape}</td>
                           <td>{$item['unit_name']|escape}</td>
                           <td>{$item['quantity']}</td>
                           <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
                           <td>{$item['creator']}</td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
                {else}
                    <p>无记录</p>
                {/if}
                {include file="pagination.tpl"}
                
             </div>
            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}