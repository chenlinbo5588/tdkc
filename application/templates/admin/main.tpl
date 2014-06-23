{include file="common/main_header.tpl"}
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><div style='float:left'> <img height="14" src="/img/frame/book1.gif" width="20" />&nbsp;欢迎使用{$TITLE}。 </div>
      <div style='float:right;padding-right:8px;'>
        <!--  //保留接口  -->
      </div></td>
  </tr>
  <tr>
    <td height="1" background="/img/frame/sp_bg.gif" style='padding:0px'></td>
  </tr>
</table>
      
<div class="fm">
    <table class="table" width="98%" align="center" border="0" cellpadding="3" cellspacing="1" bgcolor="#CBD8AC" style="margin-bottom:8px;margin-top:8px;">
        <tr>
            <td background="/img/frame/wbg.gif" bgcolor="#EEF4EA" class='title'><a href="{url_path('pm','receive')}" title="点击查看新消息">消息({$messageCount})</a> &nbsp; <a href="{url_path('my_event')}" title="点击查看待办事宜">待办事宜({$eventCount})</a></td>
        </tr>
    </table>
</div>
        
<div class="fm">
    <h2>最近项目列表</h2>
    <table class="table" style="width:auto" align="center" border="0" >
        <thead>
            <tr>
                <th>登记日期</th>
                <th>联系人</th>
                <th>联系人号码</th>
                <th>接洽人</th>
                <th>项目名称</th>
                <th>负责人</th>
                <th>当前处理人</th>
                <th>当前状态</th>
                <th>要求完成时间</th>
                <th>备注</th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$userProjectList item=item}
            <tr>
                <td>{$item['createtime']|date_format:"Y-m-d"}</td>
                <td>{$item['contacter']}</td>
                <td>{$item['contacter_mobile']}</td>
                <td>{$item['manager']}</td>
                <td><a href="{url_path('project_ch','task','id=')}{$item['id']}">{$item['name']|escape}</a></td>
                <td>{$item['pm']}</td>
                <td>{$item['sendor']}</td>
                <td>{$item['status']}</td>
                <td>{if $item['start_date']}{$item['start_date']|date_format:"Y-m-d"}{/if}</td>
                <td>{$item['descripton']|escape}</td>
            </tr>
            {/foreach}
            {foreach from=$userProjectList2 item=item}
            <tr>
                <td>{$item['createtime']|date_format:"Y-m-d"}</td>
                <td>{$item['contacter']}</td>
                <td>{$item['contacter_mobile']}</td>
                <td>{$item['manager']}</td>
                <td><a href="{url_path('project_gh','task','id=')}{$item['id']}">{$item['name']|escape}</a></td>
                <td>{$item['pm']}</td>
                <td>{$item['sendor']}</td>
                <td>{$item['status']}</td>
                <td>{if $item['start_date']}{$item['start_date']|date_format:"Y-m-d"}{/if}</td>
                <td>{$item['descripton']|escape}</td>
            </tr>
            {/foreach}
            
        </tbody>
    </table>
    
</div>
<div class="fm">
    <table class="table" width="98%" align="center" border="0" >
        <colgroup>
            <col width="80%"/>
            <col width="20%"/>
        </colgroup>
        <tbody>
            <tr>
                <td colspan="2" background="/img/frame/wbg.gif"  bgcolor="#EEF4EA" class='title'><span>公告</span><a class="more" href="{url_path('pub','anlist')}">更多&gt;&gt;</a></td>
            </tr>
        {foreach from=$announceList item=item}
            <tr>
                <td><a class="news_item" href="javascript:void(0);" data-href="{url_path('pub','andetail','id=')}{$item['id']}">{$item['title']|escape}</a></td>
                <td>[{$item['createtime']|date_format:"Y-m-d"}]</td>
            </tr>
        {/foreach}
        </tbody>
    </table>
</div>
<div class="fm">
    <table class="table" width="98%" align="center" border="0" >
        <colgroup>
            <col width="80%"/>
            <col width="20%"/>
        </colgroup>
        <tbody>
            <tr>
                <td colspan="2" background="/img/frame/wbg.gif"  bgcolor="#EEF4EA" class='title'><span>新闻</span><a class="more" href="{url_path('pub','newslist')}">更多&gt;&gt;</a></td>
            </tr>
        {foreach from=$newsList item=item}
            <tr>
                <td><a class="news_item" href="javascript:void(0);" data-href="{url_path('pub','detail','id=')}{$item['id']}">{$item['title']|escape}</a></td>
                <td>[{$item['createtime']|date_format:"Y-m-d"}]</td>
            </tr>
        {/foreach}
        </tbody>
    </table>
</div>

<div class="fm">
    <table class="table" width="98%" align="center" border="0" >
        <colgroup>
            <col width="80%"/>
            <col width="20%"/>
        </colgroup>
        <tbody>
            <tr>
                <td colspan="2" background="/img/frame/wbg.gif"  bgcolor="#EEF4EA" class='title'><span>制度建设</span><a class="more" href="{url_path('pub','instlist')}">更多&gt;&gt;</a></td>
            </tr>
        {foreach from=$zhiduList item=item}
            <tr>
                <td><a href="{url_path('attachment','download','id=')}{$item['id']}" >{$item['title']|escape}</a></td>
                <td>[{$item['createtime']|date_format:"Y-m-d"}]</td>
            </tr>
        {/foreach}
        </tbody>
    </table>
</div>
<script>
    $(function(){
        $(".news_item").bind("click",function(e){
            var that = $(e.target);
            $.jBox("get:" + that.attr("data-href"),{ title:"详情",width:700,height:600 });
        });
    });
</script>    
{include file="common/main_footer.tpl"}