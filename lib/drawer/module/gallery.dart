import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/drawer/module/gallery_view.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';
import '../../model/get_gallary_data_model.dart';


class Gallery extends StatelessWidget {
  GetGalleryDataModel getGalleryDataModel;
  Gallery({Key? key,required this.getGalleryDataModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(child: Column(
        children: [
          CommonHeader(title: "Gallery",hideStudentName: true,),
          smallSpace(),

          Expanded(child:getGalleryDataModel.data!.length.isEqual(0)?myImage(isNetwork: true, source: "assets/icons/empty.png"): ListView.builder(
              itemCount: getGalleryDataModel.data?.length??0,
              itemBuilder: (context,i){
                return InkWell(
                  onTap: (){
                    Get.to(()=>GalleryView(galleryImages: getGalleryDataModel.data![i].galleryImages??[],));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 3),
                    child: listCard(imageUrl: getGalleryDataModel.data![i].coverImageAbsolutePath.toString(), content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getGalleryDataModel.data![i].galleryName.toString(),style: CommonDecoration.subHeaderStyle,),
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
