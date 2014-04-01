{include file="common_header.tpl"}
                    <section>
                        <div class="slider_wrapper">
                            <div class="slider" id="scrollImg" style="height:750px;">
                                <div class="slider_item" style="background:url(/img/news/banner1.jpg) no-repeat 50% 50%;"></div>
                            </div>
                        </div>
                        <div id="news_detail" class="clearfix">
                            <div class="news_text"></div>
                            <div class="news_detail">
                                <article>
                                    <div class="title">
                                        <hgroup>
                                            <h1>{$data['title']}</h1>
                                            <h2>{$data['title2']}</h2>
                                        <hgroup>
                                    </div>
                                    <div id="new_content">{$data['content']}</div>
                                    <a class="goback" href="javascript:history.go(-1);"><em>返&nbsp;回</em></a>
                                </article>
                            </div>
                        </div>
                    </section>
{include file="common_footer.tpl"}