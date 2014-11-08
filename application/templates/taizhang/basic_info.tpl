                                {if $info['id']}
                                <tr>
                                    <td><label class="optional"><em></em><strong>当前状态</strong></label></td>
                                    <td>{$info['status']}</td>
                                </tr>
                                <tr>
                                    <td><label class="optional"><em></em><strong>当前经办人</strong></label></td>
                                    <td>{$info['sendor']}</td>
                                </tr>
                                <tr>
                                    <td><strong>台账创建人</strong></td>
                                    <td>{$info['creator']}</td>
                                </tr>
                                <tr>
                                    <td><strong>台账创建时间</strong></td>
                                    <td>{$info['createtime']|date_format:"Y-m-d H:i"}</td>
                                </tr>
                                {/if}