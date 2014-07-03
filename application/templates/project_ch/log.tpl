            <div class="pd20">
                <form name="addform" action="{url_path('project_ch','log')}" method="post">
                    <input type="hidden" name="id" value="{$info['id']}"/> 
                <table class="maintain">
                    <tbody>
                    <tr>
                        <td><label class="required"><em></em><strong>项目名称</strong></label></td>
                        <td>{$info['name']|escape}</td>
                    </tr>
                    <tr>
                        <td><label class="required"><em></em><strong>日志</strong></label></td>
                        <td>
                            <textarea style="width:400px;height:200px;"  name="logcontent" placeholder="请填写日志"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input type="button" name="submit" class="btn btn-sm btn-primary" value="保存"/>
                        </td>
                    </tr>
                    </tbody>
                </table>
                </form>
                    
                <table class="table">
                    <colgroup>
                        <col width="20%"/>
                        <col width="20%"/>
                        <col width="60%"/>
                    </colgroup>
                    <thead>
                        <tr>
                            <th>时间</th>
                            <th>填写人</th>
                            <th>内容</th>
                        </tr>
                    </thead>
                    <tbody>
                    {foreach from=$worklog item=item}
                        <tr>
                            <td>{$item['createtime']|date_format:"Y-m-d"}</td>
                            <td>{$item['creator']}</td>
                            <td>{$item['content']|escape}</td>
                        </tr>
                    {foreachelse}
                        <tr><td colspan="3">还没有日志</td></tr>
                    {/foreach}
                    </tbody>
                </table>    
                    
                <script>
                    $(function(){
                        $("input[name=submit]").bind("click",function(e){
                            if($.trim($("textarea[name=logcontent]").val()) == ''){
                                $("textarea[name=logcontent]").focus();
                                $.jBox.tip("请输入内容",'提示');
                                return false;
                            }
                            $.ajax({
                                type:"POST",
                                url: "{url_path('project_ch','log')}",
                                data: $("form[name=addform]").serialize() + '&isajax=1',
                                dataType:"json",
                                success:ajax_success
                            });
                        });
                    });
                </script>
            </div>