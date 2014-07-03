<div class="notice">提示:点击文件名进行下载</div>
<ul id="filelist" class="tj_list">
    {foreach from=$files item=item}
        <li style="color:blue;"><div class="fname"><a title="点击下载" href="{url_path('attachment','download','id=')}{$item['id']}">{$item['file_name']}</a></div><div class="fsize">{byte_format($item['file_size'])}</div></li>
    {/foreach}
</ul>