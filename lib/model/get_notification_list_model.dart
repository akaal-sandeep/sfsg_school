class GetNotificationListModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  GetNotificationListModel({this.statuscode, this.message, this.data});

  GetNotificationListModel.fromJson(Map<String, dynamic> json) {
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
  String? createDate;
  String? notificationSubject;
  String? notificationContents;
  Null notificationPriority;
  bool? status;
  bool? isForStudents;
  bool? isForParents;
  bool? isForTeachers;

  Data(
      {this.createDate,
        this.notificationSubject,
        this.notificationContents,
        this.notificationPriority,
        this.status,
        this.isForStudents,
        this.isForParents,
        this.isForTeachers});

  Data.fromJson(Map<String, dynamic> json) {
    createDate = json['CreateDate'];
    notificationSubject = json['NotificationSubject'];
    notificationContents = json['NotificationContents'];
    notificationPriority = json['NotificationPriority'];
    status = json['Status'];
    isForStudents = json['IsForStudents'];
    isForParents = json['IsForParents'];
    isForTeachers = json['IsForTeachers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CreateDate'] = this.createDate;
    data['NotificationSubject'] = this.notificationSubject;
    data['NotificationContents'] = this.notificationContents;
    data['NotificationPriority'] = this.notificationPriority;
    data['Status'] = this.status;
    data['IsForStudents'] = this.isForStudents;
    data['IsForParents'] = this.isForParents;
    data['IsForTeachers'] = this.isForTeachers;
    return data;
  }
}
