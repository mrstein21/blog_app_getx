import 'package:blog_getx/ui/list_article/widgets/item_article.dart';
import 'package:blog_getx/ui/search_result/search_result_controller.dart';
import 'package:blog_getx/ui/search_tag/search_tag_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabArticles extends StatelessWidget {
  SearchTagController searchTagController;
  ScrollController controller =ScrollController();

  void onScroll(){
    double maxScroll=controller.position.maxScrollExtent;
    double currentScroller=controller.position.pixels;
    if(maxScroll==currentScroller){
      searchTagController.onLoadMoreArticle();
    }
  }

  @override
  Widget build(BuildContext context) {
    searchTagController=Get.find<SearchTagController>();
    controller.addListener(onScroll);
    return Container(
      padding: EdgeInsets.all(10),
      child: _buildListArticle(),
    );
  }

  Widget _buildListArticle(){
    return Obx(
          ()=>searchTagController.isLoadingArticle==true?
      _buildLoading():
      searchTagController.articles.isEmpty?
      _buildMessageEmpty():
      ListView.builder(
          controller: controller,
          itemCount: searchTagController.isNoMoreLoadArticle==true?
          searchTagController.articles.length:searchTagController.articles.length+1,
          itemBuilder: (contet,index){
            if(index<searchTagController.articles.length){
              return ItemArticle(article: searchTagController.articles[index].article,);
            }else{
              return _buildLoading();
            }
          }
      ),
    );
  }

  Widget _buildMessageEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.search,
              color: Colors.grey,
              size: 70,
            ),
            Text(
              "Pencarian tidak ditemukan",
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading(){
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }


}
