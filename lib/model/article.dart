import 'dart:convert';
import 'article_tags.dart';
import 'author.dart';

List<Article> listArticleFromJson(String response) {
  final jsonData = json.decode(response);
  final data = jsonData["data"];
  return new List<Article>.from(data.map((x) => Article.fromJson(x)));
}


List<Article> listArticleFromJsonPaginate(String response) {
  final jsonData = json.decode(response);
  final data = jsonData["data"]["data"];
  return new List<Article>.from(data.map((x) => Article.fromJson(x)));
}

Article detailArticleFromJson(String response){
  final jsonData = json.decode(response);
  final data = jsonData["data"];
  return Article.fromJson(data);
}

class Article {
  int id;
  String title;
  String content;
  String short_description;
  Author author;
  String image;
  String date;
  List<ArticleTags>tags;
  String created_at;

  Article(
      {this.id,
        this.date,
        this.tags,
        this.title,
        this.short_description,
        this.image,
        this.author,
        this.content,
        this.created_at,
      });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
      id: json["id"],
      title: json["title"],
      content: json["content"],
      short_description: json["short_description"],
      author: Author.fromJson(json["author"]),
      created_at: json["created_at"],
      tags: json["tags"]!=null?listArticleTags(json["tags"]):[],
      image: json["image"],
      date: json["date"]
  );
}
