{include file="common/main_header.tpl"}
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('my_schedule','edit')}" method="post" name="infoform">
                    <input type="hidden" name="id" value="{$info['id']}"/>
                {else}
                <form action="{url_path('my_schedule','add')}" method="post" name="infoform">
                {/if}
                    <table class="maintain">
                        <tbody>
                        <tr><td></td><td>{form_error('id')}</td></tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>开始日期</strong></label></td><td><input type="text" style="width:200px" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$info['sdate']}" placeholder="日程开始日期"/>{form_error('sdate')}</td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>结束日期</strong></label></td><td><input type="text" style="width:200px" name="edate"  id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}',maxDate:'2050-10-01'})"{/literal}  value="{$info['edate']}" placeholder="日程结束日期"/>{form_error('edate')}</td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>日程标题</strong></label></td><td><input type="text" style="width:200px" name="title" value="{$info['title']}" placeholder="请输入日程标题"/>{form_error('title')}</td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>日程内容</strong></label></td><td><textarea name="content" style="width:500px;height:250px;">{$info['content']}</textarea><br/>{form_error('content')}</td>
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
                            location.href = "{url_path('my_schedule','add')}";
                        }else{
                            location.href = "{url_path('my_schedule')}";
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