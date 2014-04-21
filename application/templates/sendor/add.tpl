{include file="common/main_header.tpl"}
            <div class="row-fluid">
                <div class="notice">最多只能设置5个发送人</div>
                
                <style>
                    #selected {
                        padding:15px 0;
                    }
                    
                    #selected label {
                        margin: 2px 4px;
                        border:1px solid #c7c7c7;
                        padding:5px;
                    }
                    
                    #selected label a {
                        padding: 0 5px;
                    }
                    
                    .userlist {
                        width:800px;
                    }
                    .userlist li {
                        border:1px solid #c7c7c7;
                        padding:5px;
                        margin:2px;
                        width:100px;
                        float:left;
                    }
                    
                    .userlist li:hover {
                        border:1px solid red;
                    }
                    
                    .userlist li label {
                        display:block;
                    }
                    
                </style>    
                <div id="selected">
                    {foreach from=$userSendorList item=item}
                    <label><input type="hiddem" name="sendor[]" value="{$item['id']}" id="sel_{$item['id']}"/>{$item['name']}<a href="javascript:void(0);">删除</a></label>
                    {/foreach}
                </div>
                {*<div>输入用户名<input type="text" name="sendor_name" id="sendor_name" value="" style="width:200px" placeholder="您也可以输入用户名称方式添加"/></div>*}
                
                
                {if $action == 'edit'}
                <form action="{url_path('sendor','edit')}" method="post" name="infoform">
                    <input type="hidden" name="id" value="{$info['id']}"/>
                {else}
                <form action="{url_path('sendor','add')}" method="post" name="infoform">
                {/if}
                
                    <div><input type="submit" name="submit" class="btn btn-sm btn-primary" value="保存"/></div>
                    
                    <ul class="userlist clearfix">
                        {foreach from=$userList item=item}
                        <li><label><input type="checkbox" name="sendor[]" value="{$item['id']}" data-name="{$item['name']}"/>{$item['name']}</label></li>
                        {/foreach}
                        
                    </ul>
                </form>
                <script>
                    $(function(){
                    
                    
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
                            location.href = "{url_path('sendor')}";
                        }
                    {/if}
                    
                    {if $action == 'edit' && $feedMessage}
                        $.jBox.alert('{$feedMessage}', '提示');
                    {/if}
                    });
                </script>
            </div>
{include file="common/main_footer.tpl"}