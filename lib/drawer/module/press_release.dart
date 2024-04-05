import 'package:flutter/material.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/controller/drawer_controller.dart';
import 'package:web_school_manager/model/parent_press_release_model.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';


class PressRelease extends StatelessWidget {
  ParentPressReleaseModel parentPressReleaseModel;
  PressRelease({Key? key,required this.parentPressReleaseModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(child: Column(
        children: [
          CommonHeader(title: "Press Release",hideStudentName: true,),
          smallSpace(),
          Expanded(child: ListView.builder(
              itemCount: parentPressReleaseModel.data?.length??0,
              itemBuilder: (context,i){
                return InkWell(
                  onTap: (){
                    ParentDrawerController().getParentPressReleaseImages(id: parentPressReleaseModel.data![i].id.toString());
                   // Get.to(()=>GalleryView(galleryImages: parentPressReleaseModel.data![i].galleryImages??[],));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 3),
                    child: listCard(imageUrl: parentPressReleaseModel.data![i].coverImageAbsolutePath.toString(), content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(parentPressReleaseModel.data![i].eventName.toString(),style: CommonDecoration.subHeaderStyle,),
                          SizedBox(height: 10,),
                          Text(getTimeFormat(DateTime.parse(parentPressReleaseModel.data![i].eventDate.toString())),style: CommonDecoration.smallLabel,),
                        ],
                      ),
                    )),
                  ),
                );
              }))
        ],
      )),
    );
  }
}
