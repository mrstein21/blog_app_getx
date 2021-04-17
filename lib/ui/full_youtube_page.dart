import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FullYoutubePage extends StatefulWidget {
  YoutubePlayerController controller;
  String url;
  FullYoutubePage({
    this.url,
    this.controller
  });
  @override
  _FullYoutubePageState createState() => _FullYoutubePageState();
}

class _FullYoutubePageState extends State<FullYoutubePage> {
  YoutubePlayerController _controller;
  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.url)
    );
    _controller.toggleFullScreenMode();

    // TODO: implement initState
    super.initState();
  }
  Future<bool> onBack(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    Get.back();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBack,
      child: Scaffold(
        body: YoutubePlayer(
          controller: _controller,
          bottomActions: [
            const SizedBox(width: 14.0),
            CurrentPosition(),
            const SizedBox(width: 8.0),
            ProgressBar(
              isExpanded: true,
            ),
            RemainingDuration(),
            const SizedBox(width: 5.0),
            InkWell(
              onTap: (){
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitDown,
                  DeviceOrientation.portraitUp,
                ]);
                Navigator.of(context).pop();
              },
              child: Icon(Icons.zoom_out_map,color: Colors.white,size: 20,),
            ),

          ],
        ),
      ),
    );
  }
}
