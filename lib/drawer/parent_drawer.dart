
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/common_view/login_type.dart';
import 'package:web_school_manager/constants/color_constants.dart';
import 'package:web_school_manager/principal_model/principal_profile_model.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';

import '../constants/string_constants.dart';
import '../controller/drawer_controller.dart';
import '../generated/assets.dart';
import '../local_storage/local_storage.dart';
import '../model/login_scuccess_model.dart';
import '../parent_model/get_student_list_r1_model.dart';
import '../teacher_model/employee_profile_model.dart';

class ParentDrawer extends StatelessWidget {
  ParentDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? contact;
    String userType = LocalStorage().read(key: StringConstants.userType);
    LoginSuccessModel? loginSuccessModel;
    switch(userType){
      case StringConstants.parentType:
        GetStudentListR1Model getStudentListR1Model = LocalStorage().readStudentList();
        contact= getStudentListR1Model.data!.first.fatherMobile??"";
        loginSuccessModel = LocalStorage().readModel(key:  StringConstants.parentLoginSuccessModel);
        break;
      case StringConstants.teacherType:
        EmployeeProfileModel model=LocalStorage().readTeacherProfileModel(key: StringConstants.teacherProfileModel);
        contact = model.data!.mobileNo.toString();
        loginSuccessModel = LocalStorage().readModel(key:  StringConstants.teacherLoginSuccessModel);
        break;
      case StringConstants.principleType:
        PrincipalProfileModel principalProfileModel = LocalStorage().readPrincipalProfileModel();
        contact = principalProfileModel.data!.mobileNo.toString();
        loginSuccessModel = LocalStorage().readModel(key:  StringConstants.principalLoginSuccessModel);
        break;
      case StringConstants.coordinatorType:
          LoginSuccessModel myModel = LocalStorage().readModel(key: StringConstants.coordinatorLoginSuccessModel);
          contact = myModel.data!.instituteContactNumber.toString();
          loginSuccessModel = LocalStorage().readModel(key:  StringConstants.coordinatorLoginSuccessModel);
        break;
      case StringConstants.receptionType:
        LoginSuccessModel myModel = LocalStorage().readModel(key: StringConstants.receptionLoginSuccessModel);
        contact = myModel.data!.instituteContactNumber.toString();
        loginSuccessModel = LocalStorage().readModel(key:  StringConstants.receptionLoginSuccessModel);
        break;
    }
    // if (userType == StringConstants.parentType){
    //   GetStudentListR1Model getStudentListR1Model = LocalStorage().readStudentList();
    //   contact= getStudentListR1Model.data!.first.fatherMobile??"";
    // }else if(userType == StringConstants.teacherType){
    //   EmployeeProfileModel model=LocalStorage().readTeacherProfileModel(key: StringConstants.teacherProfileModel);
    //   contact = model.data!.mobileNo.toString();
    // }else{
    //   PrincipalProfileModel principalProfileModel = LocalStorage().readPrincipalProfileModel();
    // contact = principalProfileModel.data!.mobileNo.toString();
    // }


    //   LoginSuccessModel loginSuccessModel = LocalStorage().readModel(
    //       key: userType == StringConstants.parentType
    //           ? StringConstants.parentLoginSuccessModel
    //           : userType == StringConstants.teacherType
    //               ? StringConstants.teacherLoginSuccessModel
    //               : StringConstants.principalLoginSuccessModel);
    // myLog(label: "date", value: jsonEncode(loginSuccessModel.toJson()));
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
        child: Column(
            children: [
              Container(
                color: ColorConstants.themeColor,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(Assets.iconsNewLogo)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sahibzada Fateh Singh Jee School",
                            style: CommonDecoration.bigLabel
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            "${contact}",
                            style: CommonDecoration.bigLabel
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              smallSpace(),
              item(iconData: Icons.home, label: "Home"),
              item(iconData: Icons.pages, label: "Notice Board"),
              item(iconData: Icons.holiday_village, label: "Holidays"),
              item(iconData: Icons.photo_library_outlined, label: "Gallery"),
              item(iconData: Icons.newspaper_outlined, label: "Press Release"),
              item(iconData: Icons.notifications_active, label: "Notifications"),
             // item(iconData: Icons.sports, label: "Sports Schedule"),
              item(iconData: Icons.contact_mail_sharp, label: "Contact Us"),
              smallSpace(),
              greyLine(),
              smallSpace(),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Account Settings",
                      style: CommonDecoration.bigLabel,
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              item(iconData: Icons.swap_horiz_sharp, label: "Switch Account"),
              item(iconData: Icons.power_settings_new, label: "Logout"),
            ],
          ),
        ),
      ),
    );
  }

  Widget item({required IconData iconData, required String label}) {
    return InkWell(
      onTap: () {
        Get.back();
        if (label == "Notice Board") {
          ParentDrawerController().getParentNoticeBoardList();
        }
        if (label == "Holidays") {
          ParentDrawerController().getHolidaysList();
        }
        if (label == "Gallery") {
          ParentDrawerController().getGalleryData();
        }
        if (label == "Press Release") {
          ParentDrawerController().getParentPressRelease();
        }
        if (label == "Notifications") {
          ParentDrawerController().getNotificationList();
        }
        if (label == "Sports Schedule") {
          ParentDrawerController().getSportsScheduleList();
        }
        if (label == "Contact Us") {
          ParentDrawerController().contactUs();
        }
        if (label == "Logout") {
          logoutDialog();
        }
        if (label == "Switch Account") {
          Get.offAll(() => LoginType());
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Icon(
              iconData,
              size: 25,
              color: Colors.grey,
            ),
            SizedBox(
              width: 30,
            ),
            Text(
              label,
              style: CommonDecoration.bigLabel
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
