class PendingHomeWorkListModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  PendingHomeWorkListModel({this.statuscode, this.message, this.data});

  PendingHomeWorkListModel.fromJson(Map<String, dynamic> json) {
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
  int? classMasterId;
  String? className;
  int? classSectionMasterId;
  String? sectionName;
  List<SubjectList>? subjectList;

  Data(
      {this.classMasterId,
        this.className,
        this.classSectionMasterId,
        this.sectionName,
        this.subjectList});

  Data.fromJson(Map<String, dynamic> json) {
    classMasterId = json['ClassMasterId'];
    className = json['ClassName'];
    classSectionMasterId = json['ClassSectionMasterId'];
    sectionName = json['SectionName'];
    if (json['SubjectList'] != null) {
      subjectList = <SubjectList>[];
      json['SubjectList'].forEach((v) {
        subjectList!.add(new SubjectList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassMasterId'] = this.classMasterId;
    data['ClassName'] = this.className;
    data['ClassSectionMasterId'] = this.classSectionMasterId;
    data['SectionName'] = this.sectionName;
    if (this.subjectList != null) {
      data['SubjectList'] = this.subjectList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubjectList {
  int? subjectMasterId;
  String? subjectName;
  int? employeeMasterId;
  String? employeeName;

  SubjectList(
      {this.subjectMasterId,
        this.subjectName,
        this.employeeMasterId,
        this.employeeName});

  SubjectList.fromJson(Map<String, dynamic> json) {
    subjectMasterId = json['SubjectMasterId'];
    subjectName = json['SubjectName'];
    employeeMasterId = json['EmployeeMasterId'];
    employeeName = json['EmployeeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SubjectMasterId'] = this.subjectMasterId;
    data['SubjectName'] = this.subjectName;
    data['EmployeeMasterId'] = this.employeeMasterId;
    data['EmployeeName'] = this.employeeName;
    return data;
  }
}
