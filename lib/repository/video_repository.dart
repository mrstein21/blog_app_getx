
import 'package:blog_getx/mixins/server.dart';
import 'package:blog_getx/model/video.dart';
import 'package:blog_getx/model/video_tags.dart';
import 'package:flutter/foundation.dart';


import 'package:http/http.dart' as http;
class VideoRepository {
  Future<List<Video>> getAllVideo(int page) async {
    var response =
    await http.get(Server.url + "/api/video?page=" + page.toString());
    print("request "+response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return compute(listVideoFromJsonPaginate, response.body);
    } else {
      throw Exception();
    }
  }

  Future<List<Video>> searchVideo(String keyword,int page) async {
    var response =
    await http.get(Server.url + "/api/video/search/"+keyword+"?page=" + page.toString());
    print("request "+response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return compute(listVideoFromJsonPaginate, response.body);
    } else {
      throw Exception();
    }
  }

  Future<Video> getDetailVideo(int id) async {
    var response =
    await http.get(Server.url + "/api/video/" + id.toString());
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);

      return compute(videoFromJson, response.body);
    } else {
      throw Exception();
    }
  }

  Future<List<VideoTags>> getRelatedVideo(var body) async {
    var response =
    await http.post(Server.url + "/api/video/related",body: body,headers: {
      "Content-Type":"application/json"
    });
    print("request "+response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return compute(lisRelatedtVideoFromJson, response.body);
    } else {
      throw Exception();
    }
  }

  Future<List<VideoTags>> searchTagsVideo(String tags,int page) async {
    var response =
    await http.get(Server.url + "/api/video/tags/"+tags+"?page=" + page.toString());
    print("request "+response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return compute(lisVideoByTagsFromJson, response.body);
    } else {
      throw Exception();
    }
  }

}
