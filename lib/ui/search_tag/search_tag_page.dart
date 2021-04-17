import 'package:blog_getx/ui/search_tag/search_tag_controller.dart';
import 'package:blog_getx/ui/search_tag/widgets/tab_articles.dart';
import 'package:blog_getx/ui/search_tag/widgets/tab_videos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchTagsPage extends StatelessWidget {
  String tags;
  String tags_name;
  SearchTagsPage({
   this.tags,
    this.tags_name
  });
  SearchTagController searchTagController;
  @override
  Widget build(BuildContext context) {
    searchTagController=Get.find<SearchTagController>();
    searchTagController.search(tags);
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios,color: Colors.black,),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          titleSpacing: 0,
          title: Text(tags_name,style: TextStyle(color: Colors.black,fontFamily: "Roboto"),),
         ),
      body: Container(
        color: Colors.white,
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Material(
                color: Colors.white,
                elevation: 2,
                child: TabBar(
                    indicatorColor: Colors.black,
                    tabs: [
                      Tab(child: Text("Articles",style: TextStyle(color: Colors.black,fontFamily: "Roboto",fontWeight: FontWeight.bold),),),
                      Tab(child: Text("Videos",style: TextStyle(color: Colors.black,fontFamily: "Roboto",fontWeight: FontWeight.bold),),)
                    ]
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    TabArticles(),
                    TabVideos()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
}
