{include file="common/main_header.tpl"}

          {include file="common/ke.tpl"}
          
          
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('pm','edit')}" method="post" name="infoform">
                    <input type="hidden" name="id" value="{$info['id']}"/>
                {else}
                <form action="{url_path('pm','add')}" method="post" name="infoform">
                {/if}
                    <table class="maintain">
                        <tbody>
                        <tr>
                            <td><label class="required"><em>*</em><strong>消息标题</strong></label></td><td><input type="text" style="width:500px" name="title" value="{$info['title']}" placeholder="请输入消息标题"/>{form_error('title')}</td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>发送给</strong></label></td><td><input type="hidden" id="to_user_id" name="to_user_id" value="{$info['to_user_id']}"/><input type="text" style="width:500px" id="to_user_name" name="to_user_name" value="{$info['to_user_name']}" placeholder="请输入收件人"/>{if form_error('to_user_id') != ''}<span class="validate_error">收件人信息错误&nbsp;</span>{/if}{form_error('to_user_name')}</td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>消息内容</strong></label></td><td><textarea name="content" style="width:800px;height:400px;">{$info['content']}</textarea><br/>{form_error('content')}</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <input type="submit" name="submit" class="btn btn-sm btn-primary" value="保存"/>
                            </td>
                        </tr>
                        </tbody>
                     </table>
                </form>
                <script>
                    var editor1;
                    KindEditor.ready(function(K) {
                        editor1 = K.create('textarea[name="content"]', {
                            cssPath : '/js/plugins/code/prettify.css',
                            uploadJson : '{url_path('attachment','upload')}',
                            allowFileManager : false,
                            afterCreate : function() {
                                {*
                                var self = this;
                                K.ctrl(document, 13, function() {
                                    self.sync();
                                    K('form[name=example]')[0].submit();
                                });
                                K.ctrl(self.edit.doc, 13, function() {
                                    self.sync();
                                    K('form[name=example]')[0].submit();
                                });*}
                            }
                        });
                        prettyPrint();
                    });
                    
                    
                    $(function(){
                        $("#to_user_name").autocomplete({
                            source: "{url_path('search','getUserList','user_id=')}{$userProfile['id']}",
                            minLength: 0,
                            focus: function(event, ui) {
                                $( "#to_user_name" ).val( ui.item.label );
                            },
                            select: function( event, ui ) {
                                $( "#to_user_name" ).val( ui.item.label );
                                $( "#to_user_id" ).val( ui.item.id );
                                
                            }
                        });
        
                    
                    {if $feedback == 'success' && $action != 'edit'}
                        if(confirm('{$feedMessage}')){
                            location.href = "{url_path('pm','add')}";
                        }else{
                            location.href = "{url_path('pm','send')}";
                        }
                    {/if}
                    
                    {if $action == 'edit' && $feedMessage}
                        $.jBox.alert('{$feedMessage}', '提示');
                    {/if}
                    });
                </script>
                
            </div>
            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}