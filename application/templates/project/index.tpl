{include file="common/menu_header.tpl"}
<table width='99%' height="100%" border='0' cellspacing='0' cellpadding='0'>
  <tr>
    <td style='padding-left:3px;padding-top:8px' valign="top">
	{include file="common/user_favor.tpl"}
      <!-- Item 2 Strat -->
      <dl class='bitem'>
        <dt onClick='showHide("items2_1")'><b>测绘项目</b></dt>
        <dd style='display:block' class='sitem' id='items2_1'>
          <ul class='sitemu'>
            {auth name="project_ch+add"}<li><a href="{url_path('project_ch','add')}">项目登记</a></li>{/auth}
            {auth name="project_ch+send"}<li><a href="{url_path('project_ch','send')}">项目发送</a></li>{/auth}
            {auth name="project_ch+dispatch"}<li><a href="{url_path('project_ch','dispatch')}">项目布置</a></li>{/auth}
            {auth name="project_ch+implement"}<li><a href="{url_path('project_ch','implement')}">项目实施</a></li>{/auth}
            {auth name="project_ch+check"}<li><a href="{url_path('project_ch','check')}">项目自查</a></li>{/auth}
            {auth name="project_ch+first_sh"}<li><a href="{url_path('project_ch','first_sh')}">项目初审</a></li>{/auth}
            {auth name="project_ch+second_sh"}<li><a href="{url_path('project_ch','second_sh')}">项目复审</a></li>{/auth}
            {auth name="project_ch+fee"}<li><a href="{url_path('project_ch','fee')}">项目收费</a></li>{/auth}
            {auth name="project_ch+archive"}<li><a href="{url_path('project_ch','archive')}">项目归档</a></li>{/auth}
            {auth name="project_ch"}<li><a href="{url_path('project_ch')}">项目查询</a></li>{/auth}
          </ul>
        </dd>
      </dl>
      <!-- Item 2 End -->
	  </td>
  </tr>
</table>
{include file="common/menu_footer.tpl"}