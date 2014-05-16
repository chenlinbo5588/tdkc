{include file="common/menu_header.tpl"}
<table width='99%' height="100%" border='0' cellspacing='0' cellpadding='0'>
  <tr>
    <td style='padding-left:3px;padding-top:8px' valign="top">
	{include file="common/user_favor.tpl"}
      <!-- Item 2 Strat -->
      <dl class='bitem'>
        <dt onClick='showHide("items2_1")'><b>信息中心</b></dt>
        <dd style='display:block' class='sitem' id='items2_1'>
          <ul class='sitemu'>
            {auth name="announce"}<li><a href="{url_path('announce')}">通知公告</a></li>{/auth}
            {auth name="notice"}<li><a href="{url_path('notice')}">滚动公告</a></li>{/auth}
            {auth name="inst"}<li><a href="{url_path('inst')}">制度建设</a></li>{/auth}
            {auth name="culture"}<li><a href="{url_path('culture')}">企业文化</a></li>{/auth}
          </ul>
        </dd>
      </dl>
      <!-- Item 2 End -->
	  </td>
  </tr>
</table>
{include file="common/menu_footer.tpl"}