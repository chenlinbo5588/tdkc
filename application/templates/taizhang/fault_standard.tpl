{if $info['sendor_id'] == $userProfile['id'] && ($info['status'] == '已提交初审' || $info['status'] == '已提交复审')}
<tr class="fault">
    <td colspan="2">
        <div class="fault_wrapper">
            <a href="javascript:void(0);" class="toggle" data-toggle='{ "toggleText": ["-收起扣分标准","+展开扣分标准"],"target":"#faultList" }' >+展开扣分标准</a>
            <div id="faultList" style="display:none;">
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