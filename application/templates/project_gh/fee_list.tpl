                <tr>
                    <td>费用明细</td>
                    <td>
                        {if $info['status'] == '项目已提交'}<a class="link_btn" id="addFeeItem" href="javascript:void(0);">+增加费用明细</a>{/if}
                        <table id="feetb">
                            <thead>
                                <th>规格</th>
                                <th>数量</th>
                                <th>单价</th>
                                <th>制作费</th>
                                <th>小计</th>
                                <th>备注</th>
                                <th>操作</th>
                            </thead>
                            <tbody>
                                {if $info['status'] == '项目已提交'}
                                {if empty($feeList)}
                                <tr>
                                    <td><input type="text" name="size[]" style="width:100px;" value=""/></td>
                                    <td><input type="text" name="num[]" style="width:60px;" value="1"/></td>
                                    <td><input type="text" name="price[]" style="width:60px;" value="0.00"/></td>
                                    <td><input type="text" name="charge_make[]" style="width:60px;" value="0.00"/></td>
                                    <td class="subtotal">0.00</td>
                                    <td><input type="text" name="remark[]" style="width:150px;" value=""/></td>
                                    <td>
                                        <a href="javascript:void(0);" class="feeDel">删除</a>
                                    </td>
                                </tr>
                                {/if}
                                {foreach from=$feeList key=key item=item}
                                 <tr>
                                    <td><input type="text" name="size[]" style="width:100px;" value="{$item['size']}"/></td>
                                    <td><input type="text" name="num[]" style="width:60px;" value="{$item['num']}"/></td>
                                    <td><input type="text" name="price[]" style="width:60px;" value="{$item['price']}"/></td>
                                    <td><input type="text" name="charge_make[]" style="width:60px;" value="{$item['charge_make']}"/></td>
                                    <td class="subtotal">{$item['num'] * $item['price'] + $item['charge_make']}</td>
                                    <td><input type="text" name="remark[]" style="width:150px;" value="{$item['remark']|escape}"/></td>
                                    <td>
                                        <a href="javascript:void(0);" class="feeDel">删除</a>
                                    </td>
                                </tr>
                                {/foreach}
                                {else}
                                 {foreach from=$feeList key=key item=item}
                                 <tr>
                                    <td>{$item['size']}</td>
                                    <td>{$item['num']}</td>
                                    <td>{$item['price']}</td>
                                    <td>{$item['charge_make']}</td>
                                    <td class="subtotal">{$item['num'] * $item['price'] + $item['charge_make']}</td>
                                    <td>{$item['remark']|escape}</td>
                                    <td></td>
                                </tr>
                                 {/foreach}
                                {/if}
                            </tbody>
                        </table>
                    </td>
                </tr>
                
                <script type="x-my-template" id="feeRowTemplate">
                    <tr>
                        <td><input type="text" name="size[]" style="width:100px;" value=""/></td>
                        <td><input type="text" name="num[]" style="width:60px;" value="1"/></td>
                        <td><input type="text" name="price[]" style="width:60px;" value="0.00"/></td>
                        <td><input type="text" name="charge_make[]" style="width:60px;" value="0.00"/></td>
                        <td class="subtotal">0.00</td>
                        <td><input type="text" name="remark[]" style="width:150px;" value=""/></td>
                        <td>
                            <a href="javascript:void(0);" class="feeDel">删除</a>
                        </td>
                    </tr>
                </script>
<script>
    $(function(){
        var feeBody = $("#feetb tbody");
        
        $("#addFeeItem").bind("click",function(e){
            var feeRow = $($("#feeRowTemplate").html());
            feeBody.append(feeRow);
        });
            
        $("#feetb").delegate(".feeDel","click",function(e){
            $(this).closest("tr").remove();
        });
        
        $("#feetb").delegate("input[type=text]",'change', function(e){
            var that = $(e.target);
            var tr = that.closest("tr");
            
            var num = tr.find("input[name='num[]']").val();
            var price = tr.find("input[name='price[]']").val();
            var charge_make = tr.find("input[name='charge_make[]']").val();
            
            if(!/^[0-9]+$/.test(num)){
                num = 0;
            }
            
            if(!/^[0-9]+(.[0-9]+)?$/.test(price)){
                price = 0;
            }
            
            if(!/^[0-9]+(.[0-9]+)?$/.test(charge_make)){
                charge_make = 0;
            }
            
            var subtotal = parseInt(num) * parseFloat(price) + parseFloat(charge_make);
            tr.find(".subtotal").html(subtotal.toFixed(2));
        });
    });
    
</script>