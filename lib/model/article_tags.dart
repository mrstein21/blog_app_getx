import 'dart:convert';
import 'package:blog_getx/model/article.dart';
import 'package:blog_getx/model/topic.dart';

List<ArticleTags> listArticleTags(var data) {
  return new List<ArticleTags>.from(data.map((x) => ArticleTags.fromJson(x)));
}

List<ArticleTags> lisRelatedtArticleFromJson(String response) {
  final jsonData = json.decode(response);
  final data = jsonData["data"];
  return new List<ArticleTags>.from(data.map((x) => ArticleTags.fromJson(x)));
}

List<ArticleTags> lisArticleByTagsFromJson(String response) {
  final jsonData = json.decode(response);
  final data = jsonData["data"]["data"];
  return new List<ArticleTags>.from(data.map((x) => ArticleTags.fromJson(x)));
}


class ArticleTags{
  int article_id;
  int topic_id;
  Topic topic;
  Article article;
  ArticleTags({
    this.article_id,
    this.topic_id,
    this.topic,
    this.article
  });
  factory ArticleTags.fromJson(Map<String,dynamic>json)=>ArticleTags(
      article_id: json["article_id"],
      topic_id: json["topic_id"],
      article: json["article"]!=null?Article.fromJson(json["article"]):null,
      topic: json["topics"]!=null?Topic.fromJson(json["topics"]):null
  );
}