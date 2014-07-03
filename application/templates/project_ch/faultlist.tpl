<tr>
    <td>初审缺陷历史</td>
    <td>
        <div class="notice">
            <table>
                <colgroup>
                    <col width="50%"/>
                    <col width="10%"/>
                    <col width="30%"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>缺陷项</th>
                        <th>扣分</th>
                        <th>备注</th>
                    </tr>
                </thead>
                <tbody>
                {foreach from=$userFaultList0 item=item}
                    <tr>
                        <td>{$item['fault_code']}{$item['fault_name']}</td>
                        <td>{$item['score']}</td>
                        <td>{$item['remark']|escape}</td>
                    </tr>
                {foreachelse}
                    <tr>
                        <td colspan="3">暂无缺陷</td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    </td>
</tr>
<tr>
    <td>复审缺陷历史</td>
    <td>
        <div class="notice">
            <table>
                <colgroup>
                    <col width="50%"/>
                    <col width="10%"/>
                    <col width="30%"/>
                </colgroup>
                <thead>
                    <tr>
                        <th>缺陷项</th>
                        <th>扣分</th>
                        <th>备注</th>
                    </tr>
                </thead>
                <tbody>
                {foreach from=$userFaultList1 item=item}
                    <tr>
                        <td>{$item['fault_code']}{$item['fault_name']}</td>
                        <td>{$item['score']}</td>
                        <td>{$item['remark']|escape}</td>
                    </tr>
                {foreachelse}
                    <tr>
                        <td colspan="3">暂无缺陷</td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    </td>
</tr>
{if $info['sendor_id'] == $userProfile['id'] && ($info['status'] == '已提交初审' || $info['status'] == '已提交复审')}
<tr class="fault">
    <td>缺陷扣分</td>
    <td>
        <div class="fault_wrapper">
            <a href="javascript:void(0);" class="toggle" data-toggle='{ "toggleText": ["-收起","+展开"],"target":"#faultList" }' >-收起</a>
            <div id="faultList" style="height:300px;overflow-y:scroll;">
                <table class="fault_list">
                        <caption>{$item['title']}</caption>
                        <colgroup>
                            <col width="50%"/>
                            <col width="10%"/>
                            <col width="30%"/>
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
                            <tr>
                            {if trim($list['name']) != ''}
                            <td><div><label><input type="checkbox" name="fault[]" value="{$list['code']}"/>{$list['code']}  {$list['name']}</label></div></td>
                            <td>{$list['score']}</td>
                            <td><input type="text" name="{$list['code']}_remark" style="width:280px;" value="" placeholder="请填写详情"/></td>
                            {/if}
                            </tr>
                        {/foreach}
                    {/foreach}  
                    </tbody>
                </table>
            </div>
        </div>
    </td>
</tr>
{/if}