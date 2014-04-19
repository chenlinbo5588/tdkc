{include file="common/main_header.tpl"}
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('contacts','edit')}" method="post" name="infoform">
                    <input type="hidden" name="id" value="{$info['id']}"/>
                {else}
                <form action="{url_path('contacts','add')}" method="post" name="infoform">
                {/if}
                    <table class="maintain">
                        <tbody>
                            <tr><td></td><td>{form_error('id')}</td></tr>
                            <tr>
                                <td><label class="required"><em>*</em><strong>类型</strong></label></td>
                                <td>
                                    <select name="type" style="width:200px" >
                                        <option value="0" {if $info['type'] === '0'}selected{/if}>内部通讯录</optin>
                                        <option value="1" {if $info['type'] === '1'}selected{/if}>外部通讯录</optin>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td><label class="required"><em>*</em><strong>名称</strong></label></td><td><input type="text" style="width:200px" name="name" value="{$info['name']}" placeholder="请输入名称"/>{form_error('name')}</td>
                            </tr>
                            <tr>
                                <td><label class="required"><em>*</em><strong>手机号码</strong></label></td><td><input type="text" style="width:200px" name="mobile" value="{$info['mobile']}" placeholder="请输入手机号码"/>{form_error('mobile')}</td>
                            </tr>
                            <tr>
                                <td><label class="optional"><em></em><strong>固定电话</strong></label></td><td><input type="text" style="width:200px" name="tel" value="{$info['tel']}" placeholder="请输入固定电话"/>{form_error('tel')}</td>
                            </tr>
                            <tr>
                                <td><label class="optional"><em></em><strong>传真号码</strong></label></td><td><input type="text" style="width:200px" name="fax" value="{$info['fax']}" placeholder="请输入传真号码"/>{form_error('fax')}</td>
                            </tr>
                            <tr>
                                <td><label class="required"><em>*</em><strong>地址</strong></label></td><td><input type="text" style="width:400px" name="address" value="{$info['address']}" placeholder="请输入地址"/>{form_error('address')}</td>
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
                    $(function(){
                    {if $feedback == 'success' && $action != 'edit'}
                        if(confirm('{$feedMessage}')){
                            location.href = "{url_path('contacts','add')}";
                        }else{
                            location.href = "{url_path('contacts')}";
                        }
                    {/if}
                    
                    {if $action == 'edit' && $feedMessage}
                        $.jBox.alert('{$feedMessage}', '提示');
                    {/if}
                    });
                </script>
            </div>
{include file="common/main_footer.tpl"}