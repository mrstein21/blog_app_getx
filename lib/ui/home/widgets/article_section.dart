import 'package:blog_getx/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../mixins/server.dart';
import '../../../model/article.dart';

class ArticleSection extends StatelessWidget {
  List<Article>list;
  ArticleSection({this.list});

  @override
  Widget build(BuildContext context) {
    return _buildListArticle(list, context);
  }

  Widget _buildListArticle(List<Article> list,BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (ctx, index) {
          return _buildRowArticle(list[index],context);
        });
  }

  Widget _buildRowArticle(Article article,BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouterGenerator.routeDetailArticle,arguments: {
          "article_id":article.id
        });
        // Navigator.pushNamed(context, RouterGenerator.routeDetailArticle,arguments: {
        //   "id":article.id
        // });
      },
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue,
                  image: DecorationImage(
                      image: NetworkImage(Server.url+article.image),
                      fit: BoxFit.fill
                  )
              ),
            ),
            SizedBox(width: 4,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    article.title,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    article.short_description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontFamily: "Roboto",
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: CircleAvatar(
                              backgroundImage:
                              NetworkImage(Server.url + article.author.avatar),
                              radius: 50,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            article.author.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
