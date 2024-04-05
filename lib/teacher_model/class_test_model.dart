class ClassTestListModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  ClassTestListModel({this.statuscode, this.message, this.data});

  ClassTestListModel.fromJson(Map<String, dynamic> json) {
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

  Data({this.id, this.subjectName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    subjectName = json['SubjectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['SubjectName'] = this.subjectName;
    return data;
  }
}
