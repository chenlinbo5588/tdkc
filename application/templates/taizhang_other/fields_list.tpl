    <td>
        {if $info['project_no']}<span>当前编号:{$info['project_no']}</span>&nbsp;{/if}<input type="text" name="master_serial" value="{$info['master_serial']}" style="width:90px" placeholder="请输入编号"/>
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
            <option value="土方" {if $info['nature'] == '土方'}selected{/if}>土方</option>
            <option value="山塘" {if $info['nature'] == '山塘'}selected{/if}>山塘</option>
            <option value="地形" {if $info['nature'] == '地形'}selected{/if}>地形</option>
            <option value="评估" {if $info['nature'] == '评估'}selected{/if}>评估</option>
            <option value="控制" {if $info['nature'] == '控制'}selected{/if}>控制</option>
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