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
                {*<li><a href="#anchor_check">审核信息</a></li>
                <li><a href="#anchor_doc">成果信息</a></li>
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
                        <td>登记台账号</td>
                        <td>{$info['project_no']|escape}</td>
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
                        <td>{$info['nature']|escape}</td>
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
                    
                </table>
               
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
                {if $info['sendor_id'] == $userProfile['id']}
                    {if $info['status'] == '新增'}
                        <input type="submit" name="submit" class="btn btn-orange" value="发送"/>
                    {elseif $info['status'] == '已发送'}
                        <input type="submit" name="submit" class="btn btn-orange" value="布置"/>
                    {elseif $info['status'] == '已布置'}
                        <input type="submit" name="submit" class="btn btn-orange" value="实施"/>
                    {elseif $info['status'] == '已实施'}
                        {*<input type="submit" name="submit" class="btn btn-orange" value="完成"/>*}
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
                    <input type="submit" name="submit" class="btn btn-sm btn-gray" value="退回"/>
                {/if}
                {if $gobackUrl }<input type="hidden" name="gobackUrl" value="{$gobackUrl}"/><a class="goback" href="{$gobackUrl}">返回</a>{/if}
                </div>
             </form>
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
                        
                            if(cansubmit && (op == '发送' || op == '布置' || op == '提交初审' || op == '提交复审' || op == '项目提交' || op == '收费')){
                                if($("input[name=sendor]:checked").length == 0){
                                    $.jBox.alert("请选择发送人",'提示');
                                    cansubmit = false;
                                }
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