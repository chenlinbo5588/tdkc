{include file="common/menu_header.tpl"}
<table width='99%' height="100%" border='0' cellspacing='0' cellpadding='0'>
  <tr>
    <td style='padding-left:3px;padding-top:8px' valign="top">
	<!-- Item 1 Strat -->
      <dl class='bitem'>
        <dt onClick='showHide("items1_1")'><b>常用操作</b></dt>
        <dd style='display:block' class='sitem' id='items1_1'>
          <ul class='sitemu'>
            <li><a href='archives.html' target='main'>常用操作1</a> </li>
          </ul>
        </dd>
      </dl>
      <!-- Item 1 End -->
      <!-- Item 2 Strat -->
      <dl class='bitem'>
        <dt onClick='showHide("items2_1")'><b>个人办公</b></dt>
        <dd style='display:block' class='sitem' id='items2_1'>
          <ul class='sitemu'>
            <li class="first {if $smarty.get.c == 'my_event'}active{/if}"><a href="{url_path('my_event')}">待办事宜</a></li>
            <li class="{if $smarty.get.c == 'msg'}active{/if}"><a href="{url_path('msg')}">点对点消息</a></li>
            <li class="{if $smarty.get.c == 'my_schedule'}active{/if}"><a href="{url_path('my_schedule')}">日程安排</a></li>
            <li class="{if $smarty.get.c == 'my_file'}active{/if}"><a href="{url_path('my_file')}">我的文件</a></li>
            <li class="{if $smarty.get.c == 'my_helper'}active{/if}"><a href="{url_path('my_helper')}">个人助理</a></li>
            <li class="{if $smarty.get.c == 'contacts'}active{/if}"><a href="{url_path('contacts')}">通讯录</a></li>
          </ul>
        </dd>
      </dl>
      <!-- Item 2 End -->
	  </td>
  </tr>
</table>
{include file="common/menu_footer.tpl"}