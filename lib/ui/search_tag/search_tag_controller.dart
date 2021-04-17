import 'package:blog_getx/model/article.dart';
import 'package:blog_getx/model/article_tags.dart';
import 'package:blog_getx/model/video.dart';
import 'package:blog_getx/model/video_tags.dart';
import 'package:blog_getx/repository/article_repository.dart';
import 'package:blog_getx/repository/video_repository.dart';
import 'package:get/get.dart';

class SearchTagController extends GetxController{
  var articles=new List<ArticleTags>().obs;
  var videos=new List<VideoTags>().obs;
  var tags="".obs;
  var page=0.obs;
  var page_vide=0.obs;
  VideoRepository videoRepository=Get.find<VideoRepository>();
  ArticleRepository articleRepository=Get.find<ArticleRepository>();
  var isLoadingArticle=true.obs;
  var isLoadingVideo=true.obs;
  var isNoMoreLoadArticle=false.obs;
  var isNoMoreLoadVideo=false.obs;


  void search(String tags){
    this.tags(tags);
    getArticle();
    getVideo();
  }


  void getArticle(){
    isLoadingArticle(true);
    page.value=1;
    articles.value=[];
    articleRepository.searchArticleByTags(tags.value, 1).then((value){
      articles.value=value;
      isLoadingArticle(false);
      if(value.length<10){
        isNoMoreLoadArticle(true);
      }
    });
  }


  void getVideo(){
    isLoadingVideo(true);
    page_vide.value=1;
    videos.value=[];
    videoRepository.searchTagsVideo(tags.value, 1).then((value){
      videos.value=value;
      isLoadingVideo(false);
      if(value.length<10){
        isNoMoreLoadVideo(true);
      }
    });
  }

  void onLoadMoreVideo(){
    page_vide.value=page_vide.value+1;
    videoRepository.searchTagsVideo(tags.value, page_vide.value).then((value){
      videos.value=[...videos.value,...value];
      if(value.isEmpty){
        isNoMoreLoadVideo(true);
      }
    });
  }

  void onLoadMoreArticle(){
    page.value=page.value+1;
    articleRepository.searchArticleByTags(tags.value, page.value).then((value){
      articles.value=[...articles.value,...value];
      if(value.isEmpty){
        isNoMoreLoadArticle(true);
      }
    });
  }






}