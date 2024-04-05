class StudentBagComponentModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  StudentBagComponentModel({this.statuscode, this.message, this.data});

  StudentBagComponentModel.fromJson(Map<String, dynamic> json) {
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
  int? rowVersion;
  String? planDate;
  int? classMasterId;
  String? className;
  int? sectionMasterId;
  String? sectionName;
  int? subjectMasterId;
  String? subjectName;
  String? otherComponentName;
  int? employeeMasterId;
  Null employeeName;
  String? remarks;
  Null principalRemarks;
  bool? isApproved;
  bool? isRejected;
  bool? isLocked;
  List<BagComponents>? bagComponents;

  Data(
      {this.id,
        this.rowVersion,
        this.planDate,
        this.classMasterId,
        this.className,
        this.sectionMasterId,
        this.sectionName,
        this.subjectMasterId,
        this.subjectName,
        this.otherComponentName,
        this.employeeMasterId,
        this.employeeName,
        this.remarks,
        this.principalRemarks,
        this.isApproved,
        this.isRejected,
        this.isLocked,
        this.bagComponents});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    rowVersion = json['RowVersion'];
    planDate = json['PlanDate'];
    classMasterId = json['ClassMasterId'];
    className = json['ClassName'];
    sectionMasterId = json['SectionMasterId'];
    sectionName = json['SectionName'];
    subjectMasterId = json['SubjectMasterId'];
    subjectName = json['SubjectName'];
    otherComponentName = json['OtherComponentName'];
    employeeMasterId = json['EmployeeMasterId'];
    employeeName = json['EmployeeName'];
    remarks = json['Remarks'];
    principalRemarks = json['PrincipalRemarks'];
    isApproved = json['IsApproved'];
    isRejected = json['IsRejected'];
    isLocked = json['IsLocked'];
    if (json['BagComponents'] != null) {
      bagComponents = <BagComponents>[];
      json['BagComponents'].forEach((v) {
        bagComponents!.add(new BagComponents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['RowVersion'] = this.rowVersion;
    data['PlanDate'] = this.planDate;
    data['ClassMasterId'] = this.classMasterId;
    data['ClassName'] = this.className;
    data['SectionMasterId'] = this.sectionMasterId;
    data['SectionName'] = this.sectionName;
    data['SubjectMasterId'] = this.subjectMasterId;
    data['SubjectName'] = this.subjectName;
    data['OtherComponentName'] = this.otherComponentName;
    data['EmployeeMasterId'] = this.employeeMasterId;
    data['EmployeeName'] = this.employeeName;
    data['Remarks'] = this.remarks;
    data['PrincipalRemarks'] = this.principalRemarks;
    data['IsApproved'] = this.isApproved;
    data['IsRejected'] = this.isRejected;
    data['IsLocked'] = this.isLocked;
    if (this.bagComponents != null) {
      data['BagComponents'] =
          this.bagComponents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BagComponents {
  int? id;
  String? name;
  int? sortId;

  BagComponents({this.id, this.name, this.sortId});

  BagComponents.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    sortId = json['SortId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['SortId'] = this.sortId;
    return data;
  }
}
