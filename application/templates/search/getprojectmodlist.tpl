<table>
    <tbody>
        {foreach from=$list item=item}
         <tr>
            <td>{$item['createtime']|date_format:"Y-m-d H:i"}</td>
            <td>{$item['creator']}</td>
            <td>{$item['action']}</td>
            <td>{$item['content']|escape}</td>
        </tr>    
        {/foreach}
        
    </tbody>

</table>