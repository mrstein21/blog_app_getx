import 'dart:convert';
import 'package:blog_getx/model/topic.dart';
import 'package:blog_getx/model/video.dart';

List<VideoTags> listVideoTags(var data) {
  return new List<VideoTags>.from(data.map((x) => VideoTags.fromJson(x)));
}

List<VideoTags> lisRelatedtVideoFromJson(String response) {
  final jsonData = json.decode(response);
  final data = jsonData["data"];
  return new List<VideoTags>.from(data.map((x) => VideoTags.fromJson(x)));
}

List<VideoTags> lisVideoByTagsFromJson(String response) {
  final jsonData = json.decode(response);
  final data = jsonData["data"]["data"];
  return new List<VideoTags>.from(data.map((x) => VideoTags.fromJson(x)));
}


class VideoTags{
  int video_id;
  int topic_id;
  Topic topic;
  Video video;
  VideoTags({
    this.video_id,
    this.topic_id,
    this.topic,
    this.video
  });
  factory VideoTags.fromJson(Map<String,dynamic>json)=>VideoTags(
      video_id: json["video_id"],
      topic_id: json["topic_id"],
      video: json["video"]!=null?Video.fromJson(json["video"]):null,
      topic: json["topics"]!=null?Topic.fromJson(json["topics"]):null
  );
}