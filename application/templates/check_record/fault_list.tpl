<tr>
    <td><strong>缺陷</strong></td>
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