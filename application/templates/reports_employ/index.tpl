{include file="common/main_header.tpl"}
            <div class="searchform row-fluid">
                <form action="{url_path('reports_employ','index')}" method="post" name="searchform" target="post_iframe">
                    <input type="hidden" value="reports_employ" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <input type="submit" name="submit" class="btn btn-primary" value="导出Excel"/>
                        </li>
                        <li>
                            <ol>
                                <li><label><input type="checkbox" name="field[]" checked value="name"/>姓名</label></li>
                                <li><label><input type="checkbox" name="field[]" checked value="id_card"/>身份证号码</label></li>
                                <li><label><input type="checkbox" name="field[]" checked value="sex"/>性别</label></li>
                                <li><label><input type="checkbox" name="field[]" checked value="huji"/>户籍</label></li>
                                <li><label><input type="checkbox" name="field[]" checked value="birthday"/>出生年月</label></li>
                                <li><label><input type="checkbox" name="field[]" checked value="mobile"/>手机号码</label></li>
                                <li><label><input type="checkbox" name="field[]" checked value="virtual_no"/>虚拟号</label></li>
                                <li><label><input type="checkbox" name="field[]" checked value="tel"/>座机号码（宅)</label></li>
                                <li><label><input type="checkbox" name="field[]" checked value="address"/>家庭地址</label></li>
                                <li><label><input type="checkbox" name="field[]" checked value="edu"/>学历</label></li>
                                <li><label><input type="checkbox" name="field[]" checked value="school_name"/>毕业院校</label></li>
                                <li><label><input type="checkbox" name="field[]" checked value="graduation_date"/>毕业时间</label></li>
                                <li><label><input type="checkbox" name="field[]" checked value="major"/>专业</label></li>
                                <li><label><input type="checkbox" name="field[]" checked value="job_title"/>职称</label></li>
                                <li><label><input type="checkbox" name="field[]" checked value="title_time"/>取得时间</label></li>
                                <li><label><input type="checkbox" name="field[]" checked value="enter_date"/>入院时间</label></li>
                                <li><label><input type="checkbox" name="field[]" checked value="contract_year"/>合同年限</label></li>
                                <li><label><input type="checkbox" name="field[]" checked value="contract_start"/>合同履行时间开始</label></li>
                                <li><label><input type="checkbox" name="field[]" checked value="contract_end"/>合同履行时间结束</label></li>
                            </ol>
                         </li>
                     </ul>
                </form>
            </div>
                            
            <iframe name="post_iframe" frameborder="0" height="0" width="0"></iframe>             
            <div class="span12">
                
             </div>
             {include file="common/calendar.tpl"}
{include file="common/main_footer.tpl"}