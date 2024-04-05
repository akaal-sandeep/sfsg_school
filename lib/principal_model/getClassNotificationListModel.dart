class GetClassSectionListForPushNotificationModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  GetClassSectionListForPushNotificationModel(
      {this.statuscode, this.message, this.data});

  GetClassSectionListForPushNotificationModel.fromJson(
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
  int? classMasterId;
  String? className;
  int? sectionMasterId;
  String? sectionName;
  String? classSectionName;
  int? sortId;
  bool? isSelected;

  Data(
      {this.classMasterId,
        this.className,
        this.sectionMasterId,
        this.sectionName,
        this.classSectionName,
        this.sortId,
        this.isSelected});

  Data.fromJson(Map<String, dynamic> json) {
    classMasterId = json['ClassMasterId'];
    className = json['ClassName'];
    sectionMasterId = json['SectionMasterId'];
    sectionName = json['SectionName'];
    classSectionName = json['ClassSectionName'];
    sortId = json['SortId'];
    isSelected = json['IsSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassMasterId'] = this.classMasterId;
    data['ClassName'] = this.className;
    data['SectionMasterId'] = this.sectionMasterId;
    data['SectionName'] = this.sectionName;
    data['ClassSectionName'] = this.classSectionName;
    data['SortId'] = this.sortId;
    data['IsSelected'] = this.isSelected;
    return data;
  }
}
