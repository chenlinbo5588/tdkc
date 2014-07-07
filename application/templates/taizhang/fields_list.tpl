<td>
        <input type="text" name="master_serial" value="{$info['master_serial']}" style="width:50px" placeholder="请输入总编号"/>
    </td>
    <td>
        <select name="region_name">
        {foreach from=$regionList item=item}
        <option value="{$item['name']}" {if $info['region_name'] == $item['name']}selected{/if}>{$item['name']}</option>
        {/foreach}
    </select>
        <input type="text" name="region_serial" value="{$info['region_serial']}" style="width:50px"  placeholder="请输入分编号"/>
    </td>
    <td>
        <input type="text" name="name" value="{$info['name']|escape}" placeholder="请输入单位名称"/>
    </td>
    <td>
        <input type="text" name="address" value="{$info['address']|escape}" placeholder="请输入土地坐落"/>
    </td>
    <td>
        <input type="text" name="total_area" value="{$info['total_area']}" style="width:60px"  placeholder="请输入总面积"/>
    </td>
    <td>
        <input type="text" name="churan_area" value="{$info['churan_area']}" style="width:60px"  placeholder="请输入出让面积"/>
    </td>
        <td>
        <select name="nature">
            {foreach from=$natureList item=item}
            <option value="{$item['name']}" {if $info['nature'] == $item['name']}selected{/if}>{$item['name']}</option>
            {/foreach}
        </select>
    </td>
    <td>
        <input type="text" name="contacter" value="{$info['contacter']}" style="width:50px"  placeholder="请输入联系人名称"/>
    </td>
    <td>
        <input type="text" name="contacter_mobile" value="{$info['contacter_mobile']}" style="width:80px" placeholder="请输入联系人号码"/></span>
    </td>
    <td>
        <input type="text" name="pm" value="{$info['pm']}" style="width:50px" placeholder="作业组负责人"/>
    </td>

    <td>
        <select  name="fee_type">
            <option value="1" {if $info['fee_type'] == 1}selected{/if}>挂账</option>
            <option value="2" {if $info['fee_type'] == 2}selected{/if}>票开款收</option>
            <option value="3" {if $info['fee_type'] == 3}selected{/if}>票开款未收</option>
            <option value="4" {if $info['fee_type'] == 4}selected{/if}>票未开款收</option>
        </select>    
    </td>
    <td>
        <select  name="has_doc">
            <option value="0" {if $info['has_doc'] == 0}selected{/if}>未形成</option>
            <option value="1" {if $info['has_doc'] == 1}selected{/if}>已形成</option>
        </select>    
    </td>
    <td>
        <input type="text" name="descripton" placeholder="请输入备注" style="width:80px"  value="{$info['descripton']|escape}"/>
    </td>