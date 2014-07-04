                     <td>
                         <input type="text" name="name" value="{$info['name']}" placeholder="请输入登记名称"/>
                     </td>
                     <td>
                        <select name="type_id">
                            {foreach from=$projectTypeList item=item}
                            <option value="{$item['id']}" {if $info['type_id'] == $item['id']}selected{/if}>{str_replace('项目','',$item['type'])}-{$item['name']}</option>
                            {/foreach}
                        </select>
                    </td>
                    <td>
                        <input type="text" name="manager"  style="width:50px;" value="{$info['manager']}" placeholder="请输入接洽人名称"/>
                    </td>
                    <td>
                        <input type="text" name="manager_mobile" style="width:80px;" value="{$info['manager_mobile']}" placeholder="请输入接洽人号码"/>
                    </td>
                    <td>
                        <select name="region_code">
                            {foreach from=$regionList item=item}
                            <option value="{$item['code']}" {if $info['region_code'] == $item['code']}selected{/if}>{$item['name']}</option>
                            {/foreach}
                        </select>
                    </td>
                    <td>
                        <input type="text" name="address" style="width:100px;" value="{$info['address']}" placeholder="请输入地址"/>
                    </td>
                    <td>
                        <input type="text" name="contacter" style="width:50px;" value="{$info['contacter']}" placeholder="请输入联系人名称"/>
                    </td>
                    <td>
                        <input type="text" name="contacter_mobile" style="width:80px;" value="{$info['contacter_mobile']}" placeholder="请输入联系人号码"/></span>
                    </td>
                    <td>
                        <select name="pm_id">
                            {foreach from=$userSendorList item=item}
                            <option value="{$item['sendor_id']}" {if $info['pm_id'] == $item['sendor_id']}selected{/if}>{$item['sendor']}</option>
                            {/foreach}
                        </select>
                    </td>
                    <td>
                        {$info['sendor']}
                    </td>
                    <td>
                        {$info['status']}
                    </td>
                    <td>
                        <input type="text" name="end_date" style="width:80px;" readonly onclick="WdatePicker({ minDate:'%y-%M-%d' })" value="{if $info['end_date']}{$info['end_date']|date_format:"Y-m-d"}{/if}" /></span>
                    </td>
                    <td>
                        <input type="text" name="descripton"  style="width:100px;" placeholder="请输入备注" value="{$info['descripton']}"/>
                    </td>
                    <td>
                        <select  name="has_doc">
                            <option value="0" {if $info['has_doc'] == 0}selected{/if}>未形成</option>
                            <option value="1" {if $info['has_doc'] == 1}selected{/if}>已形成</option>
                        </select>  
                    </td>