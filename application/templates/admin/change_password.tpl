{include file="common/main_header.tpl"} 
    <div class="row-fluid">
             <div class="feedback {$feedback}">{$feedMessage}</div>
             <form role="form" name="editForm" action="{url_path('admin','change_password')}" method="post">
                <table class="maintain">
                    <tr>
                        <td><label for="old_psw">原密码</label></td>
                        <td><input type="password"  name="old_psw" value="" data-required id="old_psw" style="width:300px;" placeholder="请输入原密码"/>{form_error('old_psw')}</td>
                    </tr>
                    <tr>
                        <td><label for="new_psw">新密码</label></td>
                        <td><input type="password" name="new_psw" value="" data-required id="new_psw" style="width:300px;" placeholder="请输入新密码"/>{form_error('new_psw')}</td>
                    </tr>
                    <tr>
                        <td><label for="new_psw2">新密码</label></td>
                        <td><input type="password"  name="new_psw2" value="" data-required id="new_psw2" style="width:300px;" placeholder="请再次输入新密码"/>{form_error('new_psw2')}</td>
                     </tr>
                     <tr>
                         <td></td><td><button type="submit" class="btn btn-primary">保存</button></td>
                     </tr>
                </table>
             </form>
  </div>
{include file="common/main_footer.tpl"}  