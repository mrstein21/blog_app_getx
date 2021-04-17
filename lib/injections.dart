import 'package:blog_getx/repository/article_repository.dart';
import 'package:blog_getx/repository/video_repository.dart';
import 'package:blog_getx/ui/detail_article/detail_article_controller.dart';
import 'package:blog_getx/ui/detail_video/detail_video_controller.dart';
import 'package:blog_getx/ui/home/home_controller.dart';
import 'package:blog_getx/ui/list_article/list_article_controller.dart';
import 'package:blog_getx/ui/list_video/list_video_controller.dart';
import 'package:blog_getx/ui/search/search_controller.dart';
import 'package:blog_getx/ui/search_result/search_result_controller.dart';
import 'package:blog_getx/ui/search_tag/search_tag_controller.dart';
import 'package:get/get.dart';

void setupInjections(){
  //repository
  Get.put(VideoRepository());
  Get.put(ArticleRepository());

  //controller getX
  Get.put(HomeController());
  Get.put(DetailArticleController());
  Get.put(DetailVideoController());
  Get.put(ListArticleController());
  Get.put(ListVideoController());
  Get.put(SearchResultController());
  Get.put(SearchTagController());
  Get.put(SearchController());
}