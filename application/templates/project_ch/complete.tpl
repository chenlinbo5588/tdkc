<div class="pd20">
    
    <form name="saveForm" action="{url_path('project_ch','complete')}" method="post" target="post_iframe">
        <input type="hidden" name="id" value="{$info['id']}"/>
        <table class="maintain border1">
            <tbody>
                <tr>
                    <td>登记名称</td>
                    <td>{$info['name']|escape}</td>
                </tr>
                <tr>
                    <td>项目负责人</td>
                    <td>{$info['pm']|escape}</td>
                </tr>
                <tr>
                    <td>自查主要意见</td>
                    <td>
                        <textarea style="width: 500px; height: 100px;" name="zc_yj">{if $info['zc_yj']}{$info['zc_yj']|escape}{else}外业数据正确。{/if}</textarea>
                    </td>
                </tr>
                <tr>
                    <td>自查修改和处理意见、说明</td>
                    <td>
                        <textarea style="width: 500px; height: 100px;" name="zc_remark">{$info['zc_remark']|escape}</textarea>
                    </td>
                </tr>
                <tr>
                    <td>图件文档</td>
                    <td>
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
                        <ul id="filelist" class="tj_list">
                            {foreach from=$files item=item}
                                <li style="color:blue;"><div class="fname"><a title="点击下载" href="{url_path('attachment','download','id=')}{$item['id']}">{$item['file_name']}</a></div><div class="fsize">{byte_format($item['file_size'])}</div><input type="hidden" name="file_id[]" value="{$item['id']}"/><a class="df" href="javascript:void(0);">删除</a></li>
                            {/foreach}
                        </ul>
                    </td>
                </tr>

                {if $info['type'] == $smarty.const.CH_RCZD}
                <tr>
                    <td>界址信息</td>
                    <td>
                        <div>{form_error('jz_list')}</div>
                        <div>
                            <a class="link_btn" href="{url_path('printer','jzb','id=')}{$info['id']}" target="_blank">打印界址表</a>
                            {if $info['status'] == '已实施'}
                            <a href="javascript:void(0);" id="addJz">添加界址</a>&nbsp;
                            <label>请输入原流水号(不区分大小写)<input type="text" name="source_id" value="" placeholder="请输入原流水号"/></label>
                            <input type="button" name="readJzFrom" id="readJzFrom" value="从已有界址读入"/>
                            <input type="button" name="saveJz" id="saveJz" value="保存界址表"/>
                            {/if}

                            <a href="javascript:void(0);" class="toggle" data-toggle='{ "toggleText": ["-收起","+展开"],"target":"#jz_list" }' >-收起</a>
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
                            {else}
                                <a class="link_btn" href="{url_path('printer','mjb','id=')}{$info['id']}&type=print" target="_blank">打印面积分类表</a>
                            {/if}
                        </div>
                    </td>
                </tr>
                {/if}
                <tr>
                    <td>发送给初审</td>
                    <td>{include file="project_ch/sendorlist.tpl"}</td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <input type="submit" name="submit" class="btn btn-orange" value="完成"/>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
    <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>
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
                <a href="javascript:void(0);" class="insertJz after">后插</a>&nbsp;
                <a href="javascript:void(0);" class="insertJz before">前插</a>&nbsp;
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
            $("#filelist").delegate("a.df","click",function(e){
                if(confirm("确定要删除吗")){
                    $(this).closest("li").remove();
                }
            });
                        
                        
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
</div>