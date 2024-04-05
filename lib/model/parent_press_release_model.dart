class ParentPressReleaseModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  ParentPressReleaseModel({this.statuscode, this.message, this.data});

  ParentPressReleaseModel.fromJson(Map<String, dynamic> json) {
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
  String? coverImageAbsolutePath;
  String? eventName;
  String? eventDate;
  String? remarks;

  Data(
      {this.id,
        this.coverImageAbsolutePath,
        this.eventName,
        this.eventDate,
        this.remarks});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    coverImageAbsolutePath = json['CoverImageAbsolutePath'];
    eventName = json['EventName'];
    eventDate = json['EventDate'];
    remarks = json['Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['CoverImageAbsolutePath'] = this.coverImageAbsolutePath;
    data['EventName'] = this.eventName;
    data['EventDate'] = this.eventDate;
    data['Remarks'] = this.remarks;
    return data;
  }
}
