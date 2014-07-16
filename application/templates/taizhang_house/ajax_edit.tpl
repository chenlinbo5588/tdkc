<tr id="editrow_{$info['id']}">
    <td></td>
    <td>{$info['createtime']|date_format:"Y-m-d"}</td>
    {include file="taizhang_house/fields_list.tpl"}
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


        if(cansubmit && $.trim($("input[name=name]",newrow).val()) == ''){
            alert("请输入项目名称");
            cansubmit = false;
            $("input[name=name]",newrow).focus();
        }

        if(cansubmit && $.trim($("input[name=address]",newrow).val()) == ''){
            alert("请输入土地坐落");
            cansubmit = false;
            $("input[name=address]",newrow).focus();
        }

        if(cansubmit && $.trim($("input[name=pm]",newrow).val()) == ''){
            alert("请输入作业组负责人名称");
            cansubmit = false;
            $("input[name=pm]",newrow).focus();
        }
        
        if(cansubmit && $.trim($("input[name=project_no]",newrow).val()) == ''){
            alert("请输入合同编号");
            cansubmit = false;
            $("input[name=project_no]",newrow).focus();
        }

        if(cansubmit){
            that.prop("disabled",true);

            $(".loading",newrow).show();
            $.ajax({
                type:"POST",
                url:"{url_path('taizhang_house','edit')}",
                data : {
                    isajax:"1",
                    id: "{$info['id']}",
                    name:$("input[name=name]",newrow).val(),
                    address: $("input[name=address]",newrow).val(),
                    pm:$("input[name=pm]",newrow).val(),
                    project_no:$("input[name=project_no]",newrow).val(),
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