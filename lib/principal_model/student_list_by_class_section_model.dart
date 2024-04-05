class StudentListByClassSectionModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  StudentListByClassSectionModel({this.statuscode, this.message, this.data});

  StudentListByClassSectionModel.fromJson(Map<String, dynamic> json) {
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
  var id;
  String? admissionNumber;
  var classMasterId;
  var classSectionMasterId;
  String? name;
  String? dateOfBirth;
  String? dateOfAdmission;
  String? gender;
  String? fatherName;
  String? fatherMobile;
  String? motherName;
  String? motherMobile;
  var rollNumber;
  String? className;
  String? classSectionName;
  String? token;
  String? profilePictureUrlForMobileApp;
  String? studentProfilePicturePath;
  String? attendanceStatus;

  Data(
      {this.id,
        this.admissionNumber,
        this.classMasterId,
        this.classSectionMasterId,
        this.name,
        this.dateOfBirth,
        this.dateOfAdmission,
        this.gender,
        this.fatherName,
        this.fatherMobile,
        this.motherName,
        this.motherMobile,
        this.rollNumber,
        this.className,
        this.classSectionName,
        this.token,
        this.profilePictureUrlForMobileApp,
        this.studentProfilePicturePath,
        this.attendanceStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    admissionNumber = json['AdmissionNumber'];
    classMasterId = json['ClassMasterId'];
    classSectionMasterId = json['ClassSectionMasterId'];
    name = json['Name'];
    dateOfBirth = json['DateOfBirth'];
    dateOfAdmission = json['DateOfAdmission'];
    gender = json['Gender'];
    fatherName = json['FatherName'];
    fatherMobile = json['FatherMobile'];
    motherName = json['MotherName'];
    motherMobile = json['MotherMobile'];
    rollNumber = json['RollNumber'];
    className = json['ClassName'];
    classSectionName = json['ClassSectionName'];
    token = json['Token'];
    profilePictureUrlForMobileApp = json['ProfilePictureUrlForMobileApp'];
    studentProfilePicturePath = json['StudentProfilePicturePath'];
    attendanceStatus = json['AttendanceStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['AdmissionNumber'] = this.admissionNumber;
    data['ClassMasterId'] = this.classMasterId;
    data['ClassSectionMasterId'] = this.classSectionMasterId;
    data['Name'] = this.name;
    data['DateOfBirth'] = this.dateOfBirth;
    data['DateOfAdmission'] = this.dateOfAdmission;
    data['Gender'] = this.gender;
    data['FatherName'] = this.fatherName;
    data['FatherMobile'] = this.fatherMobile;
    data['MotherName'] = this.motherName;
    data['MotherMobile'] = this.motherMobile;
    data['RollNumber'] = this.rollNumber;
    data['ClassName'] = this.className;
    data['ClassSectionName'] = this.classSectionName;
    data['Token'] = this.token;
    data['ProfilePictureUrlForMobileApp'] = this.profilePictureUrlForMobileApp;
    data['StudentProfilePicturePath'] = this.studentProfilePicturePath;
    data['AttendanceStatus'] = this.attendanceStatus;
    return data;
  }
}
