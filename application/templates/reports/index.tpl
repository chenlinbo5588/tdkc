{include file="common/menu_header.tpl"}
<table width='99%' height="100%" border='0' cellspacing='0' cellpadding='0'>
  <tr>
    <td style='padding-left:3px;padding-top:8px' valign="top">
	{include file="common/user_favor.tpl"}
      <!-- Item 2 Strat -->
      <dl class='bitem'>
        <dt onClick='showHide("items2_1")'><b>测绘项目数据报表</b></dt>
        <dd style='display:block' class='sitem' id='items2_1'>
          <ul class='sitemu'>
            {auth name="reports_fault"}<li><a href="{url_path('reports_fault')}">缺陷统计报表</a></li>{/auth}
            {auth name="reports_monthly"}<li><a href="{url_path('reports_monthly')}">项目统计报表</a></li>{/auth}
          </ul>
        </dd>
      </dl>
      <!-- Item 2 End -->
      
      <!-- Item 3 Strat -->
      <dl class='bitem'>
        <dt onClick='showHide("items2_2")'><b>办公室数据报表</b></dt>
        <dd style='display:block' class='sitem' id='items2_2'>
          <ul class='sitemu'>
            {auth name="reports_device"}<li><a href="{url_path('reports_device')}">仪器清单报表</a></li>{/auth}
            {auth name="reports_employ"}<li><a href="{url_path('reports_employ')}">人事报表</a></li>{/auth}
            {auth name="reports_salary"}<li><a href="{url_path('reports_salary')}">薪资变动报表</a></li>{/auth}
          </ul>
        </dd>
      </dl>
      <!-- Item 3 End -->
      
	  </td>
  </tr>
</table>
{include file="common/menu_footer.tpl"}