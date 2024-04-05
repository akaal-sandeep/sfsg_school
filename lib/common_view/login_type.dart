import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/common_view/login.dart';
import 'package:web_school_manager/constants/string_constants.dart';
import 'package:web_school_manager/controller/principal_controller.dart';
import 'package:web_school_manager/coordinator/coordinator_dashboard.dart';
import 'package:web_school_manager/fcm/fcm_service.dart';
import 'package:web_school_manager/generated/assets.dart';
import 'package:web_school_manager/local_storage/local_storage.dart';
import 'package:web_school_manager/reception/screen/reception_dashboard.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';

import '../controller/parent_controller.dart';
import '../controller/teacher_controller.dart';
import '../teacher/teacher_dashboard.dart';

class LoginType extends StatefulWidget {
  const LoginType({Key? key}) : super(key: key);

  @override
  State<LoginType> createState() => _LoginTypeState();
}

class _LoginTypeState extends State<LoginType> {
  checkSplash() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      onPressNavigation(initialMessage);
    } else {}
  }

  @override
  void initState() {
   // checkSplash();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: myPadding(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          smallSpace(),
          Align(
              alignment: Alignment.center,
              child: Text(
                "Choose Account Type",
                style: CommonDecoration.headerStyle,
              )),
          largeSpace(),
          Hero(
            tag: "logo",
            child: SizedBox(
                height: 150,
                child: myImage(
                    isNetwork: false,
                    source: Assets.iconsNewLogo)),
          ),
          Container(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loginTypeCard(
                  assets: "assets/icons/parent.png",
                  type: "Parent",
                  loginType: StringConstants.parentType),
              SizedBox(
                width: 15,
              ),
              loginTypeCard(
                  assets: "assets/icons/teacher.png",
                  type: "Teacher",
                  loginType: StringConstants.teacherType),
              SizedBox(
                width: 15,
              ),
              loginTypeCard(
                  assets: "assets/icons/principal.png",
                  type: "Principal",
                  loginType: StringConstants.principleType),
            ],
          ),
          SizedBox(
            height: 15,
          ),


          Expanded(child: SizedBox()),
       //   akaalWebSoft(),
          SizedBox(
            height: 10,
          )
        ],
      )),
    );
  }

  Widget loginTypeCard(
      {required String assets,
      required String type,
      required String loginType}) {
    return InkWell(
      onTap: () {
        setState(() {});
        switch (loginType) {
          case StringConstants.teacherType:
            var token =
                LocalStorage().read(key: StringConstants.teacherAccessToken);
            myLog(label: "teacher is", value: token.toString());
            if (token != null) {
              LocalStorage().write(
                  key: StringConstants.userType,
                  data: StringConstants.teacherType);
              TeacherController().getEmployeeProfile().then((value) {
                Get.offAll(() => TeacherDashboard());
              });
              return;
            }
            loginNavigation(loginType);
            break;
          case StringConstants.parentType:
            var token =
                LocalStorage().read(key: StringConstants.parentAccessToken);
            myLog(label: "parent access token", value: token.toString());
            if (token != null) {
              myLog(label: "parent access token", value: token);
              LocalStorage().write(
                  key: StringConstants.userType,
                  data: StringConstants.parentType);
              ParentController().getStudentListr1();
              return;
            }
            loginNavigation(loginType);
            break;
          case StringConstants.principleType:
            var token =
                LocalStorage().read(key: StringConstants.principalAccessToken);
            myLog(label: "principal access token", value: token.toString());
            if (token != null) {
              myLog(label: "principal access token", value: token);
              LocalStorage().write(
                  key: StringConstants.userType,
                  data: StringConstants.principleType);
              PrincipalController().getStudentTeacherAttendanceSummary();
              return;
            }
            loginNavigation(loginType);
            break;
          case StringConstants.coordinatorType:
            var token = LocalStorage()
                .read(key: StringConstants.coordinatorAccessToken);
            myLog(label: "coordinator access token", value: token.toString());
            if (token != null) {
              myLog(label: "coordinator access token", value: token);
              LocalStorage().write(
                  key: StringConstants.userType,
                  data: StringConstants.coordinatorType);
              Get.to(() => CoordinatorDashboard());
              return;
            }
            loginNavigation(loginType);
            break;
          case StringConstants.receptionType:
            var token = LocalStorage()
                .read(key: StringConstants.receptionAccessToken);
            myLog(label: "reception access token", value: token.toString());
            if (token != null) {
           // if (true) {
              myLog(label: "reception access token", value: token);
              LocalStorage().write(
                  key: StringConstants.userType,
                  data: StringConstants.receptionType);
              Get.to(() => ReceptionDashboardScreen());
              return;
            }
            loginNavigation(loginType);
            break;
            default:
              showMessage(msg: "This module not available right now");
              //Get.to(()=>StudentSearchScreen());
        }
      },
      child: Container(
       width: MediaQuery.of(context).size.width*0.26,
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(1, 1), // changes position of shadow
              ),
              BoxShadow(
                offset: Offset(-1, -1),
                blurRadius: 1,
                spreadRadius: 1,
                color: Colors.grey.withOpacity(0.3),
              ),
            ]),
        child: Column(
          children: [
            Image.asset(
              assets,
              height: 60,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              type,
              style: CommonDecoration.subHeaderStyle.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  loginNavigation(loginType) {
    Get.to(
        () => LoginPage(
              type: loginType,
            ),
        duration: Duration(milliseconds: 1000));
  }
}
