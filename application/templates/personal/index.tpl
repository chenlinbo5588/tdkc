{include file="common/menu_header.tpl"}
<table width='99%' height="100%" border='0' cellspacing='0' cellpadding='0'>
  <tr>
    <td style='padding-left:3px;padding-top:8px' valign="top">
	{include file="common/user_favor.tpl"}
      <!-- Item 2 Strat -->
      <dl class='bitem'>
        <dt onClick='showHide("items2_1")'><b>个人办公</b></dt>
        <dd style='display:block' class='sitem' id='items2_1'>
          <ul class='sitemu'>
            <li><a href="{url_path('my_event')}">待办事宜</a></li>
            <li><a href="{url_path('pm')}">点对点消息</a></li>
            <li><a href="{url_path('my_schedule')}">日程安排</a></li>
            <li><a href="{url_path('my_file')}">我的文件</a></li>
            <li><a href="{url_path('share_file')}">文件共享</a></li>
            <li><a href="{url_path('work_log')}">工作日志</a></li>
            <li><a href="{url_path('contacts')}">通讯录</a></li>
            <li><a href="{url_path('check_io')}">考勤统计</a></li>
          </ul>
        </dd>
      </dl>
      <!-- Item 2 End -->
	  </td>
  </tr>
</table>
{include file="common/menu_footer.tpl"}