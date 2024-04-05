class GetTeacherClassTestListBySubjectModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  GetTeacherClassTestListBySubjectModel({this.statuscode, this.message, this.data});

  GetTeacherClassTestListBySubjectModel.fromJson(Map<String, dynamic> json) {
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
  String? subjectName;
  String? testDate;
  String? testTopic;
  bool? isLocked;
  int? rowVersion;
  bool? isOldClassTest;

  Data(
      {this.id,
        this.subjectName,
        this.testDate,
        this.testTopic,
        this.isLocked,
        this.rowVersion,
        this.isOldClassTest});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    subjectName = json['SubjectName'];
    testDate = json['TestDate'];
    testTopic = json['TestTopic'];
    isLocked = json['IsLocked'];
    rowVersion = json['RowVersion'];
    isOldClassTest = json['IsOldClassTest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['SubjectName'] = this.subjectName;
    data['TestDate'] = this.testDate;
    data['TestTopic'] = this.testTopic;
    data['IsLocked'] = this.isLocked;
    data['RowVersion'] = this.rowVersion;
    data['IsOldClassTest'] = this.isOldClassTest;
    return data;
  }
}
