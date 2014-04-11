{include file="common/main_header.tpl"}

        <div class="searchform row-fluid">
                <form action="{url_path('user')}" method="get" name="userform">
                    <input type="hidden" value="my_event" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>开始日期</strong><input type="text" name="sdate" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.get.sdate}"/></label>
                            <label><strong>结束日期</strong><input type="text" name="edate" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.get.edate}"/></label>
                            <label><strong>待办类型</strong>
                                <select name="status">
                                   <option value="">全部</option>
                                   <option value="未处理">未处理</option>
                                   <option value="已处理">已处理</option>
                                </select>
                            </label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                        </li>
                     </ul>
                </form>
            </div>
            
            {$calender}

            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}