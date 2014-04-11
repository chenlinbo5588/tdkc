{include file="common/main_header.tpl"} 
             <div class="feedback {$feedback}">{$feedMessage}</div>
             <form role="form" name="editForm" action="{url_path('admin','change_password')}" method="post">
                <table>
                    <tr>
                        <td><label for="old_psw">原密码</label></td>
                        <td><input type="password"  name="old_psw" value="" data-required id="old_psw" style="width:600px;" placeholder="请输入原密码"/>{form_error('old_psw')}</td>
                    </tr>
                    <tr>
                        <td><label for="new_psw">新密码</label></td>
                        <td><input type="password" name="new_psw" value="" data-required id="new_psw" style="width:600px;" placeholder="请输入新密码"/>{form_error('new_psw')}</td>
                    </tr>
                    <tr>
                        <td><label for="new_psw2">新密码</label></td>
                        <td><input type="password"  name="new_psw2" value="" data-required id="new_psw2" style="width:600px;" placeholder="请再次输入新密码"/>{form_error('new_psw2')}</td>
                     </tr>
                     <tr>
                         <td></td><td><button type="submit" class="btn btn-primary">保存</button></td>
                     </tr>
                </table>
             </form>
             <script>
                $(function(){
                {if $feedback == 'success'}
                    setTimeout(function(){
                        window.top.location.href = "{url_path('admin')}";
                     },4000);
                {/if}
              });
              </script>
{include file="common/main_footer.tpl"}  