               {include file="taizhang/flowbar.tpl"}   
                <div class="sidelist">
                    {include file="taizhang/side_basic.tpl"}
                    
                    <div class="sideitem">
                        <h2>审核信息</h2>
                        <ul>
                            {auth name="taizhang_sh+second_sh"}<li {if $smarty.get.m == 'second_sh'}class="current"{/if}><a href="{url_path($tplDir,'second_sh','id=')}{$info['id']}">复审</a></li>{/auth}
                        </ul>
                    </div>
                        
                    {if $info['id'] && $info['status'] != '已删除'}
                    <div class="sideitem">
                        <h2>转换到正式台账</h2>
                        <div class="warning">（转换成功后原散活台账将被删除)</div>
                        <ul>
                            {foreach from=$addEntryList item=item}
                             <li><a href="{$item['url']}&taizhang_id={$info['id']}&source_del=yes">转换到{$item['name']}台账</a></li>
                            {/foreach}
                        </ul>
                    </div>
                    {/if}
                </div>