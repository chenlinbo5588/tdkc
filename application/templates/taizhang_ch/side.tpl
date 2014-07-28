               {include file="taizhang/flowbar.tpl"}
                <div class="sidelist">
                    {include file="taizhang/side_basic.tpl"}
                    {if $info['id']}
                    <div class="sideitem">
                        <h2>审核信息</h2>
                        <ul>
                            {auth name="taizhang_ch+check"}<li {if $smarty.get.m == 'check'}class="current"{/if}><a href="{url_path($tplDir,'check','id=')}{$info['id']}">自查</a></li>{/auth}
                            {auth name="taizhang_ch+first_sh"}<li {if $smarty.get.m == 'first_sh'}class="current"{/if}><a href="{url_path($tplDir,'first_sh','id=')}{$info['id']}">初审 {$info['fault_cnt1']}</a></li>{/auth}
                            {auth name="taizhang_ch+second_sh"}<li {if $smarty.get.m == 'second_sh'}class="current"{/if}><a href="{url_path($tplDir,'second_sh','id=')}{$info['id']}">复审 {$info['fault_cnt2']}</a></li>{/auth}
                            <li><a href="{url_path('printer','check','id=')}{$info['id']}" target="_blank">审核表</a></li>
                        </ul>
                    </div>
                    <div class="sideitem">
                        <h2>宗地表格信息</h2>
                        <ul>
                            <li><a href="{url_path('printer','covertd','id=')}{$info['id']}" target="_blank">土地勘测定界成果资料封面</a></li>
                            <li><a href="{url_path('printer','zddj','id=')}{$info['id']}" target="_blank">宗地勘测定界成果报告</a></li>
                            <li><a href="{url_path('printer','mjb','id=')}{$info['id']}" target="_blank">土地面积分类表</a></li>
                            <li><a href="{url_path('printer','fastjzb','id=')}{$info['id']}" target="_blank">宗地界址调查表</a></li>
                            <li><a href="javascript:void(0);" title="">宗地面积成果表（附件形式)</a></li>
                            <li><a href="{url_path('printer','bgb','id=')}{$info['id']}" target="_blank">土地勘测定界成果变更情况表</a></li>
                        </ul>
                    </div>
                    {if $info['ptype_name'] == '新征用地' || $info['ptype_name'] == '供地' || $info['nature'] == '新征'}
                    <div class="sideitem">
                        <h2>新征（或供地)表格信息</h2>
                        <ul>
                            <li><a href="/docs/{urlencode('五本勘测定界报告模版.doc')}" title="五本勘测定界报告" >五本勘测定界报告模版.doc</a></li>
                            <li><a href="/docs/{urlencode('五本封面模版.doc')}" title="五本封面" >五本封面模版.doc</a></li>
                            <li><a href="/docs/{urlencode('面积统计表征收模版.xls')}" title="面积统计表征收模版" >面积统计表征收模版.xls</a></li>
                            {*<li><a href="{url_path('printer','kcdj','id=')}{$info['id']}" target="_blank">土地勘测定界报告</a></li>*}
                            
                        </ul>
                    </div>
                    {/if}
                    {/if}
                </div>