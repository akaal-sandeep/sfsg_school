class RequestedAppointmentStudentModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  RequestedAppointmentStudentModel({this.statuscode, this.message, this.data});

  RequestedAppointmentStudentModel.fromJson(Map<String, dynamic> json) {
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
  String? appointmentDateRequested;
  String? appointmentDate;
  String? appointmentTime;
  String? appointmentTimeString;
  String? appointmentWith;
  int? employeeMasterId;
  String? employeeName;
  String? employeePhotoUrlForMobileApp;
  String? parentMobileNumber;
  int? studentMasterId;
  String? studentName;
  int? rollNumber;
  String? admissionNumber;
  int? classMasterId;
  String? className;
  int? classSectionMasterId;
  String? classSectionName;
  String? fatherName;
  String? motherName;
  int? relationMasterId;
  String? relationName;
  String? studentPhotoUrlForMobileApp;
  String? remarks;
  bool? isActive;

  Data(
      {this.id,
        this.appointmentDateRequested,
        this.appointmentDate,
        this.appointmentTime,
        this.appointmentTimeString,
        this.appointmentWith,
        this.employeeMasterId,
        this.employeeName,
        this.employeePhotoUrlForMobileApp,
        this.parentMobileNumber,
        this.studentMasterId,
        this.studentName,
        this.rollNumber,
        this.admissionNumber,
        this.classMasterId,
        this.className,
        this.classSectionMasterId,
        this.classSectionName,
        this.fatherName,
        this.motherName,
        this.relationMasterId,
        this.relationName,
        this.studentPhotoUrlForMobileApp,
        this.remarks,
        this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    appointmentDateRequested = json['AppointmentDateRequested'];
    appointmentDate = json['AppointmentDate'];
    appointmentTime = json['AppointmentTime'];
    appointmentTimeString = json['AppointmentTimeString'];
    appointmentWith = json['AppointmentWith'];
    employeeMasterId = json['EmployeeMasterId'];
    employeeName = json['EmployeeName'];
    employeePhotoUrlForMobileApp = json['EmployeePhotoUrlForMobileApp'];
    parentMobileNumber = json['ParentMobileNumber'];
    studentMasterId = json['StudentMasterId'];
    studentName = json['StudentName'];
    rollNumber = json['RollNumber'];
    admissionNumber = json['AdmissionNumber'];
    classMasterId = json['ClassMasterId'];
    className = json['ClassName'];
    classSectionMasterId = json['ClassSectionMasterId'];
    classSectionName = json['ClassSectionName'];
    fatherName = json['FatherName'];
    motherName = json['MotherName'];
    relationMasterId = json['RelationMasterId'];
    relationName = json['RelationName'];
    studentPhotoUrlForMobileApp = json['StudentPhotoUrlForMobileApp'];
    remarks = json['Remarks'];
    isActive = json['IsActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['AppointmentDateRequested'] = this.appointmentDateRequested;
    data['AppointmentDate'] = this.appointmentDate;
    data['AppointmentTime'] = this.appointmentTime;
    data['AppointmentTimeString'] = this.appointmentTimeString;
    data['AppointmentWith'] = this.appointmentWith;
    data['EmployeeMasterId'] = this.employeeMasterId;
    data['EmployeeName'] = this.employeeName;
    data['EmployeePhotoUrlForMobileApp'] = this.employeePhotoUrlForMobileApp;
    data['ParentMobileNumber'] = this.parentMobileNumber;
    data['StudentMasterId'] = this.studentMasterId;
    data['StudentName'] = this.studentName;
    data['RollNumber'] = this.rollNumber;
    data['AdmissionNumber'] = this.admissionNumber;
    data['ClassMasterId'] = this.classMasterId;
    data['ClassName'] = this.className;
    data['ClassSectionMasterId'] = this.classSectionMasterId;
    data['ClassSectionName'] = this.classSectionName;
    data['FatherName'] = this.fatherName;
    data['MotherName'] = this.motherName;
    data['RelationMasterId'] = this.relationMasterId;
    data['RelationName'] = this.relationName;
    data['StudentPhotoUrlForMobileApp'] = this.studentPhotoUrlForMobileApp;
    data['Remarks'] = this.remarks;
    data['IsActive'] = this.isActive;
    return data;
  }
}
