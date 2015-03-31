<tr class="fault">
    <td colspan="2">
        <div class="fault_wrapper">
            <a href="javascript:void(0);" class="toggle" data-toggle='{ "toggleText": ["-收起扣分标准","+展开扣分标准"],"target":"#faultList" }' >+展开扣分标准</a>
            <div id="faultList" style="display:none;">
                <label>筛选分类</label><select name="fault_cate" id="fault_cate">
                    <option value="">所有</option>
                {foreach from=$sysFaultList key=key item=item}
                    <option value="{$key}">{$item['title']}</option>
                {/foreach}
                </select>
                <table class="fault_list">
                        <colgroup>
                            <col width="300"/>
                            <col width="80"/>
                            <col width="300"/>
                        
                        </colgroup>
                        <thead>
                            <tr>
                                <th>缺陷项</th>
                                <th>扣分</th>
                                <th>备注</th>
                            </tr>
                        </thead>
                        <tbody>
                    {foreach from=$sysFaultList item=item}
                        {foreach name="fautlItem" from=$item['list'] item=list}
                            {if trim($list['name']) != ''}
                            <tr class="fault_cate fault_cate_{$list['type']}">
                                <td><label><input type="checkbox" name="fault[]" value="{$list['code']}" {if $userFaultList0[$list['code']]}checked{/if}/>{$list['code']}  {$list['name']}</label></td>
                                <td>{$list['score']}</td>
                                <td><input type="text" name="{$list['code']}_remark" style="width:280px;" value="{$userFaultList0[$list['code']]['remark']|escape}" placeholder="请填写详情"/></td>
                            </tr>
                            {/if}
                        {/foreach}
                    {/foreach}  
                    </tbody>
                </table>
            </div>
        </div>
    </td>
</tr>