{include file="common/main_header.tpl"}
            <div class="row-fluid">
                {if $action == 'edit'}
                <form action="{url_path('work_log','edit')}" method="post" name="infoform">
                    <input type="hidden" name="id" value="{$info['id']}"/>
                {else}
                <form action="{url_path('work_log','add')}" method="post" name="infoform">
                {/if}
                    <table class="maintain">
                        <tbody>
                        <tr>
                            <td><label class="required"><em>*</em><strong>工作标题</strong></td><td><input type="text" style="width:400px" name="title" value="{$info['title']}" placeholder="请输入标题"/></label>{form_error('title')}</td>
                        </tr>
                        <tr>
                            <td><label class="required"><em>*</em><strong>工作内容</strong></td><td><textarea name="content" style="width:400px;height:150px;">{$info['content']}</textarea></label><br/>{form_error('content')}</td>
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
                            location.href = "{url_path('work_log','add')}";
                        }else{
                            location.href = "{url_path('work_log')}";
                        }
                    {/if}
                    
                    {if $action == 'edit' && $feedMessage}
                        alert('{$feedMessage}');
                    {/if}
                    });
                </script>
            </div>
            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}