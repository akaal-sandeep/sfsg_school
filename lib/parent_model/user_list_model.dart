class DeviceListModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  DeviceListModel({this.statuscode, this.message, this.data});

  DeviceListModel.fromJson(Map<String, dynamic> json) {
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
  String? deviceIMEI;
  String? instituteCode;
  String? registrationNumber;
  String? routeNo;
  String? driverName;
  String? simNo;
  String? reading;
  int? isActive;
  int? speed;
  bool? ignition;
  int? gSMSignal;

  Data(
      {this.id,
        this.deviceIMEI,
        this.instituteCode,
        this.registrationNumber,
        this.routeNo,
        this.driverName,
        this.simNo,
        this.reading,
        this.isActive,
        this.speed,
        this.ignition,
        this.gSMSignal});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    deviceIMEI = json['DeviceIMEI'];
    instituteCode = json['InstituteCode'];
    registrationNumber = json['RegistrationNumber'];
    routeNo = json['RouteNo'];
    driverName = json['DriverName'];
    simNo = json['SimNo'];
    reading = json['Reading'];
    isActive = json['IsActive'];
    speed = json['Speed'];
    ignition = json['Ignition'];
    gSMSignal = json['GSMSignal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['DeviceIMEI'] = this.deviceIMEI;
    data['InstituteCode'] = this.instituteCode;
    data['RegistrationNumber'] = this.registrationNumber;
    data['RouteNo'] = this.routeNo;
    data['DriverName'] = this.driverName;
    data['SimNo'] = this.simNo;
    data['Reading'] = this.reading;
    data['IsActive'] = this.isActive;
    data['Speed'] = this.speed;
    data['Ignition'] = this.ignition;
    data['GSMSignal'] = this.gSMSignal;
    return data;
  }
}
