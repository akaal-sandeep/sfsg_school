import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_school_manager/generated/assets.dart';
import 'package:web_school_manager/model/login_scuccess_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContactUs extends StatelessWidget {
  String link;
  String? upperTitle;
  ContactUs({Key? key,required this.link, this.upperTitle}) : super(key: key);
  LoginSuccessModel loginSuccessModel=LoginSuccessModel();
  WebViewController controller = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  Widget build(BuildContext context) {
    controller.loadRequest(Uri.parse(link));
    return Scaffold(
      body: Column(
        children: [
          myPadding(child: CommonHeader(title: upperTitle==null?"Contact Us":upperTitle!,hideStudentName: true,)),
          smallSpace(),
          Expanded(child: WebViewWidget(
            controller:controller ,

          ))
        ],
      ),
    );
  }
}


class ContactUsStatic extends StatelessWidget {
  const ContactUsStatic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonHeader(title: "Contact Us",hideStudentName: true,),
          largeSpace(),
         Image.asset(Assets.iconsSfsjContactUs)
        ],
      )),
    );
  }
}
