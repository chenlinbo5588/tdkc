               {include file="taizhang/flowbar.tpl"}   
                <div class="sidelist">
                    {include file="taizhang/side_basic.tpl"}
                    {if $info['id']}
                    {include file="taizhang/side_workflow.tpl"}
                    {/if}
                </div>