class GetStudentRemarksListModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  GetStudentRemarksListModel({this.statuscode, this.message, this.data});

  GetStudentRemarksListModel.fromJson(Map<String, dynamic> json) {
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
  int? employeeMasterId;
  String? employeeName;
  String? entryDate;
  String? remarksTypeName;
  String? remarksDetail;
  bool? isActive;
  String? absoluteDocumentPath;
  int? studentMasterId;
  String? admissionNumber;
  int? classMasterId;
  int? sectionMasterId;
  String? studentName;
  String? dateOfBirth;
  String? dateOfAdmission;
  String? studentGender;
  String? fatherName;
  String? fatherMobile;
  String? motherName;
  String? motherMobile;
  int? rollNumber;
  String? className;
  String? sectionName;
  String? studentProfilePicturePath;

  Data(
      {this.id,
        this.employeeMasterId,
        this.employeeName,
        this.entryDate,
        this.remarksTypeName,
        this.remarksDetail,
        this.isActive,
        this.absoluteDocumentPath,
        this.studentMasterId,
        this.admissionNumber,
        this.classMasterId,
        this.sectionMasterId,
        this.studentName,
        this.dateOfBirth,
        this.dateOfAdmission,
        this.studentGender,
        this.fatherName,
        this.fatherMobile,
        this.motherName,
        this.motherMobile,
        this.rollNumber,
        this.className,
        this.sectionName,
        this.studentProfilePicturePath});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    employeeMasterId = json['EmployeeMasterId'];
    employeeName = json['EmployeeName'];
    entryDate = json['EntryDate'];
    remarksTypeName = json['RemarksTypeName'];
    remarksDetail = json['RemarksDetail'];
    isActive = json['IsActive'];
    absoluteDocumentPath = json['AbsoluteDocumentPath'];
    studentMasterId = json['StudentMasterId'];
    admissionNumber = json['AdmissionNumber'];
    classMasterId = json['ClassMasterId'];
    sectionMasterId = json['SectionMasterId'];
    studentName = json['StudentName'];
    dateOfBirth = json['DateOfBirth'];
    dateOfAdmission = json['DateOfAdmission'];
    studentGender = json['StudentGender'];
    fatherName = json['FatherName'];
    fatherMobile = json['FatherMobile'];
    motherName = json['MotherName'];
    motherMobile = json['MotherMobile'];
    rollNumber = json['RollNumber'];
    className = json['ClassName'];
    sectionName = json['SectionName'];
    studentProfilePicturePath = json['StudentProfilePicturePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['EmployeeMasterId'] = this.employeeMasterId;
    data['EmployeeName'] = this.employeeName;
    data['EntryDate'] = this.entryDate;
    data['RemarksTypeName'] = this.remarksTypeName;
    data['RemarksDetail'] = this.remarksDetail;
    data['IsActive'] = this.isActive;
    data['AbsoluteDocumentPath'] = this.absoluteDocumentPath;
    data['StudentMasterId'] = this.studentMasterId;
    data['AdmissionNumber'] = this.admissionNumber;
    data['ClassMasterId'] = this.classMasterId;
    data['SectionMasterId'] = this.sectionMasterId;
    data['StudentName'] = this.studentName;
    data['DateOfBirth'] = this.dateOfBirth;
    data['DateOfAdmission'] = this.dateOfAdmission;
    data['StudentGender'] = this.studentGender;
    data['FatherName'] = this.fatherName;
    data['FatherMobile'] = this.fatherMobile;
    data['MotherName'] = this.motherName;
    data['MotherMobile'] = this.motherMobile;
    data['RollNumber'] = this.rollNumber;
    data['ClassName'] = this.className;
    data['SectionName'] = this.sectionName;
    data['StudentProfilePicturePath'] = this.studentProfilePicturePath;
    return data;
  }
}
