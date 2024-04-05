class GetEmployeeLeaveApplyListModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  GetEmployeeLeaveApplyListModel({this.statuscode, this.message, this.data});

  GetEmployeeLeaveApplyListModel.fromJson(Map<String, dynamic> json) {
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
  int? employeeMasterId;
  String? employeeName;
  int? employeeLeaveReasonMasterId;
  String? employeeLeaveReasonName;
  String? remarks;
  int? leaveDays;
  String? fromDate;
  String? toDate;
  int? rowVersion;
  bool? isApproved;
  bool? isRejected;
  String? approveRemarks;
  String? rejectRemarks;

  Data(
      {this.id,
        this.employeeMasterId,
        this.employeeName,
        this.employeeLeaveReasonMasterId,
        this.employeeLeaveReasonName,
        this.remarks,
        this.leaveDays,
        this.fromDate,
        this.toDate,
        this.rowVersion,
        this.isApproved,
        this.isRejected,
        this.approveRemarks,
        this.rejectRemarks});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    employeeMasterId = json['EmployeeMasterId'];
    employeeName = json['EmployeeName'];
    employeeLeaveReasonMasterId = json['EmployeeLeaveReasonMasterId'];
    employeeLeaveReasonName = json['EmployeeLeaveReasonName'];
    remarks = json['Remarks'];
    leaveDays = json['LeaveDays'];
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    rowVersion = json['RowVersion'];
    isApproved = json['IsApproved'];
    isRejected = json['IsRejected'];
    approveRemarks = json['ApproveRemarks'];
    rejectRemarks = json['RejectRemarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['EmployeeMasterId'] = this.employeeMasterId;
    data['EmployeeName'] = this.employeeName;
    data['EmployeeLeaveReasonMasterId'] = this.employeeLeaveReasonMasterId;
    data['EmployeeLeaveReasonName'] = this.employeeLeaveReasonName;
    data['Remarks'] = this.remarks;
    data['LeaveDays'] = this.leaveDays;
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['RowVersion'] = this.rowVersion;
    data['IsApproved'] = this.isApproved;
    data['IsRejected'] = this.isRejected;
    data['ApproveRemarks'] = this.approveRemarks;
    data['RejectRemarks'] = this.rejectRemarks;
    return data;
  }
}
