import 'package:blog_getx/model/video.dart';
import 'package:blog_getx/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemVideo extends StatelessWidget {
  Video video;
  ItemVideo({
    this.video
  });
  @override
  Widget build(BuildContext context) {
    return _buildRowVideo(video);
  }

  Widget _buildRowVideo(Video video) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouterGenerator.routeDetailVideo,arguments: {
          "video_id":video.id
        });
      },
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 100,
              width: 100,
              child: Container(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.play_arrow,color: Colors.black,),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue,
                  image: DecorationImage(
                      image: NetworkImage("https://img.youtube.com/vi/"+video.youtube_key+"/mqdefault.jpg"),
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
                    video.title,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Oleh",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Roboto",fontSize: 12),),
                      SizedBox(width: 3,),
                      Text(
                        video.author.name,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: "Roboto",
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    video.description,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
