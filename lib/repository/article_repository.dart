import 'package:blog_getx/mixins/server.dart';
import 'package:blog_getx/model/article.dart';
import 'package:blog_getx/model/article_tags.dart';
import 'package:blog_getx/model/topic.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ArticleRepository {
  Future<List<Article>> getArticle() async {
    var response = await http.get(Server.url + "/api/artikel");
    print(response.body);

    if (response.statusCode == 200) {
      print(response.body);

      return compute(listArticleFromJson, response.body);
    } else {
      throw Exception();
    }
  }


  Future<List<Article>> searchArticle(String keyword,int page) async {
    var response = await http.get(Server.url + "/api/article/search/"+keyword+"?page="+page.toString());
    print(response.body);

    if (response.statusCode == 200) {
      print(response.body);

      return compute(listArticleFromJsonPaginate, response.body);
    } else {
      throw Exception();
    }
  }

  Future<List<ArticleTags>> searchArticleByTags(String tags,int page) async {
    var response = await http.get(Server.url + "/api/article/tags/"+tags+"?page="+page.toString());
    if (response.statusCode == 200) {
      return compute(lisArticleByTagsFromJson, response.body);
    } else {
      throw Exception();
    }
  }

  Future<Article> getDetailArticle(int id) async {
    var response =
    await http.get(Server.url + "/api/article/" + id.toString());
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);

      return compute(detailArticleFromJson, response.body);
    } else {
      throw Exception();
    }
  }

  Future<List<ArticleTags>> getRelatedArticle(var body) async {
    var response =
    await http.post(Server.url + "/api/article/related",
        body: body,
        headers: {
          "Content-Type":"application/json"
        }
    );
    print("request "+response.body);
    if (response.statusCode == 200) {
      /// print(response.body);
      return compute(lisRelatedtArticleFromJson,response.body);
    } else {
      throw Exception();
    }
  }

  Future<List<Article>> getAllArticle(int page) async {
    var response =
    await http.get(Server.url + "/api/article?page=" + page.toString());
    print("request ke " +Server.url + "/api/article?page=" + page.toString());
    if (response.statusCode == 200) {
      print("hasil response nya "+response.body);
      return compute(listArticleFromJsonPaginate, response.body);
    } else {
      throw Exception();
    }
  }


  Future<List<Topic>> getTopic() async {
    var response = await http.get(Server.url + "/api/topic");
    print(response.body);

    if (response.statusCode == 200) {
      return compute(listTopicFromJson, response.body);
    } else {
      throw Exception();
    }
  }

}
