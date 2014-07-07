<tr id="editrow_{$info['id']}">
    <td></td>
    <td>{$info['createtime']|date_format:"Y-m-d"}</td>
    {include file="taizhang/fields_list.tpl"}
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
                    region_name: $("select[name=region_name]",newrow).val(),
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