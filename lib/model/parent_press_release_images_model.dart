class ParentPressReleaseImagesModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  ParentPressReleaseImagesModel({this.statuscode, this.message, this.data});

  ParentPressReleaseImagesModel.fromJson(Map<String, dynamic> json) {
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
  String? imageAbsolutePath;

  Data({this.id, this.imageAbsolutePath});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    imageAbsolutePath = json['ImageAbsolutePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ImageAbsolutePath'] = this.imageAbsolutePath;
    return data;
  }
}
