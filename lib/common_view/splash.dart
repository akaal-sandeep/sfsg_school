import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/bio_metric.dart';
import 'package:web_school_manager/common_view/login_type.dart';
import 'package:web_school_manager/fcm/fcm_service.dart';
import 'package:web_school_manager/generated/assets.dart';

import '../constants/string_constants.dart';
import '../controller/parent_controller.dart';
import '../controller/principal_controller.dart';
import '../controller/teacher_controller.dart';
import '../local_storage/local_storage.dart';
import '../teacher/teacher_dashboard.dart';
import '../utility/helper_widget.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  BioMetric bioMetric = BioMetric();

  @override
  void initState() {
    bioMetric.init();
    Timer(Duration(seconds: 3), () {
      checkLogin();
    });
    // TODO: implement initState
    super.initState();
  }

  checkLogin()async{

    ///---------principal---------------------------

    var token = LocalStorage().read(key: StringConstants.principalAccessToken);
    myLog(label: "principal access token", value: token.toString());
    if(token!=null){


      if(LocalStorage().isBioMetricEnable()==null){
        await bioMetric.bioMetricDialog();
      }
      else if(LocalStorage().isBioMetricEnable()==true){
        bool auth =  await bioMetric.factorTwoAuth();
        if(auth){
          myLog(label: "principal access token", value: token);
          LocalStorage().write(key: StringConstants.userType,data: StringConstants.principleType);
          PrincipalController().getStudentTeacherAttendanceSummary();
        }else{
          exit(0);
        }
      }
      else{
        myLog(label: "principal access token", value: token);
        LocalStorage().write(key: StringConstants.userType,data: StringConstants.principleType);
        PrincipalController().getStudentTeacherAttendanceSummary();
      }

      return;
    }

    ///---------------teacher-----------------
    var tokenTeacher = LocalStorage().read(key: StringConstants.teacherAccessToken);
    myLog(label: "teacher access token", value: tokenTeacher.toString());
    if(tokenTeacher!=null){

      if(LocalStorage().isBioMetricEnable()==null){
        await bioMetric.bioMetricDialog();
      }
      else if(LocalStorage().isBioMetricEnable()==true){
        bool auth =  await bioMetric.factorTwoAuth();
        if(auth){
          LocalStorage().write(key: StringConstants.userType,data: StringConstants.teacherType);
          TeacherController().getEmployeeProfile().then((value){
            Get.offAll(()=>TeacherDashboard());
          });
        }else{
          exit(0);
        }
      }
      else{
        LocalStorage().write(key: StringConstants.userType,data: StringConstants.teacherType);
        TeacherController().getEmployeeProfile().then((value){
          Get.offAll(()=>TeacherDashboard());
        });
      }

      return;
    }
    ///---------------parent-----------------
    var parentToken = LocalStorage().read(key: StringConstants.parentAccessToken);
    myLog(label: "parent access token", value: parentToken.toString());
    if(parentToken!=null){
      if(LocalStorage().isBioMetricEnable()==null){
      await bioMetric.bioMetricDialog();
      }
      else if(LocalStorage().isBioMetricEnable()==true){
      bool auth =  await bioMetric.factorTwoAuth();
      if(auth){
        myLog(label: "parent access token", value: parentToken);
        LocalStorage().write(key: StringConstants.userType,data: StringConstants.parentType);
        checkSplash().then((value){
          if(value==false){
            ParentController().getStudentListr1();
            return;
          }
        });
      }else{
        exit(0);
      }
      }
      else{
        myLog(label: "parent access token", value: parentToken);
        LocalStorage().write(key: StringConstants.userType,data: StringConstants.parentType);
        checkSplash().then((value){
          if(value==false){
            ParentController().getStudentListr1();
            return;
          }
        });
      }

      return;
    }

    ///---------------loginScreen-------------------
    Get.off(()=>LoginType());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color:Color(0xff224e7f),
        color: Colors.white,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(Assets.iconsNewLogo,),
          )),
    );
  }
}
