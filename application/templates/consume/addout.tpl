{include file="common/main_header.tpl"}
          
          
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('consume','editout')}" method="post" name="infoform">
                    <input type="hidden" name="id" value="{$info['id']}"/>
                {else}
                <form action="{url_path('consume','addout')}" method="post" name="infoform">
                {/if}
                    <table class="maintain">
                        <tbody>
                            <tr>
                                <td><label class="required"><em>*</em><strong>耗材</strong></label></td>
                                <td>
                                    <select name="name">
                                        {foreach from=$consumeTypeList item=item}
                                        <option value="{$item['id']}">{$item['name']}{$item['type']}-(剩余{$item['quantity']}{$item['unit_name']})</option>
                                        {/foreach}
                                    </select>
                                    {form_error('name')}
                                </td>
                            </tr>
                            <tr>
                                <td><label class="required"><em>*</em><strong>数量</strong></label></td><td><input  type="text" name="quantity" style="width:400px" value="{$info['quantity']}" placeholder="请输入数量"/>{form_error('quantity')}</td>
                            </tr>
                            <tr>
                                <td><label class="required"><em>*</em><strong>领取人</strong></label></td><td><input  type="text" name="owner" style="width:400px" value="{$info['owner']}" placeholder="请输入领取人"/>{form_error('owner')}</td>
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
                    $(function(){
                        $("form[name=infoform]").bind("submit",function(e){
                            var cansubmit = true;
                            if(!/^[0-9]+$/.test($("input[name=quantity]").val())){
                                $.jBox.tip('数量请输入整数', '提示');
                                $("input[name=quantity]").focus();
                                cansubmit = false;
                            }
                            
                            if(cansubmit && $.trim($("input[name=owner]").val()).length == 0){
                                $.jBox.tip('请输入领取人名字', '提示');
                                $("input[name=owner]").focus();
                                cansubmit = false;
                            }
                            
                            return cansubmit;
                        });
                    
                    {if $feedback == 'success'}
                        if(confirm('{$feedMessage}')){
                            location.href = "{url_path('consume','addout')}";
                        }else{
                            location.href = "{url_path('consume','out')}";
                        }
                    {/if}
                    {if $feedback == 'failed' && $feedMessage}
                        $.jBox.alert('{$feedMessage}', '提示');
                    {/if}
                    });
                </script>
            </div>
            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}