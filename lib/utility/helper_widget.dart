import 'dart:developer';
import 'dart:io' show Platform;
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/constants/string_constants.dart';
import '../constants/color_constants.dart';
import '../controller/user_controller.dart';
import '../widget/dialog.dart';
import 'common_dimensions.dart';
import 'custom_decoration.dart';

smallSpace() {
  return const SizedBox(
    height: CommonDimension.smallSpace,
  );
}

largeSpace() {
  return const SizedBox(
    height: CommonDimension.largeSpace,
  );
}

myLog({required String label, required var value}) {
  Platform.isAndroid
      ? log("$label ------------------ $value")
      : print("$label ------------------ $value");
}

showMessage({required var msg}) {
  String snackMsg = msg.toString();
  Get.snackbar(
    "Web School Manager",
    snackMsg,
    titleText: Text(
      "Web School Manager",
      style: TextStyle(color: Colors.white),
    ),
    messageText: Text(
      snackMsg,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.blue,
    snackPosition: SnackPosition.TOP,
  );
  // Fluttertoast.showToast(msg: msg.toString());
}

//
showLoader() {
  showDialog(
      context: Get.context!,
      builder: (context) => Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Image.asset(
              "assets/icons/spin_loader.gif",
              height: 70,
              color: ColorConstants.themeColor,
            ),
          ));
}

//
//
//
//
hideLoader() {
  Navigator.pop(Get.context!);
}

Widget myPadding({required Widget child}) {
  return SafeArea(
    child: Padding(
      padding: EdgeInsets.only(
          top: CommonDimension.upperPadding,
          left: CommonDimension.horizontalPadding,
          right: CommonDimension.horizontalPadding),
      child: child,
    ),
  );
}

List<BoxShadow> myShadow = [
  BoxShadow(
    color: Colors.grey.withOpacity(0.3),
    spreadRadius: 1,
    blurRadius: .6,
    offset: Offset(0, 3), // changes position of shadow
  ),
];

List<BoxShadow> heavyShadow = [
  BoxShadow(
      color: Colors.grey.withOpacity(0.4), spreadRadius: 3.0, blurRadius: 5.0)
];

Widget myImage(
    {required bool isNetwork, required String source, boxFit, Color? color}) {
  try {
    if (isNetwork) {
      String newSource = source.replaceAll("admin.", "");
      return FancyShimmerImage(
        boxFit: boxFit ?? BoxFit.cover,
        errorWidget: Image.network(
          source.split(".").last == "pdf"
              ? "https://img.freepik.com/premium-vector/pdf-icon-document-sheet-icon-business-icon-3d-vector-illustration_71773-704.jpg?w=740"
              : 'https://t3.ftcdn.net/jpg/03/49/45/70/360_F_349457036_XWvovNpNk79ftVg4cIpBhJurdihVoJ2B.jpg',
          fit: BoxFit.contain,
        ),
        shimmerBaseColor: Colors.grey.withOpacity(.1),
        shimmerHighlightColor: Colors.grey.withOpacity(.3),
        shimmerBackColor: Colors.grey,
        imageUrl: newSource,
      );
    }
    return Image.asset(source, fit: boxFit ?? BoxFit.cover,color: color,);
  } catch (e) {
    return Text("error");
  }
}

Widget viewPdf({required PDFDocument doc}) {
  return Container(
    child: PDFViewer(
      document: doc,
    ),
  );
}

Widget listCard(
    {required String imageUrl,
    required Widget content,
    bool? showArrow,
    bool? showImage,
    Color? backgroundColor}) {
  myLog(label: "image", value: imageUrl);
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: backgroundColor == null ? Colors.white : backgroundColor,
      boxShadow: myShadow,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        if (showImage ?? true)
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(60)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: myImage(isNetwork: true, source: imageUrl)),
          ),
        if (showImage ?? true)
          SizedBox(
            width: 15,
          ),
        Expanded(child: content),
        if (showArrow ?? true)
          // Spacer(),
          if (showArrow ?? true)
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.grey,
            )
      ],
    ),
  );
}

Future logoutDialog() {
  return showDialog(
      context: Get.context!,
      builder: (context) => AlertDialogCustom(
            image: "assets/icons/logout.png",
            iconColor: Colors.red,
            showNegative: true,
            description: "Do you want to logout?",
            positiveCall: () {
              UserController().logout();
            },
            negativeCall: () {
              Get.back();
            },
          ));
}



Widget lockModule() {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 14),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: myShadow),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock_outline,
            size: 35,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Locked",
            style: CommonDecoration.smallLabel,
          )
        ],
      ));
}

Widget detailsWithIcon({
  required String asseturl,
  required text,
  var height,
  var color,
  textColor,
}) {
  if (text == "") {
    return Container();
  }
  return Padding(
    padding: EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        Image.asset(
          asseturl,
          width: 17,
          height: height ?? 17,
          color: color ?? Colors.grey,
        ),
        SizedBox(
          width: 10,
        ),
        if (text.runtimeType == String)
          Text(
            text,
            style: TextStyle(fontSize: 13, color: textColor ?? Colors.grey),
          ),
        if (text.runtimeType == Widget) text,
      ],
    ),
  );
}

Widget cardWithWidget({required String asseturl, required Widget content}) {
  return Container(
    decoration: BoxDecoration(
        boxShadow: myShadow,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)),
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(10),
    child: Row(
      children: [
        Image.asset(asseturl, height: 50),
        SizedBox(
          width: 5,
        ),
        content,
      ],
    ),
  );
}

Widget subjectCard(
    {required String subjectName, bool? hideArrow, String? teacherName}) {
  return Container(
    height: 60,
    alignment: Alignment.center,
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: myShadow),
    child: Row(
      children: [
        Image.asset(
          "assets/books.png",
          height: 40,
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              subjectName,
              style: CommonDecoration.subHeaderStyle.copyWith(fontSize: 17),
            ),
            if (teacherName != null)
              Text(
                teacherName,
                style: CommonDecoration.subHeaderStyle.copyWith(fontSize: 17),
              ),
          ],
        )),
        if (hideArrow == null)
          Icon(
            Icons.arrow_forward_ios_outlined,
            color: Colors.grey,
          ),
      ],
    ),
  );
}

Widget greyLine() {
  return Container(
    height: 1,
    width: double.infinity,
    color: Colors.grey.withOpacity(.3),
  );
}

Widget akaalWebSoft() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Ⓒ Akaal WebSoft Pvt. Ltd ",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      Text(
        "[ Ver.${StringConstants.appVersion} ]",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w300,
        ),
      ),
    ],
  );
}

Widget detailsCard({required String label, required Widget content}) {
  return Stack(
    children: [
      Container(
        margin: EdgeInsets.only(top: 7),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.withOpacity(.3))),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            content
          ],
        ),
      ),
      Container(
        color: Colors.white,
        margin: const EdgeInsets.only(left: 20),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      )
    ],
  );
}
