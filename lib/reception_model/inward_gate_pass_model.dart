class InwardGatePassModel {
  String? id;
  String? visitFor;
  String? admissionNumber;
  int? employeeMasterId;
  String? reasonForEntry;
  String? visitorName;
  String? visitorMobileNumber;
  int? visitorRelationId;
  String? otherRelationName;
  int? visitorIDProofId;
  String? visitorIDProofNumber;
  String? visitorCompany;
  int? rowVersion;
  String? visitorIDProofCapturedPhoto;
  String? visitorCapturedPhoto;

  InwardGatePassModel(
      {this.id,
        this.visitFor,
        this.admissionNumber,
        this.employeeMasterId,
        this.reasonForEntry,
        this.visitorName,
        this.visitorMobileNumber,
        this.visitorRelationId,
        this.otherRelationName,
        this.visitorIDProofId,
        this.visitorIDProofNumber,
        this.visitorCompany,
        this.rowVersion,
        this.visitorIDProofCapturedPhoto,
        this.visitorCapturedPhoto});

  InwardGatePassModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    visitFor = json['VisitFor'];
    admissionNumber = json['AdmissionNumber'];
    employeeMasterId = json['EmployeeMasterId'];
    reasonForEntry = json['ReasonForEntry'];
    visitorName = json['VisitorName'];
    visitorMobileNumber = json['VisitorMobileNumber'];
    visitorRelationId = json['VisitorRelationId'];
    otherRelationName = json['OtherRelationName'];
    visitorIDProofId = json['VisitorIDProofId'];
    visitorIDProofNumber = json['VisitorIDProofNumber'];
    visitorCompany = json['VisitorCompany'];
    rowVersion = json['RowVersion'];
    visitorIDProofCapturedPhoto = json['VisitorIDProofCapturedPhoto'];
    visitorCapturedPhoto = json['VisitorCapturedPhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['VisitFor'] = this.visitFor;
    data['AdmissionNumber'] = this.admissionNumber;
    data['EmployeeMasterId'] = this.employeeMasterId;
    data['ReasonForEntry'] = this.reasonForEntry;
    data['VisitorName'] = this.visitorName;
    data['VisitorMobileNumber'] = this.visitorMobileNumber;
    data['VisitorRelationId'] = this.visitorRelationId;
    data['OtherRelationName'] = this.otherRelationName;
    data['VisitorIDProofId'] = this.visitorIDProofId;
    data['VisitorIDProofNumber'] = this.visitorIDProofNumber;
    data['VisitorCompany'] = this.visitorCompany;
    data['RowVersion'] = this.rowVersion;
    data['VisitorIDProofCapturedPhoto'] = this.visitorIDProofCapturedPhoto;
    data['VisitorCapturedPhoto'] = this.visitorCapturedPhoto;
    return data;
  }
}
