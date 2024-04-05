import 'data_model.dart';

class ManageClassTestInvModel {
  String? statuscode;
  String? message;
  Data? data;
  bool locked = false;

  ManageClassTestInvModel({this.statuscode, this.message, this.data});

  ManageClassTestInvModel.fromJson(Map<String, dynamic> json) {
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

// class Data {
//   var id;
//   var classMasterId;
//   var classSectionMasterId;
//   String? testDate;
//   var subjectMasterId;
//   String? subjectName;
//   String? testTopic;
//   var maximumMarks;
//   var rowVersion;
//   var timeStamp;
//   List<StudentList>? studentList;
//
//   Data(
//       {this.id,
//         this.classMasterId,
//         this.classSectionMasterId,
//         this.testDate,
//         this.subjectMasterId,
//         this.subjectName,
//         this.testTopic,
//         this.maximumMarks,
//         this.rowVersion,
//         this.timeStamp,
//         this.studentList});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['Id'];
//     classMasterId = json['ClassMasterId'];
//     classSectionMasterId = json['ClassSectionMasterId'];
//     testDate = json['TestDate'];
//     subjectMasterId = json['SubjectMasterId'];
//     subjectName = json['SubjectName'];
//     testTopic = json['TestTopic'];
//     maximumMarks = json['MaximumMarks'];
//     rowVersion = json['RowVersion'];
//     timeStamp = json['TimeStamp'];
//     if (json['StudentList'] != null) {
//       studentList = <StudentList>[];
//       json['StudentList'].forEach((v) {
//         studentList!.add(new StudentList.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Id'] = this.id;
//     data['ClassMasterId'] = this.classMasterId;
//     data['ClassSectionMasterId'] = this.classSectionMasterId;
//     data['TestDate'] = this.testDate;
//     data['SubjectMasterId'] = this.subjectMasterId;
//     data['SubjectName'] = this.subjectName;
//     data['TestTopic'] = this.testTopic;
//     data['MaximumMarks'] = this.maximumMarks;
//     data['RowVersion'] = this.rowVersion;
//     data['TimeStamp'] = this.timeStamp;
//     if (this.studentList != null) {
//       data['StudentList'] = this.studentList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class StudentList {
//   var id;
//   var studentMasterId;
//   String? name;
//   String? studentProfilePicturePath;
//   String? gender;
//   String? fatherName;
//   String? admissionNumber;
//   var rollNumber;
//   String? remarks;
//   String? attendanceStatus;
//   var marksObtained;
//   var marksPercentage;
//
//   StudentList(
//       {this.id,
//         this.studentMasterId,
//         this.name,
//         this.studentProfilePicturePath,
//         this.gender,
//         this.fatherName,
//         this.admissionNumber,
//         this.rollNumber,
//         this.remarks,
//         this.attendanceStatus,
//         this.marksObtained,
//         this.marksPercentage});
//
//   StudentList.fromJson(Map<String, dynamic> json) {
//     id = json['Id'];
//     studentMasterId = json['StudentMasterId'];
//     name = json['Name'];
//     studentProfilePicturePath = json['StudentProfilePicturePath'];
//     gender = json['Gender'];
//     fatherName = json['FatherName'];
//     admissionNumber = json['AdmissionNumber'];
//     rollNumber = json['RollNumber'];
//     remarks = json['Remarks'];
//     attendanceStatus = json['AttendanceStatus'];
//     marksObtained = json['MarksObtained'];
//     marksPercentage = json['MarksPercentage'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['Id'] = this.id;
//     data['StudentMasterId'] = this.studentMasterId;
//     data['Name'] = this.name;
//     data['StudentProfilePicturePath'] = this.studentProfilePicturePath;
//     data['Gender'] = this.gender;
//     data['FatherName'] = this.fatherName;
//     data['AdmissionNumber'] = this.admissionNumber;
//     data['RollNumber'] = this.rollNumber;
//     data['Remarks'] = this.remarks;
//     data['AttendanceStatus'] = this.attendanceStatus;
//     data['MarksObtained'] = this.marksObtained;
//     data['MarksPercentage'] = this.marksPercentage;
//     return data;
//   }
// }
