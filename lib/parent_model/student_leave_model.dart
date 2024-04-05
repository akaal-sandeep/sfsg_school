class StudentAppliedLeaveModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  StudentAppliedLeaveModel({this.statuscode, this.message, this.data});

  StudentAppliedLeaveModel.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statuscode'] = this.statuscode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? studentMasterId;
  String? studentName;
  String? admissionNumber;
  int? rollNumber;
  String? profilePictureUrlForMobileApp;
  int? classMasterId;
  String? className;
  int? classSectionMasterId;
  String? sectionName;
  int? studentLeaveReasonMasterId;
  String? studentLeaveReasonName;
  String? remarks;
  int? leaveDays;
  String? fromDate;
  String? toDate;
  String? createDate;
  int? rowVersion;
  bool? isApproved;
  bool? isRejected;
  String? approveRemarks;
  String? rejectRemarks;

  Data(
      {this.id,
        this.studentMasterId,
        this.studentName,
        this.admissionNumber,
        this.rollNumber,
        this.profilePictureUrlForMobileApp,
        this.classMasterId,
        this.className,
        this.classSectionMasterId,
        this.sectionName,
        this.studentLeaveReasonMasterId,
        this.studentLeaveReasonName,
        this.remarks,
        this.leaveDays,
        this.fromDate,
        this.toDate,
        this.createDate,
        this.rowVersion,
        this.isApproved,
        this.isRejected,
        this.approveRemarks,
        this.rejectRemarks});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    studentMasterId = json['StudentMasterId'];
    studentName = json['StudentName'];
    admissionNumber = json['AdmissionNumber'];
    rollNumber = json['RollNumber'];
    profilePictureUrlForMobileApp = json['ProfilePictureUrlForMobileApp'];
    classMasterId = json['ClassMasterId'];
    className = json['ClassName'];
    classSectionMasterId = json['ClassSectionMasterId'];
    sectionName = json['SectionName'];
    studentLeaveReasonMasterId = json['StudentLeaveReasonMasterId'];
    studentLeaveReasonName = json['StudentLeaveReasonName'];
    remarks = json['Remarks'];
    leaveDays = json['LeaveDays'];
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    createDate = json['CreateDate'];
    rowVersion = json['RowVersion'];
    isApproved = json['IsApproved'];
    isRejected = json['IsRejected'];
    approveRemarks = json['ApproveRemarks'];
    rejectRemarks = json['RejectRemarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['StudentMasterId'] = this.studentMasterId;
    data['StudentName'] = this.studentName;
    data['AdmissionNumber'] = this.admissionNumber;
    data['RollNumber'] = this.rollNumber;
    data['ProfilePictureUrlForMobileApp'] = this.profilePictureUrlForMobileApp;
    data['ClassMasterId'] = this.classMasterId;
    data['ClassName'] = this.className;
    data['ClassSectionMasterId'] = this.classSectionMasterId;
    data['SectionName'] = this.sectionName;
    data['StudentLeaveReasonMasterId'] = this.studentLeaveReasonMasterId;
    data['StudentLeaveReasonName'] = this.studentLeaveReasonName;
    data['Remarks'] = this.remarks;
    data['LeaveDays'] = this.leaveDays;
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['CreateDate'] = this.createDate;
    data['RowVersion'] = this.rowVersion;
    data['IsApproved'] = this.isApproved;
    data['IsRejected'] = this.isRejected;
    data['ApproveRemarks'] = this.approveRemarks;
    data['RejectRemarks'] = this.rejectRemarks;
    return data;
  }
}
