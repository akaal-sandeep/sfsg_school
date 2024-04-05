import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/parent/video/video_player.dart';
import 'package:web_school_manager/parent/video/youtude_player.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../constants/string_constants.dart';
import '../../local_storage/local_storage.dart';
import '../../parent_model/get_student_list_r1_model.dart';

class VideoList extends StatelessWidget {
  VideoList({Key? key}) : super(key: key);

  final List<String> ids = [
    'nPt8bK2gbaU',
    'gQDByCdjUXw',
    'iLnmTe5Q2Qw',
    '_WoCV4c6XOE',
    'KmzdUe0RSJo',
    '6jZDSSZZxjQ',
    'p2lYr3vM_1w',
    '7QUtEmBT_-w',
    '34_PXCzGw1M',
  ];

  @override
  Widget build(BuildContext context) {
    StudentData studentData =
        LocalStorage().readStudentModel(key: StringConstants.profileModel);
   // myLog(label: "video", value: studentData.functionVideoList![0].videoUrl);
    return Scaffold(
      body: myPadding(
          child: Column(
        children: [
          CommonHeader(
            title: "Video List",
          ),
          smallSpace(),
          Expanded(
              child: ListView.builder(
                  itemCount: studentData.functionVideoList!.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                        onTap: () {
                          if (studentData.functionVideoList![i].videoUrl!
                                  .toLowerCase()
                                  .contains("youtu.be") ||
                              studentData.functionVideoList![i].videoUrl!
                                  .toLowerCase()
                                  .contains("youtube")){
                            Get.to(() => YoutudeVideo(
                              url: studentData
                                  .functionVideoList![i].videoUrl!,
                              tittle: studentData.functionVideoList![i]
                                  .functionSubject ??
                                  "",
                              description: studentData.functionVideoList![i]
                                  .functionContents ??
                                  "",
                            ));

                          }else{
                            Get.to(()=>VideoPlayerApp(
                              title: studentData.functionVideoList![i]
                                  .functionSubject ??
                                  "",
                              description: studentData.functionVideoList![i]
                                  .functionContents ??
                                  "",
                              url: studentData
                                .functionVideoList![i].videoUrl!,));
                          }

                        },
                        child: listCard(
                            imageUrl: "",
                            showImage: false,
                            content: Row(
                              children: [
                                SizedBox(
                                    height: 70,
                                    child: myImage(
                                        isNetwork: false,
                                        source: "assets/icons/video.png")),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        studentData.functionVideoList![i]
                                                .functionSubject ??
                                            "",
                                        style: CommonDecoration.subHeaderStyle,
                                      ),
                                      if (studentData.functionVideoList![i]
                                              .functionContents !=
                                          "")
                                        Text(
                                          studentData.functionVideoList![i]
                                                  .functionContents ??
                                              "Not define",
                                          style: CommonDecoration.smallLabel,
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            )));
                  }))
        ],
      )),
    );
  }
}
