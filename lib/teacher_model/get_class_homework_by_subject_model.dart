class GetClassHomeWorkBySubjectDateModel {
  String? statuscode;
  String? message;
  Data? data;

  GetClassHomeWorkBySubjectDateModel(
      {this.statuscode, this.message, this.data});

  GetClassHomeWorkBySubjectDateModel.fromJson(Map<String, dynamic> json) {
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
  bool? isLocked;
  bool? isApproved;
  String? homeWork;
  String? work;
  int? rowVersion;
  List<DocumentsList>? documentsList;

  Data(
      {this.id,
        this.isLocked,
        this.isApproved,
        this.homeWork,
        this.work,
        this.rowVersion,
        this.documentsList});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    isLocked = json['IsLocked'];
    isApproved = json['IsApproved'];
    homeWork = json['HomeWork'];
    work = json['Work'];
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
    data['IsLocked'] = this.isLocked;
    data['IsApproved'] = this.isApproved;
    data['HomeWork'] = this.homeWork;
    data['RowVersion'] = this.rowVersion;
    data['Work'] = this.work;
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
