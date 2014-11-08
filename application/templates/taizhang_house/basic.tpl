                                <tr>
                                    <td><strong>合同编号</strong></td>
                                    <td>{$info['project_no']}</td>
                                </tr>
                                <tr>
                                    <td><strong>区域</strong></td>
                                    <td>{$info['region_name']}</td>
                                </tr>
                                <tr>
                                    <td><strong>类型</strong></td>
                                    <td>{$info['ptype_name']}</td>
                                </tr>
                                <tr>
                                    <td><strong>项目名称</strong></td>
                                    <td>{$info['name']|escape}</td>
                                </tr>
                                <tr>
                                    <td><strong>土地坐落</strong></td>
                                    <td>{$info['address']|escape}</td>
                                </tr>
                                <tr>
                                    <td><strong>总面积</strong></td>
                                    <td>{$info['total_area']}M<sup>2</sup></td>
                                </tr>
                                <tr>
                                    <td><strong>出报告时间</strong></td>
                                    <td>{$info['complete_time']|date_format:"Y-m-d"}</td>
                                </tr>
                                <tr>
                                    <td><strong>作业负责人</strong></label></td>
                                    <td>{$info['pm']|escape}</td>
                                </tr>
                                <tr>
                                    <td><strong>备注</strong></td>
                                    <td>{$info['descripton']}</td>
                                </tr>
                                {include file="taizhang/basic_info.tpl"}
                                <tr>
                                    <td><strong>图件文档</strong></td>
                                    <td>
                                        <ul id="filelist" class="tj_list">
                                            {foreach from=$files item=item}
                                                <li style="color:blue;"><div class="fname"><a title="点击下载" href="{url_path('attachment','download','id=')}{$item['id']}">{$item['file_name']}</a></div><div class="fsize">{byte_format($item['file_size'])}</div><input type="hidden" name="file_id[]" value="{$item['id']}"/></li>
                                            {/foreach}
                                        </ul>
                                    </td>
                                </tr>