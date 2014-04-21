{include file="common/main_header.tpl"}
            <div class="row-fluid">
                <table class="maintain">
                    <tbody>
                    <tr>
                        <td><label class="required"><em></em><strong>录入类型</strong></label></td>
                        <td>{if $info['input_type'] == 0}正常登记{elseif $info['input_type'] == 1}补录登记{/if}</td>
                    </tr>
                    <tr class="bulu">
                        <td><label class="required"><em></em><strong>登记年月</strong></label></td>
                        <td>{$info['year']}年</td>
                    </tr>
                    <tr class="bulu">
                        <td><label class="required"><em></em><strong>登记月份</strong></label></td>
                        <td>{$info['month']}月份</td>
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
                        <td><label class="required"><em></em><strong>联系人名称</strong></label></td>
                        <td>{$info['contacter']|escape}</td>
                    </tr>
                    <tr>
                        <td><label class="required"><em></em><strong>联系人手机号码</strong></label></td>
                        <td>{$info['contacter_mobile']}</td>
                    </tr>
                        <tr>
                        <td><label class="optional"><em></em><strong>联系人固定号码</strong></label></td>
                        <td>{$info['contacter_tel']}</td>
                    </tr>
                    <tr>
                        <td><label class="required"><em></em><strong>接洽人名称</strong></label></td>
                        <td>{$info['manager']|escape}</td>
                    </tr>
                    <tr>
                        <td><label class="required"><em></em><strong>接洽人手机号码</strong></label></td>
                        <td>{$info['manager_mobile']}</td>
                    </tr>
                    <tr>
                        <td><label class="optional"><em></em><strong>接洽人固定号码</strong></label></td>
                        <td>{$info['manager_tel']}</td>
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
                        <td><label class="optional"><em></em><strong>登记人</strong></label></td>
                        <td>{$info['creator']}</td>
                    </tr>
                    <tr>
                        <td><label class="optional"><em></em><strong>登记时间</strong></label></td>
                        <td>{$info['createtime']|date_format:"Y-m-d H:i:s"}</td>
                    </tr>
                    <tr>
                        <td><label class="optional"><em></em><strong>最后修改人</strong></label></td>
                        <td>{$info['updator']}</td>
                    </tr>
                    <tr>
                        <td><label class="optional"><em></em><strong>最后修改时间</strong></label></td>
                        <td>{$info['updatetime']|date_format:"Y-m-d H:i:s"}</td>
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
{include file="common/main_footer.tpl"}