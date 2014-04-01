{include file="common_header.tpl"}
                    <section>
                        <div class="slider_wrapper">
                            <div class="slider" id="scrollImg" style="height:750px;">
                                <div class="slider_item" style="background:url(/img/news/banner1.jpg) no-repeat 50% 50%;"></div>
                            </div>
                        </div>
                        <div class="news clearfix">
                            <div class="news_text"></div>
                            <div class="news_list">
                                {foreach from=$list item=item}<article>
                                    <div class="news_item clearfix">
                                        <a class="news_cover" href="{$item['detail_url']}"><img src="{if empty($item['cover_img'])}/img/default_pic.jpg{else}/img/Files/{$item['cover_img']}{/if}"/></a>
                                        <div class="news_short">
                                            <a class="title" href="{$item['detail_url']}">{$item['title']}</a>
                                            <p>{$item['content']|cutText:200}</p>
                                            <a class="see_detail" href="{$item['detail_url']}">查看详情&gt;&gt;</a>
                                        </div>
                                    </div>    
                                </article>
                                {/foreach}
                                {*<article>
                                    <div class="news_item clearfix">
                                        <a class="news_cover" href="javascript:void(0);"><img src="/img/join_us/shop_sample.png"/></a>
                                        <div class="news_short">
                                            <a class="title" href="javascript:void(0);">热爱传递 为荣耀无惧挑战</a>
                                            <p>11月30日下午16时，****中国排球联赛2013-2014赛季（以下简称"排球联赛"）于深圳拉开战幕，国家体育总局排球运动管理中心副主任李全强、竞赛部部长蔡毅及品牌传播中心总监赵峰……  </p>
                                            <a class="see_detail" href="javascript:void(0);">查看详情&gt;&gt;</a>
                                        </div>
                                    </div>    
                                </article>
                                <article>
                                    <div class="news_item clearfix">
                                        <a class="news_cover" href="javascript:void(0);"><img src="/img/join_us/shop_sample.png"/></a>
                                        <div class="news_short">
                                            <a class="title" href="javascript:void(0);">热爱传递 为荣耀无惧挑战</a>
                                            <p>11月30日下午16时，****中国排球联赛2013-2014赛季（以下简称"排球联赛"）于深圳拉开战幕，国家体育总局排球运动管理中心副主任李全强、竞赛部部长蔡毅及品牌传播中心总监赵峰……  </p>
                                            <a class="see_detail" href="javascript:void(0);">查看详情&gt;&gt;</a>
                                        </div>
                                    </div>    
                                </article>*}
                                {include file="pagination_front.tpl"}
                            </div>

                            <div class="lastest_act">
                                <aside>
                                    <div class="act_item first">
                                        <a target="_blank" href="http://weibo.com/f1saiche"><img src="/img/news/f1.png"/></a>
                                        <p>最新赛事</p>
                                    </div>
                                    <div class="act_item atp">
                                        <a target="_blank" href="http://weibo.com/shanghairolexmasters"><img src="/img/news/atp.png"/></a>
                                        <p>最新赛事</p>
                                    </div>
                                </aside>
                            </div>
                        </div>
                    </section>
                    <script src="/js/jquery-1.9.1.min.js"></script>
                    <script src="/js/jquery.cycle.all.js"></script>
                    <script>
                        $('#scrollImg').cycle({
                            fx:"fade",
                            timeout: 5000,
                            center:true,
                            pause:false,
                            pagerEvent: "click.cycle"
                        });
                    </script>
{include file="common_footer.tpl"}