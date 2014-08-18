                {include file="taizhang/flowbar.tpl"}
                <div class="sidelist">
                    {include file="taizhang/side_basic.tpl"}
                    {if $info['id']}
                    <div class="sideitem">
                        <h2>审核信息</h2>
                        <ul>
                            {auth name="taizhang_wf+check"}<li {if $smarty.get.m == 'check'}class="current"{/if}><a href="{url_path($tplDir,'check','id=')}{$info['id']}">自查</a></li>{/auth}
                            {auth name="taizhang_wf+first_sh"}<li {if $smarty.get.m == 'first_sh'}class="current"{/if}><a href="{url_path($tplDir,'first_sh','id=')}{$info['id']}">初审 {$info['fault_cnt1']}</a></li>{/auth}
                            {auth name="taizhang_wf+second_sh"}<li {if $smarty.get.m == 'second_sh'}class="current"{/if}><a href="{url_path($tplDir,'second_sh','id=')}{$info['id']}">复审 {$info['fault_cnt2']}</a></li>{/auth}
                            <li><a href="{url_path('printer','check','id=')}{$info['id']}" target="_blank">审核表</a></li>
                        </ul>
                    </div>
                    <div class="sideitem">
                        <h2>宗地表格信息</h2>
                        <ul>
                            <li><a href="/docs/{urlencode('违法用地勘测定界成果报告模板.doc')}" title="违法用地勘测定界成果报告模板" >违法用地勘测定界成果报告模板.doc</a></li>
                            <li {if $smarty.get.m == 'mjb'}class="current"{/if}><a href="{url_path('printer','mjb','id=')}{$info['id']}" target="_blank">违法用地土地面积分类表</a></li>
                            <li {if $smarty.get.m == 'mjcgb'}class="current"{/if}><a href="javascript:void(0);">宗地面积成果表（附件形式上传)</a></li>
                        </ul>
                    </div>
                    {/if}
                </div>