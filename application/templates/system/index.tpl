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
        <dt onClick='showHide("items2_1")'><b>系统管理</b></dt>
        <dd style='display:block' class='sitem' id='items2_1'>
          <ul class='sitemu'>
            <li class="first {if $smarty.get.c == 'user'}active{/if}"><a href="{url_path('user')}">用户管理</a></li>
            <li class="{if $smarty.get.c == 'role'}active{/if}"><a href="{url_path('role')}">角色管理</a></li>
            <li class="{if $smarty.get.c == 'menu'}active{/if}"><a href="{url_path('menu')}">菜单管理</a></li>
            <li class="{if $smarty.get.c == 'dept'}active{/if}"><a href="{url_path('dept')}">组织机构</a></li>
            <li><a href="#">项目类型设置</a></li>
          </ul>
        </dd>
      </dl>
      <!-- Item 2 End -->
	  </td>
  </tr>
</table>
{include file="common/menu_footer.tpl"}