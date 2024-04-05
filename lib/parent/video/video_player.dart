import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:web_school_manager/utility/common_dimensions.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/widget/header.dart';

class VideoPlayerApp extends StatefulWidget {
  String url;
  String description;
  String title;
   VideoPlayerApp({super.key,required this.url,required this.title,required this.description});

  @override
  _VideoPlayerAppState createState() => _VideoPlayerAppState();
}

class _VideoPlayerAppState extends State<VideoPlayerApp> {
  FlickManager? flickManager;

  @override
  void initState() {
    flickManager = FlickManager(
      videoPlayerController:
      VideoPlayerController.network(widget.url),
    );
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            SizedBox(
              height: CommonDimension.upperPadding,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: CommonDimension.horizontalPadding),
              child: CommonHeader(title: "Video",),
            ),
            SizedBox(
              height: 40,
            ),
            FlickVideoPlayer(
                flickManager: flickManager!
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: CommonDimension.horizontalPadding),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title,style: CommonDecoration.bigLabel,),
                  Text(widget.description,style: CommonDecoration.smallLabel,),

                ],
              ),
            ),
          ],
        ),

      );

  }

  @override
  void dispose() {
    flickManager!.dispose();
    super.dispose();

  }
}