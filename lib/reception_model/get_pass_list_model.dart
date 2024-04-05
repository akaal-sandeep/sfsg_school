class GetPassListModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  GetPassListModel({this.statuscode, this.message, this.data});

  GetPassListModel.fromJson(Map<String, dynamic> json) {
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
  int? serialNumber;
  int? id;
  int? gatepassNumber;
  String? gUID;
  bool? isForStudent;
  bool? isForStaff;
  int? studentMasterId;
  String? studentGUID;
  String? studentPhotoUrlForMobileApp;
  String? studentName;
  String? studentGender;
  String? studentMobileNumber;
  String? studentEmailId;
  String? studentAadhaarNumber;
  String? studentAdmissionNo;
  int? studentRollNo;
  String? studentClassName;
  String? studentClassSectionName;
  String? studentFatherName;
  String? studentFatherMobile;
  String? studentFatherEmail;
  String? studentFatherAadhaarNumber;
  String? fatherPhotoUrlForMobileApp;
  String? studentMotherName;
  String? studentMotherMobile;
  String? studentMotherEmail;
  String? studentMotherAadhaarNumber;
  String? motherPhotoUrlForMobileApp;
  String? studentDateOfBirth;
  String? studentDateOfAdmission;
  int? employeeMasterId;
  String? employeeName;
  String? instituteGatepassEmployeeGUID;
  String? employeeGUID;
  String? employeePhotoUrlForMobileApp;
  String? employeeGender;
  String? employeeMobileNumber;
  String? employeeEmailId;
  String? employeeAadhaarNumber;
  String? reasonForExit;
  String? visitorName;
  String? visitorMobileNumber;
  String? visitorIDProofName;
  String? visitorIDProofNumber;
  String? visitorIDProofGUID;
  String? visitorIDProofPhotoUrlForMobileApp;
  String? visitorGUID;
  String? visitorPhotoUrlForMobileApp;
  String? visitorCompany;
  String? createDate;
  bool? isActive;
  int? rowVersion;

  Data(
      {this.serialNumber,
        this.id,
        this.gatepassNumber,
        this.gUID,
        this.isForStudent,
        this.isForStaff,
        this.studentMasterId,
        this.studentGUID,
        this.studentPhotoUrlForMobileApp,
        this.studentName,
        this.studentGender,
        this.studentMobileNumber,
        this.studentEmailId,
        this.studentAadhaarNumber,
        this.studentAdmissionNo,
        this.studentRollNo,
        this.studentClassName,
        this.studentClassSectionName,
        this.studentFatherName,
        this.studentFatherMobile,
        this.studentFatherEmail,
        this.studentFatherAadhaarNumber,
        this.fatherPhotoUrlForMobileApp,
        this.studentMotherName,
        this.studentMotherMobile,
        this.studentMotherEmail,
        this.studentMotherAadhaarNumber,
        this.motherPhotoUrlForMobileApp,
        this.studentDateOfBirth,
        this.studentDateOfAdmission,
        this.employeeMasterId,
        this.employeeName,
        this.instituteGatepassEmployeeGUID,
        this.employeeGUID,
        this.employeePhotoUrlForMobileApp,
        this.employeeGender,
        this.employeeMobileNumber,
        this.employeeEmailId,
        this.employeeAadhaarNumber,
        this.reasonForExit,
        this.visitorName,
        this.visitorMobileNumber,
        this.visitorIDProofName,
        this.visitorIDProofNumber,
        this.visitorIDProofGUID,
        this.visitorIDProofPhotoUrlForMobileApp,
        this.visitorGUID,
        this.visitorPhotoUrlForMobileApp,
        this.visitorCompany,
        this.createDate,
        this.isActive,
        this.rowVersion});

  Data.fromJson(Map<String, dynamic> json) {
    serialNumber = json['SerialNumber'];
    id = json['Id'];
    gatepassNumber = json['GatepassNumber'];
    gUID = json['GUID'];
    isForStudent = json['IsForStudent'];
    isForStaff = json['IsForStaff'];
    studentMasterId = json['StudentMasterId'];
    studentGUID = json['StudentGUID'];
    studentPhotoUrlForMobileApp = json['StudentPhotoUrlForMobileApp'];
    studentName = json['StudentName'];
    studentGender = json['StudentGender'];
    studentMobileNumber = json['StudentMobileNumber'];
    studentEmailId = json['StudentEmailId'];
    studentAadhaarNumber = json['StudentAadhaarNumber'];
    studentAdmissionNo = json['StudentAdmissionNo'];
    studentRollNo = json['StudentRollNo'];
    studentClassName = json['StudentClassName'];
    studentClassSectionName = json['StudentClassSectionName'];
    studentFatherName = json['StudentFatherName'];
    studentFatherMobile = json['StudentFatherMobile'];
    studentFatherEmail = json['StudentFatherEmail'];
    studentFatherAadhaarNumber = json['StudentFatherAadhaarNumber'];
    fatherPhotoUrlForMobileApp = json['FatherPhotoUrlForMobileApp'];
    studentMotherName = json['StudentMotherName'];
    studentMotherMobile = json['StudentMotherMobile'];
    studentMotherEmail = json['StudentMotherEmail'];
    studentMotherAadhaarNumber = json['StudentMotherAadhaarNumber'];
    motherPhotoUrlForMobileApp = json['MotherPhotoUrlForMobileApp'];
    studentDateOfBirth = json['StudentDateOfBirth'];
    studentDateOfAdmission = json['StudentDateOfAdmission'];
    employeeMasterId = json['EmployeeMasterId'];
    employeeName = json['EmployeeName'];
    instituteGatepassEmployeeGUID = json['InstituteGatepassEmployeeGUID'];
    employeeGUID = json['EmployeeGUID'];
    employeePhotoUrlForMobileApp = json['EmployeePhotoUrlForMobileApp'];
    employeeGender = json['EmployeeGender'];
    employeeMobileNumber = json['EmployeeMobileNumber'];
    employeeEmailId = json['EmployeeEmailId'];
    employeeAadhaarNumber = json['EmployeeAadhaarNumber'];
    reasonForExit = json['ReasonForExit'];
    visitorName = json['VisitorName'];
    visitorMobileNumber = json['VisitorMobileNumber'];
    visitorIDProofName = json['VisitorIDProofName'];
    visitorIDProofNumber = json['VisitorIDProofNumber'];
    visitorIDProofGUID = json['VisitorIDProofGUID'];
    visitorIDProofPhotoUrlForMobileApp =
    json['VisitorIDProofPhotoUrlForMobileApp'];
    visitorGUID = json['VisitorGUID'];
    visitorPhotoUrlForMobileApp = json['VisitorPhotoUrlForMobileApp'];
    visitorCompany = json['VisitorCompany'];
    createDate = json['CreateDate'];
    isActive = json['IsActive'];
    rowVersion = json['RowVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SerialNumber'] = this.serialNumber;
    data['Id'] = this.id;
    data['GatepassNumber'] = this.gatepassNumber;
    data['GUID'] = this.gUID;
    data['IsForStudent'] = this.isForStudent;
    data['IsForStaff'] = this.isForStaff;
    data['StudentMasterId'] = this.studentMasterId;
    data['StudentGUID'] = this.studentGUID;
    data['StudentPhotoUrlForMobileApp'] = this.studentPhotoUrlForMobileApp;
    data['StudentName'] = this.studentName;
    data['StudentGender'] = this.studentGender;
    data['StudentMobileNumber'] = this.studentMobileNumber;
    data['StudentEmailId'] = this.studentEmailId;
    data['StudentAadhaarNumber'] = this.studentAadhaarNumber;
    data['StudentAdmissionNo'] = this.studentAdmissionNo;
    data['StudentRollNo'] = this.studentRollNo;
    data['StudentClassName'] = this.studentClassName;
    data['StudentClassSectionName'] = this.studentClassSectionName;
    data['StudentFatherName'] = this.studentFatherName;
    data['StudentFatherMobile'] = this.studentFatherMobile;
    data['StudentFatherEmail'] = this.studentFatherEmail;
    data['StudentFatherAadhaarNumber'] = this.studentFatherAadhaarNumber;
    data['FatherPhotoUrlForMobileApp'] = this.fatherPhotoUrlForMobileApp;
    data['StudentMotherName'] = this.studentMotherName;
    data['StudentMotherMobile'] = this.studentMotherMobile;
    data['StudentMotherEmail'] = this.studentMotherEmail;
    data['StudentMotherAadhaarNumber'] = this.studentMotherAadhaarNumber;
    data['MotherPhotoUrlForMobileApp'] = this.motherPhotoUrlForMobileApp;
    data['StudentDateOfBirth'] = this.studentDateOfBirth;
    data['StudentDateOfAdmission'] = this.studentDateOfAdmission;
    data['EmployeeMasterId'] = this.employeeMasterId;
    data['EmployeeName'] = this.employeeName;
    data['InstituteGatepassEmployeeGUID'] = this.instituteGatepassEmployeeGUID;
    data['EmployeeGUID'] = this.employeeGUID;
    data['EmployeePhotoUrlForMobileApp'] = this.employeePhotoUrlForMobileApp;
    data['EmployeeGender'] = this.employeeGender;
    data['EmployeeMobileNumber'] = this.employeeMobileNumber;
    data['EmployeeEmailId'] = this.employeeEmailId;
    data['EmployeeAadhaarNumber'] = this.employeeAadhaarNumber;
    data['ReasonForExit'] = this.reasonForExit;
    data['VisitorName'] = this.visitorName;
    data['VisitorMobileNumber'] = this.visitorMobileNumber;
    data['VisitorIDProofName'] = this.visitorIDProofName;
    data['VisitorIDProofNumber'] = this.visitorIDProofNumber;
    data['VisitorIDProofGUID'] = this.visitorIDProofGUID;
    data['VisitorIDProofPhotoUrlForMobileApp'] =
        this.visitorIDProofPhotoUrlForMobileApp;
    data['VisitorGUID'] = this.visitorGUID;
    data['VisitorPhotoUrlForMobileApp'] = this.visitorPhotoUrlForMobileApp;
    data['VisitorCompany'] = this.visitorCompany;
    data['CreateDate'] = this.createDate;
    data['IsActive'] = this.isActive;
    data['RowVersion'] = this.rowVersion;
    return data;
  }
}
