               {include file="taizhang/flowbar.tpl"}
                <div class="sidelist">
                    {include file="taizhang/side_basic.tpl"}
                    {if $info['id']}
                    {include file="taizhang/side_workflow.tpl"}
                    <div class="sideitem">
                        <h2>宗地表格信息</h2>
                        <ul>
                            <li><a href="{url_path('printer','zddj','id=')}{$info['id']}" target="_blank">宗地勘测定界成果报告</a></li>
                            <li><a href="{url_path('printer','mjb','id=')}{$info['id']}" target="_blank">土地面积分类表</a></li>
                            <li><a href="{url_path('printer','fastjzb','id=')}{$info['id']}" target="_blank">宗地界址调查表</a></li>
                            <li><a href="{url_path('printer','bgb','id=')}{$info['id']}" target="_blank">土地勘测定界成果变更情况表</a></li>
                            <li><a href="javascript:void(0);" title="">宗地面积成果表（请附件形式上传)</a></li>
                        </ul>
                    </div>
                    {if $info['nature'] == '临时用地'}
                    <div class="sideitem">
                        <h2>{$info['nature']}表格信息</h2>
                        <ul>
                            <li><a href="/docs/wbfm.doc" title="五本封面" >五本封面模版.doc</a></li>
                        </ul>
                    </div>
                    {/if}
                    {if $info['ptype_name'] == '新征用地' || $info['ptype_name'] == '供地' || $info['nature'] == '新征'}
                    <div class="sideitem">
                        <h2>新征（或供地)表格信息</h2>
                        <ul>
                            <li><a href="/docs/wbkcdjbg.doc" title="五本勘测定界报告" >五本勘测定界报告模版.doc</a></li>
                            <li><a href="/docs/wbfm.doc" title="五本封面" >五本封面模版.doc</a></li>
                            <li><a href="/docs/mjtjbzs.xls" title="面积统计表征收模版" >面积统计表征收模版.xls</a></li>
                            {*<li><a href="{url_path('printer','kcdj','id=')}{$info['id']}" target="_blank">土地勘测定界报告</a></li>*}
                            
                        </ul>
                    </div>
                    {/if}
                    
                    {auth name="taizhang+fee"}
                    <div class="sideitem">
                        <h2>打印宗地表格信息</h2>
                        <ul>
                            <li><a href="{url_path('printer','covertd','id=')}{$info['id']}" target="_blank">打印土地勘测定界成果资料封面</a></li>
                            <li><a href="{url_path('printer','zddj','id=')}{$info['id']}&mode=print" target="_blank">打印宗地勘测定界成果报告</a></li>
                            <li><a href="{url_path('printer','mjb','id=')}{$info['id']}&mode=print" target="_blank">打印土地面积分类表</a></li>
                            <li><a href="{url_path('printer','fastjzb','id=')}{$info['id']}&mode=print" target="_blank">打印宗地界址调查表</a></li>
                        </ul>
                    </div>
                    {/auth}
                    
                    {/if}
                </div>