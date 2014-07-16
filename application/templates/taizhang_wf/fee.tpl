<div class="pd20">
    <form name="postform" id="tzfee" action="{url_path('taizhang_wf','fee')}" method="post" >
        <input type="hidden" name="id" value="{$info['id']}"/>
        {include file="taizhang_wf/fee_list.tpl"}
    </form>
    
    <script>
        $(function(){
            $("#tzfee input[type=submit]").bind("click",function(e){
                var that = $(e.target);
                var loading = that.siblings(".loading");
                that.prop("disabled",true);
                loading.show();
                
                $.ajax({
                    type:"POST",
                    url:"{url_path('taizhang_wf','fee')}",
                    data: $("#tzfee").serialize(),
                    dataType:"json",
                    success:function(resp){
                        alert(resp.body.text);
                        if(resp.code == 'success'){
                            location.reload();
                        }
                    },
                    complete:function(){
                        that.prop("disabled",false);
                        loading.hide();
                    },
                    error:function(){
                        that.prop("disabled",false);
                        loading.hide();
                    }
                });
                
                e.preventDefault();
            });
        });
    </script>
</div>