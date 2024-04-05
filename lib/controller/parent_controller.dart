import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:web_school_manager/api/api_client.dart';
import 'package:web_school_manager/api/api_url.dart';
import 'package:web_school_manager/model/date_class_homework_parent_model.dart';
import 'package:web_school_manager/parent/bag_component_list_screen.dart';
import 'package:web_school_manager/parent/homework/date_homework.dart';
import 'package:web_school_manager/parent/homework/home_work_details.dart'
    as document;
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/constants/string_constants.dart';
import 'package:web_school_manager/controller/parent_state_controller.dart';
import 'package:web_school_manager/controller/teacher_state_controller.dart';
import 'package:web_school_manager/local_storage/local_storage.dart';
import 'package:web_school_manager/parent/class_test/class_test.dart';
import 'package:web_school_manager/parent/fee_ledger.dart';
import 'package:web_school_manager/parent/student_lesson_plan.dart';
import 'package:web_school_manager/parent/time_table.dart';
import 'package:web_school_manager/parent_model/date_sheet_model.dart';
import 'package:web_school_manager/parent_model/employee_list_for%20appointment_model.dart';
import 'package:web_school_manager/parent_model/fee_ledger_model.dart';
import 'package:web_school_manager/parent_model/get_circular_list_model.dart';
import 'package:web_school_manager/parent_model/get_class_home_work_with_read_status.dart';
import 'package:web_school_manager/parent_model/get_student_list_r1_model.dart';
import 'package:web_school_manager/parent_model/get_student_requested_appointments_model.dart';
import 'package:web_school_manager/parent_model/home_work_uploaded_student_model.dart';
import 'package:web_school_manager/parent_model/relation_model.dart';
import 'package:web_school_manager/parent_model/student_attendance_model.dart';
import 'package:web_school_manager/parent_model/student_bag_component_model.dart';
import 'package:web_school_manager/parent_model/student_timetable_model.dart';
import 'package:web_school_manager/parent_model/test_details_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import '../model/login_scuccess_model.dart';
import '../parent/appointments/appointments.dart';
import '../parent/circular.dart';
import '../parent/class_test/test_details.dart';
import '../parent/homework/home_work_details.dart';
import '../parent/homework/student_homework.dart';
import '../parent/leave/parent/leave_applied_parent.dart';
import '../parent/map_screen.dart';
import '../parent/user_list.dart';
import '../parent_model/class_test_list_model.dart';
import '../parent_model/coordinates_model.dart';
import '../parent_model/student_leave_model.dart';
import '../parent_model/user_list_model.dart';
import '../teacher_model/get_lesson_plan_list.dart';


class ParentController {
  final teacherStateController = Get.put(TeacherStateController());
  final parentStateController = Get.put(ParentStateController());

  Future getStudentListr1() async {
    showLoader();
    var response =
        await ApiClient().postWithToken(ApiUrls.GetStudentListR1, {});
    hideLoader();
    GetStudentListR1Model getStudentListR1Model =
        GetStudentListR1Model.fromJson(response);
    LocalStorage().writeStudentList(model: getStudentListR1Model);
    Get.offAll(() => UserList(
          getStudentListR1Model: getStudentListR1Model,
        ));
  }

  Future<StudentAttendanceModel> getStudentAttendance(
      {required String month, required String year, String? admissionNumber}) async {
    showLoader();
    StudentData studentData =
        LocalStorage().readStudentModel(key: StringConstants.profileModel);
    var raw = {
      "AdmissionNumber":admissionNumber??studentData.admissionNumber.toString(),
      "MonthNo": month,
      "YearNo": year
    };
    var response =
        await ApiClient().postWithToken(ApiUrls.StudentAttendance, raw);
    hideLoader();
    StudentAttendanceModel studentAttendanceModel =
        StudentAttendanceModel.fromJson(response);
    return studentAttendanceModel;
  }
///------------------------------------------------------------
  Future getUserDeviceListWSM() async {
    showLoader();
    String? deviceId = await PlatformDeviceId.getDeviceId;
    LoginSuccessModel loginSuccessModel = LocalStorage().readModel(key:  StringConstants.parentLoginSuccessModel);
    StudentData studentData =
    LocalStorage().readStudentModel(key: StringConstants.parentProfileModel);
    String url = ApiUrls.GetUserDeviceListWSM+"?InstituteCode=${loginSuccessModel.data?.instituteCode??""}&UserMasterId=${studentData.id}&UserType=PARENT&PhoneSerialNo=$deviceId";
    var response =
    await ApiClient().getWithTokenForTracker(url);
    myLog(label: "san", value: "${jsonEncode(response)}");
    hideLoader();
    DeviceListModel deviceListModel = DeviceListModel.fromJson(response);
    if(deviceListModel.statuscode == "Success"){
      int length = deviceListModel.data?.length??0;
      if(length==0){
        showMessage(msg: "No Device Connected");
        return;
      }
      getCoordinatesByDeviceIdWSM(id: deviceListModel.data?[0].id.toString()??"0");
    }else{
      showMessage(msg:deviceListModel.message);
    }
  }

  Future getCoordinatesByDeviceIdWSM({required String id, bool? navigate})async{
    if(navigate!=false){
      showLoader();
    }

    String? deviceId = await PlatformDeviceId.getDeviceId;
    String url = ApiUrls.GetCoordinatesByDeviceIdList +
        "?DeviceIds=$id&PhoneSerialNo=$deviceId";
    var response   = await ApiClient().getWithTokenForTracker(url);
    myLog(label: "san", value: "${jsonEncode(response)}");

    if(navigate!=false){
      hideLoader();
    }
    CoordinatesModel coordinatesModel = CoordinatesModel.fromJson(response);
    if(coordinatesModel.statuscode=="Success"){
      if(navigate==false){
        return coordinatesModel.data![0];
      }
      BitmapDescriptor.fromAssetImage(
          ImageConfiguration(
              devicePixelRatio: .5,
              size: Size(10, 10)),
          "assets/icons/ios_green.png")
          .then((green) {
        BitmapDescriptor.fromAssetImage(
            ImageConfiguration(
                devicePixelRatio: .5,
                size: Size(10, 10)),
            "assets/icons/ios_red.png")
            .then((red) {
          BitmapDescriptor.fromAssetImage(
              ImageConfiguration(
                  devicePixelRatio: .5,
                  size: Size(10, 10)),
              "assets/icons/ios_orange.png")
              .then((orange) {
            Get.to(()=>MapScreenSchool(
              trackId: int.parse(id),
              locations: coordinatesModel.data![0],
              green: green,
              red: red,
              orange: orange,
            ));
          });
        });
      });
    }else{
      showMessage(msg: "Something went wrong");
    }
  }
  ///---------------------------------------------------------

  Future getClassHomeWorkWithReadStatus({String? admissionNumber}) async {
    showLoader();
    StudentData studentData = LocalStorage().readStudentModel(key: StringConstants.profileModel);
    var raw = {
      "AdmissionNo":admissionNumber??studentData.admissionNumber.toString(),
    };
    var response = await ApiClient().postWithToken(ApiUrls.GetClassHomeWorkWithReadStatus, raw);
    hideLoader();
    GetClassHomeWorkWithReadStatusModel getClassHomeWorkWithReadStatusModel =
        GetClassHomeWorkWithReadStatusModel.fromJson(response);
    Get.to(() => StudentHomework(
          getClassHomeWorkWithReadStatusModel:
              getClassHomeWorkWithReadStatusModel,
          title: 'Home Work',
        ));
  }

  Future getHolidayHomeWorkWithReadStatus() async {
    showLoader();
    StudentData studentData =
        LocalStorage().readStudentModel(key: StringConstants.profileModel);
    var raw = {
      "AdmissionNo": studentData.admissionNumber.toString(),
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetHolidayHomeWorkWithReadStatus, raw);
    hideLoader();
    GetClassHomeWorkWithReadStatusModel getClassHomeWorkWithReadStatusModel =
        GetClassHomeWorkWithReadStatusModel.fromJson(response);
    Get.to(() => StudentHomework(
          getClassHomeWorkWithReadStatusModel:
              getClassHomeWorkWithReadStatusModel,
          title: 'Holiday Home Work',
        ));
  }

  Future getLessonPlanListForStudent(
      {bool? navigate, String? fromDate, String? toDate}) async {
    showLoader();
    StudentData studentData =
        LocalStorage().readStudentModel(key: StringConstants.profileModel);
    var raw = {
      "AdmissionNumber": studentData.admissionNumber.toString(),
      "ClassMasterId": "-1",
      "ClassSectionMasterId": "-1",
      "EmployeeMasterId": "-1",
      "FromDate": fromDate ??
          DateFormat("MMM dd, yyyy")
              .format(DateTime.now().subtract(Duration(days: 60))),
      "Id": "-1",
      "ToDate": toDate ??
          DateFormat("MMM dd, yyyy")
              .format(DateTime.now().add(Duration(days: 60))),
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetLessonPlanListForStudent, raw);
    hideLoader();
    GetLessonPlanListModel getLessonPlanListModel =
        GetLessonPlanListModel.fromJson(response);
    if (getLessonPlanListModel.statuscode == StringConstants.success) {
      teacherStateController.updateGetLessonPlanListModel(
          model: getLessonPlanListModel);
      if (navigate ?? true) {
        Get.to(() => StudentLessonPlan(
              fromDate: fromDate ??
                  DateFormat("MMM dd, yyyy")
                      .format(DateTime.now().subtract(Duration(days: 60))),
              toDate: toDate ??
                  DateFormat("MMM dd, yyyy")
                      .format(DateTime.now().add(Duration(days: 60))),
            ));
      }
    } else {
      showMessage(msg: getLessonPlanListModel.message.toString());
    }
  }

  Future getStudentTimeTable() async {
    showLoader();
    StudentData studentData =
        LocalStorage().readStudentModel(key: StringConstants.profileModel);
    var raw = {
      "AdmissionNumber": studentData.admissionNumber.toString(),
    };
    var response =
        await ApiClient().postWithToken(ApiUrls.StudentTimeTable, raw);
    hideLoader();
    StudentTimeTableModel studentTimeTableModel =
        StudentTimeTableModel.fromJson(response);
    Get.to(() => TimeTable(studentTimeTableModel: studentTimeTableModel));
  }

  Future getClassTestSubject() async {
    showLoader();
    StudentData studentData =
        LocalStorage().readStudentModel(key: StringConstants.profileModel);
    var raw = {
      "AdmissionNumber": studentData.admissionNumber.toString(),
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetSubjectListForClassTest, raw);
    hideLoader();
    ClassTestListModelStudent classTestListModel =
        ClassTestListModelStudent.fromJson(response);
    Get.to(() => ClassTest(
          classTestListModel: classTestListModel,
        ));
  }

  Future getClassTestList({required String subjectMasterId}) async {
    showLoader();
    StudentData studentData =
        LocalStorage().readStudentModel(key: StringConstants.profileModel);
    var raw = {
      "SubjectMasterId": subjectMasterId,
      "AdmissionNumber": studentData.admissionNumber.toString(),
    };
    var response =
        await ApiClient().postWithToken(ApiUrls.GetClassTestList, raw);
    hideLoader();
    TestDetailsModel testDetailsModel = TestDetailsModel.fromJson(response);
    Get.to(() => TestDetails(
          testDetailsModel: testDetailsModel,
        ));
  }

  Future getFeeLedger() async {
    showLoader();
    StudentData studentData =
        LocalStorage().readStudentModel(key: StringConstants.profileModel);
    var raw = {
      "AdmissionNumber": studentData.admissionNumber.toString(),
    };
    var response = await ApiClient().postWithToken(ApiUrls.FeeLeggerR2, raw);
    hideLoader();
    FeeLedgerModel feeLedgerModel = FeeLedgerModel.fromJson(response);
    Get.to(() => FeeLedger(
          feeLedgerModel: feeLedgerModel,
        ));
  }

  Future getCircular() async {
    showLoader();
    StudentData studentData =
        LocalStorage().readStudentModel(key: StringConstants.profileModel);
    var raw = {
      "AdmissionNumber": studentData.admissionNumber.toString(),
    };
    var response =
        await ApiClient().postWithToken(ApiUrls.GetClassCircularList, raw);
    hideLoader();
    CircularListModel circularListModel = CircularListModel.fromJson(response);
    Get.to(() => CircularParent(
          circularListModel: circularListModel,
        ));
  }

  Future getCircularOther() async {
    showLoader();
    var raw = {
      "AdmissionNumber": "",
    };
    var response =
    await ApiClient().postWithToken(ApiUrls.GetClassCircularList, raw);
    hideLoader();
    CircularListModel circularListModel = CircularListModel.fromJson(response);
    Get.to(() => CircularParent(
      circularListModel: circularListModel,
    ));
  }

  Future getDateSheet() async {
    showLoader();
    StudentData studentData =
        LocalStorage().readStudentModel(key: StringConstants.profileModel);
    var raw = {
      "ClassMasterId": studentData.classMasterId.toString(),
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetDateSheetListByClassSection, raw);
    hideLoader();
    DateSheetModel dateSheetModel = DateSheetModel.fromJson(response);
    if (dateSheetModel.statuscode == StringConstants.success) {
      try{
        viewDocument(
            fileSource: dateSheetModel.data![0].absoluteImagePath ?? "",
            fromUrl: true);
      }catch(e){
        showMessage(msg: "Document not found");
      }

    } else {
      showMessage(msg: dateSheetModel.message);
    }
  }

  Future getDateSheetByClassId({required String classMaterId}) async {
    showLoader();
    StudentData studentData =
    LocalStorage().readStudentModel(key: StringConstants.profileModel);
    var raw = {
            "ClassMasterId": classMaterId,
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetDateSheetListByClassSection, raw);
    hideLoader();
    DateSheetModel dateSheetModel = DateSheetModel.fromJson(response);
    if (dateSheetModel.statuscode == StringConstants.success) {
      viewDocument(
          fileSource: dateSheetModel.data![0].absoluteImagePath ?? "",
          fromUrl: true);
    } else {
      showMessage(msg: dateSheetModel.message);
    }
  }

  Future getStudentLeaveApplyList(
      {bool? navigate,
      required String fromDate,
      required String toDate}) async {
    showLoader();
    StudentData studentData =
        LocalStorage().readStudentModel(key: StringConstants.profileModel);
    var raw = {
      "ClassMasterId": studentData.classMasterId.toString(),
      "SectionMasterId": studentData.classSectionMasterId.toString(),
      "SearchFromDate": fromDate,
      "SearchToDate": toDate
    };
    var response =
        await ApiClient().postWithToken(ApiUrls.GetStudentLeaveApplyList, raw);
    hideLoader();
    StudentAppliedLeaveModel studentLeaveApplyList =
        StudentAppliedLeaveModel.fromJson(response);
    if (studentLeaveApplyList.statuscode == StringConstants.success) {
      parentStateController.updateStudentLeaveModel(
          model: studentLeaveApplyList);
      if (navigate ?? true) {
        Get.to(() => LeaveAppliedParent(
              fromDateT: fromDate,
              toDateT: toDate,
            ));
      } else {
        return studentLeaveApplyList;
      }
    } else {
      showMessage(msg: studentLeaveApplyList.message);
    }
  }

  Future studentLeaveApply(
      {required String leaveMasterId,
      required String leaveDays,
      required String fromDate,
      required String toDate,
      required String remarks}) async {
    showLoader();
    StudentData studentData =
        LocalStorage().readStudentModel(key: StringConstants.profileModel);
    var raw = {
      "Id": "0",
      "StudentMasterId": studentData.id.toString(),
      "StudentLeaveReasonMasterId": leaveMasterId,
      "Remarks": remarks,
      "LeaveDays": leaveDays,
      "FromDate": fromDate,
      "ToDate": toDate
    };
    var response =
        await ApiClient().postWithToken(ApiUrls.SaveStudentLeaveApply, raw);
    hideLoader();
    if (response["statuscode"] == "success") {
      showMessage(msg: response["message"]);
      getStudentLeaveApplyList(
              fromDate:
                  getTimeFormat(DateTime.now().subtract(Duration(days: 90))),
              toDate: getTimeFormat(DateTime.now().add(Duration(days: 90))),
              navigate: false)
          .then((value) {
        Get.back();
      });
    } else {
      showMessage(msg: response["message"]);
    }
  }

  Future getRequestedAppointment(
      {required String fromDate, bool? navigate}) async {
    showLoader();
    var raw = {"FromDate": fromDate};
    var response =
        await ApiClient().postWithToken(ApiUrls.GetRequestedAppointments, raw);
    hideLoader();
    RequestedAppointmentStudentModel requestedAppointmentStudentModel =
        RequestedAppointmentStudentModel.fromJson(response);
    if (requestedAppointmentStudentModel.statuscode ==
        StringConstants.success) {
      parentStateController.updateRequestedAppointmentStudentModel(
          model: requestedAppointmentStudentModel);
      if (navigate ?? true) {
        Get.to(() => Appointment());
      }
    }
  }



/*=======================================================Get Selected Date Class HomeWork Api Call=======================================================================*/
  Future getClassHomeWork({required var homeWorkDate,bool? navigate}) async {
    showLoader();
    StudentData studentData =
    LocalStorage().readStudentModel(key: StringConstants.profileModel);
    var raw={
      "AdmissionNo":studentData.admissionNumber??"",
      "HomeWorkDate":homeWorkDate,
    };
    var response=await ApiClient().postWithToken(ApiUrls.GetClassHomeWorkList, raw) ;
    hideLoader();
    DateHomeWorkParentModel dateHomeWorkParentModel=DateHomeWorkParentModel.fromJson(response);
    if(dateHomeWorkParentModel.statuscode==StringConstants.success){
      if(navigate??true){
        Get.to(DateHomeWork(
          title: "Home Work",
          dateHomeWorkParentModel: dateHomeWorkParentModel,
        ));
      }
      else{
        return dateHomeWorkParentModel;
      }
    }



  }


  Future getUploadHomeWorkBySubjectData(
      {required String classHomeWorkId,
      required String homeWorkUploadDate,
      required String subjectMasterId,
      required String subjectName,
      required String className}) async {
    showLoader();

    StudentData studentData =
        LocalStorage().readStudentModel(key: StringConstants.profileModel);
    var raw = {
      "AdmissionNo": studentData.admissionNumber.toString(),
      "AdmissionNumber": studentData.admissionNumber.toString(),
      "ClassHomeWorkId": classHomeWorkId,
      "ClassMasterId": studentData.classMasterId.toString(),
      "ClassSectionMasterId": studentData.classSectionMasterId.toString(),
      "HomeWorkUploadDate": homeWorkUploadDate,
      "SubjectMasterId": subjectMasterId
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetUploadClassHomeWorkBySubjectDateR1, raw);
    hideLoader();
    UploadedHomeWorkStudentModel uploadedHomeWorkStudentModel =
        UploadedHomeWorkStudentModel.fromJson(response);
    Get.to(() => HomeworkDetails(
          classMasterId: studentData.classMasterId.toString(),
          subjectName: subjectName,
          classSectionMasterId: studentData.classSectionMasterId.toString(),
          className: studentData.className.toString(),
          homeWorkId: classHomeWorkId,
          rowVersion: uploadedHomeWorkStudentModel.data!.rowVersion.toString(),
          subjectMasterId: subjectMasterId,
          uploadedHomeWorkStudentModel: uploadedHomeWorkStudentModel,
        ));
  }

  Future saveUploadHomeWorkWithMultipleDocuments(
      {required String classHomeWorkId,
      required String rowVersion,
      required String subjectMasterId,
      required String homeWork,
      required String subjectName,
      required List<document.DocumentUpload> documentList}) async {
    showLoader();
    StudentData studentData =
        LocalStorage().readStudentModel(key: StringConstants.profileModel);
    List documentFile = [];
    Map<String, dynamic> raw = {
      "AdmissionNo": studentData.admissionNumber.toString(),
      "ClassHomeWorkId": classHomeWorkId,
      "ClassMasterId": studentData.classMasterId.toString(),
      "ClassSectionMasterId": studentData.classSectionMasterId.toString(),
      "DocumentCount": "-1",
      "HomeWork": homeWork,
      "HomeWorkDate": getTimeFormat(DateTime.now()),
      "Homework": homeWork,
      "homeworkColor": "2131099696",
      "Id": "0",
      "IsApproved": "false",
      "IsLocked": "false",
      "Remarks": homeWork,
      "RowVersion": "1",
      "SubjectMasterId": subjectMasterId,
      "SubjectName": subjectName
    };
    for (int i = 0; i < documentList.length; i++) {
      var data;
      if (documentList[i].fromUrl) {
        data = {
          "DocumentFormat":
              documentList[i].documentsList!.fileUrl!.split(".").last,
          "DocumentName": documentList[i].documentsList!.documentName,
          "FileUrl": documentList[i].documentsList!.fileUrl,
          "Id": documentList[i].documentsList!.id.toString(),
          "IsActive": documentList[i].documentsList!.isActive.toString(),
          "IsApproved": documentList[i].documentsList!.isApproved.toString(),
          "isLocked": "false",
          "IsVideoFile": documentList[i].documentsList!.isVideoFile,
          "IsYoutubeLink": documentList[i].documentsList!.isYoutubeLink
        };
        documentFile.add(data);
      }

      else if(documentList[i].isLink==true){
        Map<String,String> temp2 = {
          "ClassHomeWorkId" : classHomeWorkId,
          "DocumentName":"link",
          "DocumentNameWithExtension":"",
          "DocumentFormat":"",
          "DocumentSize":"",
          "IsApproved":"true",
          "Document":documentList[i].fileSource,
          "IsYoutubeLink": "true",
        };
        documentFile.add(temp2);

      }

      else {
        File file = File(documentList[i].fileSource);
        int size = await file.length();
        String filePath =
            await covertFileAsbytes(fileSource: documentList[i].fileSource);
        data = {
          "ClassHomeWorkId": classHomeWorkId,
          "Document": filePath,
          "DocumentFormat": documentList[i].fileSource.split(".").last,
          "DocumentName": documentList[i].fileSource.split("/").last,
          "DocumentNameWithExtension":
              documentList[i].fileSource.split("/").last,
          "DocumentSize": size.toString(),
          "FileUrl": "",
          "Id": "0",
          "IsActive": "true",
          "IsApproved": "true",
          "isLocked": "false",
          "IsVideoFile": "false",
          "IsYoutubeLink": "false"
        };
        documentFile.add(data);
      }
      raw.addAll({"DocumentsList": documentFile});
      myLog(label: "raw", value: jsonEncode(raw));
      if (documentFile.length == documentList.length) {
        var response = await ApiClient().postWithTokenAndEncoding(
            ApiUrls.SaveUploadHomeworkWithMultipleDocuments, jsonEncode(raw));
        hideLoader();
        Get.back();
        showMessage(msg: response["message"]);
      }
    }
  }

  ///------appointments---------------

  Future<EmployeeListForAppointmentModel>
      getEmployeeListForAppointment() async {
    showLoader();
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetEmployeeListForAppointmentRequest, {});
    EmployeeListForAppointmentModel employeeListForAppointmentModel =
        EmployeeListForAppointmentModel.fromJson(response);
    hideLoader();
    return employeeListForAppointmentModel;
  }

  Future<RelationModel> getRelationList() async {
    showLoader();
    var response = await ApiClient().postWithToken(ApiUrls.GetRelationList, {});
    RelationModel relationModel = RelationModel.fromJson(response);
    hideLoader();
    return relationModel;
  }

  Future saveAppointment(
      {required String date,
      required String appointmentWith,
      required String empMasterId,
      required String relationMasterId,
      required String remark}) async {
    showLoader();
    StudentData studentData =
        LocalStorage().readStudentModel(key: StringConstants.profileModel);
    var raw = {
      "AppointmentDateRequested": date,
      "AppointmentWith": appointmentWith,
      "EmployeeMasterId": empMasterId,
      "Id": "0",
      "RelationMasterId": relationMasterId,
      "Remarks": remark,
      "StudentMasterId": studentData.id.toString()
    };
    var response = await ApiClient().postWithToken(ApiUrls.SaveAppointmentRequest, raw);
    hideLoader();
    getRequestedAppointment(fromDate: DateTime.now().toString(),navigate: false);
    if(response['statuscode']==StringConstants.success){
      Get.back();
      showMessage(msg:response['message']);

    }else{
      showMessage(msg:response['message']);

    }

  }

  ///************************** Bag Component ********************************

  Future getBagComponent({required var homeWorkDate,bool? navigate}) async {
    showLoader();
    StudentData studentData =
    LocalStorage().readStudentModel(key: StringConstants.profileModel);
    var raw={
      "AdmissionNumber":studentData.admissionNumber??"",
      "BagPlanDate":homeWorkDate,
    };
    var response=await ApiClient().postWithToken(ApiUrls.GetBagPlanListForStudent, raw) ;
    hideLoader();
    StudentBagComponentModel studentBagComponentModel=StudentBagComponentModel.fromJson(response);
    if(studentBagComponentModel.statuscode==StringConstants.success){
      if(navigate??true){
      Get.to(()=>BagComponentListScreen(studentBagComponentModel: studentBagComponentModel,));
      }
      else{
        return studentBagComponentModel;
      }
    }



  }

}
