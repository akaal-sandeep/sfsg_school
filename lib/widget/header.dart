import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/constants/color_constants.dart';
import 'package:web_school_manager/constants/string_constants.dart';
import 'package:web_school_manager/controller/user_controller.dart';
import 'package:web_school_manager/generated/assets.dart';
import 'package:web_school_manager/local_storage/local_storage.dart';
import 'package:web_school_manager/model/login_scuccess_model.dart';
import '../parent_model/get_student_list_r1_model.dart';
import '../utility/custom_decoration.dart';
import '../utility/helper_widget.dart';

class CommonHeader extends StatelessWidget {
  String title;
  bool? showDrawer;
  Color? textColor;
  bool? hideStudentName;
  bool? showLogout;

  CommonHeader(
      {Key? key,
      required this.title,
      this.showDrawer,
      this.hideStudentName,
      this.showLogout,
      this.textColor})
      : super(key: key);
  StudentData studentData = StudentData();

  @override
  Widget build(BuildContext context) {
    String userType = LocalStorage().read(key: StringConstants.userType);
    myLog(label: "userType", value: userType);
    if (userType == "P") {
      var data = LocalStorage()
          .readStudentModel(key: StringConstants.parentProfileModel);
      if (data != null) {
        studentData = data;
      }
    }

    LoginSuccessModel? loginSuccessModel;
    switch (userType) {
      case StringConstants.parentType:
        loginSuccessModel = LocalStorage()
            .readModel(key: StringConstants.parentLoginSuccessModel);
        break;
      case StringConstants.teacherType:
        loginSuccessModel = LocalStorage()
            .readModel(key: StringConstants.teacherLoginSuccessModel);
        break;
      case StringConstants.principleType:
        loginSuccessModel = LocalStorage()
            .readModel(key: StringConstants.principalLoginSuccessModel);
        break;
      case StringConstants.coordinatorType:
        loginSuccessModel = LocalStorage()
            .readModel(key: StringConstants.coordinatorLoginSuccessModel);
        break;
      case StringConstants.receptionType:
        loginSuccessModel = LocalStorage()
            .readModel(key: StringConstants.receptionLoginSuccessModel);
        break;
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50)
                        .copyWith(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: 50,
                            width: 50,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(Assets.iconsNewLogo))),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                          "Sahibzada Fateh Singh Jee School",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 1,
                          color: textColor ?? Colors.black)),
                ],
              ),
              if (showDrawer == null)
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: .6,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: Icon(
                        Icons.arrow_back_ios_sharp,
                        color: ColorConstants.themeColor,
                      ),
                    ),
                  ),
                ),
              if (showDrawer == true)
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      UserController.drawerState.currentState!.openDrawer();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: .6,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: Icon(
                        Icons.menu,
                        color: ColorConstants.themeColor,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
        if (hideStudentName == null && userType == "P")
          Text(
            "${Get.currentRoute == "/StudentDashboard" ? "" : studentData.name.toString() + ","} ${studentData.className} [ ${studentData.classSectionName} ]",
            style: CommonDecoration.smallLabel,
          ),
      ],
    );
  }
}
