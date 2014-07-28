{include file="common/main_header.tpl"}
            <div class="span12">
                <div class="taizhang_entry">
                    <h1>台账登记</h1>
                    <ol>
                        <li><a href="{url_path('taizhang_ch','add')}">土地勘测台账</a></li>
                        <li><a href="{url_path('taizhang_house','add')}">房产项目台帐</a></li>
                        <li><a href="{url_path('taizhang_fg','add')}">放线、竣工台帐</a></li>
                        <li><a href="{url_path('taizhang_wf','add')}">违法用地勘测台帐</a></li>
                        <li><a href="{url_path('taizhang_other','add')}">土方山塘地形评估控制台帐</a></li>
                        <li><a href="{url_path('taizhang_person','add')}">个人建房台帐</a></li>
                    </ol>
                </div>
            </div>
{include file="common/main_footer.tpl"}