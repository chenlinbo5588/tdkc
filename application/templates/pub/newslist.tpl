{include file="common/main_header.tpl"}

<div class="fm">
    <table class="table" width="98%" align="center" border="0" >
        <colgroup>
            <col width="80%"/>
            <col width="20%"/>
        </colgroup>
        <tbody>
            <tr>
                <td colspan="2" background="/img/frame/wbg.gif"  bgcolor="#EEF4EA" class='title'><span>新闻列表</span><a class="more" href="{url_path('admin','main')}">返回</a></td>
            </tr>
        {foreach from=$data['data'] item=item}
            <tr>
                <td><a class="news_item" href="javascript:void(0);" data-href="{url_path('pub','detail','id=')}{$item['id']}">{$item['title']|escape}</a></td>
                <td>[{$item['createtime']|date_format:"Y-m-d"}]</td>
            </tr>
        {/foreach}
        </tbody>
    </table>
    {include file="pagination.tpl"}
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