import 'package:blog_getx/model/video.dart';
import 'package:blog_getx/repository/video_repository.dart';
import 'package:get/get.dart';

class ListVideoController extends GetxController{
  var list=List<Video>().obs;
  var isLoading=true.obs;
  var page=0.obs;
  var isNoMoreLoad=false.obs;
  VideoRepository videoRepository=Get.find<VideoRepository>();

  void getVido() async{
    list.value=[];
    isLoading(true);
    isNoMoreLoad(false);
    page(1);
    var data=await videoRepository.getAllVideo(1);
    isLoading(false);
    list.value=[...list.value,...data];
  }


  void loadMore()async{
    print("kesini load more getX");
    page.value=page.value+1;
    var data=await videoRepository.getAllVideo(page.value);
    list.value=[...list.value,...data];
    if(data.isEmpty){
      isNoMoreLoad(true);
    }

  }



}