{include file="common/main_header.tpl"}
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('region','edit')}" method="post" name="addform">
                    <input type="hidden" name="id" value="{$info['id']}"/>
                {else}
                <form action="{url_path('region','add')}" method="post" name="addform">
                {/if}
                    <table class="maintain">
                        <tbody>
                        <tr>
                            <td><label class="required"><em>*</em><strong>名称</strong></td>
                            <td>
                                <select name="name" style="width:200px">
                                    {foreach from=$zxList['data'] item=item}
                                    <option value="{$item['name']}" {if $info['name'] == $item['name']}selected{/if}>{$item['name']}</option>
                                    {/foreach}
                                </select>
                                {form_error('name')}
                            </td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>代码</strong></label></td><td><input type="text" style="width:200px" name="code" value="{$info['code']}" placeholder="请输入镇街代码"/><span class="tip">{form_error('code')} 如 A， 最长5个字符,不区分大小写</span></td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>年份</strong></label></td>
                            <td>
                                <select name="year"  style="width:200px" >
                                    {foreach from=$yearList item=item}
                                        <option value="{$item}" {if $info['year'] == $item}selected{/if}>{$item}</option>
                                    {/foreach}
                                </select>
                                <span class="tip">{form_error('year')}</span>
                            </td>
                        </tr>
                        <tr>
                            <td><label class="optional"><em></em><strong>排序</strong></label></td><td><input type="text" style="width:200px" name="displayorder" value="{$info['displayorder']}" placeholder="排序"/><span class="tip">{form_error('displayorder')} 项目登记时镇街显示的顺序,数字越大越前面</span></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><input type="submit" name="submit" class="btn btn-sm btn-primary" value="保存"/></td>
                        </tr>
                        </tbody>
                     </table>
                </form>
                <script>
                    $(function(){
                    {if $feedback == 'success' && $action != 'edit'}
                        if(confirm('{$feedMessage}')){
                            location.href = "{url_path('region','add')}";
                        }else{
                            location.href = "{url_path('region')}";
                        }
                    {/if}
                    
                    {if $action == 'edit' && $feedMessage}
                        $.jBox.alert('{$feedMessage}', '提示');
                    {/if}
                    });
                </script>
            </div>
{include file="common/main_footer.tpl"}