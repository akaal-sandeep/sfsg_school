class GetUploadClassHomeWorkListForStudentModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  GetUploadClassHomeWorkListForStudentModel(
      {this.statuscode, this.message, this.data});

  GetUploadClassHomeWorkListForStudentModel.fromJson(
      Map<String, dynamic> json) {
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
  String? remarks;
  String? homeWorkDate;
  String? homeWorkUploadDate;
  int? rowVersion;
  List<DocumentsList>? documentsList;

  Data(
      {this.id,
        this.remarks,
        this.homeWorkDate,
        this.homeWorkUploadDate,
        this.rowVersion,
        this.documentsList});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    remarks = json['Remarks'];
    homeWorkDate = json['HomeWorkDate'];
    homeWorkUploadDate = json['HomeWorkUploadDate'];
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
    data['HomeWorkDate'] = this.homeWorkDate;
    data['HomeWorkUploadDate'] = this.homeWorkUploadDate;
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
