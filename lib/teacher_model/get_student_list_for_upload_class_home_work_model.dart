class GetStudentListforUploadClassHomeWorkModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  GetStudentListforUploadClassHomeWorkModel(
      {this.statuscode, this.message, this.data});

  GetStudentListforUploadClassHomeWorkModel.fromJson(
      Map<String, dynamic> json) {
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
  int? studentMasterId;
  String? name;
  String? fatherName;
  String? gender;
  String? studentProfilePicturePath;
  int? rollNumber;
  String? admissionNumber;

  Data(
      {this.id,
        this.studentMasterId,
        this.name,
        this.fatherName,
        this.gender,
        this.studentProfilePicturePath,
        this.rollNumber,
        this.admissionNumber});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    studentMasterId = json['StudentMasterId'];
    name = json['Name'];
    fatherName = json['FatherName'];
    gender = json['Gender'];
    studentProfilePicturePath = json['StudentProfilePicturePath'];
    rollNumber = json['RollNumber'];
    admissionNumber = json['AdmissionNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['StudentMasterId'] = this.studentMasterId;
    data['Name'] = this.name;
    data['FatherName'] = this.fatherName;
    data['Gender'] = this.gender;
    data['StudentProfilePicturePath'] = this.studentProfilePicturePath;
    data['RollNumber'] = this.rollNumber;
    data['AdmissionNumber'] = this.admissionNumber;
    return data;
  }
}
