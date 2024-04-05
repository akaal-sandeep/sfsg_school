class StudentTeacherAttendanceModel {
  String? statuscode;
  String? message;
  Data? data;

  StudentTeacherAttendanceModel({this.statuscode, this.message, this.data});

  StudentTeacherAttendanceModel.fromJson(Map<String, dynamic> json) {
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
  List<Table>? table;
  List<Table1>? table1;
  List<Table2>? table2;

  Data({this.table, this.table1, this.table2});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Table'] != null) {
      table = <Table>[];
      json['Table'].forEach((v) {
        table!.add(new Table.fromJson(v));
      });
    }
    if (json['Table1'] != null) {
      table1 = <Table1>[];
      json['Table1'].forEach((v) {
        table1!.add(new Table1.fromJson(v));
      });
    }
    if (json['Table2'] != null) {
      table2 = <Table2>[];
      json['Table2'].forEach((v) {
        table2!.add(new Table2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.table != null) {
      data['Table'] = this.table!.map((v) => v.toJson()).toList();
    }
    if (this.table1 != null) {
      data['Table1'] = this.table1!.map((v) => v.toJson()).toList();
    }
    if (this.table2 != null) {
      data['Table2'] = this.table2!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Table {
  var tOTALSTUDENTS;
  var pRESENTCOUNT;
  var aBSENTCOUNT;
  var lEaveCount;
  var pENDINGATTENDANCE;

  Table(
      {this.tOTALSTUDENTS,
        this.pRESENTCOUNT,
        this.aBSENTCOUNT,
        this.lEaveCount,
        this.pENDINGATTENDANCE});

  Table.fromJson(Map<String, dynamic> json) {
    tOTALSTUDENTS = json['TOTAL_STUDENTS'];
    pRESENTCOUNT = json['PRESENT_COUNT'];
    aBSENTCOUNT = json['ABSENT_COUNT'];
    lEaveCount = json['LEAVE_COUNT'];
    pENDINGATTENDANCE = json['PENDING_ATTENDANCE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TOTAL_STUDENTS'] = this.tOTALSTUDENTS;
    data['PRESENT_COUNT'] = this.pRESENTCOUNT;
    data['ABSENT_COUNT'] = this.aBSENTCOUNT;
    data['LEAVE_COUNT'] = this.lEaveCount;
    data['PENDING_ATTENDANCE'] = this.pENDINGATTENDANCE;
    return data;
  }
}

class Table1 {
  var tOTALEMPLOYEES;
  var pRESENTCOUNT;
  var aBSENTCOUNT;
  var lEaveCount;
  var pENDINGATTENDANCE;

  Table1(
      {this.tOTALEMPLOYEES,
        this.pRESENTCOUNT,
        this.aBSENTCOUNT,
        this.lEaveCount,
        this.pENDINGATTENDANCE});

  Table1.fromJson(Map<String, dynamic> json) {
    tOTALEMPLOYEES = json['TOTAL_EMPLOYEES'];
    pRESENTCOUNT = json['PRESENT_COUNT'];
    aBSENTCOUNT = json['ABSENT_COUNT'];
    lEaveCount = json['LEAVE_COUNT'];
    pENDINGATTENDANCE = json['PENDING_ATTENDANCE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TOTAL_EMPLOYEES'] = this.tOTALEMPLOYEES;
    data['PRESENT_COUNT'] = this.pRESENTCOUNT;
    data['ABSENT_COUNT'] = this.aBSENTCOUNT;
    data['LEAVE_COUNT'] = this.lEaveCount;
    data['PENDING_ATTENDANCE'] = this.pENDINGATTENDANCE;
    return data;
  }
}

class Table2 {
  var tOTALEMPLOYEES;
  var pRESENTCOUNT;
  var aBSENTCOUNT;
  var lEaveCount;
  var pENDINGATTENDANCE;

  Table2(
      {this.tOTALEMPLOYEES,
        this.pRESENTCOUNT,
        this.aBSENTCOUNT,
        this.lEaveCount,
        this.pENDINGATTENDANCE});

  Table2.fromJson(Map<String, dynamic> json) {
    tOTALEMPLOYEES = json['TOTAL_EMPLOYEES'];
    pRESENTCOUNT = json['PRESENT_COUNT'];
    aBSENTCOUNT = json['ABSENT_COUNT'];
    lEaveCount = json['LEAVE_COUNT'];
    pENDINGATTENDANCE = json['PENDING_ATTENDANCE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TOTAL_EMPLOYEES'] = this.tOTALEMPLOYEES;
    data['PRESENT_COUNT'] = this.pRESENTCOUNT;
    data['ABSENT_COUNT'] = this.aBSENTCOUNT;
    data['LEAVE_COUNT'] = this.lEaveCount;
    data['PENDING_ATTENDANCE'] = this.pENDINGATTENDANCE;
    return data;
  }
}
