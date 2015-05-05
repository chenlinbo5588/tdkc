                {include file="taizhang/flowbar.tpl"}
                <div class="sidelist">
                    {include file="taizhang/side_basic.tpl"}
                    {if $info['id']}
                    {include file="taizhang/side_workflow.tpl"}
                    <div class="sideitem">
                        <h2>宗地表格信息</h2>
                        <ul>
                            <li><a href="/docs/wfydkcdjbg.doc" title="违法用地勘测定界成果报告模板">违法用地勘测定界成果报告模板.doc</a></li>
                            <li><a href="/docs/wffm.doc" title="违法封面模板">违法封面模板.doc</a></li>
                            <li><a href="{url_path('printer','mjb','id=')}{$info['id']}" target="_blank">违法用地土地面积分类表</a></li>
                            <li><a href="javascript:void(0);">宗地面积成果表（请附件形式上传)</a></li>
                        </ul>
                    </div>
                            
                    {auth name="taizhang+fee"}
                    <div class="sideitem">
                        <h2>打印宗地表格信息</h2>
                        <ul>
                            <li><a href="{url_path('printer','mjb','id=')}{$info['id']}&mode=print" target="_blank">打印违法用地土地面积分类表</a></li>
                        </ul>
                    </div>
                    {/auth}        
                    {/if}
                </div>