import 'package:blog_getx/mixins/server.dart';
import 'package:blog_getx/model/article.dart';
import 'package:blog_getx/model/article_tags.dart';
import 'package:blog_getx/routes.dart';
import 'package:blog_getx/ui/detail_article/detail_article_controller.dart';
import 'package:blog_getx/ui/detail_article/widgets/related_article_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailArticlePage extends StatelessWidget {
  var size;
  int article_id;
  double progress = 0;
  DetailArticlePage({
    this.article_id
  });
  DetailArticleController detailArticleController;

  @override
  Widget build(BuildContext context) {
    detailArticleController=Get.find<DetailArticleController>();
    detailArticleController.getArticle(article_id);
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: _buildDetail(),
    );
  }


  Widget _buildDetail() {
    return Obx(
        ()=>detailArticleController.isLoading==true?_buildLoading():SafeArea(
        child: NestedScrollView(
            headerSliverBuilder: (context, scroller) {
              return <Widget>[
                SliverAppBar(
                  leading: InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back_ios),
                  ),
                  actions: [
                    InkWell(
                      child: Icon(Icons.bookmark),
                    ),
                    SizedBox(width: 5,)
                  ],
                  titleSpacing: 0,
                  title: Text(
                    "",
                    style: TextStyle(fontFamily: "Roboto"),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expandedHeight: 240.0,
                  pinned: true,
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: _buildCover(detailArticleController.article.value),
                  ),
                )
              ];
            },
            body: Container(
              color: Colors.white,
              child: ListView(children: <Widget>[
                progress != 1.0
                    ? LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple))
                    : Container(
                  height: 0,
                ),
                // _buildRenderHtml2()
                _buildRenderHtml(detailArticleController.article.value.content),
                Obx(()=> detailArticleController.isLoadingRelated==true?Container():
                RelatedArticleSection(list: detailArticleController.related_article,))
              ]),
            )),
      ),
    );
  }


  Widget _buildRenderHtml(String content){
    return Padding(
        padding: EdgeInsets.all(8),
        child:HtmlWidget(
          content,
          customWidgetBuilder: (element){
            if(element.localName=="img" && element.attributes.containsKey("src")){
              return InkWell(
                child: Image.network(element.attributes["src"]),
                onTap: (){
                  Get.toNamed(RouterGenerator.routeFullImage,arguments: {
                    "url": element.attributes["src"]
                  });
                },
              );
              print("source element "+element.attributes["src"]);
            }else if(element.localName=="iframe" && element.attributes["src"].contains("youtube")){
              String url=element.attributes["src"];
              YoutubePlayerController _controller= YoutubePlayerController(
                  initialVideoId: YoutubePlayer.convertUrlToId(url),
                  flags: YoutubePlayerFlags(
                    autoPlay: false,
                  )
              );
              return YoutubePlayer(
                controller: _controller,
                bottomActions: [
                  const SizedBox(width: 14.0),
                  CurrentPosition(),
                  const SizedBox(width: 8.0),
                  ProgressBar(
                    isExpanded: true,
                  ),
                  RemainingDuration(),
                  InkWell(
                    onTap: (){
                      _controller.pause();
                      Get.toNamed(RouterGenerator.routeFullYoutube,arguments: {
                        "url": element.attributes["src"]
                      });
                    },
                    child: Icon(Icons.fullscreen,color: Colors.white,size: 20,),
                  ),

                ],
              );
            }
          },
          onTapUrl: (String url){
            print("click url "+url);
          ///  launchURL(url, context);
          },
          webViewJs: true,
          webView: true,
          unsupportedWebViewWorkaroundForIssue37: false,
        ));
  }


  Widget _buildCover(Article detailArticle) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(Server.url + detailArticle.image),
          )),
      child: Container(
        color: Colors.black.withOpacity(0.4),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(detailArticle.title,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 8,
            ),
            _buildTags(detailArticle.tags),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: CircleAvatar(
                        backgroundImage:
                        NetworkImage(Server.url + detailArticle.author.avatar),
                        radius: 50,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      detailArticle.author.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontSize: 14),
                    ),
                  ],
                ),
                Text(
                  detailArticle.date,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontSize: 14),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTags(List<ArticleTags> tags){
    return Wrap(
      children: tags.map<Widget>((e){
        return InkWell(
          onTap: (){
             Get.toNamed(RouterGenerator.routeSearchByTags,arguments: {
               "tags":e.topic.id.toString(),
               "tags_name":e.topic.topic_name
             });
            // Navigator.pushNamed(context, RouterGenerator.routeSearchByTags,
            //     arguments: {
            //       "tags":e.topic_id.toString(),
            //       "tags_name":e.topic.topic_name
            //     });
          },
          child: Container(
            margin: EdgeInsets.only(right: 4),
            padding: EdgeInsets.all(3),
            child: Text(e.topic.topic_name,style: TextStyle(fontSize: 12,fontFamily: "Roboto",color: Colors.white,fontWeight: FontWeight.bold),),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Colors.white)
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            height: 6,
          ),
          Text(
            "Loading..",
            style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 16,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
