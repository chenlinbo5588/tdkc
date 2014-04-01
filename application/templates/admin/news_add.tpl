          <h1 class="page-header">{$sideMenuName}</h1>
          <div class="row placeholders">
            <ul class="nav nav-pills">
                <li><a href="javascript:history.go(-1);">返回</a></li>
             </ul>
          </div>
          <link rel="stylesheet" href="/js/themes/default/default.css" />
          <script charset="utf-8" src="/js/kindeditor.js"></script>
          <script charset="utf-8" src="/js/lang/zh_CN.js"></script>
          <script charset="utf-8" src="/js/plugins/code/prettify.js"></script>
          <div class="table-responsive">
            {if $message['feedback'] }
            <div id="feedback" class="alert alert-{$message['className']}">{$message['feedback']}</div>
            <script>
                $(function(){
                    setTimeout(function(){
                        $("#feedback").fadeOut(function(){
                            $(this).remove();
                        });
                    },3000);
                });
            </script>
            {/if}
            <form role="form" name="addForm" action="{url_path('news','save',array(),true)}" method="post">
                <div class="form-group">
                    {if $action == 'edit' }
                    <input type="hidden" id="news_id" name="news_id" value="{$info['news_id']}" />
                    {/if}
                    <label for="title">主标题</label>
                    <input type="text" class="form-control" name="title" value="{$info['title']}" id="title" data-required style="width:600px;" placeholder="请输入新闻主标题，最多100个汉字"/>
                </div>
                <div class="form-group">
                    <label for="title2">次要标题</label>
                    <input type="text" class="form-control" name="title2" value="{$info['title2']}" id="title2" style="width:600px;" placeholder="请输入新闻呲次要标题，最多100个汉字"/>
                </div>
                <div class="form-group">
                    <label for="content1">内容</label>
                    <textarea class="form-control" name="content" style="width:100%;height:300px;visibility:hidden;">{$info['content']}</textarea>
                </div>
                
                <button type="submit" class="btn btn-primary">保存</button>
                </form>
                
          </div>
          
         <script src="/js/jquery-validate.js"></script>
        <script>
            var action = '{$action}';
            var editor1;
            $('form[name=addForm]').validate({
                onKeyup : true,
                eachValidField : function() {
                    $(this).closest('div').removeClass('has-error').addClass('has-success');
                },
                eachInvalidField : function() {
                    $(this).closest('div').removeClass('has-success').addClass('has-error');
                }{*,
                submitHandler:function(){
                    
                    $.ajax({
                        type:"POST",
                        url:'{url_path('news','save',array(),true)}',
                        data:{
                            title:"",
                            id: $("#news_id").length ? $("#news_id").val() : 0,
                            content:editor1.html()
                        },
                        dataType:"json",
                        success:function(resp){
                            console.log(resp);
                            alert(resp.feedback);
                        }
                    });
                }*}
            });
            
            KindEditor.ready(function(K) {
                editor1 = K.create('textarea[name="content"]', {
                    cssPath : '/js/plugins/code/prettify.css',
                    uploadJson : '{url_path('file','upload',array(),true)}',
                    //uploadJson:'/upload_json.php',
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
        </script>
        