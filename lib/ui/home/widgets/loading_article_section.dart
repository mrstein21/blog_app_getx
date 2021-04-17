import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingArticle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildListArticleEmpty(),
    );
  }

  Widget _buildListArticleEmpty() {
    return ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[400],
            highlightColor: Colors.white,
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.all(5),
              height: 200,
            ),
          );
        });
  }

}
