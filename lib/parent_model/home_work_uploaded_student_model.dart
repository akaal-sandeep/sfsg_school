class UploadedHomeWorkStudentModel {
  String? statuscode;
  String? message;
  Data? data;

  UploadedHomeWorkStudentModel({this.statuscode, this.message, this.data});

  UploadedHomeWorkStudentModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? remarks;
  int? rowVersion;
  List<DocumentsList>? documentsList;

  Data({this.id, this.remarks, this.rowVersion, this.documentsList});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    remarks = json['Remarks'];
    rowVersion = json['RowVersion'];
    if (json['DocumentsList'] != null) {
      documentsList = <DocumentsList>[];
      json['DocumentsList'].forEach((v) {
        documentsList!.add(new DocumentsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Remarks'] = this.remarks;
    data['RowVersion'] = this.rowVersion;
    if (this.documentsList != null) {
      data['DocumentsList'] =
          this.documentsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DocumentsList {
  int? id;
  String? documentName;
  String? fileUrl;
  bool? isYoutubeLink;
  bool? isVideoFile;
  bool? isActive;
  bool? isApproved;

  DocumentsList(
      {this.id,
        this.documentName,
        this.fileUrl,
        this.isYoutubeLink,
        this.isVideoFile,
        this.isActive,
        this.isApproved});

  DocumentsList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    documentName = json['DocumentName'];
    fileUrl = json['FileUrl'];
    isYoutubeLink = json['IsYoutubeLink'];
    isVideoFile = json['IsVideoFile'];
    isActive = json['IsActive'];
    isApproved = json['IsApproved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['DocumentName'] = this.documentName;
    data['FileUrl'] = this.fileUrl;
    data['IsYoutubeLink'] = this.isYoutubeLink;
    data['IsVideoFile'] = this.isVideoFile;
    data['IsActive'] = this.isActive;
    data['IsApproved'] = this.isApproved;
    return data;
  }
}
