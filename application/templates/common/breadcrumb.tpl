           <div class="breadcrumb">
               {foreach name=breadcrumb from=$breadcrumb item=item}
                   {if $item['pid'] != 0}
                   <a href="/index.php?{$item['url']}">{$item['name']}</a>&nbsp;
                   {else}
                   <a href="/index.php?{$item['url']}" target="menu">{$item['name']}</a>&nbsp;
                   {/if}
                   {if !$smarty.foreach.breadcrumb.last }&gt;{/if}
               {/foreach}
                {*
                <a href="{$_SERVER['HTTP_REFERER']}">返回</a>
                <a href="javascript:location.reload();">刷新</a>
                *}
			</div>