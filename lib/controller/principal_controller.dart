import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/api/api_client.dart';
import 'package:web_school_manager/api/api_url.dart';
import 'package:web_school_manager/constants/string_constants.dart';
import 'package:web_school_manager/principal/screen/student_list.dart';
import 'package:web_school_manager/principal/screen/teacher_attendance_summary.dart';
import 'package:web_school_manager/principal_model/fixed_appointment_list_principal_model.dart';
import 'package:web_school_manager/principal_model/student_attendance_details.dart';
import 'package:web_school_manager/local_storage/local_storage.dart';
import 'package:web_school_manager/principal/screen/student_attendance_summary.dart';
import 'package:web_school_manager/principal_model/principal_profile_model.dart';
import 'package:web_school_manager/principal_model/student_list_by_class_section_model.dart';
import 'package:web_school_manager/principal_model/student_teacher_attendance_model.dart';
import 'package:web_school_manager/principal_model/teacher_list_model.dart';
import 'package:web_school_manager/teacher/teacher_appointment.dart';

import 'package:web_school_manager/teacher_model/get_student_remarks_list.dart'as data;
import 'package:web_school_manager/teacher_model/get_fixed_appointments_list_for_teacher.dart';
import 'package:web_school_manager/teacher_model/get_fixed_appointments_list_for_teacher.dart'
    as teacherFixAppointment;
import 'package:web_school_manager/teacher_model/get_student_remarks_list.dart';
import 'package:web_school_manager/utility/helper_widget.dart';

import '../principal/screen/parent_push_notification.dart';
import '../principal/screen/principal_dashboard.dart';
import '../principal_model/getClassNotificationListModel.dart';
import '../principal_model/getClassNotificationListModel.dart'as classDataList;


class PrincipalController extends GetxController {
  List<data.Data> searchList=[];
  GetStudentRemarksListModel getStudentRemarksListModel=GetStudentRemarksListModel();


  TextEditingController? searchController;
  FocusNode? searchNode;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    searchController=TextEditingController();
    searchNode=FocusNode();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController!.dispose();

  }


  /*=========================================================Api to show Student Teacher Attendance Summary=========================================================*/
  Future getStudentTeacherAttendanceSummary() async {
    showLoader();
    var raw = {};
    var response = await ApiClient()
        .postWithToken(ApiUrls.getStudentTeacherAttendanceSummary, raw);
    hideLoader();
    StudentTeacherAttendanceModel studentTeacherAttendanceModel =
        StudentTeacherAttendanceModel.fromJson(response);
    if (studentTeacherAttendanceModel.statuscode == StringConstants.success) {
      getPrincipalProfile(studentTeacherAttendanceModel);
    } else {
      showMessage(msg: studentTeacherAttendanceModel.message);
    }
  }

  Future getPrincipalProfile(studentTeacherAttendanceModel) async {
    showLoader();
    var raw = {};
    var response =
        await ApiClient().postWithToken(ApiUrls.getPrincipalProfile, raw);
    hideLoader();
    PrincipalProfileModel principalProfileModel =
        PrincipalProfileModel.fromJson(response);
    LocalStorage().writePrincipalProfile(model: principalProfileModel);

    if (principalProfileModel.statuscode == StringConstants.success) {
      Get.offAll(PrincipalDashboard(
          studentTeacherAttendanceModel: studentTeacherAttendanceModel,
          principalProfileModel: principalProfileModel));
    }
  }

  /*=========================================================Api to show Student Attendance Details=========================================================*/

  Future getStudentAttendanceDetails({bool? fromCoordinated}) async {
    showLoader();
    var raw = {};
    var response = await ApiClient()
        .postWithToken(ApiUrls.getStudentAttendanceDetails, raw);
    hideLoader();
    StudentAttendanceDetailsModel studentAttendanceDetails =
        StudentAttendanceDetailsModel.fromJson(response);
    if (studentAttendanceDetails.statuscode == StringConstants.success) {
      if(fromCoordinated==true){
        return studentAttendanceDetails;
      }

      Get.to(() => StudentAttendanceSummary(
            studentAttendanceDetails: studentAttendanceDetails,
        fromCoordinator: fromCoordinated,
          ));
    } else {
      showMessage(msg: studentAttendanceDetails.message);
    }
  }

  /*=========================================================Api to show Student List Details =========================================================*/

  Future getStudentListByClassSection({
    var admissionNumber,
    var classMasterId,
    var classMasterSectionId,
    var employeeMasterId,
    var fromDate,
    var id,
    var sectionMasterId,
    var subjectMasterId,
    var toDate,
    var filter
  }) async {
    showLoader();
    var raw = {
      "AdmissionNumber": admissionNumber,
      "ClassMasterId": classMasterId,
      "ClassSectionMasterId": classMasterSectionId,
      "EmployeeMasterId": employeeMasterId,
      "FromDate": fromDate,
      "Id": id,
      "SectionMasterId": sectionMasterId,
      "SubjectMasterId": subjectMasterId,
      "ToDate": toDate,
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.getStudentListByClassSection, raw);
    hideLoader();
    StudentListByClassSectionModel studentListByClassSectionModel =
        StudentListByClassSectionModel.fromJson(response);
    if (studentListByClassSectionModel.statuscode == StringConstants.success) {
      myLog(label: "checked", value: filter);

      if(filter=="all"){
        Get.to(() => StudentListScreen(
          studentListByClassSectionModel: studentListByClassSectionModel,
        ));
        return;
      }

      if(filter!="present"){
        studentListByClassSectionModel.data!.removeWhere((element)=>element.attendanceStatus=="P");
      }

      if(filter!="absent"){
        studentListByClassSectionModel.data!.removeWhere((element)=>element.attendanceStatus=="A");
        studentListByClassSectionModel.data!.removeWhere((element)=>element.attendanceStatus=="L");

      }

      if(filter!="pending"){
        studentListByClassSectionModel.data!.removeWhere((element)=>element.attendanceStatus=="");
      }


      Get.to(() => StudentListScreen(
            studentListByClassSectionModel: studentListByClassSectionModel,
          ));
    } else {
      showMessage(msg: studentListByClassSectionModel.message);
    }
  }

  /*=========================================================Api to get teacher list =========================================================*/

  Future getTeacherList() async {
    showLoader();
    var raw = {};
    var response = await ApiClient().postWithToken(ApiUrls.getTeacherList, raw);
    hideLoader();
    TeacherListModel teacherListModel = TeacherListModel.fromJson(response);
    if (teacherListModel.statuscode == StringConstants.success) {
      Get.to(() => TeacherAttendanceScreen(
            teacherListModel: teacherListModel,
          ));
    } else {
      showMessage(msg: teacherListModel.message);
    }
  }

  Future <TeacherListModel>getTeacherListReturn() async {

    var raw = {};
    var response = await ApiClient().postWithToken(ApiUrls.getTeacherList, raw);
    TeacherListModel teacherListModel = TeacherListModel.fromJson(response);
    return teacherListModel;
  }

/*=========================================================Api to get fixed appointment List for Principal =========================================================*/

  Future getFixedAppointmentListForPrincipal({
    var fromdate,
    bool? navigate,
  }) async {
    showLoader();
    var raw = {
      "EmployeeMasterId": 0.toString(),
      "FromDate": fromdate,
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.getFixedAppointmentListForPrincipal, raw);
    hideLoader();
    FixedAppointmentListModel fixedAppointmentListModel =
        FixedAppointmentListModel.fromJson(response);


    if (fixedAppointmentListModel.statuscode == StringConstants.success) {
      GetFixedAppointmentsListforTeacher getFixedAppointmentsListforTeacher =
      GetFixedAppointmentsListforTeacher();
      getFixedAppointmentsListforTeacher.data = [];
      for (int i = 0; i < fixedAppointmentListModel.data!.length; i++) {
        getFixedAppointmentsListforTeacher.data!.add(teacherFixAppointment.Data(
          id: fixedAppointmentListModel.data![i].id,
          appointmentDate: fixedAppointmentListModel.data![i].appointmentDate,
          appointmentTime: fixedAppointmentListModel.data![i].appointmentTime,
          appointmentTimeString:
          fixedAppointmentListModel.data![i].appointmentTimeString,
          appointmentWith: fixedAppointmentListModel.data![i].appointmentWith,
          employeeMasterId: fixedAppointmentListModel.data![i].employeeMasterId,
          employeeName: fixedAppointmentListModel.data![i].employeeName,
          employeePhotoUrlForMobileApp:
          fixedAppointmentListModel.data![i].employeePhotoUrlForMobileApp,
          parentMobileNumber:
          fixedAppointmentListModel.data![i].parentMobileNumber,
          studentMasterId: fixedAppointmentListModel.data![i].studentMasterId,
          rollNumber: fixedAppointmentListModel.data![i].rollNumber,
          admissionNumber: fixedAppointmentListModel.data![i].admissionNumber,
          classMasterId: fixedAppointmentListModel.data![i].classMasterId,
          className: fixedAppointmentListModel.data![i].className,
          classSectionMasterId:
          fixedAppointmentListModel.data![i].classSectionMasterId,
          classSectionName: fixedAppointmentListModel.data![i].classSectionName,
          fatherName: fixedAppointmentListModel.data![i].fatherName,
          motherName: fixedAppointmentListModel.data![i].motherName,
          relationMasterId: fixedAppointmentListModel.data![i].relationMasterId,
          relationName: fixedAppointmentListModel.data![i].relationName,
          studentPhotoUrlForMobileApp:
          fixedAppointmentListModel.data![i].studentPhotoUrlForMobileApp,
          isActive: fixedAppointmentListModel.data![i].isActive,
          appointmentDateRequested: "",
          studentName: fixedAppointmentListModel.data![i].studentName,
        ));
      }

      if(navigate??true){
        Get.to(()=>TeacherAppointment(getFixedAppointmentsListforTeacher: getFixedAppointmentsListforTeacher));
      }else{
        return  getFixedAppointmentsListforTeacher;
      }

    }
    else{
      showMessage(msg: fixedAppointmentListModel.message);
    }
  }


  Future pushTeacherNotification({required String subject,required String content,String?remark})async{
    showLoader();
    var body = {
      "NotificationSubject": "${subject}",
      "NotificationContents": "${content}",
      "Remarks": "${remark}"
    };
    var response =await ApiClient().postWithToken(ApiUrls.SaveTeacherNotificationLog, body);
    hideLoader();
    if(response['statuscode']==StringConstants.success){
        Get.back();
        showMessage(msg:response['message']);
    }else{
      showMessage(msg:response['message']);
    }
  }

  Future pushParentNotification({required String subject,required String content,String?remark,required List<classDataList.Data> classList })async{
    showLoader();
    List data = [];
    for(var u in classList){
      data.add(u.toJson());
    }

    var body = {
      "NotificationSubject": "${subject}",
      "NotificationContents": "${content}",
      "Remarks": "${remark}",
      "ClassList":data
    };
    var response =await ApiClient().postWithTokenAndEncoding(ApiUrls.SaveParentNotificationLog, jsonEncode(body));
    hideLoader();
    if(response['statuscode']==StringConstants.success){
      Get.back();
      showMessage(msg:response['message']);
    }else{
      showMessage(msg:response['message']);
    }
  }


  Future getClassListForNotification()async{
    showLoader();
    var response =await ApiClient().postWithToken(ApiUrls.GetClassSectionListForPushNotification, {});
    hideLoader();
    GetClassSectionListForPushNotificationModel getClassSectionListForPushNotificationModel = GetClassSectionListForPushNotificationModel.fromJson(response);
    if(getClassSectionListForPushNotificationModel.statuscode == StringConstants.success){
      Get.to(()=>ParentPushNotification(getClassSectionListForPushNotificationModel: getClassSectionListForPushNotificationModel,));
    }else{
      showMessage(msg: getClassSectionListForPushNotificationModel.message);
    }

  }
}
