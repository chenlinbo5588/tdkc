{include file="common/menu_header.tpl"}
<body target="main">
<table width='99%' height="100%" border='0' cellspacing='0' cellpadding='0'>
  <tr>
    <td style='padding-left:3px;padding-top:8px' valign="top">
	{include file="common/user_favor.tpl"}
      
      {*
      <!-- Item 2 Strat -->
      <dl class='bitem'>
        <dt onClick='showHide("items2_1")'><b>系统帮助</b></dt>
        <dd style='display:block' class='sitem' id='items2_1'>
          <ul class='sitemu'>
            <li><a href="javascript:void(0);" target='main'>如何添加新闻</a></li>
          </ul>
        </dd>
      </dl>
      <!-- Item 2 End -->
      *}
      {auth name="system"}
      <dl class='bitem'>
        <dt onClick='showHide("system")'><b>系统管理</b></dt>
        <dd style='display:none' class='sitem' id='system'>
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
      {/auth}
      
      
      {auth name="project"}
      <dl class='bitem'>
        <dt onClick='showHide("project_ch")'><b>测绘项目</b></dt>
        <dd style='display:block' class='sitem' id='project_ch'>
          <ul class='sitemu'>
            {auth name="project_ch"}<li><a href="{url_path('project_ch')}">测绘项目管理</a></li>{/auth}
            {auth name="taizhang"}
                <li><a href="{url_path('taizhang','index','pm=')}{urlencode($userProfile['name'])}">我的台账</a></li>
                <li><a href="{url_path('taizhang')}">台账查询</a></li>
            {/auth}
            {auth name="taizhang+recyclebin"}<li><a href="{url_path('taizhang','recyclebin')}">台账回收站</a></li>{/auth}
            {*
            {auth name="taizhang_ch"}<li><a href="{url_path('taizhang_ch')}">土地勘测登记台账</a></li>{/auth}
            {auth name="taizhang_house"}<li><a href="{url_path('taizhang_house')}">房产项目登记台帐</a></li>{/auth}
            {auth name="taizhang_fg"}<li><a href="{url_path('taizhang_fg')}">放线、竣工登记台帐</a></li>{/auth}
            {auth name="taizhang_wf"}<li><a href="{url_path('taizhang_wf')}">违法用地登记台帐</a></li>{/auth}
            {auth name="taizhang_other"}<li><a href="{url_path('taizhang_other')}">土方山塘地形评估控制登记台帐</a></li>{/auth}
            {auth name="taizhang_person"}<li><a href="{url_path('taizhang_person')}">个人建房登记台帐</a></li>{/auth}
            {auth name="project_ch+send"}<li><a href="{url_path('project_ch','send')}">项目发送</a></li>{/auth}
            {auth name="project_ch+dispatch"}<li><a href="{url_path('project_ch','dispatch')}">项目布置</a></li>{/auth}
            {auth name="project_ch+implement"}<li><a href="{url_path('project_ch','implement')}">项目实施</a></li>{/auth}
            {auth name="project_ch+check"}<li><a href="{url_path('project_ch','check')}">项目自查</a></li>{/auth}
            {auth name="project_ch+first_sh"}<li><a href="{url_path('project_ch','first_sh')}">项目初审</a></li>{/auth}
            {auth name="project_ch+second_sh"}<li><a href="{url_path('project_ch','second_sh')}">项目复审</a></li>{/auth}
            {auth name="project_ch+fee"}<li><a href="{url_path('project_ch','fee')}">项目收费</a></li>{/auth}
            {auth name="project_ch+archive"}<li><a href="{url_path('project_ch','archive')}">项目归档</a></li>{/auth}
            *}
            {auth name="taizhang+statistics"}<li><a href="{url_path('taizhang','statistics')}">台账统计</a></li>{/auth}
          </ul>
        </dd>
      </dl>
      {/auth}
      
      {auth name="project+guihua"}
      <dl class='bitem'>
        <dt onClick='showHide("project_gh")'><b>规划项目</b></dt>
        <dd style='display:block' class='sitem' id='project_gh'>
          <ul class='sitemu'>
            {auth name="project_gh+add"}<li><a href="{url_path('project_gh','add')}">项目登记</a></li>{/auth}
            {*
            {auth name="project_gh+send"}<li><a href="{url_path('project_gh','send')}">项目发送</a></li>{/auth}
            {auth name="project_gh+dispatch"}<li><a href="{url_path('project_gh','dispatch')}">项目布置</a></li>{/auth}
            {auth name="project_gh+implement"}<li><a href="{url_path('project_gh','implement')}">项目实施</a></li>{/auth}
            {auth name="project_gh+check"}<li><a href="{url_path('project_gh','check')}">项目自查</a></li>{/auth}
            {auth name="project_gh+first_sh"}<li><a href="{url_path('project_gh','first_sh')}">项目初审</a></li>{/auth}
            {auth name="project_gh+second_sh"}<li><a href="{url_path('project_gh','second_sh')}">项目复审</a></li>{/auth}
            {auth name="project_gh+fee"}<li><a href="{url_path('project_gh','fee')}">项目收费</a></li>{/auth}
            {auth name="project_gh+archive"}<li><a href="{url_path('project_gh','archive')}">项目归档</a></li>{/auth}
            *}
            {auth name="project_gh"}<li><a href="{url_path('project_gh')}">项目查询</a></li>{/auth}
            {auth name="project_gh+statistics"}<li><a href="{url_path('project_gh','statistics')}">项目统计</a></li>{/auth}
          </ul>
        </dd>
      </dl>
      {/auth}
      
      {auth name="office"}
      <dl class='bitem'>
        <dt onClick='showHide("office")'><b>办公室</b></dt>
        <dd style='display:block' class='sitem' id='office'>
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
      {/auth}
      
      {auth name="info"}
      <dl class='bitem'>
        <dt onClick='showHide("info")'><b>信息中心</b></dt>
        <dd style='display:none' class='sitem' id='info'>
          <ul class='sitemu'>
            {auth name="announce"}<li><a href="{url_path('announce')}">通知公告</a></li>{/auth}
            {auth name="notice"}<li><a href="{url_path('notice')}">滚动公告</a></li>{/auth}
            {auth name="inst"}<li><a href="{url_path('inst')}">制度建设</a></li>{/auth}
            {auth name="culture"}<li><a href="{url_path('culture')}">企业文化</a></li>{/auth}
          </ul>
        </dd>
      </dl>
      {/auth}
      
      {auth name="reports"}
      <dl class='bitem'>
        <dt onClick='showHide("reports")'><b>数据报表</b></dt>
        <dd style='display:none' class='sitem' id='reports'>
          <ul class='sitemu'>
            {auth name="reports_taizhang"}<li><a href="{url_path('reports_taizhang')}">台账明细报表</a></li>{/auth}
            {auth name="reports_fault"}<li><a href="{url_path('reports_fault')}">缺陷统计报表</a></li>{/auth}
            {auth name="reports_monthly"}<li><a href="{url_path('reports_monthly')}">项目台账统计报表</a></li>{/auth}
            {auth name="reports_work"}<li><a href="{url_path('reports_work')}">工作量统计报表</a></li>{/auth}
            {auth name="reports_device"}<li><a href="{url_path('reports_device')}">仪器清单报表</a></li>{/auth}
            {auth name="reports_employ"}<li><a href="{url_path('reports_employ')}">人事报表</a></li>{/auth}
            {auth name="reports_salary"}<li><a href="{url_path('reports_salary')}">薪资变动报表</a></li>{/auth}
            {auth name="reports_ghfee"}<li><a href="{url_path('reports_ghfee')}">规划项目费用报表</a></li>{/auth}
            {auth name="reports_house"}<li><a href="{url_path('reports_house')}">房产台账统计报表</a></li>{/auth}
            {auth name="reports_reg"}<li><a href="{url_path('reports_reg')}">台账备案报表</a></li>{/auth}
            {auth name="reports_reg"}<li><a href="{url_path('reports_chanzhi')}">产值统计报表</a></li>{/auth}
          </ul>
        </dd>
      </dl>
      {/auth}
      
      
      {auth name="personal"}
      <dl class='bitem'>
        <dt onClick='showHide("personal")'><b>个人办公</b></dt>
        <dd style='display:none' class='sitem' id="personal">
          <ul class='sitemu'>
            {auth name="my_event"}<li><a href="{url_path('my_event')}">待办事宜</a></li>{/auth}
            {auth name="pm+receive"}<li><a href="{url_path('pm','receive')}">点对点消息</a></li>{/auth}
            {auth name="my_schedule"}<li><a href="{url_path('my_schedule')}">日程安排</a></li>{/auth}
            {auth name="my_file"}<li><a href="{url_path('my_file')}">我的文件</a></li>{/auth}
            {auth name="share_file"}<li><a href="{url_path('share_file')}">文件共享</a></li>{/auth}
            {auth name="work_log"}<li><a href="{url_path('work_log')}">工作日志</a></li>{/auth}
            {auth name="sendor"}<li><a href="{url_path('sendor')}">发送人设置</a></li>{/auth}
            {auth name="contacts"}<li><a href="{url_path('contacts')}">外部通讯录</a></li>{/auth}
            {auth name="our_contacts"}<li><a href="{url_path('our_contacts')}">内部通讯录</a></li>{/auth}
            {*<li><a href="{url_path('kq')}">考勤统计</a></li>*}
          </ul>
        </dd>
      </dl>
      {/auth}
	  </td>
  </tr>
</table>
{include file="common/menu_footer.tpl"}