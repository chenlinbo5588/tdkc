{include file="common/menu_header.tpl"}
<table width='99%' height="100%" border='0' cellspacing='0' cellpadding='0'>
  <tr>
    <td style='padding-left:3px;padding-top:8px' valign="top">
	{include file="common/user_favor.tpl"}
      <!-- Item 2 Strat -->
      <dl class='bitem'>
        <dt onClick='showHide("items2_1")'><b>办公室</b></dt>
        <dd style='display:block' class='sitem' id='items2_1'>
          <ul class='sitemu'>
            {auth name="employ"}<li><a href="{url_path('employ')}">人事管理</a></li>{/auth}
            {auth name="doc"}<li><a href="{url_path('doc')}">测绘合同</a></li>{/auth}
            {auth name="inout"}<li><a href="{url_path('inout')}">文件管理</a></li>{/auth}
            {*<li><a href="{url_path('kq')}">考勤管理</a></li>*}
            {auth name="salary_type"}<li><a href="{url_path('salary_type')}">薪资结构</a></li>{/auth}
            {auth name="salary"}<li><a href="{url_path('salary')}">工资变动</a></li>{/auth}
            {auth name="device"}<li><a href="{url_path('device')}">仪器设备</a></li>{/auth}
            {auth name="consume_type"}<li><a href="{url_path('consume_type')}">耗材类型</a></li>{/auth}
            {auth name="consume"}<li><a href="{url_path('consume')}">耗材库存</a></li>{/auth}
          </ul>
        </dd>
      </dl>
      <!-- Item 2 End -->
	  </td>
  </tr>
</table>
{include file="common/menu_footer.tpl"}