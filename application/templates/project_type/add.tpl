{include file="common/main_header.tpl"}
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('project_type','edit')}" method="post" name="infoform">
                    <input type="hidden" name="id" value="{$info['id']}"/>
                {else}
                <form action="{url_path('project_type','add')}" method="post" name="infoform">
                {/if}
                    <table class="maintain">
                        <tbody>
                        <tr>
                            <td><label class="required"><em>*</em><strong>类型</strong></label></td>
                            <td>
                                <select name="type" style="width:200px">
                                    <option value="测绘项目" {if $info['type'] == '测绘项目'}selected{/if}>测绘项目</option>
                                    <option value="规划项目" {if $info['type'] == '规划项目'}selected{/if}>规划项目</option>
                                </select>
                                {form_error('type')}
                            </td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>名称</strong></label></td><td><input type="text" style="width:200px" name="name" value="{$info['name']}" placeholder="请输入名称"/>{form_error('name')}</td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>排序</strong></label></td><td><input type="text" style="width:200px" name="displayorder" value="{$info['displayorder']}" placeholder="排序"/><span class="tip">{form_error('displayorder')} 项目登记类型选择是显示的顺序,数字越大越前面</span></td>
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
                            location.href = "{url_path('project_type','add')}";
                        }else{
                            location.href = "{url_path('project_type')}";
                        }
                    {/if}
                    
                    {if $action == 'edit' && $feedMessage}
                        $.jBox.alert('{$feedMessage}', '提示');
                    {/if}
                    });
                </script>
            </div>
{include file="common/main_footer.tpl"}