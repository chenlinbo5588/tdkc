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
            {auth name="my_event"}<li><a href="{url_path('my_event')}">待办事宜</a></li>{/auth}
            {auth name="pm+receive"}<li><a href="{url_path('pm','receive')}">点对点消息</a></li>{/auth}
            {auth name="my_schedule"}<li><a href="{url_path('my_schedule')}">日程安排</a></li>{/auth}
            {auth name="my_file"}<li><a href="{url_path('my_file')}">我的文件</a></li>{/auth}
            {auth name="share_file"}<li><a href="{url_path('share_file')}">文件共享</a></li>{/auth}
            {auth name="work_log"}<li><a href="{url_path('work_log')}">工作日志</a></li>{/auth}
            {auth name="sendor"}<li><a href="{url_path('sendor')}">发送人设置</a></li>{/auth}
            {auth name="contacts"}<li><a href="{url_path('contacts')}">通讯录</a></li>{/auth}
            {*<li><a href="{url_path('kq')}">考勤统计</a></li>*}
          </ul>
        </dd>
      </dl>
      <!-- Item 2 End -->
	  </td>
  </tr>
</table>
{include file="common/menu_footer.tpl"}