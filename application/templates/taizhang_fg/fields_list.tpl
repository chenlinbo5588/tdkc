    <td>
        <input type="text" name="master_serial" value="{$info['master_serial']}" style="width:90px" placeholder="请输入编号"/>
    </td>
    <td>
        <input type="text" name="name" value="{$info['name']|escape}" placeholder="请输入项目名称"/>
    </td>
    <td>
        <input type="text" name="address" value="{$info['address']|escape}" placeholder="请输入土地坐落"/>
    </td>
    
    <td>
        <input type="text" name="pm" value="{$info['pm']}" style="width:50px" placeholder="作业组负责人"/>
    </td>
    <td>
        <select name="nature">
            <option value="放线" {if $info['nature'] == '放线'}selected{/if}>放线</option>
            <option value="竣工" {if $info['nature'] == '竣工'}selected{/if}>竣工</option>
        </select>
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
        <input type="text" name="descripton" placeholder="请输入备注" value="{$info['descripton']|escape}"/>
    </td>