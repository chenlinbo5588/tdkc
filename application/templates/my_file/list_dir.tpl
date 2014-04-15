<div class="pd20">
    <form name="moveForm" action="{url_path('my_file','move')}" method="post">
        <input type="hidden" name="move_id" value=""/>
    </form>
    <ul class="dir_list">
        <li class="filerow isdir"><input type="hidden" name="folder_id" value="0"/><span class="file_icon dir_icon16"></span><span class="filename" >根目录</span></li>
    {foreach from=$dirList item=item}
        <li class="filerow isdir"><input type="hidden" name="folder_id" value="{$item['id']}"/><span class="file_icon dir_icon16" style="left:{($item['level'] + 1) * 16}px"></span><span class="filename" style="margin-left:{($item['level'] + 2) * 16}px">{$item['file_name']}</span></li>
    {/foreach}
    </ul>
    <script>
    $(function(){
        $(".dir_list li").bind("click",function(){
            $(this).closest("ul").find("li").removeClass("selected");
            $(this).addClass("selected");
            
            $("input[name=move_id]").val($("input[name=folder_id]",this).val());
        });
    })
    </script>
</div>