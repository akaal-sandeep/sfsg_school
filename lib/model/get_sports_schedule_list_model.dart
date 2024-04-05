class GetSportsScheduleListModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  GetSportsScheduleListModel({this.statuscode, this.message, this.data});

  GetSportsScheduleListModel.fromJson(Map<String, dynamic> json) {
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
  String? scheduleDate;
  String? scheduleTime;
  String? scheduleTimeString;
  String? remarks;

  Data(
      {this.id,
        this.scheduleDate,
        this.scheduleTime,
        this.scheduleTimeString,
        this.remarks});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    scheduleDate = json['ScheduleDate'];
    scheduleTime = json['ScheduleTime'];
    scheduleTimeString = json['ScheduleTimeString'];
    remarks = json['Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ScheduleDate'] = this.scheduleDate;
    data['ScheduleTime'] = this.scheduleTime;
    data['ScheduleTimeString'] = this.scheduleTimeString;
    data['Remarks'] = this.remarks;
    return data;
  }
}
