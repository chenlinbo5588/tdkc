<tr>
    <td><strong>初审缺陷(组长对组员)</strong></td>
    <td>
        <div class="notice">
            <table>
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
    <td><strong>复审缺陷(复审员对组长)</strong></td>
    <td>
        <div class="notice">
            <table>
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
<tr>
    <td><strong>出资料后发现的缺陷</strong></td>
    <td>
        <div class="notice">
            <table>
                <thead>
                    <tr>
                        <th>缺陷项</th>
                        <th>扣分</th>
                        <th>备注</th>
                    </tr>
                </thead>
                <tbody>
                {foreach from=$userFaultList2 item=item}
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