class TeacherTimeTableModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  TeacherTimeTableModel({this.statuscode, this.message, this.data});

  TeacherTimeTableModel.fromJson(Map<String, dynamic> json) {
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
  String? weekDayName;
  bool showData = false;
  List<PeriodList>? periodList;

  Data({this.weekDayName, this.periodList});

  Data.fromJson(Map<String, dynamic> json) {
    weekDayName = json['WeekDayName'];
    if (json['PeriodList'] != null) {
      periodList = <PeriodList>[];
      json['PeriodList'].forEach((v) {
        periodList!.add(new PeriodList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WeekDayName'] = this.weekDayName;
    if (this.periodList != null) {
      data['PeriodList'] = this.periodList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PeriodList {
  int? periodNo;
  String? subjectName;
  String? classMasterName;
  String? classSectionMasterName;

  PeriodList(
      {this.periodNo,
        this.subjectName,
        this.classMasterName,
        this.classSectionMasterName});

  PeriodList.fromJson(Map<String, dynamic> json) {
    periodNo = json['PeriodNo'];
    subjectName = json['SubjectName'];
    classMasterName = json['ClassMasterName'];
    classSectionMasterName = json['ClassSectionMasterName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PeriodNo'] = this.periodNo;
    data['SubjectName'] = this.subjectName;
    data['ClassMasterName'] = this.classMasterName;
    data['ClassSectionMasterName'] = this.classSectionMasterName;
    return data;
  }
}
