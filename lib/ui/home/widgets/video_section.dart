import 'package:blog_getx/model/video.dart';
import 'package:blog_getx/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../mixins/server.dart';

class VideoSection extends StatefulWidget {
  List<Video>video;
  VideoSection({
    this.video
  });
  @override
  _VideoSectionState createState() => _VideoSectionState();
}

class _VideoSectionState extends State<VideoSection> {
  int _current;
  @override
  Widget build(BuildContext context) {
    return widget.video.isNotEmpty?Container(height: 230,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildListVideo(widget.video),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.video.map((url) {
                int index = widget.video.indexOf(url);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
              }).toList(),
            ),
          ],
        )
    ):Container();
  }


  Widget _buildListVideo(List<Video> list) {
    return Container(
      height: 200,
      child: PageView.builder(
          onPageChanged: (x){
            setState(() {
              _current=x;
            });
          },
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (ctx, index) {
            return  _buildRowVideo(list[index]);
          }),
    );
  }


  Widget _buildRowVideo(Video video) {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, RouterGenerator.routeDetailVideo,arguments: {
        //   "id":video.id
        // });
        Get.toNamed(RouterGenerator.routeDetailVideo,arguments: {
          "video_id":video.id
        });
      },
      child: Container(
        height: 200,
        width: 330,
        child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  video.title,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  video.created_at,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontFamily: "Roboto",
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  video.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontFamily: "Roboto",
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                          width: 25,
                          child: CircleAvatar(
                            backgroundImage:
                            NetworkImage(Server.url + video.author.avatar),
                            radius: 50,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          video.author.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors:<Color>[
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.3),
                  ]
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            )),
        decoration: BoxDecoration(
            boxShadow: [
              new BoxShadow(
                color: Colors.black38,
                blurRadius: 2.0,
              )
            ],
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage("https://img.youtube.com/vi/"+video.youtube_key+"/mqdefault.jpg")),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        margin: EdgeInsets.all(7),
      ),
    );
  }
}

