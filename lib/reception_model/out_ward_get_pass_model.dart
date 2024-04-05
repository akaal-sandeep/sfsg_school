class OutWardGetPassModel {
  String? id;
  bool? isForStudent;
  bool? isForStaff;
  int? employeeMasterId;
  String? reasonForExit;
  String? visitorName;
  String? visitorMobileNumber;
  int? visitorIDProofId;
  String? visitorIDProofNumber;
  int? rowVersion;
  String? visitorIDProofCapturedPhoto;
  String? visitorCapturedPhoto;
  String? employeePhotoCapturedPhoto;
  List<LstStudent>? lstStudent;

  OutWardGetPassModel(
      {this.id,
        this.isForStudent,
        this.isForStaff,
        this.employeeMasterId,
        this.reasonForExit,
        this.visitorName,
        this.visitorMobileNumber,
        this.visitorIDProofId,
        this.visitorIDProofNumber,
        this.rowVersion,
        this.visitorIDProofCapturedPhoto,
        this.visitorCapturedPhoto,
        this.employeePhotoCapturedPhoto,
        this.lstStudent});

  OutWardGetPassModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    isForStudent = json['IsForStudent'];
    isForStaff = json['IsForStaff'];
    employeeMasterId = json['EmployeeMasterId'];
    reasonForExit = json['ReasonForExit'];
    visitorName = json['VisitorName'];
    visitorMobileNumber = json['VisitorMobileNumber'];
    visitorIDProofId = json['VisitorIDProofId'];
    visitorIDProofNumber = json['VisitorIDProofNumber'];
    rowVersion = json['RowVersion'];
    visitorIDProofCapturedPhoto = json['VisitorIDProofCapturedPhoto'];
    visitorCapturedPhoto = json['VisitorCapturedPhoto'];
    employeePhotoCapturedPhoto = json['EmployeePhotoCapturedPhoto'];
    if (json['LstStudent'] != null) {
      lstStudent = <LstStudent>[];
      json['LstStudent'].forEach((v) {
        lstStudent!.add(new LstStudent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id.toString();
    data['IsForStudent'] = this.isForStudent;
    data['IsForStaff'] = this.isForStaff;
    data['EmployeeMasterId'] = this.employeeMasterId;
    data['ReasonForExit'] = this.reasonForExit.toString();
    data['VisitorName'] = this.visitorName.toString();
    data['VisitorMobileNumber'] = this.visitorMobileNumber.toString();
    data['VisitorIDProofId'] = this.visitorIDProofId;
    data['VisitorIDProofNumber'] = this.visitorIDProofNumber.toString();
    data['RowVersion'] = this.rowVersion;
    data['VisitorIDProofCapturedPhoto'] = this.visitorIDProofCapturedPhoto.toString();
    data['VisitorCapturedPhoto'] = this.visitorCapturedPhoto.toString();
    data['EmployeePhotoCapturedPhoto'] = this.employeePhotoCapturedPhoto.toString();
    if (this.lstStudent != null) {
      data['LstStudent'] = this.lstStudent!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LstStudent {
  String? admissionNumber;
  String? visitorRelationId;
  String? otherRelationName;

  LstStudent(
      {this.admissionNumber, this.visitorRelationId, this.otherRelationName});

  LstStudent.fromJson(Map<String, dynamic> json) {
    admissionNumber = json['AdmissionNumber'];
    visitorRelationId = json['VisitorRelationId'];
    otherRelationName = json['OtherRelationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AdmissionNumber'] = this.admissionNumber;
    data['VisitorRelationId'] = this.visitorRelationId;
    data['OtherRelationName'] = this.otherRelationName;
    return data;
  }
}
