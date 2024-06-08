import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/common_view/document_view.dart';
import 'package:web_school_manager/constants/color_constants.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/dialog.dart';
import 'package:web_school_manager/widget/header.dart';

import 'common_view/login_type.dart';
import 'constants/string_constants.dart';
import 'local_storage/local_storage.dart';

Future getFcmToken()async{
 String? data = await FirebaseMessaging.instance.getToken();
 myLog(label: "device fcm token", value: data.toString());
return data;
}

platFormName(){
  if(Platform.isAndroid){
    return "Android";
  }else{
    return "IOS";
  }
}

String getTimeFormat(DateTime dateTime){
  return DateFormat("dd MMM, yyyy").format(dateTime);
}

String apiTimeFormat(DateTime datetime){
  return DateFormat("MMM dd,yyyy").format(datetime);
}

String commonTimeConvert(DateTime datetime){
  return DateFormat("hh:mm a, MMM dd, yyyy").format(datetime);
}

String findLabel(label){
  if(label=="H"){
    return "Half Day";
  }
  if(label == "L"){
    return "Leave";
  }
  if(label=="A"){
    return "Absent";
  }
  if(label=="P"){
    return "Present";
  }
  return "";
}

Future<String> covertFileAsbytes({required String fileSource})async{
  String imgpath = fileSource;
  File imgfile = File(imgpath);
  Uint8List imgbytes = await imgfile.readAsBytes();
  String bs4str = base64.encode(imgbytes);
  return bs4str;
}

Future<String> covertFileAsBytesReception({required String fileSource})async{
  String imgpath = fileSource;
  File imgfile = File(imgpath);
  Uint8List imgbytes = await imgfile.readAsBytes().then((value) {
    return value;
  });
  String bs4str = base64.encode(imgbytes);
  return bs4str;
}

bool isTeacher(){
  return LocalStorage()
      .read(key: StringConstants.userType) == StringConstants.teacherType;
}

bool isCoordinator(){
  return LocalStorage()
      .read(key: StringConstants.userType) == StringConstants.coordinatorType;
}

bool isParent(){
  return LocalStorage()
      .read(key: StringConstants.userType) == StringConstants.parentType;
}

bool isPrincipal(){
  return LocalStorage()
      .read(key: StringConstants.userType) == StringConstants.principleType;
}

Map<String,dynamic> listMapIndex( String label,int index){
  Map<String,dynamic> value={
    "name": label,
    "index" : index
  };
  return value;
}



viewDocument({required String fileSource,required bool fromUrl,bool? back})async{
  myLog(label: "fileUrl", value: fileSource);
  if(fileSource.split(".").last=="pdf"){
    showLoader();
    PDFDocument doc;
    if(fromUrl){
      doc = await PDFDocument.fromURL(fileSource);
    }else{
      doc = await PDFDocument.fromFile(File(fileSource));
    }
    hideLoader();
    if(back??false) {
      return Container(
        child: PDFViewer(
          document: doc,
        ),
      );
    }
    Get.to(()=>DocumentView(child: Expanded(
      child: Container(
        child: PDFViewer(
          document: doc,
        ),
      ),
    )));
  }else{
    if(back??false) {
      return
      Container(
          child: fromUrl? Image.network(fileSource):Image.file(File(fileSource)));

    }
    Get.to(()=>DocumentView(child:
    Expanded(
      child: InteractiveViewer(
        minScale: 0.1,
        maxScale: 1.6,

        child:fromUrl? Image.network(fileSource):Image.file(File(fileSource)),

      ),
    )));
  }






}
/*==============================common switch dialog==========================================================*/

switchDialog({exit}){
  return
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialogCustom(
        switchText: "Switch",
        exitText: "Exit",
        image: "assets/icons/switch-button.png",
        subTitle: "Do you want to switch your account?",
        showNegative: true,
        positiveCall: () {
          Get.offAll(LoginType());
          exit = false;
        },
        negativeCall: () {
          Get.back();
          exit = true;
        },
      )
    ).then((value){
      return exit;
    });
}

/*=========================================Common Profile Bg View==============================================*/
commonProfileBgView({headerTitle,profileImage}){
  return    Stack(
    alignment: Alignment.topCenter,
    children: <Widget>[
      SizedBox(
          width: double.infinity,
          child: myImage(isNetwork: false, source: "assets/icons/background.png",color: ColorConstants.themeColor)),


      myPadding(child: CommonHeader(title:headerTitle,hideStudentName: true,textColor: Colors.white,)),
      largeSpace(),
      Container(
        margin: EdgeInsets.only(top: 120),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.blue
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: myImage(isNetwork: true, source:profileImage)),
      ),


    ],
  );
}

///--------------------------sortOption----------



/*=========================================Common Expansion Tile==============================================*/


commonExpansionTile({title,required Widget content}){
  return Theme(
    data: ThemeData().copyWith(dividerColor: Colors.transparent),

    child: ExpansionTile(
      // collapsedBackgroundColor: Colors.blue,
      // backgroundColor: Colors.pink,
      childrenPadding: EdgeInsets.symmetric(horizontal: 10),
      title: Text(

        title,
        style: CommonDecoration.expensionStyle,
      ),
      children: <Widget>[

        Container(

          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1)
            ),
            child: content),

      ],
    ),
  );
}

