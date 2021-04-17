import 'package:blog_getx/ui/list_video/widgets/item_vide.dart';
import 'package:blog_getx/ui/search_result/search_result_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabVideos extends StatelessWidget {
  SearchResultController searchResultController;
  ScrollController controller =ScrollController();

  void onScroll(){
    double maxScroll=controller.position.maxScrollExtent;
    double currentScroller=controller.position.pixels;
    if(maxScroll==currentScroller){
      searchResultController.onLoadMoreVideo();
    }
  }
  @override
  Widget build(BuildContext context) {
    searchResultController=Get.find<SearchResultController>();
    controller.addListener(onScroll);
    return Container(
      padding: EdgeInsets.all(10),
      child: _buildListVideo(),
    );
  }

  Widget _buildListVideo(){
    return Obx(
          ()=>searchResultController.isLoadingVideo==true?
      _buildLoading():
      searchResultController.videos.isEmpty?
      _buildMessageEmpty():
      ListView.builder(
          controller: controller,
          itemCount: searchResultController.isNoMoreLoadVideo==true?
          searchResultController.videos.length:searchResultController.videos.length+1,
          itemBuilder: (contet,index){
            if(index<searchResultController.videos.length){
              return ItemVideo(video: searchResultController.videos[index],);
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
      child: CircularProgressIndicator(),
    );
  }


}
