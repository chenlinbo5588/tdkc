<div class="pd20">
    <style>
        .sendorList li {
            margin:5px 0;
        }
    </style>
    
    <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>
     <form action="{url_path('project_ch','sendone')}" method="post" name="sf" target="post_iframe">
        {foreach from=$id item=item}
        <input type="hidden" name="id[]" value="{$item}"/>     
        {/foreach}
        {if $userSendorList}
        <ul class="sendorList">
            {foreach name="sendorlist" from=$userSendorList item=item}
            <li>
                <label><input type="radio" name="sendor" value="{$item['sendor_id']}" {if $smarty.foreach.sendorlist.first}checked{/if}>{$item['sendor']}</label>
            </li>
            {/foreach}
        </ul>
        <input type="submit" style="margin:10px;" name="submit" class="btn btn-sm btn-primary" value="发送"/>
        {/if}
        <div>还没有设置发送人或者找不到你要发送的人？，请点击<a class="notice" href="{url_path('sendor','add')}">这里</a>进行添加</a></div>
        
     </form>
     
</div>