import 'package:blog_getx/model/article.dart';
import 'package:blog_getx/model/video.dart';
import 'package:blog_getx/repository/article_repository.dart';
import 'package:blog_getx/repository/video_repository.dart';
import 'package:get/get.dart';

class SearchResultController extends GetxController{
  var articles=new List<Article>().obs;
  var videos=new List<Video>().obs;
  var page=0.obs;
  var page_vide=0.obs;
  VideoRepository videoRepository=Get.find<VideoRepository>();
  ArticleRepository articleRepository=Get.find<ArticleRepository>();
  var isLoadingArticle=true.obs;
  var isLoadingVideo=true.obs;
  var isNoMoreLoadArticle=false.obs;
  var isNoMoreLoadVideo=false.obs;
  var keyword="".obs;

  void getArticle(){
    isLoadingArticle(true);
    page.value=1;
    articles.value=[];
    articleRepository.searchArticle(keyword.value, 1).then((value){
      articles.value=value;
      isLoadingArticle(false);
      if(value.length<10){
        isNoMoreLoadArticle(true);
      }
    });
  }

  void search(String keyword){
    this.keyword(keyword);
    getVideo();
    getArticle();

  }

  void getVideo(){
    isLoadingVideo(true);
    page_vide.value=1;
    videos.value=[];
    videoRepository.searchVideo(keyword.value, 1).then((value){
      videos.value=value;
      isLoadingVideo(false);
      if(value.length<10){
        isNoMoreLoadVideo(true);
      }
    });
  }

  void onLoadMoreVideo(){
    page_vide.value=page_vide.value+1;
     videoRepository.searchVideo(keyword.value, page_vide.value).then((value){
      videos.value=[...videos.value,...value];
      if(value.isEmpty){
        isNoMoreLoadVideo(true);
      }
    });
  }

  void onLoadMoreArticle(){
    page.value=page.value+1;
    articleRepository.searchArticle(keyword.value, page.value).then((value){
      articles.value=[...articles.value,...value];
      if(value.isEmpty){
        isNoMoreLoadArticle(true);
      }
    });
  }

}