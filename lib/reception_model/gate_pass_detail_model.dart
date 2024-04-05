class GatePassDetailModel {
  String? statuscode;
  String? message;
  Data? data;

  GatePassDetailModel({this.statuscode, this.message, this.data});

  GatePassDetailModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? gatepassNumber;
  bool? isForStudent;
  bool? isForStaff;
  bool? isForGeneral;
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
  String? studentMotherName;
  String? studentMotherMobile;
  String? studentMotherEmail;
  String? studentMotherAadhaarNumber;
  String? studentDateOfBirth;
  String? studentDateOfAdmission;
  int? employeeMasterId;
  String? employeeName;
  String? employeeGUID;
  String? employeePhotoUrlForMobileApp;
  String? employeeGender;
  String? employeeMobileNumber;
  String? employeeEmailId;
  String? employeeAadhaarNumber;
  String? reasonForEntry;
  String? visitorName;
  String? visitorMobileNumber;
  String? visitorRelationName;
  String? otherRelationName;
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
      {this.id,
        this.gatepassNumber,
        this.isForStudent,
        this.isForStaff,
        this.isForGeneral,
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
        this.studentMotherName,
        this.studentMotherMobile,
        this.studentMotherEmail,
        this.studentMotherAadhaarNumber,
        this.studentDateOfBirth,
        this.studentDateOfAdmission,
        this.employeeMasterId,
        this.employeeName,
        this.employeeGUID,
        this.employeePhotoUrlForMobileApp,
        this.employeeGender,
        this.employeeMobileNumber,
        this.employeeEmailId,
        this.employeeAadhaarNumber,
        this.reasonForEntry,
        this.visitorName,
        this.visitorMobileNumber,
        this.visitorRelationName,
        this.otherRelationName,
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
    id = json['Id'];
    gatepassNumber = json['GatepassNumber'];
    isForStudent = json['IsForStudent'];
    isForStaff = json['IsForStaff'];
    isForGeneral = json['IsForGeneral'];
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
    studentMotherName = json['StudentMotherName'];
    studentMotherMobile = json['StudentMotherMobile'];
    studentMotherEmail = json['StudentMotherEmail'];
    studentMotherAadhaarNumber = json['StudentMotherAadhaarNumber'];
    studentDateOfBirth = json['StudentDateOfBirth'];
    studentDateOfAdmission = json['StudentDateOfAdmission'];
    employeeMasterId = json['EmployeeMasterId'];
    employeeName = json['EmployeeName'];
    employeeGUID = json['EmployeeGUID'];
    employeePhotoUrlForMobileApp = json['EmployeePhotoUrlForMobileApp'];
    employeeGender = json['EmployeeGender'];
    employeeMobileNumber = json['EmployeeMobileNumber'];
    employeeEmailId = json['EmployeeEmailId'];
    employeeAadhaarNumber = json['EmployeeAadhaarNumber'];
    reasonForEntry = json['ReasonForEntry'];
    visitorName = json['VisitorName'];
    visitorMobileNumber = json['VisitorMobileNumber'];
    visitorRelationName = json['VisitorRelationName'];
    otherRelationName = json['OtherRelationName'];
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
    data['Id'] = this.id;
    data['GatepassNumber'] = this.gatepassNumber;
    data['IsForStudent'] = this.isForStudent;
    data['IsForStaff'] = this.isForStaff;
    data['IsForGeneral'] = this.isForGeneral;
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
    data['StudentMotherName'] = this.studentMotherName;
    data['StudentMotherMobile'] = this.studentMotherMobile;
    data['StudentMotherEmail'] = this.studentMotherEmail;
    data['StudentMotherAadhaarNumber'] = this.studentMotherAadhaarNumber;
    data['StudentDateOfBirth'] = this.studentDateOfBirth;
    data['StudentDateOfAdmission'] = this.studentDateOfAdmission;
    data['EmployeeMasterId'] = this.employeeMasterId;
    data['EmployeeName'] = this.employeeName;
    data['EmployeeGUID'] = this.employeeGUID;
    data['EmployeePhotoUrlForMobileApp'] = this.employeePhotoUrlForMobileApp;
    data['EmployeeGender'] = this.employeeGender;
    data['EmployeeMobileNumber'] = this.employeeMobileNumber;
    data['EmployeeEmailId'] = this.employeeEmailId;
    data['EmployeeAadhaarNumber'] = this.employeeAadhaarNumber;
    data['ReasonForEntry'] = this.reasonForEntry;
    data['VisitorName'] = this.visitorName;
    data['VisitorMobileNumber'] = this.visitorMobileNumber;
    data['VisitorRelationName'] = this.visitorRelationName;
    data['OtherRelationName'] = this.otherRelationName;
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
