          <h1 class="page-header">修改密码</h1>
          <div class="row placeholders">
            {*
            <ul class="nav nav-pills">
                <!--<li><a href="javascript:history.go(-1);">返回</a></li>-->
             </ul>
             *}
          </div>
          
          <div class="table-responsive">
            {if $message['feedback'] }
            <div id="feedback" class="alert alert-{$message['className']}">{$message['feedback']}</div>
            <script>
                $(function(){
                    setTimeout(function(){
                        $("#feedback").fadeOut(function(){
                            $(this).remove();
                        });
                        
                        {if $message['location']}
                        location.href = '{$message['location']}';
                        {/if}
                    },3000);
                });
            </script>
            {/if}
            <form role="form" name="editForm" action="{url_path('admin','save_password',array(),true)}" method="post">
                <div class="form-group">
                    <label for="old_psw">原密码</label>
                    <input type="password" class="form-control" name="old_psw" value="" data-required id="old_psw" style="width:600px;" placeholder="请输入原密码"/>
                </div>
                <div class="form-group">
                    <label for="new_psw">新密码</label>
                    <input type="password" class="form-control" name="new_psw" value="" data-required id="new_psw" style="width:600px;" placeholder="请输入新密码"/>
                </div>
                <div class="form-group">
                    <label for="new_psw2">新密码</label>
                    <input type="password" class="form-control" name="new_psw2" value="" data-required id="new_psw2" style="width:600px;" placeholder="请再次输入新密码"/>
                </div>
                <button type="submit" class="btn btn-primary">保存</button>
             </form>
         </div>
         <script src="/js/jquery-validate.js"></script>
        <script>
            var editor1;
            $('form[name=editForm]').validate({
                onKeyup : true,
                eachValidField : function() {
                    $(this).closest('div').removeClass('has-error').addClass('has-success');
                },
                eachInvalidField : function() {
                    $(this).closest('div').removeClass('has-success').addClass('has-error');
                }
            });
            
        </script>