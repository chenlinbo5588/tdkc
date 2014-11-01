<div class="pd20">
    <form name="postform" id="tzfee" action="{url_path('taizhang','fee')}" method="post" >
        <input type="hidden" name="id" value="{$info['id']}"/>
        {include file="taizhang/fee_list.tpl"}
    </form>
    
    <script>
        $(function(){
            $("#tzfee input[type=submit]").bind("click",function(e){
                var that = $(e.target);
                var btnVal = that.val();
                var loading = that.siblings(".loading");
                that.prop("disabled",true);
                loading.show();
                
                $.ajax({
                    type:"POST",
                    url:"{url_path('taizhang','fee')}",
                    data: $("#tzfee").serialize() + "&submit=" + that.val(),
                    dataType:"json",
                    success:function(resp){
                        alert(resp.body.text);
                        if(resp.code == 'success'){
                            if(btnVal == '受理'){
                                that.val("收费");
                            }else{
                                location.reload();
                            }
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