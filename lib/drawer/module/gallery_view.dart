import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../model/get_gallary_data_model.dart';

class GalleryView extends StatelessWidget {
  List<GalleryImages> galleryImages;

  GalleryView({Key? key, required this.galleryImages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
          child: Column(
        children: [
          CommonHeader(
            title: "Gallery View",
            hideStudentName: true,
          ),
          smallSpace(),
          Expanded(
              child:galleryImages.length.isEqual(0)? myImage(isNetwork: false, source: "assets/icons/empty.png"):GridView.builder(
                  itemCount: galleryImages.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10
                  ),
                  itemBuilder: (context, i) => InkWell(
                    onTap: (){
                      viewDocument(fileSource: galleryImages[i].imageAbsolutePath ?? "", fromUrl: true);
                    },
                    child: myImage(
                        isNetwork: true,
                        source: galleryImages[i].imageAbsolutePath ?? ""),
                  )))
        ],
      )),
    );
  }
}
