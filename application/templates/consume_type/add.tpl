{include file="common/main_header.tpl"}
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('consume_type','edit')}" method="post" name="infoform">
                    <input type="hidden" name="id" value="{$info['id']}"/>
                {else}
                <form action="{url_path('consume_type','add')}" method="post" name="infoform">
                {/if}
                    <table class="maintain">
                        <tbody>
                            <tr>
                                <td><label class="required"><em>*</em><strong>耗材名称</strong></label></td><td><input type="text" style="width:200px" name="name" value="{$info['name']}" placeholder="请输入名称"/>{form_error('name')}</td>
                            </tr>
                            <tr>
                                <td><label class="optional"><em></em><strong>耗材型号</strong></label></td><td><input type="text" style="width:200px" name="type" value="{$info['type']}" placeholder="请输入型号"/>{form_error('type')}</td>
                            </tr>
                            <tr>
                                <td><label class="optional"><em></em><strong>计算单位</strong></label></td><td><input type="text" style="width:200px" name="unit_name" value="{$info['unit_name']}" placeholder="请输入计算单位"/><span class="tip">{form_error('unit_name')} 单位名称:如 支，个</span></td>
                            </tr>
                            <tr>
                                <td><label class="optional"><em></em><strong>使用该耗材的设备</strong></label></td><td><input type="text" style="width:200px" name="machine" value="{$info['machine']}" placeholder="请输入使用改耗材的设备"/>{form_error('machine')}</td>
                            </tr>
                            {if $action == 'edit'}
                            <tr>
                                <td><label class="required"><em></em><strong>耗材数量</strong></label></td><td><input type="text" style="width:200px" name="quantity" value="{$info['quantity']}" placeholder="请输入数量"/>{form_error('quantity')}</td>
                            </tr>    
                            {/if}
                            <tr>
                                <td></td>
                                <td>
                                    <input type="submit" name="submit" class="btn btn-sm btn-primary" value="保存"/>
                                    <input type="reset" name="reset" class="btn btn-sm btn-default" value="重置"/>
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
                            location.href = "{url_path('consume_type','add')}";
                        }else{
                            location.href = "{url_path('consume_type')}";
                        }
                    {/if}
                    
                    {if $action == 'edit' && $feedMessage}
                        $.jBox.alert('{$feedMessage}', '提示');
                    {/if}
                    });
                </script>
            </div>
{include file="common/main_footer.tpl"}