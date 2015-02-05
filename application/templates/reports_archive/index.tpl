{include file="common/main_header.tpl"}
            <div class="searchform row-fluid">
                <form action="{url_path('reports_archive','index')}" method="post" name="searchform" target="post_iframe">
                    <input type="hidden" value="reports_archive" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    
                    <table class="normal">
                        <tr>
                            <td colspan="2">
                                <label><strong>登记日期开始</strong><input type="text" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({ maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.post.sdate}"/>{form_error('sdate')}</label>
                                <label><strong>登记日期结束</strong><input type="text" name="edate" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({ minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.post.edate}"/>{form_error('edate')}</label>
                                <input type="submit" name="submit" class="btn btn-primary" value="导出Excel"/>
                            </td>
                        </tr>
                        <tr>
                            <td><label><strong>状态</strong></label></td>
                            <td>
                                <label><input type="checkbox" name="status[]" value="新增" />新增</label>
                                <label><input type="checkbox" name="status[]" value="已提交初审" />已提交初审</label>
                                <label><input type="checkbox" name="status[]" value="已通过初审" />已通过初审</label>
                                <label><input type="checkbox" name="status[]" value="已提交复审" />已提交复审</label>
                                <label><input type="checkbox" name="status[]" value="已通过复审" checked/>已通过复审</label>
                            </td>
                        </tr>
                     </table>
                </form>
            </div>
                            
            <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>             
            <div class="span12">
                
             </div>
             <script>
                 $(function(){
                    $("form[name=searchform]").bind("submit",function(e){
                        if($("#sdate").val() == ''){
                            $.jBox.tip("请输入登记日期开始","提示");
                            $("#sdate").focus();
                            return false;
                        }
                        
                        if($("#edate").val() == ''){
                            $.jBox.tip("请输入登记日期结束","提示");
                            $("#edate").focus();
                            return false;
                        }
                    });
                 });
              </script>    
             {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}