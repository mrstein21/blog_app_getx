
import 'package:blog_getx/ui/detail_article/detail_article_page.dart';
import 'package:blog_getx/ui/detail_video/detail_video_page.dart';
import 'package:blog_getx/ui/full_image_page.dart';
import 'package:blog_getx/ui/full_youtube_page.dart';
import 'package:blog_getx/ui/home/home_page.dart';
import 'package:blog_getx/ui/list_article/list_article_page.dart';
import 'package:blog_getx/ui/list_video/list_video_page.dart';
import 'package:blog_getx/ui/search/search_page.dart';
import 'package:blog_getx/ui/search_result/search_result_page.dart';
import 'package:blog_getx/ui/search_tag/search_tag_page.dart';
import 'package:blog_getx/ui/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class RouterGenerator{
  static const routeDetailArticle = "/article/detail";
  static const routeHome = "/home";
  static const routeSplash = "/splash";
  static const routeSearch= "/search";
  static const routeFullImage= "/full_image";
  static const routeFullYoutube= "/full_youtube";
  static const routeListArticle= "/article";
  static const routeListVideo= "/video";
  static const routeSearchResult= "/search_result";
  static const routeSearchByTags= "/search_by_tags";
  static const routeDetailVideo= "/video/detail";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Map<String,dynamic>params=settings.arguments as Map<String, dynamic>;
   if(settings.name==routeHome){
      return MaterialPageRoute(builder: (_) => HomePage());
    }else if(settings.name==routeDetailArticle) {
     return MaterialPageRoute(builder: (_) =>
         DetailArticlePage(
           article_id: params["article_id"],
         ));
   }else if(settings.name==routeSplash) {
      return MaterialPageRoute(builder: (_) =>
         SplashScreenPage());
    }else if(settings.name==routeListArticle){
     return MaterialPageRoute(builder: (_) =>
      ListArticlePage());
   }else if(settings.name==routeListVideo){
     return MaterialPageRoute(builder: (_) =>
         ListVideoPage());
   }else if(settings.name==routeDetailVideo){
     return MaterialPageRoute(builder: (_) =>
         DetailVideoPage(
           video_id: params["video_id"],
         ));
   }else if(settings.name==routeSearch){
     return MaterialPageRoute(builder: (_) =>
        SearchPage());
   }else if(settings.name==routeSearchResult){
     return MaterialPageRoute(builder: (_) =>
         SearchResultPage(
           keyword: params["keyword"],
         ));
   }else if(settings.name==routeFullImage){
      return MaterialPageRoute(builder: (_) => FullImagePage(
        url: params["url"],
      ));
    }else if(settings.name==routeFullYoutube){
      return MaterialPageRoute(builder: (_) => FullYoutubePage(
        url: params["url"],
      ));
    }else if(settings.name==routeSearchByTags){
     return MaterialPageRoute(builder: (_) => SearchTagsPage(
       tags: params["tags"],
       tags_name: params["tags_name"],
     ));
   }
  }
}