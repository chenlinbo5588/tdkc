            <div class="pd20">
                <form name="addform" action="{url_path('project_gh','log')}" method="post">
                    <input type="hidden" name="id" value="{$info['id']}"/> 
                <table class="maintain">
                    <tbody>
                    <tr>
                        <td><label class="required"><em></em><strong>项目编号</strong></label></td>
                        <td>{$info['project_no']}</td>
                    </tr>
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
                    
                <div>
                    <li>
                    {foreach from=$worklog item=item}
                        <div>
                            <h3>{$item['createtime']|date_format:"Y-m-d"} {$item['creator']}</h3>
                            <p>{$item['content']|escape}</p>
                        </div>
                    {foreachelse}
                        还没有日志
                    {/foreach}
                    </li>
                </div>    
                    
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
                                url: "{url_path('project_gh','log')}",
                                data: $("form[name=addform]").serialize(),
                                dataType:"json",
                                success:ajax_success
                            });
                        });
                    });
                </script>
            </div>