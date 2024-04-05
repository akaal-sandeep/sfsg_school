class ResponseCheckModel {
  String? statuscode;
  String? message;
  List<Null>? data;

  ResponseCheckModel({this.statuscode, this.message, this.data});

  ResponseCheckModel.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Null>[];
      json['data'].forEach((v) {

      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statuscode'] = this.statuscode;
    data['message'] = this.message;
    if (this.data != null) {

    }
    return data;
  }
}
