class GetPersonalityListModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  GetPersonalityListModel({this.statuscode, this.message, this.data});

  GetPersonalityListModel.fromJson(Map<String, dynamic> json) {
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
  String? parentPersonalityTrait;

  Data({this.id, this.name, this.sortId, this.parentPersonalityTrait});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    sortId = json['SortId'];
    parentPersonalityTrait = json['ParentPersonalityTrait'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['SortId'] = this.sortId;
    data['ParentPersonalityTrait'] = this.parentPersonalityTrait;
    return data;
  }
}
