class RemarksTypeModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  RemarksTypeModel({this.statuscode, this.message, this.data});

  RemarksTypeModel.fromJson(Map<String, dynamic> json) {
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

  Data({this.id, this.name, this.sortId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    sortId = json['SortId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['SortId'] = this.sortId;
    return data;
  }
}
