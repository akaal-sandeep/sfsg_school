class CircularListModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  CircularListModel({this.statuscode, this.message, this.data});

  CircularListModel.fromJson(Map<String, dynamic> json) {
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
  String? createDate;
  String? className;
  String? sectionName;
  String? title;
  String? absoluteImagePath;
  String? fileExtension;

  Data(
      {this.id,
        this.createDate,
        this.className,
        this.sectionName,
        this.title,
        this.absoluteImagePath,
        this.fileExtension});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    createDate = json['CreateDate'];
    className = json['ClassName'];
    sectionName = json['SectionName'];
    title = json['Title'];
    absoluteImagePath = json['AbsoluteImagePath'];
    fileExtension = json['FileExtension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['CreateDate'] = this.createDate;
    data['ClassName'] = this.className;
    data['SectionName'] = this.sectionName;
    data['Title'] = this.title;
    data['AbsoluteImagePath'] = this.absoluteImagePath;
    data['FileExtension'] = this.fileExtension;
    return data;
  }
}
