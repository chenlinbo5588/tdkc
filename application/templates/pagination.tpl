<div class="pagination">
    {if ($page['pager']['pageLastNum'] > 1)}
        {if ($page['pager']['pageNow'] != 1)}
            <a href="javascript:void(0)" onclick="{$page['pager']['callJs']}(1);return false;">第一页</a>
            <a href="javascript:void(0)" onclick="{$page['pager']['callJs']}({$page['pager']['pageNow'] - 1});return false;">上一页</a>
        {else}
            <a href="javascript:void(0)" onclick="{$page['pager']['callJs']}(1);return false;">第一页</a>
        {/if}

        {section name=a loop=($page['pager']['pageAe'] - $page['pager']['pageAb'] + 1)}
            {if ($page['pager']['pageNow'] == ($smarty.section.a.index + $page['pager']['pageAb']))}
                <a class="active" href="javascript:void(0)">{$smarty.section.a.index + $page['pager']['pageAb']}</a>
            {else}
                <a href="javascript:void(0)" onclick="{$page['pager']['callJs']}({{$smarty.section.a.index + $page['pager']['pageAb']}});return false;">{{$smarty.section.a.index + $page['pager']['pageAb']}}</a>
            {/if}
        {/section}

        {if ($page['pager']['pageNow'] != $page['pager']['pageLastNum'])}
            <a href="javascript:void(0)" onclick="{$page['pager']['callJs']}({$page['pager']['pageNow'] + 1});return false;">下一页</a>
            <a href="javascript:void(0)" onclick="{$page['pager']['callJs']}({$page['pager']['pageLastNum']});return false;">最后页</a>
        {else}
            <a href="javascript:void(0)" onclick="{$page['pager']['callJs']}({$page['pager']['pageLastNum']});return false;">最后页</a>
        {/if}
        <strong><label>找到{$page['pager']['pageSum']}个记录</label><input type="text" style="width:40px" name="jumpPage" value="{$page['pager']['pageNow']}" />&nbsp;<input type="button" name="jumpBtn" value="跳转" class="jumpBtn" />&nbsp;<span>第{$page['pager']['pageNow']}页/共{$page['pager']['pageLastNum']}页</span></strong>
    {/if}
</div>