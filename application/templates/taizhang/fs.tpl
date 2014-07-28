                                {if $info['status'] == '已提交复审' && $info['sendor_id'] == $userProfile['id']}
                                <tr>
                                    <td><strong>复审主要意见</strong></td>
                                    <td>
                                        <textarea style="width: 500px; height: 50px;" name="fs_yj">{if $info['fs_yj']}{$info['fs_yj']|escape}{else}经查资料齐全，合格。{/if}</textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>复审修改和处理意见、说明</strong></td>
                                    <td>
                                        <textarea style="width: 500px; height: 50px;" name="fs_remark">{$info['fs_remark']|escape}</textarea>
                                    </td>
                                </tr>
                                {else}
                                <tr>
                                    <td><strong>复审主要意见</strong></td>
                                    <td>{$info['fs_yj']|escape}</td>
                                </tr>
                                <tr>
                                    <td><strong>复审修改和处理意见、说明</strong></td>
                                    <td>{$info['fs_remark']|escape}</td>
                                </tr>
                                <tr>
                                    <td><strong>复审人</strong></td>
                                    <td>{$info['fs_name']|escape}</td>
                                </tr>
                                {/if}
                                