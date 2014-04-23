<div id="proj_modpanel">
    <h1 class="panel_title">历史操作</h1>
    <a href="javascript:void(0);" id="modlist_close" style="position:absolute;right:10px;top:10px;" >-收起</a>
    <div class="panel_list">
    {foreach from=$modList item=item}
        <div class="moditem">
            <h3 class="title">【{$item['createtime']|date_format:"Y-m-d H:i:s"}】 {$item['creator']} - {$item['action']}</h3>
            <div class="modcontent">
                <p>{$item['content']}</p>
            </div>
        </div>    
    {/foreach}
    </div>

    
    <script>
        $("#modlist_close").bind("click",function(e){
            if($(this).html() == '-收起'){
                $(this).html('+展开');
            }else{
                $(this).html('-收起');
            }
            $("#proj_modpanel .panel_list").slideToggle();
        });
        
    </script>
</div>