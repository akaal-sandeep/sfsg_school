class ParentModuleListModel {
  String? statuscode;
  String? message;
  Data? data;

  ParentModuleListModel({this.statuscode, this.message, this.data});

  ParentModuleListModel.fromJson(Map<String, dynamic> json) {
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
  String? onlineFeePaymentModuleApplicable;
  bool? onlineFeePayModuleApplicable;
  bool? attendanceModuleApplicable;
  bool? homeWorkModuleApplicable;
  bool? timeTableModuleApplicable;
  bool? classTestModuleApplicable;
  bool? mCQTestModuleApplicable;
  bool? syllabusModuleApplicable;
  bool? feeLedgerModuleApplicable;
  bool? videosModuleApplicable;
  bool? lessonManagementModuleApplicable;
  bool? applyLeaveModuleApplicable;
  bool? parentCameraModuleApplicable;
  bool? parentAppointmentModuleApplicable;
  bool? parentDateSheetModuleApplicable;
  bool? parentHolidayHomeWorkModuleApplicable;
  bool? parentGPSTrackingModuleApplicable;
  bool? parentCircularModuleApplicable;
  bool? parentBagPlanModuleApplicable;

  Data(
      {this.onlineFeePaymentModuleApplicable,
        this.onlineFeePayModuleApplicable,
        this.attendanceModuleApplicable,
        this.homeWorkModuleApplicable,
        this.timeTableModuleApplicable,
        this.classTestModuleApplicable,
        this.mCQTestModuleApplicable,
        this.syllabusModuleApplicable,
        this.feeLedgerModuleApplicable,
        this.videosModuleApplicable,
        this.lessonManagementModuleApplicable,
        this.applyLeaveModuleApplicable,
        this.parentCameraModuleApplicable,
        this.parentAppointmentModuleApplicable,
        this.parentDateSheetModuleApplicable,
        this.parentHolidayHomeWorkModuleApplicable,
        this.parentCircularModuleApplicable,
        this.parentGPSTrackingModuleApplicable,
        this.parentBagPlanModuleApplicable
      });

  Data.fromJson(Map<String, dynamic> json) {
    onlineFeePaymentModuleApplicable = json['OnlineFeePaymentModuleApplicable'];
    onlineFeePayModuleApplicable = json['OnlineFeePayModuleApplicable'];
    attendanceModuleApplicable = json['AttendanceModuleApplicable'];
    homeWorkModuleApplicable = json['HomeWorkModuleApplicable'];
    timeTableModuleApplicable = json['TimeTableModuleApplicable'];
    classTestModuleApplicable = json['ClassTestModuleApplicable'];
    mCQTestModuleApplicable = json['MCQTestModuleApplicable'];
    syllabusModuleApplicable = json['SyllabusModuleApplicable'];
    feeLedgerModuleApplicable = json['FeeLedgerModuleApplicable'];
    videosModuleApplicable = json['VideosModuleApplicable'];
    lessonManagementModuleApplicable = json['LessonManagementModuleApplicable'];
    applyLeaveModuleApplicable = json['ApplyLeaveModuleApplicable'];
    parentCameraModuleApplicable = json['ParentCameraModuleApplicable'];
    parentAppointmentModuleApplicable =
    json['ParentAppointmentModuleApplicable'];
    parentDateSheetModuleApplicable = json['ParentDateSheetModuleApplicable'];
    parentHolidayHomeWorkModuleApplicable =
    json['ParentHolidayHomeWorkModuleApplicable'];
    parentCircularModuleApplicable = json['ParentCircularModuleApplicable'];
    parentGPSTrackingModuleApplicable =
    json['ParentGPSTrackingModuleApplicable'];
    parentBagPlanModuleApplicable = json['ParentBagPlanModuleApplicable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OnlineFeePaymentModuleApplicable'] =
        this.onlineFeePaymentModuleApplicable;
    data['OnlineFeePayModuleApplicable'] = this.onlineFeePayModuleApplicable;
    data['AttendanceModuleApplicable'] = this.attendanceModuleApplicable;
    data['HomeWorkModuleApplicable'] = this.homeWorkModuleApplicable;
    data['TimeTableModuleApplicable'] = this.timeTableModuleApplicable;
    data['ClassTestModuleApplicable'] = this.classTestModuleApplicable;
    data['MCQTestModuleApplicable'] = this.mCQTestModuleApplicable;
    data['SyllabusModuleApplicable'] = this.syllabusModuleApplicable;
    data['FeeLedgerModuleApplicable'] = this.feeLedgerModuleApplicable;
    data['VideosModuleApplicable'] = this.videosModuleApplicable;
    data['LessonManagementModuleApplicable'] =
        this.lessonManagementModuleApplicable;
    data['ApplyLeaveModuleApplicable'] = this.applyLeaveModuleApplicable;
    data['ParentCameraModuleApplicable'] = this.parentCameraModuleApplicable;
    data['ParentAppointmentModuleApplicable'] =
        this.parentAppointmentModuleApplicable;
    data['ParentDateSheetModuleApplicable'] =
        this.parentDateSheetModuleApplicable;
    data['ParentHolidayHomeWorkModuleApplicable'] =
        this.parentHolidayHomeWorkModuleApplicable;
    data['ParentCircularModuleApplicable'] = this.parentCircularModuleApplicable;
    data['ParentGPSTrackingModuleApplicable'] =
        this.parentGPSTrackingModuleApplicable;
    data['ParentBagPlanModuleApplicable'] = this.parentBagPlanModuleApplicable;
    return data;
  }
}
