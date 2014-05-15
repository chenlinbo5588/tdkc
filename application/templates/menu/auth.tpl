{include file="common/main_header.tpl"}
            <div class="span12">
                {form_error('auth_key[]')}
                <form name="authForm" action="{$actionUrl}" method="post">
                    <input type="hidden" name="id" value="{$info['id']}"/>

                    <table class="table">
                        <thead>
                            <tr>
                                <th style="width:60px;"><input type="checkbox" name="checkall" value=""/></th>
                                <th>菜单名称</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$data item=item}
                            <tr id="row_{$item['id']}">
                                <td><input type="checkbox" name="auth_key[]" value="{$item['auth_key']}" {if in_array($item['auth_key'],$existsAuth)}checked{/if}></td>
                                <td>{$item['sep']}{$item['name']}</td>
                            </tr>
                            {/foreach}
                        </tbody>
                    </table>
                    <div>
                        <input type="submit" name="submit" class="btn btn-sm btn-primary" value="保存"/>
                    </div>
                </form>
            </div>
            
            <script>
                $(function(){
                    {if $feedMessage}
                        alert('{$feedMessage}');
                        location.href="{$redirectUrl}";
                    {/if}
                    
                    $("input[name=checkall]").bind("click",function(){
                        var checkboxs = $(".table tbody input[type=checkbox]");
                        var allchecked = $(this).prop("checked");
                        
                        checkboxs.each(function(){
                            if($(this).prop("checked") && !allchecked){
                                $(this).prop("checked",false)
                            }
                            
                            if(!$(this).prop("checked") && allchecked){
                                $(this).prop("checked",true);
                            }
                            
                        });
                    });
                
                    $(".table tr").each(function(index){
                        $("td:eq(1)",this).bind("click",function(e){
                            var checkbox = $(this).closest("tr").find("input[type=checkbox]:eq(0)");

                            if(checkbox.prop("checked")){
                                checkbox.prop("checked",false);
                            }else{
                                checkbox.prop("checked",true);
                            }
                        });
                    });
                    
                });
            </script>
{include file="common/main_footer.tpl"}