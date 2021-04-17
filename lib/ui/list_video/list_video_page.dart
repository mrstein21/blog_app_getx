import 'package:blog_getx/ui/list_article/list_article_controller.dart';
import 'package:blog_getx/ui/list_article/widgets/item_article.dart';
import 'package:blog_getx/ui/list_video/list_video_controller.dart';
import 'package:blog_getx/ui/list_video/widgets/item_vide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListVideoPage extends StatelessWidget {
  ListVideoController videoController;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  ScrollController controller =ScrollController();

  void onScroll(){
    double maxScroll=controller.position.maxScrollExtent;
    double currentScroller=controller.position.pixels;
    if(maxScroll==currentScroller){
      videoController.loadMore();
    }
  }




  @override
  Widget build(BuildContext context) {
    videoController=Get.find<ListVideoController>();
    controller.addListener(onScroll);
    videoController.getVido();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios),),
        title: Text("Latest Article",style: TextStyle(fontFamily: "Roboto",fontWeight: FontWeight.bold),),
      ),
      body: Container(
        padding: EdgeInsets.all(9),
        child: Obx(
                ()=>videoController.isLoading==true?_buildLoading():ListView.builder(
                itemCount: videoController.isNoMoreLoad==true?videoController.list.length:
                videoController.list.length+1,
                controller: controller,
                itemBuilder: (ctx,index){
                  if(index<videoController.list.length) {
                    return ItemVideo(video: videoController.list[index],);
                  }else{
                    return _buildLoading();
                  }
                }
            )
        ),
      ),
    );
  }

  Widget _buildLoading(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

}
