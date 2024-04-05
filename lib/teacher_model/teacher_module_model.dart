
class TeacherModuleListModel {
  String? statuscode;
  String? message;
  Data? data;

  TeacherModuleListModel({this.statuscode, this.message, this.data});

  TeacherModuleListModel.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statuscode'] = this.statuscode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  bool? teacherTimeTableModuleApplicable;
  bool? teacherClassModuleApplicable;
  bool? teacherClassWorkModuleApplication;
  bool? teacherResultCardModuleApplication;
  bool? teacherSalarySlipModuleApplicable;
  bool? teacherSyllabusModuleApplicable;
  bool? teacherLessonManagementModuleApplicable;
  bool? teacherApplyLeaveModuleApplicable;
  bool? teacherStudentsListWhoAppliedForLeaveModuleApplicable;
  bool? teacherMarkAttendanceModuleApplicable;
  bool? teacherPeriodAttendanceModuleApplicable;
  bool? teacherStudentRemarksModuleApplicable;
  bool? teacherAppointmentModuleApplicable;
  bool? teacherDateSheetModuleApplicable;
  bool? teacherHolidayHomeWorkModuleApplicable;
  bool? teacherCircularModuleApplicable;
  bool? teacherBagPlanModuleApplicable;

  Data(
      {this.teacherTimeTableModuleApplicable,
        this.teacherClassModuleApplicable,
        this.teacherSalarySlipModuleApplicable,
        this.teacherSyllabusModuleApplicable,
        this.teacherLessonManagementModuleApplicable,
        this.teacherApplyLeaveModuleApplicable,
        this.teacherStudentsListWhoAppliedForLeaveModuleApplicable,
        this.teacherMarkAttendanceModuleApplicable,
        this.teacherPeriodAttendanceModuleApplicable,
        this.teacherStudentRemarksModuleApplicable,
        this.teacherAppointmentModuleApplicable,
        this.teacherDateSheetModuleApplicable,
        this.teacherHolidayHomeWorkModuleApplicable,
        this.teacherCircularModuleApplicable,
        this.teacherClassWorkModuleApplication,
        this.teacherResultCardModuleApplication,
        this.teacherBagPlanModuleApplicable
      });

  Data.fromJson(Map<String, dynamic> json) {
    teacherTimeTableModuleApplicable = json['TeacherTimeTableModuleApplicable'];
    teacherClassModuleApplicable = json['TeacherClassModuleApplicable'];
    teacherSalarySlipModuleApplicable =
    json['TeacherSalarySlipModuleApplicable'];
    teacherSyllabusModuleApplicable = json['TeacherSyllabusModuleApplicable'];
    teacherLessonManagementModuleApplicable =
    json['TeacherLessonManagementModuleApplicable'];
    teacherApplyLeaveModuleApplicable =
    json['TeacherApplyLeaveModuleApplicable'];
    teacherStudentsListWhoAppliedForLeaveModuleApplicable =
    json['TeacherStudentsListWhoAppliedForLeaveModuleApplicable'];
    teacherMarkAttendanceModuleApplicable =
    json['TeacherMarkAttendanceModuleApplicable'];
    teacherPeriodAttendanceModuleApplicable =
    json['TeacherPeriodAttendanceModuleApplicable'];
    teacherStudentRemarksModuleApplicable =
    json['TeacherStudentRemarksModuleApplicable'];
    teacherAppointmentModuleApplicable =
    json['TeacherAppointmentModuleApplicable'];
    teacherDateSheetModuleApplicable = json['TeacherDateSheetModuleApplicable'];
    teacherHolidayHomeWorkModuleApplicable =
    json['TeacherHolidayHomeWorkModuleApplicable'];
    teacherCircularModuleApplicable = json['TeacherCircularModuleApplicable'];
    teacherClassWorkModuleApplication = json['TeacherClassWorkModuleApplicable'];
    teacherResultCardModuleApplication = json['TeacherResultCardModuleApplicable'];
    teacherBagPlanModuleApplicable = json['TeacherBagPlanModuleApplicable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TeacherTimeTableModuleApplicable'] =
        this.teacherTimeTableModuleApplicable;
    data['TeacherClassModuleApplicable'] = this.teacherClassModuleApplicable;
    data['TeacherSalarySlipModuleApplicable'] =
        this.teacherSalarySlipModuleApplicable;
    data['TeacherSyllabusModuleApplicable'] =
        this.teacherSyllabusModuleApplicable;
    data['TeacherLessonManagementModuleApplicable'] =
        this.teacherLessonManagementModuleApplicable;
    data['TeacherApplyLeaveModuleApplicable'] =
        this.teacherApplyLeaveModuleApplicable;
    data['TeacherStudentsListWhoAppliedForLeaveModuleApplicable'] =
        this.teacherStudentsListWhoAppliedForLeaveModuleApplicable;
    data['TeacherMarkAttendanceModuleApplicable'] =
        this.teacherMarkAttendanceModuleApplicable;
    data['TeacherPeriodAttendanceModuleApplicable'] =
        this.teacherPeriodAttendanceModuleApplicable;
    data['TeacherStudentRemarksModuleApplicable'] =
        this.teacherStudentRemarksModuleApplicable;
    data['TeacherAppointmentModuleApplicable'] =
        this.teacherAppointmentModuleApplicable;
    data['TeacherDateSheetModuleApplicable'] =
        this.teacherDateSheetModuleApplicable;
    data['TeacherHolidayHomeWorkModuleApplicable'] =
        this.teacherHolidayHomeWorkModuleApplicable;
    data['TeacherCircularModuleApplicable'] = this.teacherCircularModuleApplicable;
    data['TeacherHolidayHomeWorkModuleApplicable'] = this.teacherHolidayHomeWorkModuleApplicable;
    data['TeacherClassWorkModuleApplicable'] = this.teacherClassWorkModuleApplication;
    data['TeacherResultCardModuleApplicable'] = this.teacherResultCardModuleApplication;
    data['TeacherBagPlanModuleApplicable'] = this.teacherBagPlanModuleApplicable;
    return data;
  }
}
