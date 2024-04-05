class ParentNoticeBoardListModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  ParentNoticeBoardListModel({this.statuscode, this.message, this.data});

  ParentNoticeBoardListModel.fromJson(Map<String, dynamic> json) {
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
  String? noticeBoardSubject;
  String? noticeBoardContents;
  String? fileAbsolutePath;

  Data(
      {this.id,
        this.noticeBoardSubject,
        this.noticeBoardContents,
        this.fileAbsolutePath});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    noticeBoardSubject = json['NoticeBoardSubject'];
    noticeBoardContents = json['NoticeBoardContents'];
    fileAbsolutePath = json['FileAbsolutePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['NoticeBoardSubject'] = this.noticeBoardSubject;
    data['NoticeBoardContents'] = this.noticeBoardContents;
    data['FileAbsolutePath'] = this.fileAbsolutePath;
    return data;
  }
}
