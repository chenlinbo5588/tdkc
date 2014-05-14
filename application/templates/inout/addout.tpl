{include file="common/main_header.tpl"}

          {include file="common/ke.tpl"}
          
          
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('inout','editout')}" method="post" name="infoform">
                    <input type="hidden" name="id" value="{$info['id']}"/>
                {else}
                <form action="{url_path('inout','addout')}" method="post" name="infoform">
                {/if}
                    <table class="maintain">
                        <tbody>
                            <tr>
                                <td><label class="required"><em>*</em><strong>主题</strong></label></td><td><input  type="text" name="title" style="width:400px" value="{$info['title']|escape}" placeholder="请输入主题"/>{form_error('title')}</td>
                            </tr>
                            <tr>
                                <td><label class="required"><em>*</em><strong>文件文号</strong></label></td><td><input  type="text" name="file_code" style="width:400px" value="{$info['file_code']|escape}" placeholder="请输入文件文号"/>{form_error('file_code')}</td>
                            </tr>
                            <tr>
                                <td><label class="required"><em>*</em><strong>发文时间</strong></label></td><td><input type="text" class="Wdate" readonly onclick="WdatePicker()"  name="send_time" value="{$info['send_time']|date_format:"Y-m-d"}" placeholder="发文时间"/>{form_error('receive_time')}</td>
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
                            location.href = "{url_path('inout','addout')}";
                        }else{
                            location.href = "{url_path('inout','send')}";
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