class LoginSuccessModel {
  String? statuscode;
  String? message;
  Data? data;

  LoginSuccessModel({this.statuscode, this.message, this.data});

  LoginSuccessModel.fromJson(Map<String, dynamic> json) {
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
  String? accessToken;
  String? userType;
  String? userTypeFullName;
  String? instituteMasterId;
  String? instituteName;
  String? instituteCode;
  String? instituteLogo;
  String? instituteCompleteAddress;
  String? instituteEmailId;
  String? instituteWebsite;
  String? instituteContactNumber;
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

  Data(
      {this.accessToken,
        this.userType,
        this.userTypeFullName,
        this.instituteMasterId,
        this.instituteName,
        this.instituteCode,
        this.instituteLogo,
        this.instituteCompleteAddress,
        this.instituteEmailId,
        this.instituteWebsite,
        this.instituteContactNumber,
        this.onlineFeePaymentModuleApplicable,
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
        this.parentHolidayHomeWorkModuleApplicable});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['AccessToken'];
    userType = json['UserType'];
    userTypeFullName = json['UserTypeFullName'];
    instituteMasterId = json['InstituteMasterId'];
    instituteName = json['InstituteName'];
    instituteCode = json['InstituteCode'];
    instituteLogo = json['InstituteLogo'];
    instituteCompleteAddress = json['InstituteCompleteAddress'];
    instituteEmailId = json['InstituteEmailId'];
    instituteWebsite = json['InstituteWebsite'];
    instituteContactNumber = json['InstituteContactNumber'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AccessToken'] = this.accessToken;
    data['UserType'] = this.userType;
    data['UserTypeFullName'] = this.userTypeFullName;
    data['InstituteMasterId'] = this.instituteMasterId;
    data['InstituteName'] = this.instituteName;
    data['InstituteCode'] = this.instituteCode;
    data['InstituteLogo'] = this.instituteLogo;
    data['InstituteCompleteAddress'] = this.instituteCompleteAddress;
    data['InstituteEmailId'] = this.instituteEmailId;
    data['InstituteWebsite'] = this.instituteWebsite;
    data['InstituteContactNumber'] = this.instituteContactNumber;
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
    return data;
  }
}
