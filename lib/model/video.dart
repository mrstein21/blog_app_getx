import 'dart:convert';
import 'package:blog_getx/model/author.dart';
import 'package:blog_getx/model/video_tags.dart';

List<Video> listVideoFromJsonPaginate(String response) {
  final jsonData = json.decode(response);
  final data = jsonData["data"]["data"];
  return new List<Video>.from(data.map((x) => Video.fromJson(x)));
}

Video videoFromJson(String response){
  final jsonData = json.decode(response);
  final data = jsonData["data"];
  return Video.fromJson(data);
}


class Video{
  int id;
  String title;
  String description;
  String youtube_key;
  String created_at;
  Author author;
  List<VideoTags>list;

  Video({
    this.id,
    this.title,
    this.description,
    this.youtube_key,
    this.created_at,
    this.author,
    this.list
  });

  factory Video.fromJson(Map<String,dynamic>json)=>Video(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      youtube_key: json["youtube_key"],
      author: Author.fromJson(json["author"]),
      created_at: json["date"],
      list: json["tags"]!=null?listVideoTags(json["tags"]):null
  );

}