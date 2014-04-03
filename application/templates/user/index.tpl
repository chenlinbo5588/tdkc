{include file="common/header.tpl"}
        <div class="row-fluid">
            <ul class="breadcrumb">
				<li>
					<a href="#">系统管理</a> <span class="divider"></span>
				</li>
				<li>
					<a href="#">用户管理</a> <span class="divider"></span>
				</li>
				<li class="active">
					主题
				</li>
			</ul>
            
            <div class="row-fluid">
                <form action="{url_path('user')}" method="get" name="search">
                    <input type="hidden" value="user" name="{config_item('controller_trigger')}"/>
                    <input type="hidden" value="index" name="{config_item('function_trigger')}"/>
                    <ul>
                        <li>
                            <label><strong>工号</strong><input type="text" name="gh" value="{$smarty.get.gh}" placeholder="请输入工号"/></label>
                            <label><strong>姓名</strong><input type="text" name="name" value="{$smarty.get.name}" placeholder="请输入用户姓名"/></label>
                            <label><strong>包含删除</strong>
                                <select name="inc_del" >
                                    <option value="否">否</option>
                                    <option value="是">是</option>
                                </select>
                            </label>
                            <input type="submit" name="submit" class="btn btn-primary" value="查询"/>
                        </li>
                     </ul>
                </form>
                
               <a href="{url_path('user','add')}">添加员工</a>
            </div>
            
            
            <div class="span12">
                <table class="table">
                    <thead>
                        <tr>
                            <th>工号</th>
                            <th>姓名</th>
                            <th>登陆账号</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach from=$data['data'] item=item}
                        <tr>
                           <td>{$item['gh']}</td>
                           <td>{$item['name']|escape}</td>
                           <td>{$item['account']}</td>
                           <td>{$item['status']}</td>
                           <td>
                               <a href="#">编辑</a>
                               <a href="#">锁定</a>
                               <a href="#">删除</a>
                           </td>
                        </tr>
                        {foreachelse}
                            <tr>
                                <td colspan="6">还没有员工 <a href="#">点击开始添加员工</a></td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
                {include file="pagination_front.tpl"}
             </div>
        </div>
    
{include file="common/footer.tpl"}