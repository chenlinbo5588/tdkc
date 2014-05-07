<table class="maintain border1">
    <caption>项目日志</caption>
    <colgroup>
        <col width="100">
        <col width="50">
        <col width="800">
    </colgroup>
    <thead>
        <tr>
            <td>日期</td>
            <td>操作人员</td>
            <td>内容</td>
        </tr>
    </thead>
    <tbody>
        {foreach from=$worklog item=item}
        <tr>
            <td>{$item['createtime']|date_format:"Y-m-d H:i:s"}</td>
            <td>{$item['creator']}</td>
            <td>{$item['content']|escape}</td>
        </tr>
        {foreachelse}
        <tr><td colspan="3">还没有日志</td></tr>
        {/foreach}
    </tbody>
</table>