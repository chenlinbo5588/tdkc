{include file="common/main_header.tpl"}
            <div class="searchform row-fluid">
                <form action="{url_path('reports_salary','index')}" method="post" name="searchform" target="post_iframe">
                    <input type="hidden" value="reports_salary" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>请选择需要到出的薪资月份</strong><input type="text" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({dateFmt:'yyyy-MM'})"{/literal} value="{$smarty.post.sdate}"/>{form_error('sdate')}</label>
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