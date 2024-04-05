class ManageClassTestMainModel {
  String? statuscode;
  String? message;
  Data? data;
  bool locked = false;

  ManageClassTestMainModel({this.statuscode, this.message, this.data});

  ManageClassTestMainModel.fromJson(Map<String, dynamic> json) {
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
  var id;
  var classMasterId;
  var classSectionMasterId;
  String? testDate;
  var subjectMasterId;
  String? subjectName;
  String? testTopic;
  var maximumMarks;
  var rowVersion;
  var timeStamp;

  Data(
      {this.id,
        this.classMasterId,
        this.classSectionMasterId,
        this.testDate,
        this.subjectMasterId,
        this.subjectName,
        this.testTopic,
        this.maximumMarks,
        this.rowVersion,
        this.timeStamp});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    classMasterId = json['ClassMasterId'];
    classSectionMasterId = json['ClassSectionMasterId'];
    testDate = json['TestDate'];
    subjectMasterId = json['SubjectMasterId'];
    subjectName = json['SubjectName'];
    testTopic = json['TestTopic'];
    maximumMarks = json['MaximumMarks'];
    rowVersion = json['RowVersion'];
    timeStamp = json['TimeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ClassMasterId'] = this.classMasterId;
    data['ClassSectionMasterId'] = this.classSectionMasterId;
    data['TestDate'] = this.testDate;
    data['SubjectMasterId'] = this.subjectMasterId;
    data['SubjectName'] = this.subjectName;
    data['TestTopic'] = this.testTopic;
    data['MaximumMarks'] = this.maximumMarks;
    data['RowVersion'] = this.rowVersion;
    data['TimeStamp'] = this.timeStamp;
    return data;
  }
}
