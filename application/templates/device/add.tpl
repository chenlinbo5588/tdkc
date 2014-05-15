{include file="common/main_header.tpl"}
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('device','edit')}" method="post" name="infoform">
                    <input type="hidden" name="id" value="{$info['id']}"/>
                {else}
                <form action="{url_path('device','add')}" method="post" name="infoform">
                {/if}
                    <table class="maintain">
                        <tbody>
                            <tr>
                                <td><label class="required"><em>*</em><strong>设备名称</strong></label></td><td><input type="text" style="width:200px" name="name" value="{$info['name']}" placeholder="请输入设备名称"/>{form_error('name')}</td>
                            </tr>
                            <tr>
                                <td><label class="required"><em>*</em><strong>设备型号</strong></label></td><td><input type="text" style="width:200px" name="type" value="{$info['type']}" placeholder="请输入设备型号"/>{form_error('type')}</td>
                            </tr>
                             <tr>
                                <td><label class="required"><em>*</em><strong>购买日期</strong></label></td><td><input type="text"  name="buy_time" class="Wdate" readonly onclick="WdatePicker()" value="{$info['buy_time']|date_format:"Y-m-d"}" placeholder="请输入购买日期"/>{form_error('buy_time')}</td>
                            </tr>
                            <tr>
                                <td><label class="required"><em>*</em><strong>购买价格</strong></label></td><td><input type="text"  name="pay_amout" value="{$info['pay_amout']}" placeholder="请输入购买价格"/>{form_error('pay_amout')}</td>
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
                    {if $feedback == 'success' && $action != 'edit'}
                        if(confirm('{$feedMessage}')){
                            location.href = "{url_path('device','add')}";
                        }else{
                            location.href = "{url_path('device')}";
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