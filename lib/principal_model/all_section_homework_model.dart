class AllSectionHomeWorkModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  AllSectionHomeWorkModel({this.statuscode, this.message, this.data});

  AllSectionHomeWorkModel.fromJson(Map<String, dynamic> json) {
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
  String? homeWorkDate;
  String? subjectName;
  int? documentCount;
  String? className;
  String? sectionName;
  String? createdByUserName;
  String? createDate;
  String? homeWork;
  List<DocumentsList>? documentsList;
  bool? showDocument;

  Data(
      {this.id,
        this.homeWorkDate,
        this.subjectName,
        this.documentCount,
        this.className,
        this.sectionName,
        this.createdByUserName,
        this.createDate,
        this.showDocument,
        this.homeWork,
        this.documentsList});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    homeWorkDate = json['HomeWorkDate'];
    subjectName = json['SubjectName'];
    documentCount = json['DocumentCount'];
    className = json['ClassName'];
    sectionName = json['SectionName'];
    createdByUserName = json['CreatedByUserName'];
    createDate = json['CreateDate'];
    homeWork = json['HomeWork'];
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
    data['HomeWorkDate'] = this.homeWorkDate;
    data['SubjectName'] = this.subjectName;
    data['DocumentCount'] = this.documentCount;
    data['ClassName'] = this.className;
    data['SectionName'] = this.sectionName;
    data['CreatedByUserName'] = this.createdByUserName;
    data['CreateDate'] = this.createDate;
    data['HomeWork'] = this.homeWork;
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
