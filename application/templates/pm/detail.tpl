<div class="pm_item_detail">
    <h3 class="title">{$info['title']}</h3>
    <table class="pm_item_table">
        <colgroup>
            <col width="100"/>
            <col width="200"/>
        </colgroup>
        <tbody>
            <tr>
                <th>发件人</th><td>{$info['creator']}</td>
            </tr>
            <tr>
                <th>收件人</th><td>{$info['receivor']}</td>
            </tr>
            <tr>
                <th>发件时间</th><td>{$info['createtime']|date_format:"Y-m-d H:i:s"}</td>
            </tr>
            <tr>
                <td colspan="2">{$info['content']}</td>
            </tr>
        </tbody>
    </table>
</div>