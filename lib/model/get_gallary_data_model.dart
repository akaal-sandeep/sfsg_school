class GetGalleryDataModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  GetGalleryDataModel({this.statuscode, this.message, this.data});

  GetGalleryDataModel.fromJson(Map<String, dynamic> json) {
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
  String? galleryName;
  String? coverImageAbsolutePath;
  String? remarks;
  String? galleryDate;
  List<GalleryImages>? galleryImages;

  Data(
      {this.id,
        this.galleryName,
        this.coverImageAbsolutePath,
        this.remarks,
        this.galleryDate,
        this.galleryImages});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    galleryName = json['GalleryName'];
    coverImageAbsolutePath = json['CoverImageAbsolutePath'];
    remarks = json['Remarks'];
    galleryDate = json['GalleryDate'];
    if (json['GalleryImages'] != null) {
      galleryImages = <GalleryImages>[];
      json['GalleryImages'].forEach((v) {
        galleryImages!.add(new GalleryImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['GalleryName'] = this.galleryName;
    data['CoverImageAbsolutePath'] = this.coverImageAbsolutePath;
    data['Remarks'] = this.remarks;
    data['GalleryDate'] = this.galleryDate;
    if (this.galleryImages != null) {
      data['GalleryImages'] =
          this.galleryImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GalleryImages {
  String? imageAbsolutePath;

  GalleryImages({this.imageAbsolutePath});

  GalleryImages.fromJson(Map<String, dynamic> json) {
    imageAbsolutePath = json['ImageAbsolutePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ImageAbsolutePath'] = this.imageAbsolutePath;
    return data;
  }
}
