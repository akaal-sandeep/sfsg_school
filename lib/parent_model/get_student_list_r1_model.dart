class GetStudentListR1Model {
  String? statuscode;
  String? message;
  List<StudentData>? data;

  GetStudentListR1Model({this.statuscode, this.message, this.data});

  GetStudentListR1Model.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StudentData>[];
      json['data'].forEach((v) {
        data!.add(new StudentData.fromJson(v));
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

class StudentData {
  var id;
  String? attendanceStatus;
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
  List<FunctionVideoList>? functionVideoList;

  StudentData(
      {this.id,
        this.attendanceStatus,
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
        this.functionVideoList});

  StudentData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    attendanceStatus = json['AttendanceStatus'];
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
    if (json['FunctionVideoList'] != null) {
      functionVideoList = <FunctionVideoList>[];
      json['FunctionVideoList'].forEach((v) {
        functionVideoList!.add(new FunctionVideoList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['AttendanceStatus'] = this.attendanceStatus;
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
    if (this.functionVideoList != null) {
      data['FunctionVideoList'] =
          this.functionVideoList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FunctionVideoList {
  String? functionSubject;
  String? functionContents;
  String? fileAbsolutePath;
  String? videoUrl;

  FunctionVideoList(
      {this.functionSubject,
        this.functionContents,
        this.fileAbsolutePath,
        this.videoUrl});

  FunctionVideoList.fromJson(Map<String, dynamic> json) {
    functionSubject = json['FunctionSubject'];
    functionContents = json['FunctionContents'];
    fileAbsolutePath = json['FileAbsolutePath'];
    videoUrl = json['VideoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FunctionSubject'] = this.functionSubject;
    data['FunctionContents'] = this.functionContents;
    data['FileAbsolutePath'] = this.fileAbsolutePath;
    data['VideoUrl'] = this.videoUrl;
    return data;
  }
}
