{include file="common/main_header.tpl"}

        <div class="searchform row-fluid">
                <form action="{url_path('my_schedule')}" method="get" name="searchform">
                    <input type="hidden" value="my_schedule" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>开始日期</strong><input type="text" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.get.sdate}"/></label>
                            <label><strong>结束日期</strong><input type="text" name="edate" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.get.edate}"/></label>
                            <label><strong>标题</strong><input type="text" name="title" value="{$smarty.get.title}"/></label>
                            
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                            
                            {auth name="my_schedule+add"}<a class="addlink" href="{url_path('my_schedule','add')}">添加日程</a>{/auth}
                        </li>
                     </ul>
                </form>
            </div>
            
            <div id="cal">{$calender}</div>

            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}