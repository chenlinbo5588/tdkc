                                {if $info['status'] == '新增' && $info['sendor_id'] == $userProfile['id']}
                                <tr>
                                    <td><strong>自查主要意见</strong></td>
                                    <td>
                                        <textarea style="width: 500px; height: 50px;" name="zc_yj">{if $info['zc_yj']}{$info['zc_yj']|escape}{else}外业数据正确。{/if}</textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>自查修改和处理意见、说明</strong></td>
                                    <td>
                                        <textarea style="width: 500px; height: 50px;" name="zc_remark">{$info['zc_remark']|escape}</textarea>
                                    </td>
                                </tr>
                                {else}
                                <tr>
                                    <td><strong>自查主要意见</strong></td>
                                    <td>{$info['zc_yj']|escape}</td>
                                </tr>
                                <tr>
                                    <td><strong>自查修改和处理意见、说明</strong></td>
                                    <td>{$info['zc_remark']|escape}</td>
                                </tr>
                                <tr>
                                    <td><strong>自查人</strong></td>
                                    <td>{$info['zc_name']|escape}</td>
                                </tr>
                                {/if}
                                