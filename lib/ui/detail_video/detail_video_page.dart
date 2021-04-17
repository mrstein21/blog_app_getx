import 'package:blog_getx/mixins/server.dart';
import 'package:blog_getx/model/video.dart';
import 'package:blog_getx/model/video_tags.dart';
import 'package:blog_getx/routes.dart';
import 'package:blog_getx/ui/detail_video/detail_video_controller.dart';
import 'package:blog_getx/ui/detail_video/widgets/related_video_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailVideoPage extends StatelessWidget {
  int video_id;
  DetailVideoPage({
    this.video_id
  });
  YoutubePlayerController controller;
  DetailVideoController videoController;


  @override
  Widget build(BuildContext context) {
    videoController=Get.find<DetailVideoController>();
    videoController.getDetail(video_id);
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: _buildUI(),
      ),
    );
  }

  Widget _buildYoutubeVideo(String url){
    controller= YoutubePlayerController(
        initialVideoId: url,
        flags: YoutubePlayerFlags(
          autoPlay: false,
        )
    );
    return YoutubePlayer(
      controller: controller,
      bottomActions: [
        const SizedBox(width: 14.0),
        CurrentPosition(),
        const SizedBox(width: 8.0),
        ProgressBar(
          isExpanded: true,
        ),
        RemainingDuration(),
      ],
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            height: 6,
          ),
          Text(
            "Loading..",
            style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 16,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _buildUI(){
    return Obx(
        ()=>videoController.isLoading==true?_buildLoading():ListView(
        children: [
          _buildYoutubeVideo(videoController.video.value.youtube_key),
          SizedBox(height: 4,),
          _buildDescription(videoController.video.value),
          SizedBox(height: 5,),
          videoController.isLoadingRelated==true?Container():
          RelatedVideo(list:videoController.list)
        ],
      ),
    );

  }


  Widget _buildDescription(Video video){
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(video.title,style: TextStyle(fontSize:15,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Roboto"),),
          SizedBox(height: 7,),
          Text(video.created_at,style: TextStyle(fontSize:13,color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "Roboto"),),
          SizedBox(height: 7,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 25,
                width: 25,
                child: CircleAvatar(
                  backgroundImage:
                  NetworkImage(Server.url + video.author.avatar),
                  radius: 50,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                video.author.name,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontSize: 13),
              ),
            ],
          ),
          SizedBox(height: 8,),
          _buildTags(video.list),
          SizedBox(height: 5,),
          Text(
            video.description,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto',
                fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildTags(List<VideoTags> tags){
    return Wrap(
      children: tags.map<Widget>((e){
        return InkWell(
          onTap: (){
            Get.toNamed(RouterGenerator.routeSearchByTags,arguments: {
              "tags":e.topic.id.toString(),
              "tags_name":e.topic.topic_name
            });
            // Navigator.pushNamed(context, RouterGenerator.routeSearchByTags,
            //     arguments: {
            //       "tags":e.topic_id.toString(),
            //       "tags_name":e.topic.topic_name
            //     });
          },
          child: Container(
            margin: EdgeInsets.only(right: 4),
            padding: EdgeInsets.all(3),
            child: Text(e.topic.topic_name,style: TextStyle(fontSize: 12,fontFamily: "Roboto",color: Colors.white,fontWeight: FontWeight.bold),),
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Colors.black)
            ),
          ),
        );
      }).toList(),
    );
  }
}
