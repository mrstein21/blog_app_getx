import 'package:blog_getx/model/article.dart';
import 'package:blog_getx/model/video.dart';
import 'package:blog_getx/repository/article_repository.dart';
import 'package:blog_getx/repository/video_repository.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  var isLoading=true.obs;
  var isLoadingVideo=true.obs;
  List<Article>article=new List<Article>().obs;
  List<Video>video=new List<Video>().obs;
  var articleRepository=Get.find<ArticleRepository>();
  var videoRepository=Get.find<VideoRepository>();

  /// fungsi ini dijalankan setelah mendeklarasikan controller home,fungsi ini dijalankan satu kali saja
  /// bahkan ketika di redirect ke home kembali pun tidak akan dieksekusi kembali,terkeculi jika anda
  /// keluar app maka fungsi ini akan dijalankan kembali
  @override
  void onInit() {
    getArticle();
    getVideo();
    // TODO: implement onInit
    super.onInit();
  }

  void getArticle(){
    articleRepository.getAllArticle(1).then((value){
      article=value;
      isLoading(false);
    });
  }

  void getVideo(){
    videoRepository.getAllVideo(1).then((value){
      video=value;
      isLoadingVideo(false);
    });
  }


}