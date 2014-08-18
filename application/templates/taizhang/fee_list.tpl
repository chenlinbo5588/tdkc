        <table class="maintain border1">
            <tbody>
                <tr>
                    <td>单位名称</td>
                    <td>{$info['name']|escape}</td>
                </tr>
                <tr>
                    <td>项目负责人</td>
                    <td>{$info['pm']|escape}</td>
                </tr>
                <tr>
                    <td>项目完成时间</td>
                    <td>
                        <input type="text"  name="complete_time" class="Wdate" readonly onclick="WdatePicker()" value="{$info['complete_time']|date_format:"Y-m-d"}" placeholder="项目完成时间"/>
                    </td>
                </tr>
                <tr>
                    <td>成果资料领取</td>
                    <td>
                        <label><input type="radio" name="get_doc" value="1" {if $info['get_doc'] == 1}checked{/if}>已领取</label>
                        <label><input type="radio" name="get_doc" value="0" {if $info['get_doc'] == 0}checked{/if}>未领取</label>
                    </td>
                </tr>
                <tr>
                    <td>成果资料领取时间</td>
                    <td>
                        <input type="text"  name="get_doctime" class="Wdate" readonly onclick="WdatePicker()" value="{$info['get_doctime']|date_format:"Y-m-d"}" placeholder="成果资料领取时间"/>
                    </td>
                </tr
                <tr>
                    <td>成果资料领取人姓名</td>
                    <td>
                        <input type="text" name="get_owner" value="{$info['get_owner']|escape}"/>
                    </td>
                </tr>
                <tr>
                    <td>成果资料领取人联系号码</td>
                    <td>
                        <input type="text" name="owner_tel" value="{$info['owner_tel']|escape}"/>
                    </td>
                </tr>
                <tr>
                    <td>考核金额</td>
                    <td>
                        <input type="text" name="kh_amount" value="{$info['kh_amount']}"/>
                    </td>
                </tr>
                <tr>
                    <td>应收金额</td>
                    <td>
                        <input type="text" name="ys_amount" value="{$info['ys_amount']}"/>
                    </td>
                </tr>
                <tr>
                    <td>实收金额</td>
                    <td>
                        <input type="text" name="ss_amount" value="{$info['ss_amount']}"/>
                    </td>
                </tr>
                {*
                <tr>
                    <td>欠费情况</td>
                    <td>
                        <label><input type="radio" name="is_owed" value="0" {if $info['is_owed'] == 0}checked{/if}/>不欠费</label>
                        <label><input type="radio" name="is_owed" value="1" {if $info['is_owed'] == 1}checked{/if}/>欠费</label>
                    </td>
                </tr>
                
                <tr>
                    <td>是否政府挂账</td>
                    <td>
                        <label><input type="radio" name="is_gov" value="0" {if $info['is_gov'] == 0}checked{/if}/>否</label>
                        <label><input type="radio" name="is_gov" value="1" {if $info['is_gov'] == 1}checked{/if}/>是</label>
                    </td>
                </tr>
                *}
                <tr>
                    <td>收费情况</td>
                    <td>
                        <label><input type="radio" name="fee_type" value="1" {if $info['fee_type'] == 1}checked{/if}/>挂账</label>
                        <label><input type="radio" name="fee_type" value="2" {if $info['fee_type'] == 2}checked{/if}/>票开款收</label>
                        <label><input type="radio" name="fee_type" value="3" {if $info['fee_type'] == 3}checked{/if}/>票开款未收</label>
                        <label><input type="radio" name="fee_type" value="4" {if $info['fee_type'] == 4}checked{/if}/>票未开款收</label>
                    </td>
                </tr>
                <tr>
                    <td>备注</td>
                    <td>
                        <textarea name="remark" style="width:100%;height:50px;">{$info['remark']|escape}</textarea>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <input type="submit" name="submit" class="btn btn-orange" value="保存"/>
                        <div class="loading" style="display:none;"></div>
                    </td>
                </tr>
            </tbody>
        </table>