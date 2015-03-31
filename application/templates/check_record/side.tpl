                <div class="sidelist">
                    {include file="./side_basic.tpl"}
                    {if $info['id']}
                    <div class="sideitem">
                        <h2>表格信息</h2>
                        <ul>
                            <li><a href="{url_path('printer','check_record_cover','id=')}{$info['id']}&mode=print" target="_blank">测绘外业检查记录封面</a></li>
                            <li><a href="{url_path('printer','check_record','id=')}{$info['id']}&mode=print" target="_blank">打印检查记录表</a></li>
                            <li><a href="/docs/外业检查说明.doc">下载外业检查说明.doc</a></li>
                            <li><a href="/docs/测绘外业检查记录封面.doc">测绘外业检查记录封面.doc</a></li>
                        </ul>
                    </div>
                    {/if}
                </div>