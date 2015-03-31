{include file="common/main_header.tpl"}
            <div class="row-fluid">
                <div class="searchform row-fluid">
                <form action="{url_path('check_record')}" method="get" name="searchform">
                    <input type="hidden" value="check_record" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <table class="normal">
                        <tr>
                            <td><label><strong>项目名称</strong></label></td>
                            <td>
                                <input type="text" name="name" style="width:145px;" value="{$smarty.get.name}" placeholder="请输入项目名称"/>
                            </td>
                            <td><label><strong>编号</strong></label></td>
                            <td>
                                <input type="text" name="project_no"  value="{$smarty.get.project_no}" placeholder="请输入编号"/>
                            </td>
                            <td><label><strong>作业组负责人</strong></label></td>
                            <td>
                                <input type="text" name="pm"  value="{$smarty.get.pm}" placeholder="作业组负责人"/>
                            </td>
                            <td>
                                <input type="submit" name="submit" class="btn btn-primary" value="查询"/>&nbsp;
                                {auth name="check_record+add"}<a class="addlink" href="{url_path('check_record','add')}">+添加检查记录</a>{/auth}
                            </td>
                        </tr>
                        <tr>
                            <td><label><strong>登记日期开始</strong></label></td>
                            <td><input type="text" name="sdate" id="sdate" style="width:90px;" class="Wdate" readonly {literal}onclick="WdatePicker({maxDate:'#F{$dp.$D(\'edate\')}'})"{/literal} value="{$smarty.get.sdate}"/></td>
                            <td><label><strong>登记日期结束</strong></label></td>
                            <td><input type="text" name="edate" id="edate" style="width:90px;" class="Wdate" readonly {literal}onclick="WdatePicker({minDate:'#F{$dp.$D(\'sdate\')}'})"{/literal} value="{$smarty.get.edate}"/></td>
                            <td><label><strong>精度评定</strong></label></td>
                            <td colspan="2">
                                {foreach from=$evaluate item=item}
                                <label><input type="checkbox" name="evaluate[]" value="{$item}" {if is_array($smarty.get.evaluate) && in_array($item, $smarty.get.evaluate)}checked{/if}>{$item}</label>
                                {/foreach}
                            </td>
                        </tr>
                        <tr>
                            <td><label><strong>当前经办人为</strong></label></td>
                            <td colspan="6">
                                <input type="text" name="sendor" value="{$smarty.get.sendor}" data-self="{$userProfile['name']}"/>&nbsp;<input type="button" name="setself" value="填入自己"/>
                            </td>
                        </tr>
                     </table>
                </form>
            </div>
                        
            <div class="span12">
                <table class="table" id="listtable" >
                    <thead>
                        <tr>
                            <th>时间</th>
                            <th>编号</th>
                            <th>名称</th>
                            <th>项目类型</th>
                            <th>检查方法</th>
                            <th>精度评定</th>
                            <th>当前经办人</th>
                            <th>控制点</th>
                            <th>碎部点</th>
                            <th>边长</th>
                            <th>界址点</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr id="row_{$item['id']}">
                           <td>{$item['createtime']|date_format:"Y-m-d"}</td>
                           <td>{$item['project_no']}</td>
                           <td><a href="{url_path('check_record','edit','id=')}{$item['id']}">{$item['name']}</a></td>
                           <td>{$item['type']}</td>
                           <td>{$item['method']}</td>
                           <td>{$item['evaluate']}</td>
                           <th>{$item['sendor']}</th>
                           <td>精度（限差）:<span class="warning">{$item['kzd_jd']}cm</span>点数:<span class="warning">{$item['kzd_num']}</span>个,<br/>误差均值:<span class="warning">{$item['kzd_avg']}cm</span>,超限点数:<span class="warning">{$item['kzd_overflow']}</span>个</td>
                           <td>精度（限差）:<span class="warning">{$item['sbd_jd']}cm</span>,点数:<span class="warning">{$item['sbd_num']}</span>个,<br/>误差均值:<span class="warning">{$item['sbd_avg']}cm</span>,超限点数:<span class="warning">{$item['sbd_overflow']}</span>个</td>
                           <td>精度（限差）:<span class="warning">{$item['bc_jd']}cm</span>,点数:<span class="warning">{$item['bc_num']}</span>个,<br/>误差均值:<span class="warning">{$item['bc_avg']}cm</span>,超限点数:<span class="warning">{$item['bc_overflow']}</span>个</td>
                           <td>精度（限差）:<span class="warning">{$item['jzd_jd']}cm</span>,点数:<span class="warning">{$item['jzd_num']}</span>个,<br/>误差均值:<span class="warning">{$item['jzd_avg']}cm</span>,超限点数:<span class="warning">{$item['jzd_overflow']}</span>个</td>
                           <td><a href="javascript:void(0);" class="delete" data-id="{$item['id']}" data-title="{$item['name']|escape}" data-href="{url_path('check_record','delete','id=')}{$item['id']}"  >删除</a></td>
                        </tr>
                        {/foreach}
                    </tbody>
                </table>
                {include file="pagination.tpl"}
            </div>
            
            <script>
                
                $(function(){
                
                    $("input[name=setself]").bind("click",function(e){
                        $("input[name=sendor]").val($("input[name=sendor]").attr("data-self"));
                    });
                    
                });
            </script>    
            {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}