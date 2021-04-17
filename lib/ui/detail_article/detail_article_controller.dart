import 'dart:convert';
import 'package:blog_getx/model/article.dart';
import 'package:blog_getx/model/article_tags.dart';
import 'package:blog_getx/repository/article_repository.dart';
import 'package:get/get.dart';

class DetailArticleController extends GetxController{
  var isLoading=true.obs;
  var isLoadingRelated=true.obs;
  var article=new Article().obs;
  List<ArticleTags>related_article=new List<ArticleTags>().obs;
  ArticleRepository repository=Get.find<ArticleRepository>();

  void getArticle(int article_id){
    isLoading(true);
    repository.getDetailArticle(article_id).then((value){
      article=value.obs;
      List<String>topics_id=new List<String>();
      for(int i=0;i<value.tags.length;i++){
        topics_id.add(value.tags[i].topic_id.toString());
      }
      var body=json.encode({
        "topic_id":topics_id,
        "article_id":article_id.toString()
      });
      isLoading(false);
      getRelatedArticle(body);
    });
  }

  void getRelatedArticle(var body){
    isLoadingRelated(true);
    repository.getRelatedArticle(body).then((value){
      related_article=value;
      isLoadingRelated(false);
    });
  }

}