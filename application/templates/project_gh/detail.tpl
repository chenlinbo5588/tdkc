            <div class="pd20">
                <table class="maintain">
                    <tbody>
                    <tr>
                        <td><label class="required"><em></em><strong>录入类型</strong></label></td>
                        <td>{if $info['input_type'] == 0}正常登记{elseif $info['input_type'] == 1}补录登记{/if}</td>
                    </tr>
                    <tr>
                        <td><label class="required"><em></em><strong>登记年月</strong></label></td>
                        <td>{$info['year']}年{$info['month']}月份</td>
                    </tr>
                    <tr>
                        <td><label class="required"><em></em><strong>区域</strong></label></td>
                        <td>{$info['region_name']}</td>
                    </tr>
                    <tr>
                        <td><label class="required"><em></em><strong>登记类型</strong></label></td>
                        <td>{$info['type']}</td>
                    </tr>
                    <tr>
                        <td><label class="required"><em></em><strong>登记名称</strong></label></td>
                        <td>{$info['name']|escape}</td>
                    </tr>
                    <tr>
                        <td><label class="required"><em></em><strong>地址</strong></label></td>
                        <td>{$info['address']|escape}</td>
                    </tr>
                    <tr>
                        <td><label class="optional"><em></em><strong>村名</strong></label></td>
                        <td>{$info['village']|escape}</td>
                    </tr>
                    <tr>
                        <td><label class="required"><em></em><strong>联系人信息</strong></label></td>
                        <td>姓名:{$info['contacter']|escape} 手机号码:{$info['contacter_mobile']} 固定号码:{$info['contacter_tel']}</td>
                    </tr>
                    
                    <tr>
                        <td><label class="required"><em></em><strong>接洽人信息</strong></label></td>
                        <td>姓名:{$info['manager']|escape} 手机号码:{$info['manager_mobile']} 固定号码:{$info['manager_tel']}</td>
                    </tr>
                    <tr>
                        <td><label class="optional"><em></em><strong>备注</strong></label></td>
                        <td>{$info['descripton']}</td>
                    </tr>
                    <tr>
                        <td><label class="optional"><em></em><strong>优先级</strong></label></td>
                        <td>{$info['displayorder']}</td>
                    </tr>
                    <tr>
                        <td><label class="optional"><em></em><strong>登记信息</strong></label></td>
                        <td>登记人姓名:{$info['creator']} 登记时间：{$info['createtime']|date_format:"Y-m-d H:i:s"}</td>
                    </tr>
                    
                    <tr>
                        <td><label class="optional"><em></em><strong>最后修改</strong></label></td>
                        <td>修改人：{$info['updator']} 修改时间:{$info['updatetime']|date_format:"Y-m-d H:i:s"}</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            {*<input type="submit" name="submit" class="btn btn-sm btn-primary" value="保存"/>
                            <input type="reset" name="reset" class="btn btn-sm btn-default" value="重置"/>*}</td>
                    </tr>
                    </tbody>
                </table>
                <script>
                    $(function(){
                    
                        
                    });
                </script>
            </div>