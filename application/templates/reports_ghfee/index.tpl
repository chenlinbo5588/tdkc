{include file="common/main_header.tpl"}
            <div class="searchform row-fluid">
                <form action="{url_path('reports_ghfee','index')}" method="post" name="searchform" target="post_iframe">
                    <input type="hidden" value="reports_ghfee" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>登记日期开始</strong><input type="text" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.post.sdate}"/>{form_error('sdate')}</label>
                            <label><strong>登记日期结束</strong><input type="text" name="edate" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.post.edate}"/>{form_error('edate')}</label>
                            {*<label><strong>镇乡名称</strong><input type="text" name="region_name" value="{$smarty.get.region_name}" placeholder="请输入镇乡名称"/></label>*}
                            {*<label><strong>负责人名称</strong><input type="text" name="pm" value="{$smarty.post.pm}" placeholder="请输入项目负责人"/></label>*}
                            
                            <input type="submit" name="submit" class="btn btn-primary" value="导出Excel"/>
                        </li>
                     </ul>
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