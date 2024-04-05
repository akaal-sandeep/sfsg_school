class GetSyllabusListByClassSectionSubjectModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  GetSyllabusListByClassSectionSubjectModel(
      {this.statuscode, this.message, this.data});

  GetSyllabusListByClassSectionSubjectModel.fromJson(
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
  String? className;
  String? sectionName;
  String? subjectName;
  String? absoluteImagePath;
  String? title;

  Data(
      {this.id,
        this.className,
        this.sectionName,
        this.subjectName,
        this.absoluteImagePath,
        this.title});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    className = json['ClassName'];
    sectionName = json['SectionName'];
    subjectName = json['SubjectName'];
    absoluteImagePath = json['AbsoluteImagePath'];
    title = json['Title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ClassName'] = this.className;
    data['SectionName'] = this.sectionName;
    data['SubjectName'] = this.subjectName;
    data['AbsoluteImagePath'] = this.absoluteImagePath;
    data['Title'] = this.title;
    return data;
  }
}
