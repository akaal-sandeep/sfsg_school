class CoordinatesModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  CoordinatesModel({this.statuscode, this.message, this.data});

  CoordinatesModel.fromJson(Map<String, dynamic> json) {
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
  String? timestamp;
  String? longitude;
  String? latitude;
  Null packet;
  String? deviceIMEI;
  Null description;
  int? speed;
  int? topSpeed;
  String? deviceId;
  String? createDate;
  int? altitude;
  int? direction;
  int? satellites;
  bool? isOverSpeed;
  bool? ignition;
  bool? movement;
  int? gSMSignal;
  int? sleepMode;
  int? gNSSStatus;
  int? externalVoltage;
  int? batteryVoltage;
  int? batteryCurrent;
  int? activeGSMOperator;
  int? totalOdometer;
  bool? isOffline;
  int? limit;
  Null fromDate;
  Null toDate;
  String? registrationNumber;
  String? routeNo;
  String? simNo;
  String? driverName;
  String? reading;
  int? vehicleTypeMasterId;
  Null vehicleTypeName;
  int? speedLimit;
  String? recordDate;
  String? fromTime;
  String? toTime;
  int? duration;
  Null fromLongitude;
  Null fromLatitude;
  Null toLongitude;
  Null toLatitude;

  Data(
      {this.timestamp,
        this.longitude,
        this.latitude,
        this.packet,
        this.deviceIMEI,
        this.description,
        this.speed,
        this.topSpeed,
        this.deviceId,
        this.createDate,
        this.altitude,
        this.direction,
        this.satellites,
        this.isOverSpeed,
        this.ignition,
        this.movement,
        this.gSMSignal,
        this.sleepMode,
        this.gNSSStatus,
        this.externalVoltage,
        this.batteryVoltage,
        this.batteryCurrent,
        this.activeGSMOperator,
        this.totalOdometer,
        this.isOffline,
        this.limit,
        this.fromDate,
        this.toDate,
        this.registrationNumber,
        this.routeNo,
        this.simNo,
        this.driverName,
        this.reading,
        this.vehicleTypeMasterId,
        this.vehicleTypeName,
        this.speedLimit,
        this.recordDate,
        this.fromTime,
        this.toTime,
        this.duration,
        this.fromLongitude,
        this.fromLatitude,
        this.toLongitude,
        this.toLatitude});

  Data.fromJson(Map<String, dynamic> json) {
    timestamp = json['Timestamp'];
    longitude = json['Longitude'];
    latitude = json['Latitude'];
    packet = json['Packet'];
    deviceIMEI = json['DeviceIMEI'];
    description = json['Description'];
    speed = json['Speed'];
    topSpeed = json['TopSpeed'];
    deviceId = json['DeviceId'];
    createDate = json['CreateDate'];
    altitude = json['Altitude'];
    direction = json['Direction'];
    satellites = json['Satellites'];
    isOverSpeed = json['IsOverSpeed'];
    ignition = json['Ignition'];
    movement = json['Movement'];
    gSMSignal = json['GSMSignal'];
    sleepMode = json['SleepMode'];
    gNSSStatus = json['GNSSStatus'];
    externalVoltage = json['ExternalVoltage'];
    batteryVoltage = json['BatteryVoltage'];
    batteryCurrent = json['BatteryCurrent'];
    activeGSMOperator = json['ActiveGSMOperator'];
    totalOdometer = json['TotalOdometer'];
    isOffline = json['IsOffline'];
    limit = json['Limit'];
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    registrationNumber = json['RegistrationNumber'];
    routeNo = json['RouteNo'];
    simNo = json['SimNo'];
    driverName = json['DriverName'];
    reading = json['Reading'];
    vehicleTypeMasterId = json['VehicleTypeMasterId'];
    vehicleTypeName = json['VehicleTypeName'];
    speedLimit = json['SpeedLimit'];
    recordDate = json['RecordDate'];
    fromTime = json['FromTime'];
    toTime = json['ToTime'];
    duration = json['Duration'];
    fromLongitude = json['FromLongitude'];
    fromLatitude = json['FromLatitude'];
    toLongitude = json['ToLongitude'];
    toLatitude = json['ToLatitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Timestamp'] = this.timestamp;
    data['Longitude'] = this.longitude;
    data['Latitude'] = this.latitude;
    data['Packet'] = this.packet;
    data['DeviceIMEI'] = this.deviceIMEI;
    data['Description'] = this.description;
    data['Speed'] = this.speed;
    data['TopSpeed'] = this.topSpeed;
    data['DeviceId'] = this.deviceId;
    data['CreateDate'] = this.createDate;
    data['Altitude'] = this.altitude;
    data['Direction'] = this.direction;
    data['Satellites'] = this.satellites;
    data['IsOverSpeed'] = this.isOverSpeed;
    data['Ignition'] = this.ignition;
    data['Movement'] = this.movement;
    data['GSMSignal'] = this.gSMSignal;
    data['SleepMode'] = this.sleepMode;
    data['GNSSStatus'] = this.gNSSStatus;
    data['ExternalVoltage'] = this.externalVoltage;
    data['BatteryVoltage'] = this.batteryVoltage;
    data['BatteryCurrent'] = this.batteryCurrent;
    data['ActiveGSMOperator'] = this.activeGSMOperator;
    data['TotalOdometer'] = this.totalOdometer;
    data['IsOffline'] = this.isOffline;
    data['Limit'] = this.limit;
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['RegistrationNumber'] = this.registrationNumber;
    data['RouteNo'] = this.routeNo;
    data['SimNo'] = this.simNo;
    data['DriverName'] = this.driverName;
    data['Reading'] = this.reading;
    data['VehicleTypeMasterId'] = this.vehicleTypeMasterId;
    data['VehicleTypeName'] = this.vehicleTypeName;
    data['SpeedLimit'] = this.speedLimit;
    data['RecordDate'] = this.recordDate;
    data['FromTime'] = this.fromTime;
    data['ToTime'] = this.toTime;
    data['Duration'] = this.duration;
    data['FromLongitude'] = this.fromLongitude;
    data['FromLatitude'] = this.fromLatitude;
    data['ToLongitude'] = this.toLongitude;
    data['ToLatitude'] = this.toLatitude;
    return data;
  }
}
