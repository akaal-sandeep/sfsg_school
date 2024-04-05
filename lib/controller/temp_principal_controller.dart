import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/controller/teacher_state_controller.dart';
import 'package:web_school_manager/principal/screen/all_section_screen.dart';
import 'package:web_school_manager/principal/screen/subjects_screen.dart';
import 'package:web_school_manager/principal_model/all_section_homework_model.dart';
import 'package:web_school_manager/principal_model/get_subject_list_for_class_model.dart';

import '../api/api_client.dart';
import '../api/api_url.dart';
import '../common-functions.dart';
import '../constants/string_constants.dart';
import '../parent/leave/leave_applied.dart';
import '../teacher/lession/teacher_lesson_plans.dart';
import '../teacher_model/get_employee_leave_apply_list_model.dart';
import '../teacher_model/get_lesson_plan_list.dart';
import '../utility/helper_widget.dart';

class TempPrincipalController {
  final teacherStateController = Get.put(TeacherStateController());

  Future getLessonPlanList(
      {bool? navigate, String? fromDate, String? toDate}) async {
    showLoader();
    var raw = {
      "AdmissionNumber": "",
      "ClassMasterId": "0",
      "ClassSectionMasterId": "-1",
      "EmployeeMasterId": "0",
      "FromDate": fromDate ??
          DateFormat("MMM dd, yyyy")
              .format(DateTime.now().subtract(Duration(days: 60))),
      "Id": "-1",
      "SectionMasterId": "0",
      "SubjectMasterId": "0",
      "ToDate": toDate ??
          DateFormat("MMM dd, yyyy")
              .format(DateTime.now().add(Duration(days: 60))),
    };
    var response =
        await ApiClient().postWithToken(ApiUrls.GetLessonPlanList, raw);
    hideLoader();
    GetLessonPlanListModel getLessonPlanListModel =
        GetLessonPlanListModel.fromJson(response);
    if (getLessonPlanListModel.statuscode == StringConstants.success) {
      teacherStateController.updateGetLessonPlanListModel(
          model: getLessonPlanListModel);
      if (navigate ?? true) {
        Get.to(() => TeacherLessonPlans(
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

  Future rejectLessonPlan(
      {required String id, required String rowVersion}) async {
    showLoader();
    var raw = {"Id": id, "RowVersion": rowVersion};
    var response =
        await ApiClient().postWithToken(ApiUrls.RejectLessonPlan, raw);
    hideLoader();
    if (response['statuscode'] == StringConstants.success) {
      getLessonPlanList(navigate: false);
      Get.back();
      showMessage(msg: response['message']);
    } else {
      showMessage(msg: response['message']);
    }
  }

  Future UpdateLessonPlan(
      {String? fileSource,
      String? fileUrl,
      required String classMasterId,
      required String evaluation,
      required String fromDate,
      required String toDate,
      required String id,
      required String objective,
      required String rowVersion,
      required String sectionMasterId,
      required String subjectMasterId,
      required String teacherProcedure,
      required String warmUpActivity,
      required String followUpActivity,
      required String principalRemark}) async {
    showLoader();

    var raw = {
      "ClassMasterId": classMasterId,
      "ClassName": "",
      "EmployeeMasterId": "-1",
      "EmployeeName": "",
      "Evaluation": evaluation,
      "FollowUpActivities": followUpActivity,
      "FromDate": fromDate,
      "Id": id,
      "IsApproved": "false",
      "IsLocked": "false",
      "isPrincipal": "false",
      "IsRejected": "false",
      "isStudent": "false",
      "isTeacher": "false",
      "LessonPlan": "",
      "Objectives": objective,
      "PrincipalRemarks": principalRemark,
      "Remarks": "",
      "RowVersion": rowVersion,
      "SectionMasterId": sectionMasterId,
      "SectionName": "",
      "SubjectMasterId": subjectMasterId,
      "SubjectName": "",
      "TeachingProcedure": teacherProcedure,
      "ToDate": toDate,
      "WarmUpActivities": warmUpActivity
    };

    if (fileSource != null) {
      File file = File(fileSource);
      int size = await file.length();
      String filePath = await covertFileAsbytes(fileSource: fileSource);
      var temp = {
        "DocumentFormat": "",
        "DocumentName": "",
        "DocumentNameWithExtension": "." + fileSource.split(".").last,
        "DocumentSize": "0",
        "AbsoluteDocumentPath": "",
        "Document": filePath,
        "FileExtension": "",
      };
      raw.addAll(temp);
    } else {
      var temp = {
        "Document": "",
        "DocumentFormat": "",
        "DocumentName": "",
        "DocumentNameWithExtension": "." + fileUrl.toString().split(".").last,
        "DocumentSize": "",
        "AbsoluteDocumentPath": fileUrl.toString(),
        "FileExtension": "",
      };
      raw.addAll(temp);
    }
    myLog(label: "myRaw", value: jsonEncode(raw).toString());
    var response = await ApiClient()
        .postWithTokenAndEncoding(ApiUrls.UpdateLessonPlan, jsonEncode(raw));
    hideLoader();
    if (response['statuscode'] == StringConstants.success) {
      approveLessonPlan(
          rowVersion: (int.parse(rowVersion) + 1).toString(), id: id);
    } else {
      showMessage(msg: response['message']);
    }
  }

  Future approveLessonPlan(
      {required String id, required String rowVersion}) async {
    showLoader();
    var raw = {"Id": id, "RowVersion": rowVersion};
    var response =
        await ApiClient().postWithToken(ApiUrls.ApproveLessonPlan, raw);
    hideLoader();
    if (response['statuscode'] == StringConstants.success) {
      getLessonPlanList(navigate: false);
      Get.back();
      showMessage(msg: response['message']);
    } else {
      showMessage(msg: response['message']);
    }
  }

  Future getEmployeeLeaveApplyList(
      {String? fromDate, String? toDate, bool? navigate}) async {
    showLoader();

    var raw = {
      "EmployeeMasterId": "0",
      "SearchFromDate": fromDate ??
          getTimeFormat(DateTime.now().subtract(Duration(days: 60))),
      "SearchToDate":
          toDate ?? getTimeFormat(DateTime.now().add(Duration(days: 60))),
    };
    var response =
        await ApiClient().postWithToken(ApiUrls.GetEmployeeLeaveApplyList, raw);
    hideLoader();
    GetEmployeeLeaveApplyListModel employeeLeaveApplyListModel =
        GetEmployeeLeaveApplyListModel.fromJson(response);
    if (employeeLeaveApplyListModel.statuscode == StringConstants.success) {
      teacherStateController.updateGetEmployeeLeaveApplyListModel(
          model: employeeLeaveApplyListModel);
      if (navigate ?? true) {
        Get.to(() => LeaveApplied(
              fromDateT: fromDate ??
                  getTimeFormat(DateTime.now().subtract(Duration(days: 60))),
              toDateT: toDate ??
                  getTimeFormat(DateTime.now().add(Duration(days: 60))),
            ));
      }
    } else {
      showMessage(msg: employeeLeaveApplyListModel.message);
    }
  }

  Future approveEmployeeLeave(
      {required String id,
      required String rowVersion,
      required remarks}) async {
    showLoader();
    var raw = {
      "ApproveRemarks":
          remarks == "" ? "Your leave has been approved" : remarks,
      "Id": id,
      "RowVersion": rowVersion
    };
    var response =
        await ApiClient().postWithToken(ApiUrls.ApproveEmployeeLeaveApply, raw);
    hideLoader();
    getEmployeeLeaveApplyList(navigate: false);
    Get.back();
    showMessage(msg: response['message']);
  }

  Future rejectEmployeeLeave(
      {required String id,
      required String rowVersion,
      required remarks}) async {
    showLoader();
    var raw = {
      "RejectRemarks": remarks == "" ? "Your leave has been rejected" : remarks,
      "Id": id,
      "RowVersion": rowVersion
    };
    var response =
        await ApiClient().postWithToken(ApiUrls.RejectEmployeeLeaveApply, raw);
    hideLoader();
    getEmployeeLeaveApplyList(navigate: false);
    Get.back();
    showMessage(msg: response['message']);
  }

  Future getSubjectListForClass(
      {required String id,
      String? sectionMasterId,
      String? sectionName,
        bool? fromBagComponents,
      String? className,
      String? classMasterId}) async {
    showLoader();
    var raw = {
      "AdmissionNumber": "",
      "ClassMasterId": "-1",
      "ClassSectionMasterId": "-1",
      "EmployeeMasterId": "-1",
      "FromDate": "",
      "Id": id,
      "SectionMasterId": "-1",
      "SubjectMasterId": "-1",
      "ToDate": ""
    };
    var response =
        await ApiClient().postWithToken(ApiUrls.GetSubjectListForClass, raw);
    hideLoader();
    GetSubjectListForClassModel getSubjectListForClassModel =
        GetSubjectListForClassModel.fromJson(response);
    if (getSubjectListForClassModel.statuscode == StringConstants.success) {
      Get.to(() => SubjectListScreen(
            getSubjectListForClassModel: getSubjectListForClassModel,
            className: className.toString(),
            classMasterId: classMasterId.toString(),
            sectionName: sectionName.toString(),
            classSectionMasterId: sectionMasterId.toString(),
        fromBagComponents: fromBagComponents??false,
          ));
    } else {
      showMessage(msg: getSubjectListForClassModel.message);
    }
  }

  Future getClassHomeWorkListByClassSection({
    required String classMasterId,
    required String sectionMasterId,
    required String date,
    required String className,
    required String sectionName,
    bool? navigate,
  }) async {
    showLoader();
    var raw = {
      "HomeWorkDate": date,
      "ClassMasterId": classMasterId,
      "ClassSectionMasterId": sectionMasterId
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetClassHomeWorkListByClassSection, raw);
    hideLoader();
    AllSectionHomeWorkModel allSectionHomeWorkModel =
        AllSectionHomeWorkModel.fromJson(response);
    if (allSectionHomeWorkModel.statuscode == StringConstants.success) {
      if(navigate!=null){
        return allSectionHomeWorkModel;
      }
      Get.to(() => AllSectionHomeworkScreen(
           classMasterId: classMasterId,
            sectionMasterId: sectionMasterId,
            className: className.toString(),
            sectionName: sectionName.toString(),
        allSectionHomeWorkModel: allSectionHomeWorkModel,
          ));
    } else {
      showMessage(msg: allSectionHomeWorkModel.message);
    }
  }
}
