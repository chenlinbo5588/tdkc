<tr id="editrow_{$info['id']}">
    <td></td>
    <td>{$info['createtime']|date_format:"Y-m-d"}</td>
    <td>
        <input type="text" name="master_serial" value="{$info['master_serial']}" placeholder="请输入总编号"/>
    </td>
    <td>
        <select name="region_code">
        {foreach from=$regionList item=item}
        <option value="{$item['code']}" {if $info['region_code'] == $item['code']}selected{/if}>{$item['name']}</option>
        {/foreach}
    </select>
        <input type="text" name="region_serial" value="{$info['region_serial']}" placeholder="请输入分编号"/>
    </td>
    <td>
        <input type="text" name="name" value="{$info['name']|escape}" placeholder="请输入单位名称"/>
    </td>
    <td>
        <input type="text" name="address" value="{$info['address']|escape}" placeholder="请输入土地坐落"/>
    </td>
    <td>
        <input type="text" name="total_area" value="{$info['total_area']}" placeholder="请输入总面积"/>
    </td>
    <td>
        <input type="text" name="churan_area" value="{$info['churan_area']}" placeholder="请输入出让面积"/>
    </td>
        <td>
        <select name="nature">
            {foreach from=$natureList item=item}
            <option value="{$item['name']}" {if $info['nature'] == $item['name']}selected{/if}>{$item['name']}</option>
            {/foreach}
        </select>
    </td>
    <td>
        <input type="text" name="contacter" value="{$info['contacter']}" placeholder="请输入联系人名称"/>
    </td>
    <td>
        <input type="text" name="contacter_mobile" value="{$info['contacter_mobile']}" placeholder="请输入联系人号码"/></span>
    </td>
    <td>
        <input type="text" name="pm" value="{$info['pm']}" placeholder="作业组负责人"/>
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
        <input type="text" name="descripton" placeholder="请输入备注" value=""/>
    </td>
    <td>
        {* 操作 *}
        <div class="loading" style="display:none;"></div>
        <div>
            <input type="button" name="saveRow" class="edit_save" value="保存"/>
            <input type="button" name="cancelRow" class="edit_cancel" value="取消"/>
        </div>
    </td>
</tr>
<script>
$(function(){
    $("#editrow_{$info['id']} .edit_save").bind("click",function(e){
        var that = $(e.target);
        var newrow = that.closest('tr');
        var cansubmit = true;

        if(cansubmit && !/^[0-9]+$/.test($("input[name=master_serial]",newrow).val())){
            alert("请输入正确的总编号");
            cansubmit = false;
            $("input[name=master_serial]",newrow).focus();
        }

        if(cansubmit && !/^[0-9]+$/.test($("input[name=region_serial]",newrow).val())){
            alert("请输入正确的分编号");
            cansubmit = false;
            $("input[name=region_serial]",newrow).focus();
        }

        if(cansubmit && $.trim($("input[name=name]",newrow).val()) == ''){
            alert("请输入单位名称");
            cansubmit = false;
            $("input[name=name]",newrow).focus();
        }

        if(cansubmit && $.trim($("input[name=address]",newrow).val()) == ''){
            alert("请输入宗地坐落");
            cansubmit = false;
            $("input[name=address]",newrow).focus();
        }


        if(cansubmit && !/^[0-9]+(.[0-9]+)?$/.test($("input[name=total_area]",newrow).val())){
            $("input[name=total_area]",newrow).focus();
            alert("请输入正确的总面积",'提示');
            cansubmit = false;
        }

        if(cansubmit && !/^[0-9]+(.[0-9]+)?$/.test($("input[name=churan_area]",newrow).val())){
            $("input[name=churan_area]",newrow).focus();
            alert("请输入正确的出让面积",'提示');
            cansubmit = false;
        }


        if(cansubmit && $.trim($("select[name=nature]",newrow).val()) == ''){
            alert("请选择用途");
            cansubmit = false;
            $("select[name=nature]",newrow).focus();
        }


        if(cansubmit && $.trim($("input[name=contacter]",newrow).val()) == ''){
            alert("请输入联系人名称");
            cansubmit = false;
            $("input[name=contacter]",newrow).focus();
        }

        if(cansubmit && $.trim($("input[name=contacter_mobile]",newrow).val()) == ''){
            alert("请输入联系人号码");
            cansubmit = false;
            $("input[name=contacter_mobile]",newrow).focus();
        }


        if(cansubmit && $.trim($("input[name=pm]",newrow).val()) == ''){
            alert("请输入作业组负责人名称");
            cansubmit = false;
            $("input[name=pm]",newrow).focus();
        }

        if(cansubmit){
            that.prop("disabled",true);

            $(".loading",newrow).show();
            $.ajax({
                type:"POST",
                url:"{url_path('taizhang','edit')}",
                data : {
                    isajax:"1",
                    id: "{$info['id']}",
                    name:$("input[name=name]",newrow).val(),
                    master_serial: $("input[name=master_serial]",newrow).val(),
                    region_code: $("select[name=region_code]",newrow).val(),
                    region_serial: $("input[name=region_serial]",newrow).val(),
                    address: $("input[name=address]",newrow).val(),
                    total_area:$("input[name=total_area]",newrow).val(),
                    churan_area: $("input[name=churan_area]",newrow).val(),
                    nature: $("select[name=nature]",newrow).val(),
                    contacter:$("input[name=contacter]",newrow).val(),
                    contacter_mobile: $("input[name=contacter_mobile]",newrow).val(),
                    pm:$("input[name=pm]",newrow).val(),
                    fee_type:$("select[name=fee_type]",newrow).val(),
                    has_doc:$("select[name=has_doc]",newrow).val(),
                    descripton:$("input[name=descripton]",newrow).val()
                },
                dataType:"json",
                success:function(resp){
                    alert(resp.body.text);
                    if(resp.code == 'success'){
                        location.reload();
                    }
                },
                complete:function(){
                    that.prop("disabled",false);
                    $(".loading",newrow).hide();
                },
                error:function(){
                    that.prop("disabled",false);
                    $(".loading",newrow).hide();
                }
            });
        }
    });

    $("#editrow_{$info['id']} .edit_cancel").bind("click",function(e){
        $("#editrow_{$info['id']}").remove();
        $("#row_{$info['id']}").show();
    });
});
</script>