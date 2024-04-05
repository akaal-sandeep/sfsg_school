class StudentAttendanceDetailsModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  StudentAttendanceDetailsModel({this.statuscode, this.message, this.data});

  StudentAttendanceDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? cLASSNAME;
 var cLASSMASTERID;
 var cLASSSECTIONMASTERID;
 var cLASSSORTID;
 var cLASSSECTIONSORTID;
 var tOTALSTUDENTS;
 var pRESENTCOUNT;
 var aBSENTCOUNT;
 var pENDINGATTENDANCE;


  Data(
      {this.cLASSNAME,
        this.cLASSMASTERID,
        this.cLASSSECTIONMASTERID,
        this.cLASSSORTID,
        this.cLASSSECTIONSORTID,
        this.tOTALSTUDENTS,
        this.pRESENTCOUNT,
        this.aBSENTCOUNT,
        this.pENDINGATTENDANCE,


      });

  Data.fromJson(Map<String, dynamic> json) {
    cLASSNAME = json['CLASS_NAME'];
    cLASSMASTERID = json['CLASS_MASTER_ID'];
    cLASSSECTIONMASTERID = json['CLASS_SECTION_MASTER_ID'];
    cLASSSORTID = json['CLASS_SORTID'];
    cLASSSECTIONSORTID = json['CLASS_SECTION_SORTID'];
    tOTALSTUDENTS = json['TOTAL_STUDENTS'];
    pRESENTCOUNT = json['PRESENT_COUNT'];
    aBSENTCOUNT = json['ABSENT_COUNT'];
    pENDINGATTENDANCE = json['PENDING_ATTENDANCE'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CLASS_NAME'] = this.cLASSNAME;
    data['CLASS_MASTER_ID'] = this.cLASSMASTERID;
    data['CLASS_SECTION_MASTER_ID'] = this.cLASSSECTIONMASTERID;
    data['CLASS_SORTID'] = this.cLASSSORTID;
    data['CLASS_SECTION_SORTID'] = this.cLASSSECTIONSORTID;
    data['TOTAL_STUDENTS'] = this.tOTALSTUDENTS;
    data['PRESENT_COUNT'] = this.pRESENTCOUNT;
    data['ABSENT_COUNT'] = this.aBSENTCOUNT;
    data['PENDING_ATTENDANCE'] = this.pENDINGATTENDANCE;

    return data;
  }
}
