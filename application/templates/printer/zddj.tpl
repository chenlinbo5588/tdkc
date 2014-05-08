<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
        <title>{if !empty($info['title'])}{$info['title']}{else}{$info['name']}{/if}</title>
        <link rel="stylesheet" type="text/css" href="/css/printer.css" media="all" />
        <script type="text/javascript" src="/js/jquery-1.10.2.js"></script>
    </head>
    <body>
        <div class="container">
            <h1 class="title">宗地勘测定界报告</h1>
            <div>
                <div>
                    <p>慈溪市土地勘测规划设计院有限公司于{$info['createtime']|date_format:"Y年m月"}月</p>
                    <p>受慈溪市国土资源局及慈溪市{$info['region_name']}国土资源所委托，对</p>
                    <p>位于<strong>{$info['address']}</strong>的该宗地所在地块进行</p>
                    <p>土地勘测定界测量和属性、权属调查。经实地调查，</p>
                    <p>其征收土地总面积{$info['ch_area']},平面坐标为宁波独立坐标系，高程</p>
                    <p>基准为1985国家高程基准</p>
                </div>
                <div>
                    <h2>一、作业依据</h2>
                    <ul>
                        <li>1、GB/T 21010-2007中华人民共和国关于《土地利用现状分类》。</li>
                        <li>2、[2003] 《浙江省土地利用现状更新调查技术规范。</li>
                        <li>3、[2005] 《浙江省城市数字地籍调查暂行规定。</li>
                        <li>4、CJJ-99 城市测量规范。</li>
                        <li>5、[2003]宁波市控制测量技术补充规程(试行)》。</li>
                    </ul>
                    <h2>二、人员组成及仪器设备</h2>
                    <ul>
                        <li>1、本次作业根据任务情况，组织三名测绘技术人员（其中测绘助理工程师一名），技术员一名，测工一名，提供技术保障。</li>
                        <li>2、本次作业投入的仪器设备有拓普康全站仪一台采用全野外数字法观测、Trimble 5700 GPS RTK 仪器一套，投入的仪器设备均经过质检。电脑成图由“瑞德”软件及南方CASS6.0软件作为基本软件。</li>
                    </ul>
                    <h2>三、土地勘测定界情况</h2>
                    <ul>
                        <li>1、权属及地类调查</li>
                    </ul>
                </div>
            </div>
        </div>
    </body>
</html>