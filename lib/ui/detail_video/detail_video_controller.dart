import 'dart:convert';

import 'package:blog_getx/model/video.dart';
import 'package:blog_getx/model/video_tags.dart';
import 'package:blog_getx/repository/article_repository.dart';
import 'package:blog_getx/repository/video_repository.dart';
import 'package:blog_getx/ui/detail_video/widgets/related_video_section.dart';
import 'package:get/get.dart';

class DetailVideoController extends GetxController{
  var  video = new Video().obs;
  List<VideoTags>list=new List<VideoTags>().obs;
  var isLoading = true.obs;
  var isLoadingRelated=true.obs;
  VideoRepository videoRepository=Get.find<VideoRepository>();


  void getDetail(int id){
      isLoading(true);
      videoRepository.getDetailVideo(id).then((value){
        video=value.obs;
        List<String>topics_id=new List<String>();
        for(int i=0;i<value.list.length;i++){
          topics_id.add(value.list[i].topic_id.toString());
        }
        isLoading(false);
        var body=json.encode({
          "topic_id":topics_id,
          "video_id":id.toString()
        });
        getRelatedVideo(body);
      });
  }

  void getRelatedVideo(var body){
    isLoadingRelated(true);
    videoRepository.getRelatedVideo(body).then((value){
      list=value.obs;
      isLoadingRelated(false);
    });
  }
}