import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingVideoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildListVideoEmpty(),
    );
  }


  Widget _buildListVideoEmpty() {
    return Container(
      height: 150,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (ctx, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[400],
              highlightColor: Colors.white,
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.all(5),
                height: 150,
                width: 280,
              ),
            );
          }),
    );
  }
}
