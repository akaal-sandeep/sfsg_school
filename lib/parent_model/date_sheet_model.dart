class DateSheetModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  DateSheetModel({this.statuscode, this.message, this.data});

  DateSheetModel.fromJson(Map<String, dynamic> json) {
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
  String? className;
  String? sectionName;
  String? absoluteImagePath;

  Data({this.id, this.className, this.sectionName, this.absoluteImagePath});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    className = json['ClassName'];
    sectionName = json['SectionName'];
    absoluteImagePath = json['AbsoluteImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ClassName'] = this.className;
    data['SectionName'] = this.sectionName;
    data['AbsoluteImagePath'] = this.absoluteImagePath;
    return data;
  }
}
