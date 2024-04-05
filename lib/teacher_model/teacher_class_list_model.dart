class TeacherClassesListModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  TeacherClassesListModel({this.statuscode, this.message, this.data});

  TeacherClassesListModel.fromJson(Map<String, dynamic> json) {
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
  var classMasterId;
  String? className;
  var classSectionMasterId;
  String? classSectionName;
  bool? isClassIncharge;
  String? homeWorkUploadDateByStudent;
  bool? isHomeWorkUploadedByStudent;
  var totalHomeWorkUploadedByStudentForClass;
  var totalHomeWorkDocumentsUploadedByStudentForClass;

  Data(
      {this.classMasterId,
        this.className,
        this.classSectionMasterId,
        this.classSectionName,
        this.isClassIncharge,
        this.homeWorkUploadDateByStudent,
        this.isHomeWorkUploadedByStudent,
        this.totalHomeWorkUploadedByStudentForClass,
        this.totalHomeWorkDocumentsUploadedByStudentForClass});

  Data.fromJson(Map<String, dynamic> json) {
    classMasterId = json['ClassMasterId'];
    className = json['ClassName'];
    classSectionMasterId = json['ClassSectionMasterId'];
    classSectionName = json['ClassSectionName'];
    isClassIncharge = json['IsClassIncharge'];
    homeWorkUploadDateByStudent = json['HomeWorkUploadDateByStudent'];
    isHomeWorkUploadedByStudent = json['IsHomeWorkUploadedByStudent'];
    totalHomeWorkUploadedByStudentForClass =
    json['TotalHomeWorkUploadedByStudentForClass'];
    totalHomeWorkDocumentsUploadedByStudentForClass =
    json['TotalHomeWorkDocumentsUploadedByStudentForClass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassMasterId'] = this.classMasterId;
    data['ClassName'] = this.className;
    data['ClassSectionMasterId'] = this.classSectionMasterId;
    data['ClassSectionName'] = this.classSectionName;
    data['IsClassIncharge'] = this.isClassIncharge;
    data['HomeWorkUploadDateByStudent'] = this.homeWorkUploadDateByStudent;
    data['IsHomeWorkUploadedByStudent'] = this.isHomeWorkUploadedByStudent;
    data['TotalHomeWorkUploadedByStudentForClass'] =
        this.totalHomeWorkUploadedByStudentForClass;
    data['TotalHomeWorkDocumentsUploadedByStudentForClass'] =
        this.totalHomeWorkDocumentsUploadedByStudentForClass;
    return data;
  }
}
