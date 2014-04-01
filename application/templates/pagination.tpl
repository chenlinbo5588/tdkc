{if ($page['pager']['pageLastNum'] > 1)}
<ul class="pagination pagination-lg">
	{if ($page['pager']['pageNow'] != 1)}
        <li><a href="javascript:void(0)" onclick="{$page['pager']['callJs']}(1);return false;">第一页</a></li>
		<li><a href="javascript:void(0)" onclick="{$page['pager']['callJs']}({$page['pager']['pageNow'] - 1});return false;">上一页</a></li>
	{else}
		<li><a href="javascript:void(0)" onclick="{$page['pager']['callJs']}(1);return false;">第一页</a></li>
	{/if}

	{section name=a loop=($page['pager']['pageAe'] - $page['pager']['pageAb'] + 1)}
		{if ($page['pager']['pageNow'] == ($smarty.section.a.index + $page['pager']['pageAb']))}
			<li class="active"><a href="javascript:void(0)">{$smarty.section.a.index + $page['pager']['pageAb']}</a></li>
		{else}
			<li><a href="javascript:void(0)" onclick="{$page['pager']['callJs']}({{$smarty.section.a.index + $page['pager']['pageAb']}});return false;">{{$smarty.section.a.index + $page['pager']['pageAb']}}</a></li>
		{/if}
	{/section}

	{if ($page['pager']['pageNow'] != $page['pager']['pageLastNum'])}
		<li><a href="javascript:void(0)" onclick="{$page['pager']['callJs']}({$page['pager']['pageNow'] + 1});return false;">下一页</a></li>
        <li><a href="javascript:void(0)" onclick="{$page['pager']['callJs']}({$page['pager']['pageLastNum']});return false;">最后页</a></li>
	{else}
		<li><a href="javascript:void(0)" onclick="{$page['pager']['callJs']}({$page['pager']['pageLastNum']});return false;">最后页</a></li>
	{/if}
</ul>
{/if}


