class DateHomeWorkParentModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  DateHomeWorkParentModel({this.statuscode, this.message, this.data});

  DateHomeWorkParentModel.fromJson(Map<String, dynamic> json) {
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
  var id;
  var subjectMasterId;
  String? subjectName;
  String? homeWork;
  bool? isLocked;
  var documentCount;
  bool showModel=false;
  List<DocumentsList>? documentsList;

  Data(
      {this.id,
        this.subjectMasterId,
        this.subjectName,
        this.homeWork,
        this.isLocked,
        this.documentCount,
        this.documentsList});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    subjectMasterId = json['SubjectMasterId'];
    subjectName = json['SubjectName'];
    homeWork = json['HomeWork'];
    isLocked = json['IsLocked'];
    documentCount = json['DocumentCount'];
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
    data['SubjectMasterId'] = this.subjectMasterId;
    data['SubjectName'] = this.subjectName;
    data['HomeWork'] = this.homeWork;
    data['IsLocked'] = this.isLocked;
    data['DocumentCount'] = this.documentCount;
    if (this.documentsList != null) {
      data['DocumentsList'] =
          this.documentsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DocumentsList {
  String? documentName;
  String? fileUrl;
  bool? isYoutubeLink;
  bool? isVideoFile;

  DocumentsList(
      {this.documentName, this.fileUrl, this.isYoutubeLink, this.isVideoFile});

  DocumentsList.fromJson(Map<String, dynamic> json) {
    documentName = json['DocumentName'];
    fileUrl = json['FileUrl'];
    isYoutubeLink = json['IsYoutubeLink'];
    isVideoFile = json['IsVideoFile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocumentName'] = this.documentName;
    data['FileUrl'] = this.fileUrl;
    data['IsYoutubeLink'] = this.isYoutubeLink;
    data['IsVideoFile'] = this.isVideoFile;
    return data;
  }
}
