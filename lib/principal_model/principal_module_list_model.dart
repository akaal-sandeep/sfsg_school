class PrincipalModuleListModel {
  String? statuscode;
  String? message;
  Data? data;

  PrincipalModuleListModel({this.statuscode, this.message, this.data});

  PrincipalModuleListModel.fromJson(Map<String, dynamic> json) {
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
  bool? principalClassModuleApplicable;
  bool? principalSyllabusModuleApplicable;
  bool? principalHomeWorkModuleApplicable;
  bool? principalLessonManagementModuleApplicable;
  bool? principalTeacherLeaveApprovalModuleApplicable;
  bool? principalStudentRemarksModuleApplicable;
  bool? principalAppointmentModuleApplicable;
  bool? principalDateSheetModuleApplicable;
  bool? principalHolidayHomeWorkModuleApplicable;
  bool? principalEmployeeNotificationModuleApplicable;
  bool? principalParentNotificationModuleApplicable;
  bool? principalCircularModuleApplicable;

  Data(
      {this.principalClassModuleApplicable,
        this.principalSyllabusModuleApplicable,
        this.principalHomeWorkModuleApplicable,
        this.principalLessonManagementModuleApplicable,
        this.principalTeacherLeaveApprovalModuleApplicable,
        this.principalStudentRemarksModuleApplicable,
        this.principalAppointmentModuleApplicable,
        this.principalDateSheetModuleApplicable,
        this.principalHolidayHomeWorkModuleApplicable,
        this.principalEmployeeNotificationModuleApplicable,
        this.principalParentNotificationModuleApplicable,
        this.principalCircularModuleApplicable
      });

  Data.fromJson(Map<String, dynamic> json) {
    principalClassModuleApplicable = json['PrincipalClassModuleApplicable'];
    principalSyllabusModuleApplicable =
    json['PrincipalSyllabusModuleApplicable'];
    principalHomeWorkModuleApplicable =
    json['PrincipalHomeWorkModuleApplicable'];
    principalLessonManagementModuleApplicable =
    json['PrincipalLessonManagementModuleApplicable'];
    principalTeacherLeaveApprovalModuleApplicable =
    json['PrincipalTeacherLeaveApprovalModuleApplicable'];
    principalStudentRemarksModuleApplicable =
    json['PrincipalStudentRemarksModuleApplicable'];
    principalAppointmentModuleApplicable =
    json['PrincipalAppointmentModuleApplicable'];
    principalDateSheetModuleApplicable =
    json['PrincipalDateSheetModuleApplicable'];
    principalHolidayHomeWorkModuleApplicable =
    json['PrincipalHolidayHomeWorkModuleApplicable'];
    principalEmployeeNotificationModuleApplicable =
    json['PrincipalEmployeeNotificationModuleApplicable'];
    principalParentNotificationModuleApplicable =
    json['PrincipalParentNotificationModuleApplicable'];
    principalCircularModuleApplicable = json['PrincipalCircularModuleApplicable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PrincipalClassModuleApplicable'] =
        this.principalClassModuleApplicable;
    data['PrincipalSyllabusModuleApplicable'] =
        this.principalSyllabusModuleApplicable;
    data['PrincipalHomeWorkModuleApplicable'] =
        this.principalHomeWorkModuleApplicable;
    data['PrincipalLessonManagementModuleApplicable'] =
        this.principalLessonManagementModuleApplicable;
    data['PrincipalTeacherLeaveApprovalModuleApplicable'] =
        this.principalTeacherLeaveApprovalModuleApplicable;
    data['PrincipalStudentRemarksModuleApplicable'] =
        this.principalStudentRemarksModuleApplicable;
    data['PrincipalAppointmentModuleApplicable'] =
        this.principalAppointmentModuleApplicable;
    data['PrincipalDateSheetModuleApplicable'] =
        this.principalDateSheetModuleApplicable;
    data['PrincipalHolidayHomeWorkModuleApplicable'] =
        this.principalHolidayHomeWorkModuleApplicable;
    data['PrincipalEmployeeNotificationModuleApplicable'] =
        this.principalEmployeeNotificationModuleApplicable;
    data['PrincipalParentNotificationModuleApplicable'] =
        this.principalParentNotificationModuleApplicable;
    data['PrincipalCircularModuleApplicable']= this.principalCircularModuleApplicable;
    return data;
  }
}
