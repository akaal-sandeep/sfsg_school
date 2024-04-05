class ClassAttendanceModel {
  String? statuscode;
  String? message;
  Data? data;

  ClassAttendanceModel({this.statuscode, this.message, this.data});

  ClassAttendanceModel.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    message = json['message'];
    data = (json['data'] != null && json['data'].toString()!="[]") ? new Data.fromJson(json['data']) : null;
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
  bool? isLocked;
  List<StudentList>? studentList;

  Data({this.isLocked, this.studentList});

  Data.fromJson(Map<String, dynamic> json) {
    isLocked = json['IsLocked'];
    if (json['StudentList'] != null) {
      studentList = <StudentList>[];
      json['StudentList'].forEach((v) {
        studentList!.add(new StudentList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsLocked'] = this.isLocked;
    if (this.studentList != null) {
      data['StudentList'] = this.studentList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentList {
  int? id;
  int? studentMasterId;
  String? studentName;
  String? studentProfilePicturePath;
  int? rollNo;
  String? admissionNo;
  String? attendanceStatus;
  String? attendanceDate;
  String? attendanceRemarks;
  int? rowVersion;

  StudentList(
      {this.id,
        this.studentMasterId,
        this.studentName,
        this.studentProfilePicturePath,
        this.rollNo,
        this.admissionNo,
        this.attendanceStatus,
        this.attendanceDate,
        this.attendanceRemarks,
        this.rowVersion});

  StudentList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    studentMasterId = json['StudentMasterId'];
    studentName = json['StudentName'];
    studentProfilePicturePath = json['StudentProfilePicturePath'];
    rollNo = json['RollNo'];
    admissionNo = json['AdmissionNo'];
    attendanceStatus = json['AttendanceStatus'];
    attendanceDate = json['AttendanceDate'];
    attendanceRemarks = json['AttendanceRemarks'];
    rowVersion = json['RowVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['StudentMasterId'] = this.studentMasterId;
    data['StudentName'] = this.studentName;
    data['StudentProfilePicturePath'] = this.studentProfilePicturePath;
    data['RollNo'] = this.rollNo;
    data['AdmissionNo'] = this.admissionNo;
    data['AttendanceStatus'] = this.attendanceStatus;
    data['AttendanceDate'] = this.attendanceDate;
    data['AttendanceRemarks'] = this.attendanceRemarks;
    data['RowVersion'] = this.rowVersion;
    return data;
  }
}
