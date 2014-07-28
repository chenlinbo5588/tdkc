                    <div class="sideitem">
                        <ul>
                            <li><a href="{url_path('taizhang','index')}">&lt;&lt;返回列表页</a></li>
                        </ul>
                    </div>
                    <div class="sideitem">
                        <h2>基本信息</h2>
                        <ul>
                            {if $smarty.get.m == 'add'}
                                <li class="current"><a href="{url_path($tplDir,'add')}">基本资料</a></li>
                            {elseif $smarty.get.m == 'edit'}
                                <li class="current"><a href="{url_path($tplDir,'edit','id=')}{$info['id']}">基本资料</a></li>
                            {else}
                                <li><a href="{url_path($tplDir,'edit','id=')}{$info['id']}">基本资料</a></li>
                            {/if}
                        </ul>
                    </div>