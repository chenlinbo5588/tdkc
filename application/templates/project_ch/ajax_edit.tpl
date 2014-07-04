<tr id="editrow_{$info['id']}">
                     <td></td>
                     <td>{$info['id']}</td>
                     <td>{$info['createtime']|date_format:"Y-m-d"}</td>
                     {include file="project_ch/fields_list.tpl"}
                    <td>
                        <div class="loading" style="display:none;"></div>
                        <div>
                            <input type="button" name="saveRow"  class="edit_save" value="保存"/>
                            <input type="button" name="cancelRow" class="edit_cancel" value="取消" />
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

                            if(cansubmit && $.trim($("input[name=manager]",newrow).val()) == ''){
                                alert("请输入接洽人名称");
                                cansubmit = false;
                                $("input[name=manager]",newrow).focus();
                            }

                            if(cansubmit && $.trim($("input[name=manager_mobile]",newrow).val()) == ''){
                                alert("请输入接洽人号码");
                                cansubmit = false;
                                $("input[name=manager_mobile]",newrow).focus();
                            }

                            if(cansubmit && $.trim($("input[name=address]",newrow).val()) == ''){
                                alert("请输入地址");
                                cansubmit = false;
                                $("input[name=address]",newrow).focus();
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


                            if(cansubmit && $.trim($("input[name=end_date]",newrow).val()) == ''){
                                alert("请输入要求完成时间");
                                cansubmit = false;
                                $("input[name=end_date]",newrow).focus();
                            }

                            if(cansubmit){
                                that.prop("disabled",true);

                                $(".loading",newrow).show();
                                $.ajax({
                                    type:"POST",
                                    url:"{url_path('project_ch','edit')}",
                                    data : {
                                        isajax:"1",
                                        id:"{$info['id']}",
                                        name:$("input[name=name]",newrow).val(),
                                        type_id: $("select[name=type_id]",newrow).val(),
                                        manager:$("input[name=manager]",newrow).val(),
                                        manager_mobile: $("input[name=manager_mobile]",newrow).val(),
                                        region_code: $("select[name=region_code]",newrow).val(),
                                        address: $("input[name=address]",newrow).val(),
                                        contacter:$("input[name=contacter]",newrow).val(),
                                        contacter_mobile: $("input[name=contacter_mobile]",newrow).val(),
                                        pm_id:$("select[name=pm_id]",newrow).val(),
                                        end_date:$("input[name=end_date]",newrow).val(),
                                        descripton:$("input[name=descripton]",newrow).val(),
                                        has_doc:$("select[name=has_doc]",newrow).val()
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