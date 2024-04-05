class TeacherListModel {
  String? statuscode;
  String? message;
  List<TeacherListData>? data;

  TeacherListModel({this.statuscode, this.message, this.data});

  TeacherListModel.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TeacherListData>[];
      json['data'].forEach((v) {
        data!.add(new TeacherListData.fromJson(v));
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

class TeacherListData {
  var id;
  String? employeeCategoryName;
  String? displayName;
  String? employeeId;
  String? mobileNo;
  String? gender;
  var serialNumber;
  String? dateOfJoining;
  String? dateOfBirth;
  String? employeeProfilePicturePath;
  String? emailId;
  var sortId;
  var rowVersion;
  bool? isActive;
  bool? isPrincipal;
  bool? isClassIncharge;
  String? attendanceStatus;

  TeacherListData(
      {this.id,
        this.employeeCategoryName,
        this.displayName,
        this.employeeId,
        this.mobileNo,
        this.gender,
        this.serialNumber,
        this.dateOfJoining,
        this.dateOfBirth,
        this.employeeProfilePicturePath,
        this.emailId,
        this.sortId,
        this.rowVersion,
        this.isActive,
        this.isPrincipal,
        this.isClassIncharge,
        this.attendanceStatus});

  TeacherListData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    employeeCategoryName = json['EmployeeCategoryName'];
    displayName = json['DisplayName'];
    employeeId = json['EmployeeId'];
    mobileNo = json['MobileNo'];
    gender = json['Gender'];
    serialNumber = json['SerialNumber'];
    dateOfJoining = json['DateOfJoining'];
    dateOfBirth = json['DateOfBirth'];
    employeeProfilePicturePath = json['EmployeeProfilePicturePath'];
    emailId = json['EmailId'];
    sortId = json['SortId'];
    rowVersion = json['RowVersion'];
    isActive = json['IsActive'];
    isPrincipal = json['IsPrincipal'];
    isClassIncharge = json['IsClassIncharge'];
    attendanceStatus = json['AttendanceStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['EmployeeCategoryName'] = this.employeeCategoryName;
    data['DisplayName'] = this.displayName;
    data['EmployeeId'] = this.employeeId;
    data['MobileNo'] = this.mobileNo;
    data['Gender'] = this.gender;
    data['SerialNumber'] = this.serialNumber;
    data['DateOfJoining'] = this.dateOfJoining;
    data['DateOfBirth'] = this.dateOfBirth;
    data['EmployeeProfilePicturePath'] = this.employeeProfilePicturePath;
    data['EmailId'] = this.emailId;
    data['SortId'] = this.sortId;
    data['RowVersion'] = this.rowVersion;
    data['IsActive'] = this.isActive;
    data['IsPrincipal'] = this.isPrincipal;
    data['IsClassIncharge'] = this.isClassIncharge;
    data['AttendanceStatus'] = this.attendanceStatus;
    return data;
  }
}
