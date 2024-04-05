import 'dart:convert';

import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/api/api_client.dart';
import 'package:web_school_manager/api/api_url.dart';
import 'package:web_school_manager/constants/string_constants.dart';
import 'package:web_school_manager/controller/teacher_state_controller.dart';
import 'package:web_school_manager/model/leave_reason_list_model.dart';
import 'package:web_school_manager/parent/leave/apply_leave.dart';
import 'package:web_school_manager/principal/screen/subjects_screen.dart';
import 'package:web_school_manager/principal_model/get_subject_list_for_class_model.dart';
import 'package:web_school_manager/principal_model/get_subject_list_for_class_model.dart'
    as get_Subject_List;
import 'package:web_school_manager/teacher/bag_components/screen/bag_component_screen.dart';
import 'package:web_school_manager/teacher/classes/attendance.dart';
import 'package:web_school_manager/teacher/classes/homework/view_list_upload_work.dart';
import 'package:web_school_manager/teacher/classes/test/SubjectChapterTest.dart';
import 'package:web_school_manager/teacher/classes/test/class_test_teacher.dart';
import 'package:web_school_manager/teacher/classes/test/create_test.dart';
import 'package:web_school_manager/teacher/get_result_card/model/result_card_student_list_model.dart';
import 'package:web_school_manager/teacher/get_result_card/model/resultcard_model.dart';
import 'package:web_school_manager/teacher/lession/teacher_lesson_plans.dart';
import 'package:web_school_manager/teacher/salary_slip_teacher.dart';
import 'package:web_school_manager/teacher/student_leave.dart';
import 'package:web_school_manager/teacher/teacher_time_table.dart';
import 'package:web_school_manager/teacher_model/GetTeacherClassTestListBySubjectModel.dart';
import 'package:web_school_manager/teacher_model/attendance_save_model.dart';
import 'package:web_school_manager/teacher_model/bag_components_model.dart';
import 'package:web_school_manager/teacher_model/class_test_model.dart';
import 'package:web_school_manager/teacher_model/employee_profile_model.dart';
import 'package:web_school_manager/teacher_model/get_class_homework_by_subject_model.dart';
import 'package:web_school_manager/teacher_model/get_class_list_model.dart';
import 'package:web_school_manager/teacher_model/get_class_section_list_model.dart';
import 'package:web_school_manager/teacher_model/get_employee_leave_apply_list_model.dart';
import 'package:web_school_manager/teacher_model/get_fixed_appointments_list_for_teacher.dart';
import 'package:web_school_manager/teacher_model/get_holiday_home_work_subject_list_model.dart';
import 'package:web_school_manager/teacher_model/get_lesson_plan_list.dart';
import 'package:web_school_manager/teacher_model/get_reult_terms_model.dart';
import 'package:web_school_manager/teacher_model/get_student_list_for_upload_class_home_work_model.dart';
import 'package:web_school_manager/teacher_model/get_student_remarks_list.dart';
import 'package:web_school_manager/teacher_model/get_syllabus_list_by_class_section_subject_model.dart';
import 'package:web_school_manager/teacher_model/manage_class_test_inv_model.dart';
import 'package:web_school_manager/teacher_model/mange_class_test_main.dart';
import 'package:web_school_manager/teacher_model/personality_list_model.dart';
import 'package:web_school_manager/teacher_model/remarks_type_model.dart';
import 'package:web_school_manager/teacher_model/response_check_model.dart';
import 'package:web_school_manager/teacher_model/salary_slip_model.dart';
import 'package:web_school_manager/teacher_model/student_list_remarks_model.dart';
import 'package:web_school_manager/teacher_model/teacher_bag_component_model.dart';
import 'package:web_school_manager/teacher_model/teacher_class_homework_model.dart';
import 'package:web_school_manager/teacher_model/teacher_class_list_model.dart';
import 'package:web_school_manager/teacher_model/teacher_plan_list_model.dart';
import 'package:web_school_manager/teacher_model/teacher_timetable_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import '../common-functions.dart';
import '../local_storage/local_storage.dart';
import '../parent/leave/leave_applied.dart';
import '../parent/syllabus.dart';
import '../teacher/classes/homework/class_home_work.dart';
import '../teacher/classes/homework/view_uploaded_home_work_teacher.dart';
import '../teacher/classes/teacher_class.dart';
import '../teacher/classes/test/test_result.dart';
import '../teacher/holiday_homework_teacher/upload_homework_teacher.dart';
import '../teacher/students_remarks/student_remark.dart';
import '../teacher/syllabus/section_syllabus.dart';
import '../teacher/syllabus/teacher_syllabus.dart';
import '../teacher/teacher_appointment.dart';
import '../teacher_model/class_attendance_model.dart';
import '../teacher_model/get_result_card_model.dart';
import '../teacher_model/get_upload_class_home_work_list_for_student.dart';
import '../teacher_model/student_leave_apply_list_model.dart';

class TeacherController {
  final teacherStateController = Get.put(TeacherStateController());

  Future<GetResultTermsModel> getResultCardTerms() async {
    showLoader();
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetResultCardTerms, {"AdmissionNo": ""});

    hideLoader();
    return GetResultTermsModel.fromJson(response);
  }

  Future<GetResultCardModel> getResultCard() async {
    showLoader();
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetResultCardExams, {"AdmissionNo": ""});

    hideLoader();
    return GetResultCardModel.fromJson(response);
  }

  Future<BagComponentModel> getBagComponentList() async {
    showLoader();
    var response =
        await ApiClient().postWithToken(ApiUrls.GetBagComponentList, {});
    hideLoader();
    return BagComponentModel.fromJson(response);
  }

  Future saveBagComponent(
      {required String date,
      required String classMasterId,
      required String sectionMasterId,
      required String subjectMasterId,
      required String other,
      required List<ComponentsModel> listData}) async {
    showLoader();
    Map<String, dynamic> raw = {
      "Id": "0",
      "PlanDate": date,
      "ClassMasterId": classMasterId,
      "SectionMasterId": sectionMasterId,
      "SubjectMasterId": subjectMasterId,
      "OtherComponentName": other,
      "Remarks": "",
      "RowVersion": 1,
    };
    List bagComponents = [];
    listData.forEach((element) {
      if (element.id != -1) {
        bagComponents.add(
          {"Id": element.id, "SortId": "0"},
        );
      }
    });
    raw.addAll({"BagComponents": bagComponents});
    myLog(label: "raw", value: raw);
    var response = await ApiClient()
        .postWithTokenAndEncoding(ApiUrls.SaveBagPlan, jsonEncode(raw));
    hideLoader();
    if (response['statuscode'] == "error") {
      showMessage(msg: response['message']);
    } else {
      Get.back();
      showMessage(msg: "Done");
    }
  }

  Future getBagPlanList(
      {required String date,
      String? classMasterId,
      String? sectionMasterId,
      String? subjectMasterId}) async {
    showLoader();
    String userType = LocalStorage().read(key: StringConstants.userType);
    EmployeeProfileModel? model;
    if (userType == StringConstants.teacherType) {
      model = LocalStorage()
          .readTeacherProfileModel(key: StringConstants.teacherProfileModel);
    }
    Map<String, dynamic> raw = {
      "ClassMasterId": 0,
      "SectionMasterId": 0,
      "SubjectMasterId": 0,
      "FromDate": date,
      "ToDate": date,
      "EmployeeMasterId": model?.data?.id ?? null
    };

    Map<String, dynamic> principalRaw = {
      "ClassMasterId": classMasterId,
      "SectionMasterId": sectionMasterId,
      "SubjectMasterId": subjectMasterId,
      "FromDate": date,
      "ToDate": date,
      "EmployeeMasterId": 0
    };

    bool teacher = (StringConstants.teacherType ==
        LocalStorage().read(key: StringConstants.userType));
    myLog(label: "userTYpe", value: teacher);
    var response = await ApiClient().postWithTokenAndEncoding(
        ApiUrls.GetBagPlanList, jsonEncode(teacher ? raw : principalRaw));
    TeacherBagComponentModel teacherBagComponentModel =
        TeacherBagComponentModel.fromJson(response);
    hideLoader();
    if (response['statuscode'] == "error") {
      showMessage(msg: response['message']);
    } else {
      return teacherBagComponentModel;
    }
  }

  Future getResultSubjectList(
      {required String classId,
      required String sectionId,
      required String termsId,
      required String examId}) async {
    showLoader();
    var response = await ApiClient().postWithToken(ApiUrls.GetSubjects, {
      "AdmissionNo": "",
      "ClassMasterId": classId,
      "SectionMasterId": sectionId,
      "TermMasterId": termsId,
      "ExamMasterId": examId
    });

    hideLoader();
    return ResultSubjectModel.fromJson(response);
  }

  Future<RemarkStudentListModel> getStudentListForRemark(
      {required String classId,
      required String sectionId,
      required String termsId,
      required String examId,
      required String subjectMasterId}) async {
    showLoader();
    var response =
        await ApiClient().postWithToken(ApiUrls.GetRemarkStudentList, {
      "ClassMasterId": "$classId",
      "SectionMasterId": "$sectionId",
      "ExamMasterId": "$examId",
      "TermMasterId": "$termsId",
      "SubjectMasterId": "$subjectMasterId",
      "DatesheetRequired": "false"
    });

    hideLoader();
    return RemarkStudentListModel.fromJson(response);
  }

  Future<RemarkStudentListModel> getStudentListForPersonalityTraits(
      {required String classId,
      required String sectionId,
      required String termsId,
      required String personalityTraitMasterId}) async {
    showLoader();
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetStudentListForPeronalityTraits, {
      "ClassMasterId": "$classId",
      "SectionMasterId": "$sectionId",
      "TermMasterId": "$termsId",
      "PersonalityTraitMasterId": "$personalityTraitMasterId",
    });

    hideLoader();
    return RemarkStudentListModel.fromJson(response);
  }

  Future<RemarkStudentListModel> GetStudentListForRemarksRemark({
    required String classId,
    required String sectionId,
    required String termsId,
  }) async {
    showLoader();
    var response =
        await ApiClient().postWithToken(ApiUrls.GetStudentListForRemarks, {
      "ClassMasterId": "$classId",
      "SectionMasterId": "$sectionId",
      "TermMasterId": "$termsId",
    });

    hideLoader();
    return RemarkStudentListModel.fromJson(response);
  }

  Future<RemarksTypeModel> getRemarks() async {
    showLoader();
    var response = await ApiClient().postWithToken(ApiUrls.GetRemarks,{"data":"test"});

    hideLoader();
    RemarksTypeModel model = RemarksTypeModel.fromJson(response);
    if (model.statuscode == StringConstants.success) {
      return model;
    } else {
      RemarksTypeModel model = RemarksTypeModel();
      showMessage(msg: model.message.toString());
      return model;
    }
  }

  Future<ResponseCheckModel> saveResultMarks(
      {required RemarkStudentListModel remarkStudentListModel}) async {
    showLoader();
    var response = await ApiClient().postWithTokenAndEncoding(
        ApiUrls.SaveResultMarks,
        jsonEncode(remarkStudentListModel.data!.data!.toJson()));

    hideLoader();
    return ResponseCheckModel.fromJson(response);
  }

  Future<ResponseCheckModel> savePersonalityTraits(
      {required RemarkStudentListModel remarkStudentListModel}) async {
    showLoader();
    var response = await ApiClient().postWithTokenAndEncoding(
        ApiUrls.SavePersonaityTraits,
        jsonEncode(remarkStudentListModel.data!.data!.toJson()));

    hideLoader();
    return ResponseCheckModel.fromJson(response);
  }

  Future<ResponseCheckModel> saveRemark(
      {required RemarkStudentListModel remarkStudentListModel}) async {
    showLoader();

    List studentList = [];

    remarkStudentListModel.data!.data!.lstStudent!.forEach((element) {
      studentList.add({
        "StudentMasterId": element.studentMasterId.toString(),
        "AdmissionNumber": element.admissionNumber.toString(),
        "StudentName": element.studentName.toString(),
        "FatherName": element.fatherName.toString(),
        "MobileNumber": element.mobileNumber.toString(),
        "RollNumber": element.rollNumber.toString(),
        "CustomRemarks": element.customRemark!.value.text.toString(),
        "RowVersion":element.rowVersion.toString(),
        "Remarks": element.remarks.toString().trim().isEmpty
            ? "-1"
            : element.remarks.toString() == element.customRemark!.value.text.toString()
                ? "-1"
                : element.remarks.toString() == "0"?"-1" :element.remarks.toString() // RemarksMasterId
      });
    });

    var data = {
      "id":remarkStudentListModel.data?.data?.id??0,
      "ClassMasterId":
          remarkStudentListModel.data?.data?.classMasterId.toString(),
      "ClassSectionMasterId":
          remarkStudentListModel.data?.data?.classSectionMasterId.toString(),
      "TermMasterId":
          remarkStudentListModel.data?.data?.termMasterId.toString(),
      "LstStudent": studentList,
      "RowVersion":remarkStudentListModel.data?.data?.rowVersion.toString(),
    };

    var response = await ApiClient()
        .postWithTokenAndEncoding(ApiUrls.SaveRemarks, jsonEncode(data));

    hideLoader();
    ResponseCheckModel responseCheckModel =
        ResponseCheckModel.fromJson(response);
    return responseCheckModel;
  }

  Future getEmployeeProfile() async {
    showLoader();
    var response = await ApiClient().postWithToken(ApiUrls.EmployeeProfile, {});
    hideLoader();
    EmployeeProfileModel model = EmployeeProfileModel.fromJson(response);
    if (model.statuscode == StringConstants.success) {
      LocalStorage()
          .writeModel(key: StringConstants.teacherProfileModel, model: model);
    } else {
      showMessage(msg: model.message.toString());
    }
  }

  Future getTeacherClassList() async {
    showLoader();
    var response =
        await ApiClient().postWithToken(ApiUrls.GetTeacherClassList, {});
    hideLoader();
    TeacherClassesListModel model = TeacherClassesListModel.fromJson(response);
    if (model.statuscode == StringConstants.success) {
      Get.to(() => TeacherClass(
            model: model,
          ));
    } else {
      showMessage(msg: model.message.toString());
    }
  }

  Future getStudentListForAttendance(
      {required String classMasterId,
      required String sectionMasterId,
      required String attendanceDate}) async {
    showLoader();
    var raw = {
      "ClassMasterId": classMasterId,
      "ClassSectionMasterId": sectionMasterId,
      "AttendanceDate": attendanceDate
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetStudentListForAttendance, raw);
    hideLoader();
    ClassAttendanceModel model = ClassAttendanceModel.fromJson(response);
    if (model.statuscode == StringConstants.success) {
      Get.to(() => ClassAttendance(
            model: model,
          ));
    } else {
      showMessage(msg: model.message.toString());
    }
  }

  Future saveStudentDailyAttendance(
      {required ClassAttendanceModel classAttendanceModel}) async {
    showLoader();
    List data = [];
    for (int i = 0; i < classAttendanceModel.data!.studentList!.length; i++) {
      classAttendanceModel.data!.studentList![i].attendanceDate =
          DateTime.now().toString();
      data.add(jsonEncode(classAttendanceModel.data!.studentList![i]));
    }
    var raw = data.toString();
    var response = await ApiClient()
        .postWithTokenAndEncoding(ApiUrls.SaveStudentDailyAttendance, raw);
    hideLoader();
    AttendanceSaveModel attendanceSaveModel =
        AttendanceSaveModel.fromJson(response);
    Get.back();
    showMessage(msg: attendanceSaveModel.message.toString());
  }

  Future getTimeTable() async {
    showLoader();
    var response =
        await ApiClient().postWithToken(ApiUrls.TeacherTimeTable, {});
    hideLoader();
    TeacherTimeTableModel teacherTimeTableModel =
        TeacherTimeTableModel.fromJson(response);
    if (teacherTimeTableModel.statuscode == StringConstants.success) {
      Get.to(() => TeacherTimeTable(
            teacherTimeTableModel: teacherTimeTableModel,
          ));
    } else {
      showMessage(msg: teacherTimeTableModel.message.toString());
    }
  }

  Future teacherClassHomeWork(
      {required String classMasterid,
      required String classSectionMasterid,
      required String className,
      String? sectionName,
      bool? fromComponent,
      bool? navigate}) async {
    showLoader();
    var raw = {
      "ClassMasterId": classMasterid,
      "ClassSectionMasterId": classSectionMasterid
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetClassHomeworkSubjectList, raw);
    hideLoader();
    TeacherClassHomeworkModel teacherClassHomeworkModel =
        TeacherClassHomeworkModel.fromJson(response);
    if (teacherClassHomeworkModel.statuscode == StringConstants.success) {
      if (navigate ?? true) {
        if (fromComponent == true) {
          GetSubjectListForClassModel getSubjectListForClassModel =
              GetSubjectListForClassModel(data: []);
          teacherClassHomeworkModel.data!.forEach((element) {
            getSubjectListForClassModel.data!.add(get_Subject_List.Data(
                id: element.id,
                name: element.subjectName,
                subjectId: element.subjectMasterId));
          });
          Get.to(() => SubjectListScreen(
                getSubjectListForClassModel: getSubjectListForClassModel,
                className: className.toString(),
                classMasterId: classMasterid.toString(),
                sectionName: sectionName.toString(),
                classSectionMasterId: classSectionMasterid.toString(),
                fromBagComponents: true,
              ));
        } else {
          Get.to(() => ClassHomeWork(
                teacherClassHomeworkModel: teacherClassHomeworkModel,
                className: className,
                classMasterId: classMasterid,
                classSectionMasterId: classSectionMasterid,
              ));
        }
      } else {
        return teacherClassHomeworkModel;
      }
    }
  }

  Future getClassHomeWorkBySubjectDate(
      {required String classMasterId,
      required String classSectionMasterId,
      DateTime? date,
      required String subjectMasterId,
      bool? navigate}) async {
    showLoader();
    var data = {
      "Id": "-1",
      "ClassMasterId": classMasterId,
      "ClassSectionMasterId": classSectionMasterId,
      "HomeWorkDate":
          date == null ? DateTime.now().toString() : date.toString(),
      "SubjectMasterId": subjectMasterId
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetClassHomeWorkBySubjectDate, data);
    hideLoader();
    GetClassHomeWorkBySubjectDateModel getClassHomeWorkBySubjectDateModel =
        GetClassHomeWorkBySubjectDateModel.fromJson(response);
    if (navigate ?? true) {
    } else {
      return getClassHomeWorkBySubjectDateModel;
    }
  }

  Future getHolidayHomeWorkSubjectDate(
      {required String classMasterId,
      required String classSectionMasterId,
      required String subjectMasterId,
      bool? navigate}) async {
    showLoader();
    var data = {
      "Id": "-1",
      "ClassMasterId": classMasterId,
      "ClassSectionMasterId": classSectionMasterId,
      "HomeWorkDate": DateTime.now().toString(),
      "SubjectMasterId": subjectMasterId
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetHolidayHomeWorkBySubjectDate, data);
    hideLoader();
    GetClassHomeWorkBySubjectDateModel getClassHomeWorkBySubjectDateModel =
        GetClassHomeWorkBySubjectDateModel.fromJson(response);
    if (navigate ?? true) {
    } else {
      return getClassHomeWorkBySubjectDateModel;
    }
  }

  Future uploadHomeWork({
    required String filePath,
    required String classHomeWorkId,
    required String homeworkTitle,
    required String homeworkDate,
    required String classMasterId,
    required String sectionMasterId,
    required String subjectMasterId,
    required String documentName,
    required String extensionWithName,
    required String rowVersion,
    required String format,
    required String documentSize,
    required List<DocumentUpload> documentList,
  }) async {
    showLoader();
    Map<String, dynamic> raw = {
      "Id": classHomeWorkId,
      "HomeWork": homeworkTitle,
      "HomeWorkDate": homeworkDate,
      "ClassMasterId": classMasterId,
      "ClassSectionMasterId": sectionMasterId,
      "SubjectMasterId": subjectMasterId,
      "RowVersion": rowVersion,
      "Remarks": "",
      "IsApproved": "true",
    };
    List documents = [];
    for (int i = 0; i < documentList.length; i++) {
      if (documentList[i].fromUrl) {
        Map<String, String> temp2 = {
          "DocumentFormat": documentList[i].documentFormat.toString(),
          "DocumentName": documentList[i].documentName.toString(),
          "FileUrl": documentList[i].fileUrl.toString(),
          "Id": documentList[i].id.toString(),
          "IsActive": documentList[i].isActive.toString(),
          "IsApproved": documentList[i].isApproved.toString(),
          "isLocked": "false",
          "IsVideoFile": documentList[i].isVideoFile.toString(),
          "IsYoutubeLink": documentList[i].isYoutubeLink.toString()
        };
        documents.add(temp2);
      } else if (documentList[i].isLink == true) {
        Map<String, String> temp2 = {
          "ClassHomeWorkId": classHomeWorkId,
          "DocumentName": documentList[i].fileSource,
          "DocumentNameWithExtension": "YOUTUBE_VIDEO_LINK",
          "DocumentFormat": "YOUTUBE_VIDEO_LINK",
          "DocumentSize": "0",
          "IsApproved": "true",
          "FileUrl": "",
          "Document": "",
          "IsYoutubeLink": "true",
          "IsVideoFile": "false",
          "IsActive": "true",
          "isLocked": "false",
        };
        documents.add(temp2);
      } else {
        File file = File(documentList[i].fileSource);
        int size = await file.length();
        String filePath =
            await covertFileAsbytes(fileSource: documentList[i].fileSource);
        Map<String, String> temp2 = {
          "ClassHomeWorkId": classHomeWorkId,
          "DocumentName": documentList[i].fileSource.split("/").last,
          "DocumentNameWithExtension":
              documentList[i].fileSource.split("/").last,
          "DocumentFormat": documentList[i].fileSource.split(".").last,
          "DocumentSize": size.toString(),
          "IsApproved": "true",
          "Document": filePath
        };
        documents.add(temp2);
      }
    }
    raw.addAll({"DocumentsList": documents});
    var response = await ApiClient().postWithTokenAndEncoding(
        ApiUrls.SaveHomeWorkWithMultipleDocuments, jsonEncode(raw));
    hideLoader();
    if (response['statuscode'] == StringConstants.success) {
      Get.back();
      showMessage(msg: response['message']);
    } else {
      showMessage(msg: response['message']);
    }
  }

  Future getReasonList() async {
    showLoader();
    String url = "";
    if (LocalStorage().read(key: StringConstants.userType) ==
        StringConstants.teacherType) {
      url = ApiUrls.GetEmployeeLeaveReasonList;
    } else {
      url = ApiUrls.GetStudentLeaveReasonList;
    }
    var response = await ApiClient().postWithToken(url, {});
    hideLoader();
    LeaveReasonList leaveReasonList = LeaveReasonList.fromJson(response);
    Get.to(() => ApplyLeave(
          leaveReasonList: leaveReasonList,
        ));
  }

  Future teacherApplyLeave(
      {required String id,
      required String employeeMasterId,
      required String EmployeeLeaveReasonMasterId,
      required String remarks,
      required String leaveDays,
      required String fromDate,
      required String toDate}) async {
    showLoader();
    EmployeeProfileModel model = LocalStorage()
        .readTeacherProfileModel(key: StringConstants.profileModel);
    var raw = {
      "Id": "0",
      "EmployeeMasterId": model.data!.id.toString(),
      "EmployeeLeaveReasonMasterId": EmployeeLeaveReasonMasterId,
      "Remarks": remarks.isEmpty ? "null" : remarks,
      "LeaveDays": leaveDays,
      "FromDate": fromDate,
      "ToDate": toDate
    };
    var response =
        await ApiClient().postWithToken(ApiUrls.SaveEmployeeLeaveApply, raw);
    hideLoader();

    getEmployeeLeaveApplyList(navigate: false).then((value) {
      Get.back();
      showMessage(msg: response['message']);
    });
  }

  ///----remarks
  Future getStudentRemarks({required bool navigate}) async {
    showLoader();
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetStudentRemarks, {"id": "random"});
    hideLoader();
    GetStudentRemarksListModel getStudentRemarksListModel =
        GetStudentRemarksListModel.fromJson(response);
    if (getStudentRemarksListModel.statuscode == StringConstants.success) {
      teacherStateController.updateController(
          getStudentRemarksListModel: getStudentRemarksListModel);
      if (navigate) {
        Get.to(() => StudentsRemarks(
              getStudentRemarksListModel: getStudentRemarksListModel,
            ));
      } else {
        return getStudentRemarksListModel;
      }
    } else {
      showMessage(msg: getStudentRemarksListModel.message.toString());
    }
  }

  Future<GetHolidayHomeworkSubjectListModel> getHolidayHomeworkSubjectList(
      {required String classMasterId,
      required String classSectionMasterId}) async {
    showLoader();
    var raw = {
      "AdmissionNumber": "",
      "ClassMasterId": classMasterId,
      "ClassSectionMasterId": classSectionMasterId,
      "EmployeeMasterId": "-1",
      "FromDate": "",
      "Id": "-1",
      "SectionMasterId": "-1",
      "SubjectMasterId": "-1",
      "ToDate": ""
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetHolidayHomeworkSubjectList, raw);
    hideLoader();
    GetHolidayHomeworkSubjectListModel getHolidayHomeworkSubjectListModel =
        GetHolidayHomeworkSubjectListModel.fromJson(response);
    return getHolidayHomeworkSubjectListModel;
  }

  Future<TeacherClassesListModel> returnTeacherClassList() async {
    showLoader();
    var response =
        await ApiClient().postWithToken(ApiUrls.GetTeacherClassList, {});
    hideLoader();
    TeacherClassesListModel model = TeacherClassesListModel.fromJson(response);
    if (model.statuscode == StringConstants.success) {
      return model;
    } else {
      TeacherClassesListModel model = TeacherClassesListModel();
      return model;
    }
  }

  Future<RemarksTypeModel> getRemarksType() async {
    showLoader();
    var response =
        await ApiClient().postWithToken(ApiUrls.GetRemarksTypeList, {});
    hideLoader();
    RemarksTypeModel model = RemarksTypeModel.fromJson(response);
    if (model.statuscode == StringConstants.success) {
      return model;
    } else {
      RemarksTypeModel model = RemarksTypeModel();
      showMessage(msg: model.message.toString());
      return model;
    }
  }

  Future<StudentListForRemarksModel> getStudentListForRemarks(
      {required String classMasterId,
      required String sectionMasteMasterId}) async {
    showLoader();
    var raw = {
      "ClassMasterId": classMasterId,
      "ClassSectionMasterId": sectionMasteMasterId
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetStudentListForRemarksEntry, raw);
    hideLoader();
    StudentListForRemarksModel model =
        StudentListForRemarksModel.fromJson(response);
    if (model.statuscode == StringConstants.success) {
      return model;
    } else {
      StudentListForRemarksModel model = StudentListForRemarksModel();
      showMessage(msg: model.message.toString());
      return model;
    }
  }

  Future uploadRemarks(
      {required String id,
      required String entryDate,
      required String studentMasterId,
      required String remarkMasterId,
      required String remarksDetails,
      required String fileSource}) async {
    showLoader();
    File file = File(fileSource);
    int size = fileSource.isNotEmpty ? await file.length() : 0;
    String filePath = fileSource.isNotEmpty
        ? await covertFileAsbytes(fileSource: fileSource)
        : "";

    var raw = {
      "Id": "0",
      "EntryDate": entryDate,
      "StudentMasterId": studentMasterId,
      "RemarksTypeMasterId": remarkMasterId,
      "RemarksDetail": remarksDetails,
    };
    if (fileSource.isNotEmpty) {
      raw.addAll({
        "FileExtension": fileSource.split(".").last,
        "DocumentName": fileSource.split("/").last,
        "DocumentNameWithExtension": fileSource.split("/").last,
        "DocumentFormat": fileSource.split(".").last,
        "DocumentSize": size.toString(),
        "Document": filePath
      });
    } else {
      raw.addAll({
        "FileExtension": "",
        "DocumentName": "",
        "DocumentNameWithExtension": "",
        "DocumentFormat": "",
        "DocumentSize": "",
        "Document": ""
      });
    }
    var response = await ApiClient()
        .postWithTokenAndEncoding(ApiUrls.SaveStudentRemarks, jsonEncode(raw));
    hideLoader();
    hideLoader();
    showMessage(msg: response['message']);
    //getStudentRemarks(navigate: false);
  }

  Future GetClassTestList(
      {required String classMasterId,
      required String classSectionMasterId,
      required String className}) async {
    showLoader();
    var raw = {
      "ClassMasterId": classMasterId,
      "ClassSectionMasterId": classSectionMasterId
    };
    var response =
        await ApiClient().postWithToken(ApiUrls.GetClassTestSubjectList, raw);
    hideLoader();
    ClassTestListModel classTestListModel =
        ClassTestListModel.fromJson(response);
    if (classTestListModel.statuscode == StringConstants.success) {
      Get.to(() => TestSubject(
          classTestListModel: classTestListModel,
          classSectionMasterId: classSectionMasterId,
          classMasterId: classMasterId,
          className: className));
    } else {
      showMessage(msg: classTestListModel.message.toString());
    }
  }

  Future getTeacherClassTestListBySubject(
      {required String classMasterId,
      ClassTestListModel? classTestListModel,
      required String classSectionMasterId,
      required String subjectName,
      required String className,
      required bool navigate,
      required String subjectMasterId}) async {
    showLoader();
    var raw = {
      "ClassMasterId": classMasterId,
      "ClassSectionMasterId": classSectionMasterId,
      "SubjectMasterId": subjectMasterId,
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetTeacherClassTestListBySubject, raw);
    hideLoader();
    GetTeacherClassTestListBySubjectModel model =
        GetTeacherClassTestListBySubjectModel.fromJson(response);
    if (model.statuscode == StringConstants.success) {
      teacherStateController.updateGetTeacherClassTestListBySubjectModel(
          model: model);
      if (navigate) {
        Get.to(() => SubjectChapterTest(
            className: className,
            model: model,
            classTestListModel: classTestListModel!,
            subjectMasterId: subjectMasterId,
            classSectionMasterId: classSectionMasterId,
            classMasterId: classMasterId,
            subjectName: subjectName));
      }
    } else {
      showMessage(msg: model.message.toString());
    }
  }

  Future manageClassTestMain(
      {required String id,
      required String className,
      ClassTestListModel? classTestListModel,
      required subjectName,
      required bool navigate,
      required bool isLocked}) async {
    showLoader();
    var raw = {"Id": id};
    var response =
        await ApiClient().postWithToken(ApiUrls.ManageClassTestMain, raw);
    hideLoader();
    ManageClassTestMainModel model =
        ManageClassTestMainModel.fromJson(response);
    if (model.statuscode == StringConstants.success) {
      model.locked = isLocked;
      teacherStateController.updateManageClassTestMainModel(model: model);
      if (navigate) {
        Get.to(() => CreateTest(
              model: model,
              classTestListModel: classTestListModel!,
              classname: className,
              subjectName: subjectName,
            ));
      } else {
        return model;
      }
    } else {
      showMessage(msg: model.message.toString());
    }
  }

  Future manageClassTestInv(
      {required ManageClassTestMainModel model,
      required bool isLocked,
      required bool filled,
      required ClassTestListModel classTestListModel,
      required selectedSubjectIndex,
      required bool navigate}) async {
    showLoader();
    var raw = {
      "ClassMasterId": model.data!.id.toString() == "0"
          ? teacherStateController.classMasterId.value.toString()
          : model.data!.classMasterId.toString(),
      "ClassSectionMasterId": model.data!.id.toString() == "0"
          ? teacherStateController.sectionMasterId.value.toString()
          : model.data!.classSectionMasterId.toString(),
      "Id": model.data!.id.toString(),
      "MaximumMarks": model.data!.maximumMarks.toString(),
      "RowVersion": model.data!.rowVersion.toString(),
      "SubjectMasterId": model.data!.subjectMasterId.toString(),
      "SubjectName": model.data!.subjectName.toString(),
      "TestDate": model.data!.testDate.toString(),
      "TestTopic": model.data!.testTopic.toString(),
      "TimeStamp": model.data!.timeStamp.toString()
    };
    var response =
        await ApiClient().postWithToken(ApiUrls.ManageClassTestInv, raw);
    ManageClassTestInvModel manageClassTestInvModel =
        ManageClassTestInvModel.fromJson(response);
    hideLoader();
    if (manageClassTestInvModel.statuscode == StringConstants.success) {
      manageClassTestInvModel.locked = isLocked;
      teacherStateController.updateClassTestInvModel(
          model: manageClassTestInvModel);
      if (navigate) {
        Get.to(() => TestResult(
              classTestListModel: classTestListModel,
              selectedSubjectIndex: selectedSubjectIndex,
              filled: filled,
              subjectName: model.data!.subjectName.toString(),
              topic: model.data!.testTopic.toString(),
              selectedDate: model.data!.testDate.toString(),
              model: model,
              className: '',
              maxMarks: model.data!.maximumMarks.toString(),
              subject: model.data!.subjectName.toString(),
            ));
      }
    } else {
      showMessage(msg: manageClassTestInvModel.message);
    }
  }

  Future saveClassTest(
      {required ManageClassTestMainModel model,
      required ManageClassTestInvModel manageClassTestInvModel,
      required String selectedDate,
      required String subject,
      required String topic,
      required String maxMarks}) async {
    showLoader();
    manageClassTestInvModel.data!.testDate = selectedDate;
    manageClassTestInvModel.data!.subjectName = subject;
    manageClassTestInvModel.data!.testTopic = topic;
    manageClassTestInvModel.data!.maximumMarks = maxMarks;
    var raw = manageClassTestInvModel.data!.toJson();
    myLog(label: "raw", value: raw.toString());
    var response = await ApiClient()
        .postWithTokenAndEncoding(ApiUrls.SaveClassTest, jsonEncode(raw));
    hideLoader();
    if (response['statuscode'] == StringConstants.success) {
      teacherStateController.manageClassTestMainModel.data!.id =
          response['data'];
      showMessage(msg: response['message']);
      return true;
    } else {
      showMessage(msg: response['message']);
      return false;
    }
  }

  Future lockClassTest(
      {required String id,
      required String isLocked,
      required String rowVersion}) async {
    showLoader();
    var raw = {"Id": id, "IsLocked": "true", "RowVersion": rowVersion};
    var response = await ApiClient().postWithToken(ApiUrls.LockClassTest, raw);
    hideLoader();
    if (response['statuscode'] == StringConstants.success) {
      showMessage(msg: response['message']);
      teacherStateController.lockClassTest();
      return true;
    } else {
      showMessage(msg: response['message']);
      return false;
    }
  }

  Future deleteClassTest(
      {required String Id,
      required String isActive,
      required String rowVersion}) async {
    showLoader();
    var data = {
      "Id": Id,
      "IsActive": false.toString(),
      "RowVersion": rowVersion
    };
    var response =
        await ApiClient().postWithToken(ApiUrls.DeleteClassTest, data);
    hideLoader();
    if (response['statuscode'] == StringConstants.success) {
      showMessage(msg: response['data']);
      teacherStateController.lockClassTest();
      return true;
    } else {
      showMessage(msg: response['message']);
      return false;
    }
  }

  ///-----------syllabus----------------------------

  Future getClassList(
      {bool? navigate,
      bool? fromHomeWork,
      bool? classWorkTeacher,
      bool? fromResultCard,
      bool? fromBagComponents,
      bool? fromDateSheet}) async {
    showLoader();
    var response = await ApiClient().postWithToken(ApiUrls.GetClassList, {});
    GetClassListModel getClassListModel = GetClassListModel.fromJson(response);
    hideLoader();
    if (navigate ?? true) {
      if (fromResultCard == true) {
        Get.to(() => TeacherSyllabus(
              getClassListModel: getClassListModel,
              fromResultCard: fromResultCard,
            ));
        return;
      }

      if (fromHomeWork == true) {
        Get.to(() => TeacherSyllabus(
              getClassListModel: getClassListModel,
              fromHomeWork: fromHomeWork,
            ));

        return;
      }
      if (classWorkTeacher == true) {
        Get.to(() => TeacherSyllabus(
              getClassListModel: getClassListModel,
              fromClassWork: true,
            ));

        return;
      }

      if (fromBagComponents == true) {
        Get.to(() => TeacherSyllabus(
              getClassListModel: getClassListModel,
              fromBagComponents: true,
            ));

        return;
      }
      if (fromDateSheet == true) {
        Get.to(() => TeacherSyllabus(
              getClassListModel: getClassListModel,
              fromDateSheet: fromDateSheet,
            ));

        return;
      }

      Get.to(() => TeacherSyllabus(
            getClassListModel: getClassListModel,
          ));
    } else {
      return getClassListModel;
    }
  }

  Future<GetPersonalityListModel> getPersonalityTraits() async {
    showLoader();
    var response = await ApiClient().postWithTokenAndEncoding(
        ApiUrls.GetPersonalityTraits, jsonEncode({"check": "check"}));
    hideLoader();
    return GetPersonalityListModel.fromJson(response);
  }

  Future getClassSectionList(
      {bool? navigate,
      required String id,
      bool? fromHomeWork,
      String? className,
      bool? fromClassWork,
      bool? fromResultCard,
      bool? fromBagComponents}) async {
    showLoader();
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetClassSectionList, {"Id": id});
    GetClassSectionListModel getClassSectionListModel =
        GetClassSectionListModel.fromJson(response);
    hideLoader();
    if (navigate ?? true) {
      if (fromResultCard == true) {
        Get.to(() => SectionSyllabus(
              getClassSectionListModel: getClassSectionListModel,
              classMasterId: id.toString(),
              className: className,
              fromResultCard: true,
            ));
        return;
      }

      if (fromBagComponents == true) {
        Get.to(() => SectionSyllabus(
              getClassSectionListModel: getClassSectionListModel,
              classMasterId: id.toString(),
              className: className,
              fromBagComponents: true,
            ));
        return;
      }

      if (fromHomeWork == true) {
        Get.to(() => SectionSyllabus(
              getClassSectionListModel: getClassSectionListModel,
              classMasterId: id.toString(),
              fromHomeWork: fromHomeWork,
              className: className,
            ));
      } else if (fromClassWork == true) {
        Get.to(() => SectionSyllabus(
              getClassSectionListModel: getClassSectionListModel,
              classMasterId: id.toString(),
              fromClassWork: true,
              className: className,
            ));
      } else {
        Get.to(() => SectionSyllabus(
              className: className,
              getClassSectionListModel: getClassSectionListModel,
              classMasterId: id.toString(),
            ));
      }
    } else {
      return getClassSectionListModel;
    }
  }

  Future getSyllabusListByClassSection(
      {bool? navigate,
      required String classMasterId,
      required String classSectionMasterId}) async {
    showLoader();
    var raw = {
      "ClassMasterId": classMasterId,
      "ClassSectionMasterId": classSectionMasterId
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetSyllabusListByClassSectionSubject, raw);
    GetSyllabusListByClassSectionSubjectModel
        getSyllabusListByClassSectionSubjectModel =
        GetSyllabusListByClassSectionSubjectModel.fromJson(response);
    hideLoader();
    if (navigate ?? true) {
      Get.to(() => Syllabus(
            getSyllabusListByClassSectionSubjectModel:
                getSyllabusListByClassSectionSubjectModel,
          ));
    }
  }

  ///----------lesson plan ----------------
  Future getLessonPlanList(
      {bool? navigate, String? fromDate, String? toDate}) async {
    showLoader();
    EmployeeProfileModel model = LocalStorage()
        .readTeacherProfileModel(key: StringConstants.profileModel);
    var raw = {
      "AdmissionNumber": "",
      "ClassMasterId": "0",
      "ClassSectionMasterId": "-1",
      "EmployeeMasterId": model.data!.id.toString(),
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

  ///  may be wrong implementation
  Future getTeacherPlanList({required String employeeMasterId}) async {
    showLoader();
    var raw = {"EmployeeMasterId": employeeMasterId};
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetLessonPlanListByTeacher, raw);
    LessonPlanListByTeacher teacherLessionPlans =
        LessonPlanListByTeacher.fromJson(response);
    hideLoader();
    if (teacherLessionPlans.statuscode == StringConstants.success) {
    } else {
      showMessage(msg: teacherLessionPlans.message.toString());
    }
  }

  Future saveLessonPlan({
    String? fileSource,
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
  }) async {
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
      "PrincipalRemarks": "",
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
        "DocumentSize": "${size}",
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
        .postWithTokenAndEncoding(ApiUrls.SaveLessonPlan, jsonEncode(raw));
    hideLoader();

    if (response['statuscode'] == StringConstants.success) {
      getLessonPlanList(navigate: false).then((value) {
        Get.back();
        showMessage(msg: response['message']);
      });
    } else {
      showMessage(msg: response['message']);
    }
  }

  Future markAttendance({required String attendance}) async {
    showLoader();
    EmployeeProfileModel model = LocalStorage()
        .readTeacherProfileModel(key: StringConstants.profileModel);
    var data = {
      "AttendanceStatus": attendance,
      "EmployeeMasterId": model.data!.id.toString()
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.SaveEmployeeDailyAttendance, data);
    hideLoader();
    if (response['statuscode'] == StringConstants.success) {
      showMessage(msg: response['message']);
    } else {
      showMessage(msg: response['message']);
    }
  }

  Future getEmployeeLeaveApplyList(
      {String? fromDate, String? toDate, bool? navigate}) async {
    showLoader();
    EmployeeProfileModel model = LocalStorage()
        .readTeacherProfileModel(key: StringConstants.profileModel);
    var raw = {
      "EmployeeMasterId": model.data!.id.toString(),
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

  Future getSalarySlip() async {
    showLoader();
    var response = await ApiClient().postWithToken(ApiUrls.SalarySlip, {});
    hideLoader();
    SalarySlipModel salarySlipModel = SalarySlipModel.fromJson(response);
    if (salarySlipModel.statuscode == StringConstants.success) {
      Get.to(() => SalarySlip(
            salarySlipModel: salarySlipModel,
          ));
    } else {
      showMessage(msg: salarySlipModel.message);
    }
  }

  Future getStudentLeaveApplyList({bool? navigate, String? fromDate}) async {
    showLoader();
    var raw = {
      "ClassMasterId": "null",
      "SectionMasterId": "null",
      "SearchFromDate": fromDate ?? getTimeFormat(DateTime.now()),
      "SearchToDate": "null"
    };
    var response =
        await ApiClient().postWithToken(ApiUrls.GetStudentLeaveApplyList, raw);
    hideLoader();
    StudentLeaveApplyList studentLeaveApplyList =
        StudentLeaveApplyList.fromJson(response);
    if (studentLeaveApplyList.statuscode == StringConstants.success) {
      if (navigate ?? true) {
        Get.to(() => StudentLeave(
              studentLeaveApplyList: studentLeaveApplyList,
            ));
      } else {
        return studentLeaveApplyList;
      }
    } else {
      showMessage(msg: studentLeaveApplyList.message);
    }
  }

  Future getFixedAppointmentsListForTeacher(
      {bool? navigate, String? fromDate}) async {
    showLoader();
    EmployeeProfileModel model = LocalStorage()
        .readTeacherProfileModel(key: StringConstants.profileModel);
    var raw = {
      "EmployeeMasterId": model.data!.id.toString(),
      "FromDate": fromDate ?? getTimeFormat(DateTime.now())
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetFixedAppointmentsListForTeacher, raw);
    hideLoader();
    GetFixedAppointmentsListforTeacher getFixedAppointmentsListforTeacher =
        GetFixedAppointmentsListforTeacher.fromJson(response);
    if (navigate ?? true) {
      if (getFixedAppointmentsListforTeacher.statuscode ==
          StringConstants.success) {
        Get.to(() => TeacherAppointment(
              getFixedAppointmentsListforTeacher:
                  getFixedAppointmentsListforTeacher,
            ));
      } else {
        showMessage(msg: getFixedAppointmentsListforTeacher.message);
      }
    } else {
      return getFixedAppointmentsListforTeacher;
    }
  }

  Future getStudentListForClassHomeWork(
      {required String classMasterId,
      required String classSectionMasterId,
      required String subjectMasterId,
      required String homeWorkUploadDate,
      bool? navigate}) async {
    showLoader();
    var raw = {
      "ClassMasterId": classMasterId,
      "ClassSectionMasterId": classSectionMasterId,
      "SubjectMasterId": subjectMasterId,
      "HomeWorkUploadDate": homeWorkUploadDate
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetStudentListForUploadClassHomeWork, raw);
    hideLoader();
    GetStudentListforUploadClassHomeWorkModel
        getStudentListforUploadClassHomeWorkModel =
        GetStudentListforUploadClassHomeWorkModel.fromJson(response);
    if (navigate ?? true) {
      Get.to(ViewUploadedHomeWork(
        classMasterId: classMasterId,
        sectionMasterId: classSectionMasterId,
        subjectMasterId: subjectMasterId,
        getStudentListforUploadClassHomeWorkModel:
            getStudentListforUploadClassHomeWorkModel,
      ));
    } else {
      return getStudentListforUploadClassHomeWorkModel;
    }
  }

  Future getUpdateUploadHomeWorkReadStatus({required String id}) async {
    showLoader();
    var raw = {"Id": id, "IsRead": "1"};
    var response =
        ApiClient().postWithToken(ApiUrls.UpdateUploadHomeWorkReadStatus, raw);
    hideLoader();
  }

  /*====================================================Get Class Work Subject List=-==========================*/
  Future getClassWorkSubjectList(
      {required String classMasterId,
      required String classSectionMasterId,
      required String className}) async {
    showLoader();
    var raw = {
      "AdmissionNo": "",
      "ClassMasterId": classMasterId,
      "ClassSectionMasterId": classSectionMasterId,
    };
    var response = await ApiClient().postWithTokenAndEncoding(
        ApiUrls.GetClassWorkSubjectList, jsonEncode(raw));
    hideLoader();
    TeacherClassHomeworkModel teacherClassHomeworkModel =
        TeacherClassHomeworkModel.fromJson(response);
    if (teacherClassHomeworkModel.statuscode == StringConstants.success) {
      Get.to(() => ClassHomeWork(
            teacherClassHomeworkModel: teacherClassHomeworkModel,
            className: className,
            fromClassWork: true,
            classMasterId: classMasterId,
            classSectionMasterId: classSectionMasterId,
          ));
    }
  }

  Future getClassWorkBySubjectDate(
      {required String classMasterId,
      required String classSectionMasterId,
      DateTime? date,
      required String subjectMasterId,
      bool? navigate}) async {
    showLoader();
    var data = {
      "Id": "-1",
      "ClassMasterId": classMasterId,
      "ClassSectionMasterId": classSectionMasterId,
      "HomeWorkDate":
          date == null ? DateTime.now().toString() : date.toString(),
      "SubjectMasterId": subjectMasterId
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetClassWorkBySubjectDate, data);
    myLog(label: "response", value: response.toString());
    hideLoader();
    GetClassHomeWorkBySubjectDateModel getClassHomeWorkBySubjectDateModel =
        GetClassHomeWorkBySubjectDateModel.fromJson(response);
    if (navigate ?? true) {
    } else {
      return getClassHomeWorkBySubjectDateModel;
    }
  }

  Future saveClassWorkWithMultipleDocuments({
    required String filePath,
    required String classHomeWorkId,
    required String homeworkTitle,
    required String homeworkDate,
    required String classMasterId,
    required String sectionMasterId,
    required String subjectMasterId,
    required String documentName,
    required String extensionWithName,
    required String rowVersion,
    required String format,
    required String documentSize,
    required List<DocumentUpload> documentList,
  }) async {
    showLoader();
    Map<String, dynamic> raw = {
      "Id": classHomeWorkId,
      "Work": homeworkTitle,
      "ClassWorkDate": homeworkDate,
      "ClassMasterId": classMasterId,
      "ClassSectionMasterId": sectionMasterId,
      "SubjectMasterId": subjectMasterId,
      "RowVersion": rowVersion,
      "Remarks": "",
      "IsApproved": "true",
    };
    List documents = [];
    for (int i = 0; i < documentList.length; i++) {
      if (documentList[i].fromUrl) {
        Map<String, String> temp2 = {
          "DocumentFormat": documentList[i].documentFormat.toString(),
          "DocumentName": documentList[i].documentName.toString(),
          "FileUrl": documentList[i].fileUrl.toString(),
          "Id": documentList[i].id.toString(),
          "IsActive": documentList[i].isActive.toString(),
          "IsApproved": documentList[i].isApproved.toString(),
          "isLocked": "false",
          "IsVideoFile": documentList[i].isVideoFile.toString(),
          "IsYoutubeLink": documentList[i].isYoutubeLink.toString()
        };
        documents.add(temp2);
      } else if (documentList[i].isLink == true) {
        Map<String, String> temp2 = {
          "ClassWorkId": classHomeWorkId,
          "DocumentName": "link",
          "DocumentNameWithExtension": "",
          "DocumentFormat": "",
          "DocumentSize": "",
          "IsApproved": "true",
          "Document": documentList[i].fileSource,
          "IsYoutubeLink": "true",
        };
        documents.add(temp2);
      } else {
        myLog(
            label: "selected file path $i", value: documentList[i].fileSource);
        File file = File(documentList[i].fileSource);
        int size = await file.length();
        String filePath =
            await covertFileAsbytes(fileSource: documentList[i].fileSource);
        Map<String, String> temp2 = {
          "ClassWorkId": classHomeWorkId,
          "DocumentName": documentList[i].fileSource.split("/").last,
          "DocumentNameWithExtension":
              documentList[i].fileSource.split("/").last,
          "DocumentFormat": documentList[i].fileSource.split(".").last,
          "DocumentSize": size.toString(),
          "IsApproved": "true",
          "Document": filePath
        };
        documents.add(temp2);
      }
    }
    raw.addAll({"DocumentsList": documents});
    var response = await ApiClient().postWithTokenAndEncoding(
        ApiUrls.SaveClassWorkWithMultipleDocuments, jsonEncode(raw));
    hideLoader();
    if (response['statuscode'] == StringConstants.success) {
      Get.back();
      showMessage(msg: response['message']);
    } else {
      showMessage(msg: response['message']);
    }
  }

  ///-----------------------------------------------------------------------

  Future getUploadClassHomeWorkListForStudent(
      {required String admissionNo,
      required String classMasterId,
      required DateTime homeWorkUplaodDate,
      required String classSectionMasterId,
      required String subjectMasterID}) async {
    showLoader();
    var raw = {
      "AdmissionNo": admissionNo,
      "AdmissionNumber": admissionNo,
      "ClassHomeWorkId": "-1",
      "ClassMasterId": classMasterId,
      "ClassSectionMasterId": classSectionMasterId,
      "HomeWorkUploadDate": apiTimeFormat(homeWorkUplaodDate),
      "SubjectMasterId": subjectMasterID
    };
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetUploadClassHomeWorkListForStudent, raw);
    hideLoader();
    GetUploadClassHomeWorkListForStudentModel
        getUploadClassHomeWorkListForStudentModel =
        GetUploadClassHomeWorkListForStudentModel.fromJson(response);
    Get.to(() => ViewHomeWorkList(
          getUploadClassHomeWorkListForStudentModel:
              getUploadClassHomeWorkListForStudentModel,
        ));
  }

  Future approveStudentLeave(
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
        await ApiClient().postWithToken(ApiUrls.ApproveStudentLeaveApply, raw);
    hideLoader();
    getStudentLeaveApplyList(navigate: false);
    Get.back();
    showMessage(msg: response['message']);
  }

  Future rejectStudentLeave(
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
        await ApiClient().postWithToken(ApiUrls.RejectStudentLeaveApply, raw);
    hideLoader();
    getStudentLeaveApplyList(navigate: false);
    Get.back();
    showMessage(msg: response['message']);
  }
}
