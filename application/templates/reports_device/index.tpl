{include file="common/main_header.tpl"}
            <div class="searchform row-fluid">
                <form action="{url_path('reports_device','index')}" method="post" name="searchform" target="post_iframe">
                    <input type="hidden" value="reports_device" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>登记日期开始</strong><input type="text" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.post.sdate}"/>{form_error('sdate')}</label>
                            <label><strong>登记日期结束</strong><input type="text" name="edate" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.post.edate}"/>{form_error('edate')}</label>
                            <label><strong>使用者</strong><input type="text" name="user" value="{$smarty.post.user}" placeholder="请输入使用者"/></label>
                            <input type="submit" name="submit" class="btn btn-primary" value="导出Excel"/>
                        </li>
                     </ul>
                </form>
            </div>
                            
            <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>             
            <div class="span12">
                
             </div>
             {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}