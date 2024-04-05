import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../model/parent_press_release_images_model.dart';

class PressImages extends StatelessWidget {

  ParentPressReleaseImagesModel parentPressReleaseImagesModel;
  PressImages({Key? key,required this.parentPressReleaseImagesModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
          child: Column(
            children: [
              CommonHeader(
                title: "Press Release View",
                hideStudentName: true,
              ),
              smallSpace(),
              Expanded(
                  child:parentPressReleaseImagesModel.data!.length.isEqual(0)? myImage(isNetwork: false, source: "assets/icons/empty.png"):GridView.builder(
                      itemCount: parentPressReleaseImagesModel.data!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10
                      ),
                      itemBuilder: (context, i) => InkWell(
                        onTap: (){
                          viewDocument(fileSource: parentPressReleaseImagesModel.data![i].imageAbsolutePath ?? "", fromUrl: true);
                        },
                        child: myImage(
                            isNetwork: true,
                            source: parentPressReleaseImagesModel.data![i].imageAbsolutePath ?? ""),
                      )))
            ],
          )),
    );
  }
}
