                    <div class="sideitem">
                        <h2>审核信息</h2>
                        <ul>
                            {auth name="taizhang_ch+check"}<li {if $smarty.get.m == 'check'}class="current"{/if}><a href="{url_path($tplDir,'check','id=')}{$info['id']}">自查 (初审错误数：{$info['fault_cnt1']})</a></li>{/auth}
                            {auth name="taizhang_ch+first_sh"}<li {if $smarty.get.m == 'first_sh'}class="current"{/if}><a href="{url_path($tplDir,'first_sh','id=')}{$info['id']}">初审 (复审错误数：{$info['fault_cnt2']})</a></li>{/auth}
                            {auth name="taizhang_ch+second_sh"}<li {if $smarty.get.m == 'second_sh'}class="current"{/if}><a href="{url_path($tplDir,'second_sh','id=')}{$info['id']}">复审 (质检错误数：{$info['fault_cnt3']})</a></li>{/auth}
                            <li><a href="{url_path('printer','check','id=')}{$info['id']}" target="_blank">审核表</a></li>
                        </ul>
                    </div>