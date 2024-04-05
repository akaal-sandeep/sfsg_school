class GetSubjectListForClassModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  GetSubjectListForClassModel({this.statuscode, this.message, this.data});

  GetSubjectListForClassModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  int? sortId;
  var subjectId;

  Data({this.id, this.name, this.sortId, this.subjectId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    sortId = json['SortId'];
    subjectId = json['SubjectId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['SortId'] = this.sortId;
    data['SubjectId'] = this.subjectId;
    return data;
  }
}
