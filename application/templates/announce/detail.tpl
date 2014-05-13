<div class="pm_item_detail">
    <h3 class="title">{$info['title']}</h3>
    <table class="pm_item_table">
        <colgroup>
            <col width="100"/>
            <col width="200"/>
        </colgroup>
        <tbody>
            <tr>
                <td colspan="2">{$info['content']}</td>
            </tr>
            <tr>
                <th>创建人</th><td>{$info['creator']}</td>
            </tr>
            <tr>
                <th>创建时间</th><td>{$info['createtime']|date_format:"Y-m-d H:i:s"}</td>
            </tr>
        </tbody>
    </table>
</div>