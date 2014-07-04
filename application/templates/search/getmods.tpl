<table class="table">
    <thead>
        <tr>
            <th>操作时间</th>
            <th>操作人</th>
            <th>动作</th>
            <th>内容</th>
        </tr>
    </thead>
    <tbody>
        {foreach from=$list item=item}
         <tr>
            <td>{$item['createtime']|date_format:"Y-m-d H:i"}</td>
            <td>{$item['creator']}</td>
            <td>{$item['action']}</td>
            <td>{$item['content']}</td>
        </tr>    
        {/foreach}
        
    </tbody>

</table>