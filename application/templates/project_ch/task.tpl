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
            
            .tj_list li a {
                
            }
            
        </style>
        <div id="flowbar">
            {foreach from=$statusHtml item=item}
              {$item}  
            {/foreach}
        </div>
        <div class="project_detail">
            <form name="saveForm" action="{url_path('project_ch','task')}" method="post">
                <input type="hidden" name="event_id" value="{$info['event_id']}"/>
                <input type="hidden" name="id" value="{$info['id']}"/>
                <table class="maintain border1">
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
                    {if in_array($info['status'],array('已通过复审', '已提交'))} 
                    <tr>
                        <td>项目成果名称</td>
                        {if $info['status'] != '已提交'}
                        <td><input type="text" name="title" value="{$info['title']}" placeholder="请填写项目成果名称" style="width:300px;"/>{form_error('title')}</td>
                        {else}
                        <td>{$info['title']}</td>
                        {/if}
                        <td>项目面积</td>
                        {if $info['status'] != '已提交'}
                        <td><input type="text" name="area" value="{$info['area']}" placeholder="请填写项目面积" style="width:150px;"/>{form_error('area')}</td>
                        {else}
                        <td>{$info['area']}</td>
                        {/if}
                    </tr>  
                    {/if}
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
                    
               <table  class="maintain border1">
               <tbody>
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
                    <tr class="workflow">
                        <td><label class="required"><em></em><strong>流程选择</strong></label></td>
                        <td>
                            <select name="workflow" style="width:200px;">
                                {if $info['status'] == '新增'}
                                    <option value="发送">发送</option>
                                {elseif $info['status'] == '已发送'}
                                    <option value="布置">布置</option>
                                {elseif $info['status'] == '已布置'}
                                    <option value="实施">实施</option>
                                {elseif $info['status'] == '已实施'}
                                    <option value="完成">完成</option>
                                {elseif $info['status'] == '已完成'}
                                    <option value="提交初审">提交初审</option>
                                {elseif $info['status'] == '已提交初审'}
                                    <option value="通过初审">通过初审</option>
                                {elseif $info['status'] == '已通过初审'}
                                    <option value="提交复审">提交复审</option>
                                {elseif $info['status'] == '已提交复审'}
                                    <option value="通过复审">通过复审</option>
                                {elseif $info['status'] == '已通过复审'}
                                    <option value="提交">提交</option>
                                {elseif $info['status'] == '已提交'}
                                    <option value="提交收费">提交收费</option>
                                {/if}
                                
                                {if !in_array($info['status'],array('新增','已提交'))}
                                <option value="退回">退回</option>
                                {/if}
                            </select>
                        </td>
                    </tr>
                    
                    <tr id="tuihui" style="display: none;">
                        <td>退回原因</td>
                        <td>
                            <textarea name="reason" rows="8" cols="50"></textarea>
                            <br/>
                            {form_error('reason')}
                        </td>
                    </tr>
                    {if $info['status'] == '已发送'}
                    <tr id="timeReq">
                        <td>时间要求</td>
                        <td>
                            <label>开始日期<input type="text" name="start_date" id="sdate" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{if $info['start_date']}{$info['start_date']|date_format:"Y-m-d"}{/if}"/>{form_error('start_date')}</label>
                            <label>结束日期<input type="text" name="end_date" id="edate" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{if $info['end_date']}{$info['end_date']|date_format:"Y-m-d"}{/if}"/>{form_error('end_date')}</label>
                       </td>
                    </tr>
                    <tr>
                        <td>布置备注</td>
                        <td>
                            <textarea name="bz_remark" rows="8" cols="50">{$info['bz_remark']|escape}</textarea>
                            <br/>
                            {form_error('bz_remark')}
                        </td>
                    </tr>
                    {else}
                     <tr>
                         <td>时间要求</td>
                         <td>
                            <label>开始日期{$info['start_date']|date_format:"Y-m-d"}</label>
                            <label>结束日期{$info['end_date']|date_format:"Y-m-d"}</label>
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
                            <label>外业完成日期<input type="text" name="wy_enddate" id="sdate" class="Wdate" readonly onclick="WdatePicker({ minDate: '{$info["start_date"]|date_format:"Y-m-d"}' , maxDate:'{$info["end_date"]|date_format:"Y-m-d"}' })" value="{if $info['wy_enddate']}{$info['wy_enddate']|date_format:"Y-m-d"}{/if}"/>{form_error('wy_enddate')}</label>
                            <label>内业完成日期<input type="text" name="ny_enddate" id="edate" class="Wdate" readonly onclick="WdatePicker({ minDate: '{$info["start_date"]|date_format:"Y-m-d"}' , maxDate:'{$info["end_date"]|date_format:"Y-m-d"}' })" value="{if $info['ny_enddate']}{$info['ny_enddate']|date_format:"Y-m-d"}{/if}"/>{form_error('ny_enddate')}</label>
                       </td>
                    </tr>
                    <tr>
                        <td>实施备注</td>
                        <td>
                            <textarea name="ss_remark" style="width: 500px; height: 150px;">{$info['ss_remark']|escape}</textarea>
                            <br/>
                            {form_error('ss_remark')}
                        </td>
                    </tr>
                    {else}
                    <tr>
                        <td>时间安排</td>
                        <td>
                            <label>外业完成日期 {$info['wy_enddate']|date_format:"Y-m-d"}</label>
                            <label>内业完成日期 {$info['ny_enddate']|date_format:"Y-m-d"}</label>
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
                            {if $info['status'] != '已提交'}
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
                    {if in_array($info['status'],array('新增', '已发送', '已实施',  '已完成', '已通过初审','已通过复审','已提交'))}
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
                    <tr>
                        <td></td>
                        <td>
                            {if $info['sendor_id'] == $userProfile['id']}
                            <input type="submit" name="submit" class="btn btn-sm btn-primary" value="确定"/>
                            {/if}
                            
                            {if $gobackUrl }<input type="hidden" name="gobackUrl" value="{$gobackUrl}"/><a class="goback" href="{$gobackUrl}">返回</a>{/if}
                        </td>
                    </tr>
                    </tbody>
                </table>
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
                                $("#tuihui").show();
                                $("textarea[name=reason]").focus();
                            }else{
                                $("#timeReq").show();
                                $("#tuihui").hide();
                            }
                        });
                        
                        $("#filelist").delegate("a.df","click",function(e){
                            if(confirm("确定要删除吗")){
                                $(this).closest("li").remove();
                            }
                        });
                        
                        $("form[name=saveForm]").bind('submit',function(e){
                            if($("select[name=workflow]").val() == '退回' && $.trim($("textarea[name=reason]").val()).length == 0){
                                $("textarea[name=reason]").focus();
                                $.jBox.tip("请填写退回原因",'提示');
                                return false;
                            }
                            
                            {if $info['status'] == '已发送'}
                            if($("select[name=workflow]").val() == '布置'){
                                var checked = false;
                                if($("#sdate").val() == '' || $("#edate").val() == ''){
                                    $.jBox.tip("请选择时间要求",'提示');
                                    return false;
                                }
                                $(".userlist input[type=radio]").each(function(index){
                                    if($(this).prop("checked")){
                                        checked = true;
                                        return false;
                                    }
                                });
                                
                                if(!checked){
                                    $.jBox.tip("请选择发送人",'提示');
                                    return false;
                                }
                                return true;
                            }
                            {/if}
                            
                            return true;
                        });
                    });
                </script>
            </div>
            
            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}