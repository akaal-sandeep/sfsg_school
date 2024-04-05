class PrincipalProfileModel {
  String? statuscode;
  String? message;
  Data? data;

  PrincipalProfileModel({this.statuscode, this.message, this.data});

  PrincipalProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? employeeId;
  String? gender;
  String? attendanceStatus;
  String? employeeProfilePicturePath;
  String? employeeCategoryName;
  String? displayName;
  String? dateOfBirth;
  String? dateOfJoining;
  String? emailId;
  String? mobileNo;

  Data(
      {this.id,
        this.employeeId,
        this.gender,
        this.attendanceStatus,
        this.employeeProfilePicturePath,
        this.employeeCategoryName,
        this.displayName,
        this.dateOfBirth,
        this.dateOfJoining,
        this.emailId,
        this.mobileNo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    employeeId = json['EmployeeId'];
    gender = json['Gender'];
    attendanceStatus = json['AttendanceStatus'];
    employeeProfilePicturePath = json['EmployeeProfilePicturePath'];
    employeeCategoryName = json['EmployeeCategoryName'];
    displayName = json['DisplayName'];
    dateOfBirth = json['DateOfBirth'];
    dateOfJoining = json['DateOfJoining'];
    emailId = json['EmailId'];
    mobileNo = json['MobileNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['EmployeeId'] = this.employeeId;
    data['Gender'] = this.gender;
    data['AttendanceStatus'] = this.attendanceStatus;
    data['EmployeeProfilePicturePath'] = this.employeeProfilePicturePath;
    data['EmployeeCategoryName'] = this.employeeCategoryName;
    data['DisplayName'] = this.displayName;
    data['DateOfBirth'] = this.dateOfBirth;
    data['DateOfJoining'] = this.dateOfJoining;
    data['EmailId'] = this.emailId;
    data['MobileNo'] = this.mobileNo;
    return data;
  }
}
