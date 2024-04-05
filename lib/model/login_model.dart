class LoginModel {
  String? statuscode;
  String? message;
  Data? data;

  LoginModel({this.statuscode, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statuscode'] = this.statuscode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  bool? isValidUser;
  bool? isOTPRequired;
  bool? isForceUpdate;
  String? appVersion;

  Data(
      {this.isValidUser,
        this.isOTPRequired,
        this.isForceUpdate,
        this.appVersion});

  Data.fromJson(Map<String, dynamic> json) {
    isValidUser = json['IsValidUser'];
    isOTPRequired = json['IsOTPRequired'];
    isForceUpdate = json['IsForceUpdate'];
    appVersion = json['AppVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsValidUser'] = this.isValidUser;
    data['IsOTPRequired'] = this.isOTPRequired;
    data['IsForceUpdate'] = this.isForceUpdate;
    data['AppVersion'] = this.appVersion;
    return data;
  }
}
