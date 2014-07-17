                                if(cansubmit){
                                    $("input[name='size[]']").each(function(){
                                        if($(this).val() == ''){
                                            cansubmit = false;
                                            alert("请输入规格");
                                            $(this).focus();
                                            return false;
                                        }
                                    });
                                }

                                if(cansubmit){
                                    $("input[name='num[]']").each(function(){
                                        if(!/^[0-9]+$/.test($(this).val())){
                                            cansubmit = false;
                                            alert("请输入数量");
                                            $(this).focus();
                                            return false;
                                        }
                                    });
                                }
                                if(cansubmit){
                                    $("input[name='price[]']").each(function(){
                                        if(!/^[0-9]+(.[0-9]+)?$/.test($(this).val())){
                                            cansubmit = false;
                                            alert("请输入合法的价格");
                                            $(this).focus();
                                            return false;
                                        }
                                    });
                                }

                                if(cansubmit){
                                    $("input[name='charge_make[]']").each(function(){
                                        if(!/^[0-9]+(.[0-9]+)?$/.test($(this).val())){
                                            cansubmit = false;
                                            alert("请输入合法的制作费");
                                            $(this).focus();
                                            return false;
                                        }
                                    });
                                }