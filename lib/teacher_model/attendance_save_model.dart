class AttendanceSaveModel {
  String? statuscode;
  String? message;
  var data;

  AttendanceSaveModel({this.statuscode, this.message, this.data});

  AttendanceSaveModel.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statuscode'] = this.statuscode;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}
