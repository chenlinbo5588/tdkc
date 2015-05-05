<script>
    $(function(){
    
        $("#fault_cate").bind("click",function(e){
            var that = $(e.target);
            var selVal = that.val();
            
            switch(selVal){
                case "":
                    $(".fault_list .fault_cate").show();
                    break;
                default:
                    $(".fault_list .fault_cate").hide();
                    $(".fault_list .fault_cate_" + selVal).show();
                    break;
            };
        });
    
    
        $("input[name=submit]").bind('click',function(e){
            var that = $(e.target);
            var op = that.val();
            var cansubmit = true;
            $("input[name=workflow]").val(op);
            if(op == '退回' || op == '重新审核'){
                {if ($info['status'] == '已提交初审' || $info['status'] == '已提交复审' || $info['status'] == '已通过复审') }
                
                {*
                if(cansubmit && $.trim($("textarea[name=reason]").val()).length == 0){
                    $("textarea[name=reason]").focus();
                    $.jBox.alert("请填写退回原因",'提示');
                    cansubmit = false;
                }*}
                
                if(cansubmit && $("input[name='fault[]']:checked").length == 0){
                    $.jBox.alert("请至少勾选一个缺陷",'提示');
                    cansubmit = false;
                }
                $("#faultList").show();
                
                if(cansubmit){
                    $("#faultList input[type=checkbox]").each(function(index){
                        var that = $(this);
                        if(that.prop("checked") && $.trim(that.closest("tr").find("input[type=text]:eq(0)").val()) == ''){
                            that.closest("tr").find("input[type=text]:eq(0)").addClass("input_error").focus();
                            $.jBox.alert("请填写扣分项目备注",'提示');

                            cansubmit = false;
                            return false;
                        }
                    });
                }
                {/if}
                
                
            }

            if(cansubmit && (op == '通过并提交复审' || op == '通过并提交收费' || op == '提交初审' || op == '提交复审' || op == '项目提交' || op == '收费')){
                if($("input[name=sendor]:checked").length == 0){
                    $.jBox.alert("请选择发送人",'提示');
                    cansubmit = false;
                }
            }

            if(!cansubmit){
                e.preventDefault();
            }else{
                
                $("#loading").show();
            }
        });
    
    });
    
</script>    