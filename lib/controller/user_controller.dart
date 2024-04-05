import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/api/api_client.dart';
import 'package:web_school_manager/api/api_url.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/common_view/login_type.dart';
import 'package:web_school_manager/common_view/otp_verificaton.dart';
import 'package:web_school_manager/constants/string_constants.dart';
import 'package:web_school_manager/controller/parent_controller.dart';
import 'package:web_school_manager/controller/principal_controller.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/coordinator/coordinator_dashboard.dart';
import 'package:web_school_manager/local_storage/local_storage.dart';
import 'package:web_school_manager/model/login_model.dart';
import 'package:web_school_manager/model/login_scuccess_model.dart';
import 'package:web_school_manager/model/logout_model.dart';
import 'package:web_school_manager/parent_model/parent_module_list_model.dart';
import 'package:web_school_manager/principal_model/principal_module_list_model.dart';
import 'package:web_school_manager/reception/screen/reception_dashboard.dart';
import 'package:web_school_manager/teacher/teacher_dashboard.dart';
import 'package:web_school_manager/teacher_model/teacher_module_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';

class UserController {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static GlobalKey<ScaffoldState> drawerState = GlobalKey<ScaffoldState>();

  Future login(
      {required String instiCode,
      required String number,
      required String userType}) async {
    showLoader();
    String token = await getFcmToken();
    String platForm = platFormName();
    var raw = {
      "InstituteCode": instiCode,
      "MobileNo": number,
      "DeviceId": token,
      "DeviceType": platForm,
      "UserType": userType,
      "FCMID": token
    };
    var response = await ApiClient().post(ApiUrls.ValidateUserCredentials, raw);
    hideLoader();
    LoginModel loginModel = LoginModel.fromJson(response);
    if (loginModel.statuscode == "success") {
      if (loginModel.data!.isOTPRequired!) {
        LocalStorage().write(key: StringConstants.userType, data: userType);
        Get.to(() => OtpVerificationScreen(
              phoneNumber: number,
              instiCode: instiCode,
              userType: userType,
            ));
      } else {
        LoginSuccessModel loginSuccessModel =
            LoginSuccessModel.fromJson(response);
        if (loginSuccessModel.statuscode == "success") {
          NavigateToCorrectPage(
              loginSuccessModel: loginSuccessModel, userType: userType);
        } else {
          showMessage(msg: loginSuccessModel.message.toString());
        }
      }
    } else {
      showMessage(msg: loginModel.message.toString());
    }
  }

  Future otpVerification(
      {required String instiCode,
      required String number,
      required String userType,
      required String otpValue}) async {
    showLoader();
    String token = await getFcmToken();
    String platForm = platFormName();
    var raw = {
      "DeviceId": token,
      "DeviceType": platForm,
      "FCMID": token,
      "InstituteCode": instiCode,
      "MobileNo": number,
      "OTPValue": otpValue,
      "UserType": userType
    };
    var response = await ApiClient().post(ApiUrls.ValidateLoginOTPR1, raw);

    hideLoader();
    myLog(label: "my response ss ", value: jsonEncode(response));
    LoginSuccessModel loginSuccessModel = LoginSuccessModel.fromJson(response);
    if (loginSuccessModel.statuscode == "success") {
      switch(userType){
        case StringConstants.teacherType:
          LocalStorage().write(
              key: StringConstants.teacherAccessToken,
              data: loginSuccessModel.data!.accessToken.toString());
          LocalStorage().writeModel(
              key: StringConstants.teacherLoginSuccessModel,
              model: loginSuccessModel);
          break;
        case StringConstants.parentType:
          LocalStorage().write(
              key: StringConstants.parentAccessToken,
              data: loginSuccessModel.data!.accessToken.toString());
          LocalStorage().writeModel(
              key: StringConstants.parentLoginSuccessModel,
              model: loginSuccessModel);
          break;
        case StringConstants.principleType:
          LocalStorage().write(
              key: StringConstants.principalAccessToken,
              data: loginSuccessModel.data!.accessToken.toString());
          LocalStorage().writeModel(
              key: StringConstants.principalLoginSuccessModel,
              model: loginSuccessModel);
          break;
        case StringConstants.coordinatorType:
          LocalStorage().write(
              key: StringConstants.coordinatorAccessToken,
              data: loginSuccessModel.data!.accessToken.toString());
          LocalStorage().writeModel(
              key: StringConstants.coordinatorLoginSuccessModel,
              model: loginSuccessModel);
             NavigateToCorrectPage(loginSuccessModel: loginSuccessModel, userType: userType);
             return;
          break;
        case StringConstants.receptionType:
          LocalStorage().write(
              key: StringConstants.receptionAccessToken,
              data: loginSuccessModel.data!.accessToken.toString());
          LocalStorage().writeModel(
              key: StringConstants.receptionLoginSuccessModel,
              model: loginSuccessModel);
          NavigateToCorrectPage(loginSuccessModel: loginSuccessModel, userType: userType);
          return;
          break;
      }

      // LocalStorage().write(
      //     key: userType == StringConstants.teacherType
      //         ? StringConstants.teacherAccessToken
      //         :userType == StringConstants.parentType? StringConstants.parentAccessToken:StringConstants.principalAccessToken,
      //     data: loginSuccessModel.data!.accessToken.toString());
      // LocalStorage().writeModel(
      //     key: userType == StringConstants.parentType
      //         ? StringConstants.parentLoginSuccessModel
      //         :userType == StringConstants.teacherType? StringConstants.teacherLoginSuccessModel:StringConstants.principalLoginSuccessModel,
      //     model: loginSuccessModel);

      ///-----------get module list function-----------
      getModuleList(
        instiCode: instiCode,
        userType: userType,
        loginSuccessModel: loginSuccessModel,
      );

      ///---------------------------
    } else {
      showMessage(msg: loginSuccessModel.message.toString());
    }
  }

  Future getModuleList(
      {required String instiCode,
      required String userType,
      required LoginSuccessModel loginSuccessModel}) async {
    showLoader();

    var raw = {
      "InstituteCode": instiCode,
      "UserType": loginSuccessModel.data!.userType.toString(),
    };

    var response = await ApiClient().postWithToken(ApiUrls.GetModuleList, raw);
    hideLoader();

    if(response["statuscode"]=="error"){
      showMessage(msg: response["message"]);
      return;
    }

    ///---------principal-----------------
    if (userType == StringConstants.principleType) {
      PrincipalModuleListModel principalModuleListModel =
          PrincipalModuleListModel.fromJson(response);
      if (principalModuleListModel.statuscode == StringConstants.success) {
        LocalStorage().writeModel(
            key: StringConstants.principalModuleList,
            model: principalModuleListModel);
        NavigateToCorrectPage(
            loginSuccessModel: loginSuccessModel, userType: userType);
      }
    }

    ///-------teacher--------------------
    if (userType == StringConstants.teacherType) {
      TeacherModuleListModel teacherModuleListModel =
          TeacherModuleListModel.fromJson(response);
      if (teacherModuleListModel.statuscode == StringConstants.success) {
        LocalStorage().writeModel(
            key: StringConstants.teacherModuleList,
            model: teacherModuleListModel);
        NavigateToCorrectPage(
            loginSuccessModel: loginSuccessModel, userType: userType);
      }
    }

    ///-----------parent--------------------------
    if (userType == StringConstants.parentType) {
      ParentModuleListModel parentModuleListModel =
          ParentModuleListModel.fromJson(response);
      if (parentModuleListModel.statuscode == StringConstants.success) {
        LocalStorage().writeModel(
            key: StringConstants.parentModuleList,
            model: parentModuleListModel);
        NavigateToCorrectPage(
            loginSuccessModel: loginSuccessModel, userType: userType);
      }
    }
  }

  Future logout() async {
    var response =
        await ApiClient().postWithToken(ApiUrls.LogoutMobileUser, {});
    LogoutModel model = LogoutModel.fromJson(response);
    if (model.statuscode == "success") {
      LocalStorage().eraseData();
      Get.offAll(() => LoginType());
    } else {
      showMessage(msg: model.message.toString());
    }
  }

  NavigateToCorrectPage(
      {required LoginSuccessModel loginSuccessModel,
      required String userType}) {
    // LocalStorage().write(key: StringConstants.userType, data: loginSuccessModel.data!.userType);

    ///---------if teacher-----------
    if (loginSuccessModel.data!.userType == StringConstants.teacherType) {
      TeacherController().getEmployeeProfile().then((value) {
        Get.offAll(() => TeacherDashboard());
      });
    }

    ///-----------if student---------------
    else if (loginSuccessModel.data!.userType == StringConstants.parentType) {
      ParentController().getStudentListr1();
    }

    ///--------------if principal------------
    else if(loginSuccessModel.data!.userType == StringConstants.principleType){
      PrincipalController().getStudentTeacherAttendanceSummary();
    }

    ///--------------if reception-----------------------
    else if(loginSuccessModel.data!.userType == StringConstants.receptionType){
      Get.to(() => ReceptionDashboardScreen());
    }
    ///-------------if coordinator-----------------------
    else{
      Get.to(()=>CoordinatorDashboard());
    }
  }
}
