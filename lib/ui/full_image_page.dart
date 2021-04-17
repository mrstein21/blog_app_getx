import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullImagePage extends StatelessWidget {
  String url;
  FullImagePage({
    this.url
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
        ),
        body: Container(
          child: PhotoView(
            imageProvider: NetworkImage(url),
          ),
        ),
      ),
    );
  }
}
