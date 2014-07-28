                                {if $info['status'] == '已提交初审' && $info['sendor_id'] == $userProfile['id']}
                                <tr>
                                    <td><strong>初审主要意见</strong></td>
                                    <td>
                                        <textarea style="width: 500px; height: 50px;" name="cs_yj">{if $info['cs_yj']}{$info['cs_yj']|escape}{else}按规范要求测量，报告符合要求。{/if}</textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>初审修改和处理意见、说明</strong></td>
                                    <td>
                                        <textarea style="width: 500px; height: 50px;" name="cs_remark">{$info['cs_remark']|escape}</textarea>
                                    </td>
                                </tr>
                                {else}
                                <tr>
                                    <td><strong>初审主要意见</strong></td>
                                    <td>{$info['cs_yj']|escape}</td>
                                </tr>
                                <tr>
                                    <td><strong>初审修改和处理意见、说明</strong></td>
                                    <td>{$info['cs_remark']|escape}</td>
                                </tr>
                                <tr>
                                    <td><strong>初审人</strong></td>
                                    <td>{$info['cs_name']|escape}</td>
                                </tr>
                                {/if}
                                