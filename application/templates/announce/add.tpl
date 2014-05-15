{include file="common/main_header.tpl"}
          {include file="common/ke.tpl"}
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('announce','edit')}" method="post" name="infoform">
                    <input type="hidden" name="id" value="{$info['id']}"/>
                {else}
                <form action="{url_path('announce','add')}" method="post" name="infoform">
                {/if}
                    <table class="maintain">
                        <tbody>
                        <tr>
                            <td><label class="required"><em>*</em><strong>公告标题</strong></label></td><td><input type="text" style="width:500px" name="title" value="{$info['title']}" placeholder="请输入标题"/>{form_error('title')}</td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>内容</strong></label></td><td><textarea name="content" style="width:800px;height:400px;">{$info['content']}</textarea><br/>{form_error('content')}</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <input type="submit" name="submit" class="btn btn-sm btn-primary" value="保存"/>
                                <input type="reset" name="rst" class="btn btn-sm btn-default" value="重置"/>
                                {if $gobackUrl }<input type="hidden" name="gobackUrl" value="{$gobackUrl}"/><a class="goback" href="{$gobackUrl}">返回</a>{/if}
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
                    {if $feedback == 'success' && $action != 'edit'}
                        if(confirm('{$feedMessage}')){
                            location.href = "{url_path('announce','add')}";
                        }else{
                            location.href = "{url_path('announce')}";
                        }
                    {/if}
                    
                    {if $action == 'edit' && $feedMessage}
                        $.jBox.alert('{$feedMessage}', '提示');
                    {/if}
                    });
                </script>
            </div>
{include file="common/main_footer.tpl"}