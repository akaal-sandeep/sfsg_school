class GetHolidaysListModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  GetHolidaysListModel({this.statuscode, this.message, this.data});

  GetHolidaysListModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? fromDate;
  String? toDate;

  Data({this.name, this.fromDate, this.toDate});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    return data;
  }
}
