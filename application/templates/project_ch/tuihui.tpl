<div class="pd20">
    <style>
    .tuihui textarea {
        width:100%;
    }
    </style>
    <iframe name="post_iframe" frameborder="0" height="0" width="0"/>
     <form action="{url_path('project_ch','tuihui')}" method="post" name="sf" target="post_iframe">
        {foreach from=$projectList item=item}
        <div class="tuihui">
            <h2>{$item['name']|cutText:30}</h2>
            <textarea rows="3" cols="30" placeholder="请填写退回原因"></textarea>
            <input type="hidden" name="id[]" value="{$item['id']}"/>
        </div>
        {/foreach}
        <input type="submit" style="margin:10px;" name="submit" class="btn btn-sm btn-primary" value="确定"/>
     </form>
     <script>
         $("form[name=sf]").bind("submit",function(e){
            var that = $(e.target);
            var canSubmit = true;
            $("textarea",that).removeClass("requireInput");
            $("textarea",that).each(function(index){
            
                
                if($.trim($(this).val()).length == 0){
                    canSubmit = false;
                    $(this).addClass("requireInput");
                    $(this).focus();
                    
                    return false;
                }
            });
            
            return canSubmit;
         });
         
     </script>
</div>