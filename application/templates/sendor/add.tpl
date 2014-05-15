{include file="common/main_header.tpl"}
            <div class="row-fluid">
                {*<div class="notice">最多只能设置5个发送人</div>*}
                
                {*
                <div id="selected">
                    {foreach from=$userSendorList item=item}
                    <label><input type="hiddem" name="sendor[]" value="{$item['id']}" id="sel_{$item['id']}"/>{$item['name']}<a href="javascript:void(0);">删除</a></label>
                    {/foreach}
                </div>
                *}
                {*<div>输入用户名<input type="text" name="sendor_name" id="sendor_name" value="" style="width:200px" placeholder="您也可以输入用户名称方式添加"/></div>*}
                
                
                {if $action == 'edit'}
                <form action="{url_path('sendor','edit')}" method="post" name="infoform">
                    <input type="hidden" name="id" value="{$info['id']}"/>
                {else}
                <form action="{url_path('sendor','add')}" method="post" name="infoform">
                {/if}
                    <div style="margin:0 0 10px 0;"><input type="submit" name="submit" class="btn btn-sm btn-primary" value="保存"/>&nbsp;<input type="button" name="cancel" class="btn btn-sm btn-default" value="取消选择"/>{if $gobackUrl }&nbsp;<input type="hidden" name="gobackUrl" value="{$gobackUrl}"/><a class="goback" href="{$gobackUrl}">返回</a>{/if}</div>
                    <div class="userlist clearfix">
                        {foreach from=$userList item=item}
                        {if in_array($item['id'],$userSendorList)}
                        <label class="selected"><input type="checkbox" name="sendor[]" value="{$item['id']}" data-name="{$item['name']}" checked/>{$item['name']}</label>
                        {else}
                        <label><input type="checkbox" name="sendor[]" value="{$item['id']}" data-name="{$item['name']}" />{$item['name']}</label>
                        {/if}
                        {/foreach}
                    </div>
                </form>
                <script>
                    $(function(){
                        $("input[name=cancel]").bind("click",function(e){
                            $(".userlist .selected").find("input[type=checkbox]").prop("checked",false);
                            $(".userlist .selected").removeClass("selected");
                        });
                    
                        $(".userlist label").bind("click",function(e){
                            //console.log($("input[type=checkbox]",e.target).prop("checked"));
                            if($("input[type=checkbox]",e.target).prop("checked")){
                                $(e.target).removeClass("selected");
                            }else{
                                $(e.target).addClass("selected");
                            }
                        });
                        
                    {*
                    $("#sendor_name").autocomplete({
                        source: "{url_path('search','getUserList','user_id=')}{$userProfile['id']}",
                        minLength: 0,
                        focus: function(event, ui) {
                            return false;
                        },
                        select: function( event, ui ) {
                            //if(!$("#sel_" + ui.item.id)){
                                $("#selected").append('<label><input type="hidden" name="sendor[]" id="sel_' + ui.item.id  + '" value="' + ui.item.id + '"/>' + ui.item.label + '<a href="javascript:void(0);">删除</a></label>');
                            //}
                        }
                    });*}

                        
                    {if $feedback == 'success' && $action != 'edit'}
                        if(confirm('{$feedMessage}')){
                            location.href = "{url_path('sendor','add')}";
                        }else{
                            location.href = "{url_path('sendor','index')}";
                        }
                    {/if}
                    
                    {if $action == 'edit' && $feedMessage}
                        $.jBox.alert('{$feedMessage}', '提示');
                    {/if}
                    });
                </script>
            </div>
{include file="common/main_footer.tpl"}