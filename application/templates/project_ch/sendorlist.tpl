<div class="userlist_wrap">
    {if $userSendorList}
    <div class="userlist clearfix">
        {if 1 == count($userSendorList)}
        {foreach  from=$userSendorList item=item}
        <label class="item selected"><input type="radio" name="sendor" value="{$item['sendor_id']}" checked="checked">{$item['sendor']}</label>
        {/foreach}
        {else}
        {foreach  from=$userSendorList item=item}
        <label class="item"><input type="radio" name="sendor" value="{$item['sendor_id']}" {if $info['sendor_id'] == $item['sendor_id']}checked{/if}>{$item['sendor']}</label>
        {/foreach}
        {/if}
    </div>
    {/if}
    <div>没有找到你要发送的人？，请点击<a class="notice" href="{url_path('sendor','add')}">这里</a>进行添加</a></div>
</div>