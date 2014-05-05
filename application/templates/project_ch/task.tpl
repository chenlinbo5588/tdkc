{include file="common/main_header.tpl"}
        {include file="project_ch/modlist.tpl"}
        {*{include file="common/ke.tpl"}*}
        
        <style>
            .tj_list {
                margin: 15px 0;
                
            }
            
            .tj_list li {
                padding:5px;
            }
            
            .tj_list .fname {
                width:250px;
                float:left;
            }
            
            .tj_list .fsize {
                width:100px;
                float:left;
            }
            
        </style>
        <div id="flowbar">
            <span>测绘项目</span>
            {foreach from=$statusHtml item=item}
              {$item}  
            {/foreach}
        </div>
        <div class="project_detail">
            <ul id="project_nav">
                <li><a href="#anchor_base">基本信息</a></li>
                <li><a href="#anchor_work">作业信息</a></li>
                <li><a href="#anchor_check">审核信息</a></li>
                <li><a href="#anchor_doc">成果信息</a></li>
                <li><a href="#anchor_fee">收费信息</a></li>
            </ul>
            <form name="saveForm" action="{url_path('project_ch','task')}" method="post">
                <input type="hidden" name="event_id" value="{$info['event_id']}"/>
                <input type="hidden" name="id" value="{$info['id']}"/>
                <a name="anchor_base" id="anchor_base"></a>
                <table class="maintain border1">
                    <caption>基本信息</caption>
                    <tbody>
                    <tr>
                        <td>流水号</td>
                        <td>{$info['project_no']}</td>
                        <td>录入类型</td>
                        <td>{if $info['input_type'] == 0}正常登记{elseif $info['input_type'] == 1}补录登记{/if}</td>
                    </tr>
                    <tr>
                        <td>登记年月</td>
                        <td>{$info['year']}年{$info['month']}月份</td>
                        <td>区域</td>
                        <td>{$info['region_name']}</td>
                    </tr>
                    <tr>
                        <td>登记类型</td>
                        <td colspan="3">{$info['type']}</td>
                    </tr>
                    <tr>
                        <td>登记名称</td>
                        <td colspan="3">{$info['name']|escape}</td>
                    </tr>
                    <tr>
                        <td>地址</td>
                        <td colspan="3">{$info['address']|escape}</td>
                    </tr>
                    <tr>
                        <td>村名</td>
                        <td>{$info['village']|escape}</td>
                        <td>目项来源</td>
                        <td>{$info['source']|escape}</td>
                        
                    </tr>
                    <tr>
                        <td>联系单位名称</td>
                        <td>{$info['union_name']|escape}</td>
                   
                        <td>联系人信息</td>
                        <td><p>姓名:{$info['contacter']|escape}</p><p>手机号码:{$info['contacter_mobile']}</p><p>固定电话:{$info['contacter_tel']}</p></td>
                    </tr>
                    <tr>
                        <td>接洽人信息</td>
                        <td><p>姓名:{$info['manager']|escape}</p><p>手机号码:{$info['manager_mobile']}</p><p>固定电话:{$info['manager_tel']}</p></td>
                    
                        <td>备注</td>
                        <td>{$info['descripton']}</td>
                    </tr>
                    <tr>
                        <td>优先级</td>
                        <td>{$info['displayorder']}</td>
                    
                        <td>登记信息</td>
                        <td>登记人姓名:{$info['creator']} 登记时间：{$info['createtime']|date_format:"Y-m-d H:i:s"}</td>
                    </tr>
                    {*
                    <tr>
                        <td>最后修改</td>
                        <td>修改人：{$info['updator']} 修改时间:{$info['updatetime']|date_format:"Y-m-d H:i:s"}</td>
                    </tr>
                    *}
                 </tbody>
                </table>
               <a name="anchor_work" id="anchor_work"></a>
               <table  class="maintain border1">
               <tbody>
                   <caption>作业信息</caption>
                    <tr>
                        <td>测绘项目负责人</td>
                        <td>{$info['pm']}</td>
                    </tr>
                    <tr class="workflow">
                        <td><label class="required"><em></em><strong>当前状态</strong></label></td>
                        <td><b class="notice">{$info['status']}{$info['sub_status']}</b></td>
                    </tr>
                    <tr>
                        <td>当前处理人</td>
                        <td>{$info['sendor']}</td>
                    </tr>
                    {if $info['sendor_id'] == $userProfile['id']}
                    <tr class="workflow">
                        <td><label class="required"><em></em><strong>流程选择</strong></label></td>
                        <td>
                            <select name="workflow" style="width:200px;">
                                {if $info['status'] == '新增'}
                                    <option value="发送" {if $smarty.post.workflow == '发送'}selected{/if}>发送</option>
                                {elseif $info['status'] == '已发送'}
                                    <option value="布置" {if $smarty.post.workflow == '布置'}selected{/if}>布置</option>
                                {elseif $info['status'] == '已布置'}
                                    <option value="实施" {if $smarty.post.workflow == '实施'}selected{/if}>实施</option>
                                {elseif $info['status'] == '已实施'}
                                    <option value="完成" {if $smarty.post.workflow == '完成'}selected{/if}>完成</option>
                                {elseif $info['status'] == '已完成'}
                                    <option value="提交初审" {if $smarty.post.workflow == '提交初审'}selected{/if}>提交初审</option>
                                {elseif $info['status'] == '已提交初审'}
                                    <option value="通过初审" {if $smarty.post.workflow == '通过初审'}selected{/if}>通过初审</option>
                                {elseif $info['status'] == '已通过初审'}
                                    <option value="提交复审" {if $smarty.post.workflow == '提交复审'}selected{/if}>提交复审</option>
                                {elseif $info['status'] == '已提交复审'}
                                    <option value="通过复审" {if $smarty.post.workflow == '通过复审'}selected{/if}>通过复审</option>
                                {elseif $info['status'] == '已通过复审'}
                                    <option value="提交" {if $smarty.post.workflow == '提交'}selected{/if}>提交</option>
                                {elseif $info['status'] == '已提交'}
                                    <option value="提交收费" {if $smarty.post.workflow == '提交收费'}selected{/if}>提交收费</option>
                                {/if}
                                
                                {if !in_array($info['status'],array('新增','已提交'))}
                                <option value="退回" {if $smarty.post.workflow == '退回'}selected{/if}>退回</option>
                                {/if}
                            </select>
                        </td>
                    </tr>
                    {/if}
                    <tr class="tuihui" {if $smarty.post.workflow != '退回'}style="display: none;"{/if}>
                        <td>退回原因</td>
                        <td>
                            <textarea name="reason" style="width: 500px; height: 100px;">{$info['reason']|escape}</textarea>
                            <div>{form_error('reason')}</div>
                        </td>
                    </tr>
                    <tr>
                        <td>当前缺陷</td>
                        <td>
                            <table>
                                <colgroup>
                                    <col width="400"/>
                                    <col width="40"/>
                                    <col width="300"/>
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th>缺陷项</th>
                                        <th>扣分</th>
                                        <th>备注</th>
                                    </tr>
                                </thead>
                                <tbody>
                                {foreach from=$userFaultList item=item}
                                    <tr>
                                        <td>{$item['fault_code']}{$item['fault_name']}</td>
                                        <td>{$item['score']}</td>
                                        <td>{$item['remark']|escape}</td>
                                    </tr>
                                {/foreach}
                                  </tbody>
                            </table>
                        </td>
                    </tr>
                    
                    <tr class="fault" {if $smarty.post.workflow != '退回'}style="display: none;"{/if}>
                        <td>缺陷信息</td>
                        <td>
                            <div>{form_error('fault[]')}</div>
                            <div class="fault_wrapper">
                                <a href="javascript:void(0);" class="toggle" data-toggle='{ "toggleText": ["-收起","+展开"],"target":"#faultList" }' >-收起</a>
                                <div id="faultList">
                                    <table>
                                        <colgroup>
                                            <col width="400"/>
                                            <col width="40"/>
                                            <col width="300"/>
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
                                                <col width="400"/>
                                                <col width="40"/>
                                                <col width="300"/>
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
                        <td>实施备注</td>
                        <td>{$info['ss_remark']|escape}</td>
                    </tr>
                    {/if}
                    
                    {if in_array($info['status'],array('已实施', '已完成','已提交初审',  '已通过初审', '已提交复审', '已通过复审','已提交'))}
                    {include file="common/upload.tpl"}
                    <tr>
                        <td>图件文档</td>
                        <td>
                            {if $info['sendor_id'] == $userProfile['id'] && $info['status'] != '已提交'}
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
                    {/if}
                    {if $info['sendor_id'] == $userProfile['id'] && in_array($info['status'],array('新增', '已发送', '已实施',  '已完成', '已通过初审','已通过复审','已提交'))}
                    <tr>
                        <td>发送给</td>
                        <td>
                            {if $userSendorList}
                            <div class="userlist clearfix">
                                {foreach  from=$userSendorList item=item}
                                <label class="item{if $smarty.post.sendor == $item['sendor_id']} selected{/if}"><input type="radio" name="sendor" value="{$item['sendor_id']}" {if $smarty.post.sendor == $item['sendor_id']}checked{/if} >{$item['sendor']}</label>
                                {/foreach}
                            </div>
                            {/if}
                            <div>没有找到你要发送的人？，请点击<a class="notice" href="{url_path('sendor','add')}">这里</a>进行添加</a></div>
                            <div>{form_error('sendor')}</div>
                        </td>
                    </tr>
                    {/if}
                    </tbody>
                </table>
               <a name="anchor_check" id="anchor_check"></a>
               <table  class="maintain border1">
                   <caption>审核信息</caption> 
                    <tbody>
                    <tr>
                        <td>自查主要意见</td>
                        <td>
                            {if $info['status'] == '已完成' && $info['sendor_id'] == $userProfile['id']}
                            <textarea style="width: 500px; height: 100px;" name="zc_yj">{$info['zc_yj']|escape}</textarea>
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
                            <textarea style="width: 500px; height: 100px;" name="cs_yj">{$info['cs_yj']|escape}</textarea>
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
                            <textarea style="width: 500px; height: 100px;" name="fs_yj">{$info['fs_yj']|escape}</textarea>
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
                    {*
                    {if $info['type'] == '日常宗地'}
                    <tr>
                        <td>请填写表格数据</td>
                        <td>
                            <p>
                                <input type="hidden" name="doc_zddj" value=""/><a class="docs" href="javascript:void(0);" data-title="宗地勘测定界成果报告" data-href="{url_path('project_ch','doc','categroy=zddj&id=')}{$info['id']}">宗地勘测定界成果报告</a>
                                <div>{form_error('doc_zddj')}</div>
                            </p>
                            <p>
                                <input type="hidden" name="doc_zdmj" value=""/><a class="docs" href="javascript:void(0);" data-title="土地面积分类表" data-href="{url_path('project_ch','doc','categroy=zdmj&id=')}{$info['id']}">土地面积分类表</a>
                                <div>{form_error('doc_zdmj')}</div>
                            </p>
                            <p>
                                <input type="hidden" name="doc_zdjz" value=""/><a class="docs" href="javascript:void(0);" data-title="宗地界址调查表" data-href="{url_path('project_ch','doc','categroy=zdjz&id=')}{$info['id']}">宗地界址调查表</a>
                                <div>{form_error('doc_zdjz')}</div>
                            </p>
                            <p>
                                <input type="hidden" name="doc_zdbg" value=""/><a class="docs" href="javascript:void(0);" data-title="土地勘测定界成果变更情况表" data-href="{url_path('project_ch','doc','categroy=zdbg&id=')}{$info['id']}">土地勘测定界成果变更情况表</a>
                                <div>{form_error('doc_zdbg')}</div>
                            </p>
                        </td>
                    </tr>   
                    {/if}
                    *}
                    
                    </tbody>
                </table>
                <a name="anchor_doc" id="anchor_doc"></a>
                <table class="maintain border1">
                   <caption>成果信息</caption>
                   <tbody>
                    {if in_array($info['status'],array('已通过复审', '已提交'))} 
                    <tr>
                        <td>项目成果名称</td>
                        {if $info['status'] != '已提交'}
                        <td><input type="text" name="title" value="{$info['title']}" placeholder="请填写项目成果名称" style="width:300px;"/>{form_error('title')}</td>
                        {else}
                        <td>{$info['title']}</td>
                        {/if}
                    </tr>
                    <tr>
                        <td>项目面积</td>
                        {if $info['status'] != '已提交'}
                        <td><input type="text" name="area" value="{$info['area']}" placeholder="请填写项目面积" style="width:150px;"/>{form_error('area')}</td>
                        {else}
                        <td>{$info['area']}</td>
                        {/if}
                    </tr>
                    {/if}
                    </tbody>
                </table>
                <a name="anchor_fee" id="anchor_fee"></a>   
                <table class="maintain border1">
                    <caption>收费信息</caption>
                    <tbody>
                        <tr>
                            <td>成果资料已领取</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>领取时间</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>收费</td>
                            <td>
                                <label><input type="radio" name="fee" value="1"/>挂账</label>
                                <label><input type="radio" name="fee" value="2"/>票开款收</label>
                                <label><input type="radio" name="fee" value="3"/>票开款未收</label>
                                <label><input type="radio" name="fee" value="4"/>票未开款收</label>
                            </td>
                        </tr>
                    </tbody>
                </table> 
                    
                <div class="fixbottom">
                {if $info['sendor_id'] == $userProfile['id']}
                <input type="submit" name="submit" class="btn btn-sm btn-primary" value="确定"/>
                {/if}
                {if $gobackUrl }<input type="hidden" name="gobackUrl" value="{$gobackUrl}"/><a class="goback" href="{$gobackUrl}">返回</a>{/if}
                </div>
             </form>
                <script>
                    $(function(){
                        {if $message}
                            $.jBox.tip('{$message}');
                        {/if}
                            {*
                        $("a.docs").bind("click",function(e){
                            $.jBox("get:" + $(e.target).attr("data-href"),{ title:$(e.target).attr("data-title"),width:1000,height:600});
                        });
                            *}
                        
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
                        
                        $(".userlist label").bind("click",function(e){
                            $(".userlist label").removeClass("selected");
                            $(e.target).closest("label").addClass("selected");
                        });
                        
                        $("select[name=workflow]").bind("change",function(e){
                            var select = $(e.target);
                            if(select.val() == '退回'){
                                $("#timeReq").hide();
                                $(".tuihui").show();
                                {if $info['status'] == '已提交复审'}
                                $(".fault").show();
                                {/if}
                                $("textarea[name=reason]").focus();
                            }else{
                                $("#timeReq").show();
                                $(".tuihui").hide();
                                {if $info['status'] == '已提交复审'}
                                $(".fault").hide();
                                {/if}
                            }
                        });
                        
                        $("#filelist").delegate("a.df","click",function(e){
                            if(confirm("确定要删除吗")){
                                $(this).closest("li").remove();
                            }
                        });
                        
                        $("form[name=saveForm]").bind('submit',function(e){
                            if($("select[name=workflow]").val() == '退回'){
                                if($.trim($("textarea[name=reason]").val()).length == 0){
                                    $("textarea[name=reason]").focus();
                                    $.jBox.tip("请填写退回原因",'提示');
                                    return false;
                                }
                                
                                {if $info['status'] == '已提交复审'}
                                if($("input[name='fault[]']:checked").length == 0){
                                    $.jBox.tip("请至少勾选一个缺陷",'提示');
                                    return false;
                                }
                                
                                var remarkInput = true;
                                $("#faultList input[type=checkbox]").each(function(index){
                                    var that = $(this);
                                    if(that.prop("checked") && $.trim(that.closest("tr").find("input[type=text]:eq(0)").val()) == ''){
                                        that.closest("tr").find("input[type=text]:eq(0)").focus();
                                        remarkInput = false;
                                        $.jBox.tip("请填写扣分项目备注",'提示');
                                        
                                        return false;
                                    }
                                });
                                
                                if(!remarkInput){
                                    return false;
                                }
                                {/if}
                                
                            }
                            
                            {if $info['status'] == '已发送'}
                            if($("select[name=workflow]").val() == '布置'){
                                if($("#sdate").val() == '' || $("#edate").val() == ''){
                                    $.jBox.tip("请选择时间要求",'提示');
                                    return false;
                                }
                                
                                if($("textarea[name=bz_remark]").val().length == 0){
                                    $("textarea[name=bz_remark]").focus();
                                    $.jBox.tip("请输入布置备注",'提示');
                                    return false;
                                }
                            }
                            {elseif $info['status'] == '已布置' }
                            if($("select[name=workflow]").val() == '实施'){
                                if($("#sdate").val() == '' || $("#edate").val() == ''){
                                    $.jBox.tip("请选择时间安排",'提示');
                                    return false;
                                }
                                
                                if($("textarea[name=ss_remark]").val().length == 0){
                                    $("textarea[name=ss_remark]").focus();
                                    $.jBox.tip("请输入实施备注",'提示');
                                    return false;
                                }
                            }
                            {elseif $info['status'] == '已实施' }
                            if($("select[name=workflow]").val() == '完成'){
                                if($("input[name='file_id[]']").length == 0){
                                    $.jBox.tip("请上传图件文档",'提示');
                                    return false;
                                }
                            }
                            {elseif $info['status'] == '已完成' }
                            if($("select[name=workflow]").val() == '提交初审'){    
                                if($("textarea[name=zc_yj]").val().length == 0){
                                    $("textarea[name=zc_yj]").focus();
                                    $.jBox.tip("请输入自查意见",'提示');
                                    return false;
                                }
                                
                                
                                if($("textarea[name=zc_remark]").val().length == 0){
                                    $("textarea[name=zc_remark]").focus();
                                    $.jBox.tip("请输入自查修改和处理意见、说明",'提示');
                                    return false;
                                }
                            }
                            {elseif $info['status'] == '已提交初审' }
                             if($("select[name=workflow]").val() == '通过初审'){    
                                if($("textarea[name=cs_yj]").val().length == 0){
                                    $("textarea[name=cs_yj]").focus();
                                    $.jBox.tip("请输入初审意见",'提示');
                                    return false;
                                }
                                
                                if($("textarea[name=cs_remark]").val().length == 0){
                                    $("textarea[name=cs_remark]").focus();
                                    $.jBox.tip("请输入初审修改和处理意见、说明",'提示');
                                    return false;
                                }
                            }
                            {elseif $info['status'] == '已提交复审' }
                             if($("select[name=workflow]").val() == '通过复审'){    
                                if($("textarea[name=fs_yj]").val().length == 0){
                                    $("textarea[name=fs_yj]").focus();
                                    $.jBox.tip("请输入复审意见",'提示');
                                    return false;
                                }
                                
                                if($("textarea[name=fs_remark]").val().length == 0){
                                    $("textarea[name=fs_remark]").focus();
                                    $.jBox.tip("请输入复审修改和处理意见、说明",'提示');
                                    return false;
                                }
                            }
                            {elseif $info['status'] == '已通过复审' }
                            if($("select[name=workflow]").val() == '提交'){    
                                if($("input[name=title]").val().length == 0){
                                    $("input[name=title]").focus();
                                    $.jBox.tip("请输入项目成果名称",'提示');
                                    return false;
                                }
                                
                                if($("input[name=area]").val().length == 0){
                                    $("input[name=area]").focus();
                                    $.jBox.tip("请输入项目面积",'提示');
                                    return false;
                                }
                            }
                            {/if}
                        
                            if($("input[name=sendor]").length != 0 && $("input[name=sendor]:checked").length == 0){
                                $.jBox.tip("请选择发送人",'提示');
                                return false;
                            }
                        
                            return true;
                        });
                    });
                </script>
            </div>
            
            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}