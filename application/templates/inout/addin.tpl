{include file="common/main_header.tpl"}
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('inout','editin')}" method="post" name="infoform">
                    <input type="hidden" name="id" value="{$info['id']}"/>
                {else}
                <form action="{url_path('inout','addin')}" method="post" name="infoform">
                {/if}
                    <table class="maintain">
                        <tbody>
                        <tr>
                            <td><label class="required"><em>*</em><strong>发文单位</strong></label></td><td><input type="text" style="width:400px" name="sendor" value="{$info['sendor']|escape}" placeholder="请输入发文单位名称"/>{form_error('sendor')}</td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>主题</strong></label></td><td><input  type="text" name="title" style="width:400px" value="{$info['title']|escape}" placeholder="请输入主题"/>{form_error('title')}</td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>文件文号</strong></label></td><td><input  type="text" name="file_code" style="width:400px" value="{$info['file_code']|escape}" placeholder="请输入文件文号"/>{form_error('file_code')}</td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>收文时间</strong></label></td><td><input type="text" class="Wdate" readonly onclick="WdatePicker()"  name="receive_time" value="{$info['receive_time']|date_format:"Y-m-d"}" placeholder="收文时间"/>{form_error('receive_time')}</td>
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
                            location.href = "{url_path('inout','addin')}";
                        }else{
                            location.href = "{url_path('inout','receive')}";
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