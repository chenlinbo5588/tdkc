{include file="common/main_header.tpl"}
        {include file="project_ch/mod_list.tpl"}
        {*{include file="common/ke.tpl"}*}
        <style type="text/css">
            .breadcrumb { margin: 20px 0 10px 0;}
        </style>    
        <div id="flowbar">
            <span>测绘项目</span>
            {foreach from=$statusHtml item=item}
              {$item}  
            {/foreach}
        </div>
        <div class="project_detail">
            <ul id="project_nav">
                <li class="first"><a href="#anchor_base">基本信息</a></li>
                <li><a href="#anchor_work">作业信息</a></li>
                <li><a href="#anchor_check">审核信息</a></li>
                {*<li><a href="#anchor_doc">成果信息</a></li>
                <li><a href="#anchor_fee">收费信息</a></li>*}
                <li><a href="#anchor_log">项目日志</a></li>
            </ul>
            <form name="saveForm" action="{url_path('project_ch','task')}" method="post">
                <input type="hidden" name="event_id" value="{$info['event_id']}"/>
                <input type="hidden" name="id" value="{$info['id']}"/>
                <a name="anchor_base" id="anchor_base"></a>
                <table class="maintain border1">
                    <caption>基本信息</caption>
                    <colgroup>
                        <col width="100"/>
                        <col width="800"/>
                    </colgroup>
                    <tbody>
                    <tr>
                        <td>流水号</td>
                        <td>{$info['id']}</td>
                    </tr>
                    <tr>
                        <td>录入类型</td>
                        <td>{if $info['input_type'] == 0}正常登记{elseif $info['input_type'] == 1}意向登记{/if}</td>
                    </tr>
                    <tr>
                        <td>登记年月</td>
                        <td>{$info['year']}年{$info['month']}月份</td>
                    </tr>
                    <tr>
                        <td>区域</td>
                        <td>{$info['region_name']}</td>
                    </tr>
                    <tr>
                        <td>登记类型</td>
                        <td>{$info['type_name']}-{$info['cate_name']}-{$info['type']}</td>
                    </tr>
                    <tr>
                        <td>性质</td>
                        <td>{$info['nature']}</td>
                    </tr>
                    <tr>
                        <td>登记名称</td>
                        <td>{$info['name']|escape}</td>
                    </tr>
                    <tr>
                        <td>地址</td>
                        <td>{$info['address']|escape}</td>
                    </tr>
                    <tr>
                        <td>村名</td>
                        <td>{$info['village']|escape}</td>
                    </tr>
                    <tr>
                        <td>目项来源</td>
                        <td>{$info['source']|escape}</td>
                    </tr>
                    <tr>
                        <td>联系单位名称</td>
                        <td>{$info['union_name']|escape}</td>
                   </tr>
                   <tr>
                        <td>联系人信息</td>
                        <td><p>姓名:{$info['contacter']|escape}</p><p>联系号码:{$info['contacter_mobile']}</p><p>固定电话:{$info['contacter_tel']}</p></td>
                    </tr>
                    <tr>
                        <td>接洽人信息</td>
                        <td><p>姓名:{$info['manager']|escape}</p><p>联系号码:{$info['manager_mobile']}</p><p>固定电话:{$info['manager_tel']}</p></td>
                    </tr>
                    <tr>
                        <td>备注</td>
                        <td>{$info['descripton']}</td>
                    </tr>
                    <tr>
                        <td>优先级</td>
                        <td>{$info['displayorder']}</td>
                    </tr>
                    <tr>
                        <td>登记信息</td>
                        <td>登记人姓名:{$info['creator']} 登记时间：{$info['createtime']|date_format:"Y-m-d H:i:s"}</td>
                    </tr>
                 </tbody>
                </table>
               <a name="anchor_work" id="anchor_work"></a>
               <table  class="maintain border1">
                  <caption>作业信息</caption>
                  <colgroup>
                       <col width="100"/>
                       <col width="800"/>
                   </colgroup>
                  <tbody>
                    <tr>
                        <td>合计扣分</td>
                        <td>{$info['faultScore']}</td>
                    </tr>
                    <tr>
                        <td>测绘项目负责人</td>
                        <td>{$info['pm']}</td>
                    </tr>
                    <tr class="workflow">
                        <td><label class="required"><em></em><strong>当前状态</strong></label></td>
                        <td><b class="hightlight success">{$info['status']}{$info['sub_status']}</b></td>
                    </tr>
                    <tr class="workflow">
                        <td><label class="required"><em></em><strong>当前处理人</strong></label></td>
                        <td><b class="hightlight success">{$info['sendor']}</b></td>
                    </tr>
                    
                    <tr class="tuihui" {if $smarty.post.workflow != '退回'}style="display: none;"{/if}>
                        <td>退回原因</td>
                        <td>
                            <textarea name="reason" style="width: 500px; height: 100px;">{$reasonTxt|escape}</textarea>
                            <div>{form_error('reason')}</div>
                        </td>
                    </tr>
                    <tr>
                        <td>初审缺陷历史</td>
                        <td>
                            <div class="notice">
                                {*
                                {if $userFaultList0}
                                <a class="link_btn" href="{url_path('printer','fault','id=')}{$info['id']}" target="_blank">打印缺陷表</a>
                                {/if}
                                *}
                                <table>
                                    <colgroup>
                                        <col width="50%"/>
                                        <col width="10%"/>
                                        <col width="30%"/>
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>缺陷项</th>
                                            <th>扣分</th>
                                            <th>备注</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    {foreach from=$userFaultList0 item=item}
                                        <tr>
                                            <td>{$item['fault_code']}{$item['fault_name']}</td>
                                            <td>{$item['score']}</td>
                                            <td>{$item['remark']|escape}</td>
                                        </tr>
                                    {foreachelse}
                                        <tr>
                                            <td colspan="3">暂无缺陷</td>
                                        </tr>
                                    {/foreach}
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>复审缺陷历史</td>
                        <td>
                            <div class="notice">
                                <table>
                                    <colgroup>
                                        <col width="50%"/>
                                        <col width="10%"/>
                                        <col width="30%"/>
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>缺陷项</th>
                                            <th>扣分</th>
                                            <th>备注</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    {foreach from=$userFaultList1 item=item}
                                        <tr>
                                            <td>{$item['fault_code']}{$item['fault_name']}</td>
                                            <td>{$item['score']}</td>
                                            <td>{$item['remark']|escape}</td>
                                        </tr>
                                    {foreachelse}
                                        <tr>
                                            <td colspan="3">暂无缺陷</td>
                                        </tr>
                                    {/foreach}
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    {if $info['sendor_id'] == $userProfile['id'] && ($info['status'] == '已提交初审' || $info['status'] == '已提交复审')}
                    <tr class="fault" {if $smarty.post.workflow != '退回'}style="display: none;"{/if}>
                        <td>缺陷扣分</td>
                        <td>
                            <div>{form_error('fault[]')}</div>
                            <div class="fault_wrapper">
                                <a href="javascript:void(0);" class="toggle" data-toggle='{ "toggleText": ["-收起","+展开"],"target":"#faultList" }' >-收起</a>
                                <div id="faultList">
                                    <table>
                                        <colgroup>
                                            <col width="50%"/>
                                            <col width="10%"/>
                                            <col width="30%"/>
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th>缺陷项</th>
                                                <th>扣分</th>
                                                <th>备注</th>
                                            </tr>
                                        </thead>
                                    </table>
                                    <table class="fault_list">
                                            <caption>{$item['title']}</caption>
                                            <colgroup>
                                                <col width="50%"/>
                                                <col width="10%"/>
                                                <col width="30%"/>
                                            </colgroup>
                                            <tbody>
                                        {foreach from=$sysFaultList item=item}
                                            {foreach name="fautlItem" from=$item['list'] item=list}
                                                <tr>
                                                {if trim($list['name']) != ''}
                                                <td><div><label><input type="checkbox" name="fault[]" value="{$list['code']}"/>{$list['code']}  {$list['name']}</label></div></td>
                                                <td>{$list['score']}</td>
                                                <td><input type="text" name="{$list['code']}_remark" style="width:280px;" value="" placeholder="请填写详情"/></td>
                                                {/if}
                                                </tr>
                                            {/foreach}
                                        {/foreach}  
                                        </tbody>
                                   </table>
                                </div>
                            </div>
                        </td>
                    </tr>
                    {/if}
                    {if $info['status'] == '已发送'}
                    <tr id="timeReq">
                        <td>时间要求</td>
                        <td>
                            {if $info['sendor_id'] == $userProfile['id']}
                            <label>开始日期<input type="text" name="start_date" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{if $info['start_date']}{$info['start_date']|date_format:"Y-m-d"}{/if}"/>{form_error('start_date')}</label>
                            <label>结束日期<input type="text" name="end_date" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{if $info['end_date']}{$info['end_date']|date_format:"Y-m-d"}{/if}"/>{form_error('end_date')}</label>
                            {else}
                                {if $info['start_date']}<label>开始日期 {$info['start_date']|date_format:"Y-m-d"}</label>{/if}
                                {if $info['end_date']}<label>结束日期 {$info['end_date']|date_format:"Y-m-d"}</label>{/if}
                            {/if}
                        </td>
                    </tr>
                    <tr>
                        <td>布置备注</td>
                        <td>
                            {if $info['sendor_id'] == $userProfile['id']}
                            <textarea name="bz_remark" rows="8" cols="50">{$info['bz_remark']|escape}</textarea>
                            <div>{form_error('bz_remark')}</div>
                            {else}
                                {$info['bz_remark']|escape}
                            {/if}
                        </td>
                    </tr>
                    {else}
                     <tr>
                         <td>时间要求</td>
                         <td>
                            {if $info['start_date']}<label>开始日期{$info['start_date']|date_format:"Y-m-d"}</label>{/if}
                            {if $info['end_date']}<label>结束日期{$info['end_date']|date_format:"Y-m-d"}</label>{/if}
                         </td>
                     </tr>
                     <tr>
                        <td>布置时间</td>
                        <td>
                           {if $info['arrange_date']}{$info['arrange_date']|date_format:"Y-m-d H:i:s"}{/if}
                        </td>
                    </tr>
                     <tr>
                        <td>布置备注</td>
                        <td>{$info['bz_remark']|escape}</td>
                    </tr>
                    {/if}
                    
                    {if $info['status'] == '已布置'}
                    <tr id="timeReq">
                        <td>时间安排</td>
                        <td>
                            {if $info['sendor_id'] == $userProfile['id']}
                            <label>外业完成日期<input type="text" name="wy_enddate" id="sdate" class="Wdate" readonly onclick="WdatePicker({ minDate: '{$info["start_date"]|date_format:"Y-m-d"}' , maxDate:'{$info["end_date"]|date_format:"Y-m-d"}' })" value="{if $info['wy_enddate']}{$info['wy_enddate']|date_format:"Y-m-d"}{/if}"/>{form_error('wy_enddate')}</label>
                            <label>内业完成日期<input type="text" name="ny_enddate" id="edate" class="Wdate" readonly onclick="WdatePicker({ minDate: '{$info["start_date"]|date_format:"Y-m-d"}' , maxDate:'{$info["end_date"]|date_format:"Y-m-d"}' })" value="{if $info['ny_enddate']}{$info['ny_enddate']|date_format:"Y-m-d"}{/if}"/>{form_error('ny_enddate')}</label>
                            {else}
                                {if $info['wy_enddate']}<label>外业完成日期 {$info['wy_enddate']|date_format:"Y-m-d"}</label>{/if}
                                {if $info['ny_enddate']}<label>内业完成日期 {$info['ny_enddate']|date_format:"Y-m-d"}</label>{/if}
                            {/if}
                        </td>
                    </tr>
                    <tr>
                        <td>实施备注</td>
                        <td>
                            {if $info['sendor_id'] == $userProfile['id']}
                            <textarea name="ss_remark" style="width: 500px; height: 150px;">{$info['ss_remark']|escape}</textarea>
                            <div>{form_error('ss_remark')}</div>
                            {else}
                                {$info['ss_remark']|escape}
                            {/if}
                        </td>
                    </tr>
                    {else}
                    <tr>
                        <td>时间安排</td>
                        <td>
                            {if $info['wy_enddate']}<label>外业完成日期 {$info['wy_enddate']|date_format:"Y-m-d"}</label>{/if}
                            {if $info['ny_enddate']}<label>内业完成日期 {$info['ny_enddate']|date_format:"Y-m-d"}</label>{/if}
                        </td>
                    </tr>
                    <tr>
                        <td>实施时间</td>
                        <td>{if $info['real_startdate']}{$info['real_startdate']|date_format:"Y-m-d H:i:s"}{/if}</td>
                    </tr>
                    <tr>
                        <td>实施备注</td>
                        <td>{$info['ss_remark']|escape}</td>
                    </tr>
                    <tr>
                        <td>作业完成时间</td>
                        <td>{if $info['real_enddate']}{$info['real_enddate']|date_format:"Y-m-d H:i:s"}{/if}</td>
                    </tr>
                    {/if}
                    
                    {if in_array($info['status'],array('已实施', '已完成'))}
                    {include file="common/upload.tpl"}
                    <script>
                        $(function(){
                            $(".Uploader").each(function(index){
                                var handler = {
                                    success:function(file,serverData){
                                        try {
                                            var progress = new FileProgress(file, this.customSettings.progressTarget);
                                            progress.setComplete();
                                            progress.setStatus("Complete.");
                                            progress.toggleCancel(false);

                                            if(typeof(this.customSettings.callback) != "undefined"){
                                                this.customSettings.callback(file,serverData);
                                            }
                                            var response = $.parseJSON(serverData);

                                            var html = '';
                                            if(response.error){
                                                html += '<li style="color:red;">';
                                            }else{
                                                html += '<li style="color:blue;">';
                                            }
                                            html += '<div class="fname"><a title="点击下载" href="{url_path('attachment','download')}' + '&id=' + response.id + '">' + file.name  + '</a></div><div class="fsize">&nbsp;</div><a class="df" href="javascript:void(0);">删除</a>';
                                            html += '<input type="hidden" name="file_id[]" value="' + response.id + '"/>';
                                            html += '</li>';
                                            $("#filelist").append(html);

                                        } catch (ex) {
                                            this.debug(ex);
                                        }
                                    }
                                };

                                createSwfUpload(index + 1,$(this).attr("data-url"),{},$(this).attr("data-allowsize"),$(this).attr("data-allowfile"),handler);
                            });
                        });
                    </script>
                    {/if}
                    <tr>
                        <td>图件文档</td>
                        <td>
                            {if $info['sendor_id'] == $userProfile['id'] && in_array($info['status'],array('已实施', '已完成'))}
                            <div>
                                <span class="uploader"></span>
                                <a class="upload-button" href="javascript:void(0);"><span id="UploaderPlaceholder_1"></span></a>
                                <span class="Uploader" data-url="{url_path('attachment','upload')}&uid={$userProfile['id']}"  data-allowsize="30Mb" data-allowfile="*.*" ></span>
                                <strong>请上传完成时必要的图件文档,单文件最大<span class="notice">30M</span></strong>
                            </div>
                            <div class="field-box">
                                <div id="UploaderProgress_1"></div>
                                <div id="UploaderFeedBack_1"></div>
                            </div>
                            {/if}
                            <div>{form_error('file_id[]')}</div>
                            <ul id="filelist" class="tj_list">
                                {foreach from=$files item=item}
                                    <li style="color:blue;"><div class="fname"><a title="点击下载" href="{url_path('attachment','download','id=')}{$item['id']}">{$item['file_name']}</a></div><div class="fsize">{byte_format($item['file_size'])}</div><input type="hidden" name="file_id[]" value="{$item['id']}"/><a class="df" href="javascript:void(0);">删除</a></li>
                                {/foreach}
                            </ul>
                        </td>
                    </tr>
                    
                    
                    {if $info['type'] == $smarty.const.CH_RCZD}
                    {include file="project_ch/doc_list.tpl"}
                    <tr>
                        <td>界址信息</td>
                        <td>
                            <div>{form_error('jz_list')}</div>
                            <div>
                                {if $info['status'] == '已实施'}
                                <div class="notice">可以通过两种方式录入界址信息,方式1:直接模拟界址表表格填写，方式2:录入界址记录后在打印</div>
                                <a class="link_btn" href="{url_path('printer','fastjzb','id=')}{$info['id']}" target="_blank">方式1:填写界址表(推荐)</a>   
                                <div style="margin-top:10px;">
                                    <a class="link_btn" href="javascript:void(0);" id="addJz">方式2:添加界址</a>&nbsp;
                                    <label>请输入原流水号(不区分大小写)<input type="text" name="source_id" value="" placeholder="请输入原流水号"/></label>
                                    <input type="button" name="readJzFrom" id="readJzFrom" value="从已有界址读入"/>
                                    <input type="button" name="saveJz" id="saveJz" value="保存界址表"/>
                                    <a href="javascript:void(0);" class="toggle" data-toggle='{ "toggleText": ["-收起","+展开"],"target":"#jz_list" }' >-收起</a>
                                </div>
                                {/if}
                            </div>
                            <div id="jz_list" style="margin:10px 0;">
                                <input type="hidden" name="jz_cnt" value="{count($jzList)}"/>
                                <table id="jzTable">
                                    <caption>界址列表</caption>
                                    <colgroup>
                                        <col width="10%"/>
                                        <col width="10%"/>
                                        <col width="35%"/>
                                        <col width="35%"/>
                                        <col width="10%"/>
                                    </colgroup>
                                    <thead>
                                        <th>四址</th>
                                        <th>界址线</th>
                                        <th>界址线位置</th>
                                        <th>邻居名称</th>
                                        <th></th>
                                    </thead>
                                    <tbody>
                                    {if $info['status'] == '已实施' && $info['sendor_id'] == $userProfile['id']}
                                        {foreach name=jzList from=$jzList item=item}
                                        <tr>
                                            <td>
                                                <select name="direction[]">
                                                    <option value="1" {if $item['direction'] == 1}selected{/if}>西</option>
                                                    <option value="2" {if $item['direction'] == 2}selected{/if}>北</option>
                                                    <option value="3" {if $item['direction'] == 3}selected{/if}>东</option>
                                                    <option value="4" {if $item['direction'] == 4}selected{/if}>南</option>
                                                </select>
                                            </td>
                                            <td>
                                                <span class="point_start">{$smarty.foreach.jzList.index + 1}</span> - <span class="point_end">{if $smarty.foreach.jzList.last}1{else}{$smarty.foreach.jzList.index + 1}{/if}</span>
                                            </td>
                                            <td>
                                                <input name="jz_name[]" type="text" style="width:100%" value="{$item['name']|escape}" placeholder="请输入界址线位置"/>
                                            </td>
                                            <td>
                                                <input name="neighbor[]" type="text" style="width:100%" value="{$item['neighbor']|escape}" placeholder="请输入邻居名称"/>
                                            </td>
                                            <td>
                                                <a href="javascript:void(0);" class="insertJz after">后插界址点</a>&nbsp;
                                                <a href="javascript:void(0);" class="insertJz before">前插界址点</a>&nbsp;
                                                <a href="javascript:void(0);" class="deleteJz">删除</a>
                                            </td>
                                        </tr>
                                        {/foreach}
                                    {else}
                                        {foreach name=jzList from=$jzList item=item}
                                        <tr>
                                            <td>
                                                {if $item['direction'] == 1}西
                                                {elseif $item['direction'] == 2}北
                                                {elseif $item['direction'] == 3}东
                                                {elseif $item['direction'] == 4}南
                                                {/if}
                                            </td>
                                            <td>
                                                <span class="point_start">{$smarty.foreach.jzList.index + 1}</span> - <span class="point_end">{if $smarty.foreach.jzList.last}1{else}{$smarty.foreach.jzList.index + 2}{/if}</span>
                                            </td>
                                            <td>{$item['name']|escape}</td>
                                            <td>{$item['neighbor']|escape}</td>
                                            <td></td>
                                        </tr>
                                        {/foreach}
                                    {/if}
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                     <tr>
                        <td>土地面积分类表</td>
                        <td>
                            <div id="mjb">
                                {if $info['status'] == '已实施'}
                                    <a class="link_btn" href="{url_path('printer','mjb','id=')}{$info['id']}" target="_blank">填写面积分类表</a>
                                {/if}
                            </div>
                        </td>
                     </tr>
                     <tr>
                    <td>变更情况表</td>
                        <td>
                            <div>
                                {if $info['status'] == '已实施'}
                                    <a class="link_btn" href="{url_path('printer','bgb','id=')}{$info['id']}" target="_blank">填写土地勘测定界成果变更情况表</a>
                                {/if}
                            </div>
                        </td>
                    </tr>
                     {/if}
                    </tbody>
                </table>
               <a name="anchor_check" id="anchor_check"></a>
               <table  class="maintain border1">
                   <caption>审核信息</caption>
                   <colgroup>
                        <col width="100"/>
                        <col width="800"/>
                    </colgroup>
                    <tbody>
                        <tr>
                            <td>自查主要意见</td>
                            <td>
                                {if $info['status'] == '已完成' && $info['sendor_id'] == $userProfile['id']}
                                <textarea style="width: 500px; height: 100px;" name="zc_yj">{if $info['zc_yj']}{$info['zc_yj']|escape}{else}外业数据正确。{/if}</textarea>
                                <div>{form_error('zc_yj')}</div>
                                {else}
                                    {$info['zc_yj']|escape}
                                {/if}
                            </td>
                        </tr>
                        <tr>
                            <td>自查修改和处理意见、说明</td>
                            <td>
                                {if $info['status'] == '已完成' && $info['sendor_id'] == $userProfile['id']}
                                <textarea style="width: 500px; height: 100px;" name="zc_remark">{$info['zc_remark']|escape}</textarea>
                                <div>{form_error('zc_remark')}</div>
                                {else}
                                    {$info['zc_remark']|escape}
                                {/if}
                            </td>
                        </tr>
                        <tr>
                            <td>自查人</td>
                            <td>{$info['zc_name']}</td>
                        </tr>
                        <tr>
                            <td>自查时间</td>
                            <td>{if $info['zc_time']}{$info['zc_time']|date_format:"Y-m-d H:i:s"}{/if}</td>
                        </tr>
                        <tr>
                            <td>初审意见</td>
                            <td>
                                {if $info['status'] == '已提交初审' && $info['sendor_id'] == $userProfile['id']}
                                <textarea style="width: 500px; height: 100px;" name="cs_yj">{if $info['cs_yj']}{$info['cs_yj']|escape}{else}按规范要求测量，报告符合要求。{/if}</textarea>
                                <div>{form_error('cs_yj')}</div>
                                {else}
                                {$info['cs_yj']|escape} 
                                {/if}
                            </td>
                        </tr>
                        <tr>
                            <td>初审修改和处理意见、说明</td>
                            <td>
                                {if $info['status'] == '已提交初审' && $info['sendor_id'] == $userProfile['id']}
                                <textarea style="width: 500px; height: 100px;" name="cs_remark">{$info['cs_remark']|escape}</textarea>
                                <div>{form_error('cs_remark')}</div>
                                {else}
                                    {$info['cs_remark']|escape} 
                                {/if}
                            </td>
                        </tr>
                        <tr>
                            <td>初审人</td>
                            <td>{$info['cs_name']}</td>
                        </tr>
                        <tr>
                            <td>初审时间</td>
                            <td>{if $info['cs_time']}{$info['cs_time']|date_format:"Y-m-d H:i:s"}{/if}</td>
                        </tr>
                        <tr>
                            <td>复审意见</td>
                            <td>
                                {if $info['status'] == '已提交复审' && $info['sendor_id'] == $userProfile['id']}
                                <textarea style="width: 500px; height: 100px;" name="fs_yj">{if $info['fs_yj']}{$info['fs_yj']|escape}{else}经查资料齐全，合格。{/if}</textarea>
                                <div>{form_error('fs_yj')}</div>
                                {else}
                                    {$info['fs_yj']|escape} 
                                {/if}
                            </td>
                        </tr>
                        <tr>
                            <td>复审修改和处理意见、说明</td>
                            <td>
                                {if $info['status'] == '已提交复审' && $info['sendor_id'] == $userProfile['id']}
                                <textarea style="width: 500px; height: 100px;" name="fs_remark">{$info['fs_remark']|escape}</textarea>
                                <div>{form_error('fs_remark')}</div>
                                {else}
                                    {$info['fs_remark']|escape} 
                                {/if}
                            </td>
                        </tr>
                        <tr>
                            <td>复审人</td>
                            <td>{$info['fs_name']}</td>
                        </tr>
                        <tr>
                            <td>复审时间</td>
                            <td>{if $info['fs_time']}{$info['fs_time']|date_format:"Y-m-d H:i:s"}{/if}</td>
                        </tr>
                    </tbody>
                </table>
                {*
                <a name="anchor_doc" id="anchor_doc"></a>
                <table class="maintain border1">
                   <caption>成果信息</caption>
                   <colgroup>
                       <col width="100"/>
                       <col width="800"/>
                   </colgroup>
                   <tbody>
                    <tr>
                        <td>项目成果名称</td>
                        {if $info['status'] == '已通过复审'}
                        <td><input type="text" name="title" value="{$info['title']}" placeholder="请填写项目成果名称" style="width:300px;"/>{form_error('title')}</td>
                        {else}
                        <td>{$info['title']}</td>
                        {/if}
                    </tr>
                    <tr>
                        <td>项目面积</td>
                        {if $info['status'] == '已通过复审'}
                        <td><input type="text" name="area" value="{if $info['area']}{$info['area']}{/if}" placeholder="请填写项目面积" style="width:150px;"/>M<sup>2</sup>{form_error('area')}</td>
                        {else}
                        <td>{if $info['area']}{$info['area']}{/if}</td>
                        {/if}
                    </tr>
                    {if $info['cate_name'] == $smarty.const.CH_JGCL}
                    <tr>
                        <td>建筑幢数</td>
                        {if $info['status'] == '已通过复审'}
                        <td><input type="text" name="building_cnt" value="{if $info['building_cnt']}{$info['building_cnt']}{else}1{/if}" placeholder="请填写建筑幢数" style="width:150px;"/>幢{form_error('building_cnt')}</td>
                        {else}
                        <td>{if $info['building_cnt']}{$info['building_cnt']}{/if}</td>
                        {/if}
                    </tr>
                    {/if}
                    <tr>
                        <td>是否归档</td>
                        <td>
                            {if $info['has_archiver'] == 1}是{else}否{/if}
                        </td>
                    </tr>
                    </tbody>
                </table>
                <a name="anchor_fee" id="anchor_fee"></a>   
                <table class="maintain border1">
                    <caption>收费信息</caption>
                    <colgroup>
                       <col width="100"/>
                       <col width="800"/>
                   </colgroup>
                    <tbody>
                        <tr>
                            <td>成果资料领取</td>
                            <td>
                                {if $info['status'] == '项目已提交' && $info['sendor_id'] == $userProfile['id']}
                                <label><input type="radio" name="get_doc" value="1" {if $info['get_doc'] == 1}checked{/if}>已领取</label>
                                <label><input type="radio" name="get_doc" value="0" {if $info['get_doc'] == 0}checked{/if}>未领取</label>
                                {form_error('get_doc')}
                                {else}
                                    {if $info['get_doc'] == 1}已{else}未{/if}领取
                                {/if}
                            </td>
                        </tr>
                        <tr>
                            <td>领取时间</td>
                            <td>{if $info['get_doctime']}{$info['get_doctime']|date_format:"Y-m-d"}{/if}</td>
                        </tr>
                        <tr>
                            <td>应收金额</td>
                            <td>
                                {if $info['status'] == '项目已提交' && $info['sendor_id'] == $userProfile['id']}
                                <input type="text" name="ys_amount" value="{$info['ys_amount']}"/>{form_error('ys_amount')}
                                {else}
                                    {$info['ys_amount']}
                                {/if}
                            </td>
                        </tr>
                        <tr>
                            <td>实收金额</td>
                            <td>
                                {if $info['status'] == '项目已提交' && $info['sendor_id'] == $userProfile['id']}
                                <input type="text" name="ss_amount" value="{$info['ss_amount']}"/>{form_error('ss_amount')}
                                {else}
                                    {$info['ss_amount']}
                                {/if}
                            </td>
                        </tr>
                        <tr>
                            <td>欠费情况</td>
                            <td>
                                {if $info['status'] == '项目已提交' && $info['sendor_id'] == $userProfile['id']}
                                <label><input type="radio" name="is_owed" value="0" {if $info['is_owed'] == 0}checked{/if}/>不欠费</label>
                                <label><input type="radio" name="is_owed" value="1" {if $info['is_owed'] == 1}checked{/if}/>欠费</label>
                                {form_error('is_owed')}
                                {else}
                                    {if $info['is_owed'] == 0}不{/if}欠费
                                {/if}
                            </td>
                        </tr>
                        <tr>
                            <td>收费情况</td>
                            <td>
                                {if $info['status'] == '项目已提交' && $info['sendor_id'] == $userProfile['id']}
                                <label><input type="radio" name="fee_type" value="1" {if $info['fee_type'] == 1}checked{/if}/>挂账</label>
                                <label><input type="radio" name="fee_type" value="2" {if $info['fee_type'] == 2}checked{/if}/>票开款收</label>
                                <label><input type="radio" name="fee_type" value="3" {if $info['fee_type'] == 3}checked{/if}/>票开款未收</label>
                                <label><input type="radio" name="fee_type" value="4" {if $info['fee_type'] == 4}checked{/if}/>票未开款收</label>
                                <div>{form_error('fee_type')}</div>
                                {else}
                                    {if $info['fee_type'] == 1}挂账
                                    {elseif $info['fee_type'] == 2}票开款收
                                    {elseif $info['fee_type'] == 3}票开款未收
                                    {elseif $info['fee_type'] == 4}票未开款收
                                    {/if}
                                {/if}
                            </td>
                        </tr>
                        <tr>
                            <td>收费时间</td>
                            <td>{if $info['collect_date']}{$info['collect_date']|date_format:"Y-m-d"}{/if}</td>
                        </tr>
                    </tbody>
                </table>
                *}
                <a name="anchor_log" id="anchor_log"></a>
                {include file="project_ch/log_list.tpl"}
                <div style="margin-bottom: 50px;">&nbsp;</div>
                <div class="fixbottom">
                    {if $info['sendor_id'] == $userProfile['id'] && in_array($info['status'],array('新增', '已发送',  '已完成', '已通过初审'))}
                    <div class="userlist_wrap">
                        {if $userSendorList}
                        <div class="userlist clearfix">
                            {foreach  from=$userSendorList item=item}
                            <label class="item{if $smarty.post.sendor == $item['sendor_id']} selected{/if}"><input type="radio" name="sendor" value="{$item['sendor_id']}" {if $smarty.post.sendor == $item['sendor_id']}checked{/if} >{$item['sendor']}</label>
                            {/foreach}
                        </div>
                        {/if}
                        <div>没有找到你要发送的人？，请点击<a class="notice" href="{url_path('sendor','add')}">这里</a>进行添加</a></div>
                        <div>{form_error('sendor')}</div>
                    </div>
                    {/if}
                    <span id="loading" style="display: none;"><img src="/img/loading.gif"/></span>
                    <input type="hidden" name="workflow" value=""/>
                {if $info['sendor_id'] == $userProfile['id'] && $info['status'] != '已归档'}
                    {if $info['status'] == '新增'}
                        <input type="submit" name="submit" class="btn btn-orange" value="发送"/>
                    {elseif $info['status'] == '已发送'}
                        <input type="submit" name="submit" class="btn btn-orange" value="布置"/>
                    {elseif $info['status'] == '已布置'}
                        <input type="submit" name="submit" class="btn btn-orange" value="实施"/>
                    {elseif $info['status'] == '已实施'}
                        <input type="submit" name="submit" class="btn btn-orange" value="完成"/>
                    {elseif $info['status'] == '已完成'}
                        <input type="submit" name="submit" class="btn btn-orange" value="提交初审"/>
                    {elseif $info['status'] == '已提交初审'}
                        <input type="submit" name="submit" class="btn btn-orange" value="通过初审"/>
                    {elseif $info['status'] == '已通过初审'}
                        <input type="submit" name="submit" class="btn btn-orange" value="提交复审"/>
                    {elseif $info['status'] == '已提交复审'}
                        <input type="submit" name="submit" class="btn btn-orange" value="通过复审"/>
                    {elseif $info['status'] == '已通过复审'}
                        {*<input type="submit" name="submit" class="btn btn-orange" value="项目提交"/>*}
                    {elseif $info['status'] == '项目已提交'}
                        {*<input type="submit" name="submit" class="btn btn-orange" value="收费"/>*}
                    {elseif $info['status'] == '已收费'}
                        {*<input type="submit" name="submit" class="btn btn-orange" value="归档"/>*}
                    {/if}
                    {if !in_array($info['status'],array('新增','项目已提交','已收费','已归档'))}
                        <input type="submit" name="submit" class="btn btn-sm btn-gray" value="退回"/>
                    {/if}
                {/if}
                {if $gobackUrl }<input type="hidden" name="gobackUrl" value="{$gobackUrl}"/><a class="goback" href="{$gobackUrl}">返回</a>{/if}
                </div>
             </form>
                {if $info['type'] == $smarty.const.CH_RCZD}
                <script type="x-my-template" id="jzRowTemplate">
                    <tr>
                        <td>
                            <select name="direction[]">
                                <option value="1">西</option>
                                <option value="2">北</option>
                                <option value="3">东</option>
                                <option value="4">南</option>
                            </select>
                        </td>
                        <td>
                            <span class="point_start"></span> - <span class="point_end"></span>
                        </td>
                        <td>
                            <input name="jz_name[]" type="text" style="width:100%" value="" placeholder="请输入界址线位置"/>
                        </td>
                        <td>
                            <input name="neighbor[]" type="text" style="width:100%" value="" placeholder="请输入邻居名称"/>
                        </td>
                        <td>
                            <a href="javascript:void(0);" class="insertJz after">后插界址点</a>&nbsp;
                            <a href="javascript:void(0);" class="insertJz before">前插界址点</a>&nbsp;
                            <a href="javascript:void(0);" class="deleteJz">删除</a>
                        </td>
                    </tr>
                </script>
                <script type="x-my-template" id="mjRowTemplate">
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>
                            <a href="javascript:void(0);" class="deleteMj">删除</a>
                        </td>
                    </tr>
                </script>
                <script>
                    $(function(){
                    
                        $("#saveJz").bind("click",function(e){
                            var that = $(e.target);
                            var cansubmit = true;
                            
                            if($("#jzTable tbody tr").size() == 0){
                                cansubmit = false;
                                $.jBox.alert("请录入界址信息",'提示');
                            }
                            
                            if(cansubmit){
                                $("#jzTable tbody tr").each(function(idx){
                                    var tr = $(this);
                                    if($("input[name='jz_name[]']",tr).val() == ''){
                                        $("input[name='jz_name[]']",tr).focus();
                                        $.jBox.alert("请录入界址线位置",'提示');
                                        cansubmit = false;
                                        return false;
                                    }else if($("input[name='neighbor[]']",tr).val() == ''){
                                        $("input[name='neighbor[]']",tr).focus();
                                        $.jBox.alert("请录入邻居名称",'提示');
                                        cansubmit = false;
                                        return false;
                                    }
                                });
                            }
                            
                            if(cansubmit){
                                that.prop("disabled",true);
                                $.ajax({
                                    url:"{url_path('project_ch','savejzb')}",
                                    type:"POST",
                                    data: $("form[name=saveForm]").serialize() + '&isajax=1',
                                    dataType:"json",
                                    success:function(resp){
                                        that.prop("disabled",false);
                                        alert(resp.body.text);
                                    },
                                    complete:function(){
                                        that.prop("disabled",false);
                                    },
                                    error:function(){
                                        that.prop("disabled",false);
                                    }
                                });
                            }
                        });
                    
                        $("#addJz").bind("click",function(e){
                            var rowcnt = $("#jzTable").find("tbody tr").size();
                            var row = $($("#jzRowTemplate").html());

                            row.find(".point_start").html(rowcnt + 1);
                            row.find(".point_end").html(1);

                            var trlast = $("#jzTable tbody tr:last");
                            trlast.find(".point_end").html(rowcnt + 1);
                            
                            //找到最后已条记录的方向
                            if(trlast){
                                var dir = trlast.find("select[name='direction[]']").val();
                                row.find("select[name='direction[]'] option:eq(" + (parseInt(dir) - 1) + ")").prop("selected", "selected");
                            }
                            
                            $("#jzTable").append(row);
                        });

                        function refreshNum(){
                            var rowcnt = $("#jzTable").find("tbody tr").size();

                            for(i = 0;i < rowcnt; i++){
                                $("#jzTable tbody tr:eq(" + i + ") .point_start").html(i + 1);

                                //$("#jzTable tbody tr:eq(" + i + ") select");
                                if((i + 1) != rowcnt){
                                    $("#jzTable tbody tr:eq(" + i +") .point_end").html(i + 2);
                                }else{
                                    $("#jzTable tbody tr:eq(" + i +") .point_end").html(1);
                                }
                            }
                        }

                        $("#jzTable").delegate(".deleteJz",'click',function(e){
                            $(this).closest("tr").remove();
                            refreshNum();
                        });

                        $("#jzTable").delegate(".insertJz",'click',function(e){
                            var currentTr = $(this).closest('tr'),
                                rowcnt = 0,
                                idx = currentTr.index(),
                                i = 0,
                                row = $($("#jzRowTemplate").html()),
                                isAfter = true;

                            if($(this).hasClass("before")){
                                i = idx;
                                isAfter = false;
                            }else{
                                i = idx + 1;
                            }

                            if(isAfter){
                                row.insertAfter(currentTr);
                            }else{
                                row.insertBefore(currentTr);
                            }
                            
                            if(currentTr){
                                var dir = currentTr.find("select[name='direction[]']").val();
                                row.find("select[name='direction[]'] option:eq(" + (parseInt(dir) - 1) + ")").prop("selected", "selected");
                            }
                            
                            refreshNum();
                        });
                        
                        $("#readJzFrom").bind("click",function(e){
                            var that = $(e.target);
                            var input = $("input[name=source_id]");
                            if(input.val() == ''){
                                alert("请输入合法的流水号");
                                return ;
                            }
                            
                            that.prop("disabled",true);
                            
                            $.ajax({
                                type:'GET',
                                url: "{url_path('search','getJzListByProjectNO')}",
                                dataType:"json",
                                data : {
                                    id: input.val()
                                },
                                success:function(resp){
                                    that.prop("disabled",false);
                                    if(resp.length){
                                        for(var i = 0; i < resp.length; i++){
                                            var row = $($("#jzRowTemplate").html());
                                            row.find("select[name='direction[]'] option:eq(" + (resp[i].direction - 1) + ")").prop("selected", "selected");
                                            row.find("input[name='jz_name[]']").val(resp[i].name);
                                            row.find("input[name='neighbor[]']").val(resp[i].neighbor);
                                            
                                            $("#jzTable").append(row);
                                        }
                                        refreshNum();
                                    }
                                },
                                complete:function(){
                                    that.prop("disabled",false);
                                },
                                error:function(){
                                    that.prop("disabled",false);
                                }
                            });
                        });
                    });
                </script>
                {/if}
                <script>
                    $(function(){
                        {if $message}
                            $.jBox.alert('{$message}');
                        {/if}
                            {*
                        $("a.docs").bind("click",function(e){
                            $.jBox("get:" + $(e.target).attr("data-href"),{ title:$(e.target).attr("data-title"),width:1000,height:600});
                        });
                            *}
                        $("#filelist").delegate("a.df","click",function(e){
                            if(confirm("确定要删除吗")){
                                $(this).closest("li").remove();
                            }
                        });
                        
                        $("input[name=submit]").bind('click',function(e){
                            var that = $(e.target);
                            var op = that.val();
                            var cansubmit = true;
                            $("input[name=workflow]").val(op);
                            if(op == '退回'){
                                $("#timeReq").hide();
                                $(".tuihui").show();
                                {if ($info['status'] == '已提交初审' || $info['status'] == '已提交复审') }
                                $(".fault").show();
                                if(cansubmit && $("input[name='fault[]']:checked").length == 0){
                                    $.jBox.alert("请至少勾选一个缺陷",'提示');
                                    cansubmit = false;
                                }
                                
                                if(cansubmit){
                                    $("#faultList input[type=checkbox]").each(function(index){
                                        var that = $(this);
                                        if(that.prop("checked") && $.trim(that.closest("tr").find("input[type=text]:eq(0)").val()) == ''){
                                            that.closest("tr").find("input[type=text]:eq(0)").focus();
                                            $.jBox.alert("请填写扣分项目备注",'提示');

                                            cansubmit = false;
                                            return false;
                                        }
                                    });
                                 }
                                
                                {/if}
                        
                                if(cansubmit && $.trim($("textarea[name=reason]").val()).length == 0){
                                    $("textarea[name=reason]").focus();
                                    $.jBox.alert("请填写退回原因",'提示');
                                    cansubmit = false;
                                }
                                
                            }else{
                                $("#timeReq").show();
                                $(".tuihui").hide();
                                {if ($info['status'] == '已提交初审' || $info['status'] == '已提交复审') }
                                $(".fault").hide();
                                {/if}
                            }
                            
                            {if $info['status'] == '已发送'}
                            if(op == '布置'){
                                if(cansubmit && ($("#sdate").val() == '' || $("#edate").val() == '')){
                                    $("#sdate").focus();
                                    $.jBox.alert("请选择时间要求",'提示');
                                    cansubmit = false;
                                }
                                {*
                                if(cansubmit && $("textarea[name=bz_remark]").val().length == 0){
                                    $("textarea[name=bz_remark]").focus();
                                    $.jBox.alert("请输入布置备注",'提示');
                                    cansubmit = false;
                                }*}
                            }
                            {elseif $info['status'] == '已布置' }
                            if(op == '实施'){
                                if(cansubmit && ($("#sdate").val() == '' || $("#edate").val() == '')){
                                    $("#sdate").focus();
                                    $.jBox.alert("请选择时间安排",'提示');
                                    cansubmit = false;
                                }
                                {*
                                if(cansubmit && $("textarea[name=ss_remark]").val().length == 0){
                                    $("textarea[name=ss_remark]").focus();
                                    $.jBox.alert("请输入实施备注",'提示');
                                    cansubmit = false;
                                }*}
                            }
                            {elseif $info['status'] == '已实施' }
                            if(op == '完成'){
                                if(cansubmit && $("input[name='file_id[]']").length == 0){
                                    $.jBox.alert("请上传图件文档",'提示');
                                    cansubmit = false;
                                }
                                
                                {if $info['type'] == $smarty.const.CH_RCZD}
                                {* 界址可选
                                if(cansubmit && $("input[name='jz_name[]']").length < 3 ){
                                    $.jBox.alert("请录入界址信息,至少三址",'提示');
                                    cansubmit = false;
                                }
                                *}
                                if(cansubmit){
                                    $("#jzTable tbody tr").each(function(idx){
                                        var tr = $(this);
                                        if($("input[name='jz_name[]']",tr).val() == ''){
                                            $("input[name='jz_name[]']",tr).focus();
                                            $.jBox.alert("请录入界址线位置",'提示');
                                            cansubmit = false;
                                            return false;
                                        }else if($("input[name='neighbor[]']",tr).val() == ''){
                                            $("input[name='neighbor[]']",tr).focus();
                                            $.jBox.alert("请录入邻居名称",'提示');
                                            cansubmit = false;
                                            return false;
                                        }
                                    });
                                }
                                
                                {/if}
                            }
                            {elseif $info['status'] == '已完成' }
                            if(op == '提交初审'){
                               {*
                                if(cansubmit && $("textarea[name=zc_yj]").val().length == 0){
                                    $("textarea[name=zc_yj]").focus();
                                    $.jBox.alert("请输入自查意见",'提示');
                                    cansubmit = false;
                                }
                                
                                if(cansubmit && $("textarea[name=zc_remark]").val().length == 0){
                                    $("textarea[name=zc_remark]").focus();
                                    $.jBox.alert("请输入自查修改和处理意见、说明",'提示');
                                    cansubmit = false;
                                }
                                *}
                            }
                            {elseif $info['status'] == '已提交初审' }
                             if(op == '通过初审'){
                                {*
                                if(cansubmit && $("textarea[name=cs_yj]").val().length == 0){
                                    $("textarea[name=cs_yj]").focus();
                                    $.jBox.alert("请输入初审意见",'提示');
                                    cansubmit = false;
                                }
                                
                                if(cansubmit && $("textarea[name=cs_remark]").val().length == 0){
                                    $("textarea[name=cs_remark]").focus();
                                    $.jBox.alert("请输入初审修改和处理意见、说明",'提示');
                                    cansubmit = false;
                                }
                                *}
                            }
                            {elseif $info['status'] == '已提交复审' }
                             if(op == '通过复审'){
                                {*
                                if(cansubmit && $("textarea[name=fs_yj]").val().length == 0){
                                    $("textarea[name=fs_yj]").focus();
                                    $.jBox.alert("请输入复审意见",'提示');
                                    cansubmit = false;
                                }
                                
                                if(cansubmit && $("textarea[name=fs_remark]").val().length == 0){
                                    $("textarea[name=fs_remark]").focus();
                                    $.jBox.alert("请输入复审修改和处理意见、说明",'提示');
                                    cansubmit = false;
                                }
                                *}
                            }
                            {elseif $info['status'] == '已通过复审' }
                            if(op == '项目提交'){    
                                if(cansubmit && $("input[name=title]").val().length == 0){
                                    $("input[name=title]").focus();
                                    $.jBox.alert("请输入项目成果名称",'提示');
                                    cansubmit = false;
                                }
                                
                                if(cansubmit && !/^[0-9]+(.[0-9]+)?$/.test($("input[name=area]").val())){
                                    $("input[name=area]").focus();
                                    $.jBox.alert("请输入项目面积",'提示');
                                    cansubmit = false;
                                }
                                
                                {if $info['cate_name'] == $smarty.const.CH_JGCL}
                                if(cansubmit && !/^[1-9][0-9]*?$/.test($("input[name=building_cnt]").val())){
                                    $("input[name=building_cnt]").focus();
                                    $.jBox.alert("请输入建筑幢数",'提示');
                                    cansubmit = false;
                                }
                                {/if}
                                
                            }
                            {elseif $info['status'] == '项目已提交' }
                            if(op == '收费'){    
                                if(cansubmit && $("input[name=get_doc]:checked").length == 0){
                                    $.jBox.alert("请勾选成果资料资料情况",'提示');
                                    cansubmit = false;
                                }
                                
                                if(cansubmit && !/^[0-9]+(.[0-9]+)?$/.test($("input[name=ys_amount]").val())){
                                    $.jBox.alert("应收金额非法",'提示');
                                    cansubmit = false;
                                }
                                
                                if(cansubmit && !/^[0-9]+(.[0-9]+)?$/.test($("input[name=ss_amount]").val())){
                                    $.jBox.alert("实收金额非法",'提示');
                                    cansubmit = false;
                                }
                                
                                if(cansubmit && $("input[name=fee_type]:checked").length == 0){
                                    $.jBox.alert("请勾选收费情况",'提示');
                                    cansubmit = false;
                                }
                            }
                            {/if}
                        
                            if(op != '退回' && cansubmit && $("input[name=sendor]").length != 0 && $("input[name=sendor]:checked").length == 0){
                                $.jBox.alert("请选择发送人",'提示');
                                cansubmit = false;
                            }
                            
                            if(!cansubmit){
                                e.preventDefault();
                            }else{
                                $(".fixbottom .btn").hide();
                                $("#loading").show();
                            }
                        });
                    });
                </script>
            </div>
            
            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}