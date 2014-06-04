{include file="common/menu_header.tpl"}
<table width='99%' height="100%" border='0' cellspacing='0' cellpadding='0'>
  <tr>
    <td style='padding-left:3px;padding-top:8px' valign="top">
	{include file="common/user_favor.tpl"}
      <!-- Item 2 Strat -->
      <dl class='bitem'>
        <dt onClick='showHide("items2_1")'><b>系统管理</b></dt>
        <dd style='display:block' class='sitem' id='items2_1'>
          <ul class='sitemu'>
            {auth name="user"}<li><a href="{url_path('user')}">用户管理</a></li>{/auth}
            {auth name="role"}<li><a href="{url_path('role')}">角色管理</a></li>{/auth}
            {auth name="menu"}<li><a href="{url_path('menu')}">菜单管理</a></li>{/auth}
            {auth name="dept"}<li><a href="{url_path('dept')}">组织机构</a></li>{/auth}
            {auth name="project_type"}<li><a href="{url_path('project_type')}">测绘项目类型设置</a></li>{/auth}
            {auth name="project_gh_type"}<li><a href="{url_path('project_gh_type')}">规划项目类型设置</a></li>{/auth}
            {auth name="region"}<li><a href="{url_path('region')}">镇街设置</a></li>{/auth}
          </ul>
        </dd>
      </dl>
      <!-- Item 2 End -->
	  </td>
  </tr>
</table>
{include file="common/menu_footer.tpl"}