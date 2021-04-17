import 'package:blog_getx/routes.dart';
import 'package:blog_getx/ui/home/home_controller.dart';
import 'package:blog_getx/ui/home/widgets/article_section.dart';
import 'package:blog_getx/ui/home/widgets/loading_article_section.dart';
import 'package:blog_getx/ui/home/widgets/loading_video_section.dart';
import 'package:blog_getx/ui/home/widgets/video_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomeController homeController;
  @override
  Widget build(BuildContext context) {
    homeController=Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          "assets/logo.png",
          height: 60,
        ),
        actions: <Widget>[
          InkWell(
              onTap: () {
                Get.toNamed(RouterGenerator.routeSearch);
               // Navigator.pushNamed(context, RouterGenerator.routeSearch);
              },
              child: Icon(Icons.search)),
          SizedBox(width: 5),
          InkWell(
            child: Icon(Icons.bookmark),
          ),
          SizedBox(width: 3),
        ],
      ),
      body: _buildLoaded()
    );
  }

  Widget _buildLoaded(){
    return  Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Video",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    fontSize: 18),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(RouterGenerator.routeListVideo);
                 // Navigator.pushNamed(context, RouterGenerator.routeListVideo);
                },
                child: Text(
                  "More",
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
           Obx(()=>homeController.isLoadingVideo==true?
               LoadingVideoSection():VideoSection(video: homeController.video,)
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Latest Article",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    fontSize: 18),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(RouterGenerator.routeListArticle);
                 // Navigator.pushNamed(context, RouterGenerator.routeListArticle);
                },
                child: Text(
                  "More",
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Obx(()=>homeController.isLoading==true?LoadingArticle():
             ArticleSection(
              list: homeController.article,
            ),
          ),
        ],
      ),
    );
  }
}
