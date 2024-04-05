class GetClassHomeworkSubjectListModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  GetClassHomeworkSubjectListModel({this.statuscode, this.message, this.data});

  GetClassHomeworkSubjectListModel.fromJson(Map<String, dynamic> json) {
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
  int? subjectMasterId;
  String? subjectName;
  bool? isLocked;
  int? totalHomeWorkUploadedByStudentForSubject;
  int? documentCount;

  Data(
      {this.id,
        this.subjectMasterId,
        this.subjectName,
        this.isLocked,
        this.totalHomeWorkUploadedByStudentForSubject,
        this.documentCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    subjectMasterId = json['SubjectMasterId'];
    subjectName = json['SubjectName'];
    isLocked = json['IsLocked'];
    totalHomeWorkUploadedByStudentForSubject =
    json['TotalHomeWorkUploadedByStudentForSubject'];
    documentCount = json['DocumentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['SubjectMasterId'] = this.subjectMasterId;
    data['SubjectName'] = this.subjectName;
    data['IsLocked'] = this.isLocked;
    data['TotalHomeWorkUploadedByStudentForSubject'] =
        this.totalHomeWorkUploadedByStudentForSubject;
    data['DocumentCount'] = this.documentCount;
    return data;
  }
}
