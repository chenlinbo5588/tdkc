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
        <td background="/img/frame/wbg.gif" bgcolor="#EEF4EA" class='title'><span><a href="{url_path('pm','receive')}">新消息({$messageCount})</a></span></td>
    </tr>
    </table>
</div>
<div class="fm">
    <table class="table" width="98%" align="center" border="0" >
        <tr>
            <td background="/img/frame/wbg.gif"  bgcolor="#EEF4EA" class='title'><span>公告</span></td>
    </tr>
    {foreach from=$announceList item=item}
        <tr>
            <td><a class="news_item" href="javascript:void(0);" data-href="{url_path('news','andetail','id=')}{$item['id']}">{$item['title']|escape}</a></td>
        </tr>
    {/foreach}
    </table>
</div>
<div class="fm">
    <table class="table" width="98%" align="center" border="0" >
        <tr>
            <td background="/img/frame/wbg.gif"  bgcolor="#EEF4EA" class='title'><span>新闻</span></td>
    </tr>
    {foreach from=$newsList item=item}
        <tr>
            <td><a class="news_item" href="javascript:void(0);" data-href="{url_path('news','detail','id=')}{$item['id']}">{$item['title']|escape}</a></td>
        </tr>
    {/foreach}
    </table>
</div>

<div class="fm">
    <table class="table" width="98%" align="center" border="0" >
        <tr>
            <td background="/img/frame/wbg.gif"  bgcolor="#EEF4EA" class='title'><span>制度建设</span></td>
    </tr>
    {foreach from=$zhiduList item=item}
        <tr>
            <td><a href="{url_path('attachment','download','id=')}{$item['id']}" >{$item['title']|escape}</a></td>
        </tr>
    {/foreach}
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