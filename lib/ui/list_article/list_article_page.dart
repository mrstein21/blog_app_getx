import 'package:blog_getx/ui/list_article/list_article_controller.dart';
import 'package:blog_getx/ui/list_article/widgets/item_article.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListArticlePage extends StatelessWidget {
  ListArticleController arcController;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  ScrollController controller =ScrollController();

  void onScroll(){
    double maxScroll=controller.position.maxScrollExtent;
    double currentScroller=controller.position.pixels;
    if(maxScroll==currentScroller){
      arcController.loadMore();
    }
  }

  void _loadMore()async{
    arcController.loadMore();
    print("load more again");
  }

  void _refresh()async{
    print("referesh more again");
  }


  @override
  Widget build(BuildContext context) {
    arcController=Get.find<ListArticleController>();
    controller.addListener(onScroll);
    arcController.getArticle();
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
          ()=>arcController.isLoading==true?_buildLoading():ListView.builder(
              itemCount: arcController.isNoMoreLoad==true?arcController.list.length:
              arcController.list.length+1,
              controller: controller,
              itemBuilder: (ctx,index){
                if(index<arcController.list.length) {
                  return ItemArticle(article: arcController.list[index],);
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
