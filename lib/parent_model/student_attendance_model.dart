class StudentAttendanceModel {
  String? statuscode;
  String? message;
  Data? data;

  StudentAttendanceModel({this.statuscode, this.message, this.data});

  StudentAttendanceModel.fromJson(Map<String, dynamic> json) {
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
  int? workingDays;
  int? presentDays;
  int? leaveDays;
  int? halfDays;
  int? absentDays;
  int? holidayDays;
  int? markedHolidayDays;
  List<CalendarEntries>? calendarEntries;

  Data(
      {this.workingDays,
        this.presentDays,
        this.leaveDays,
        this.halfDays,
        this.absentDays,
        this.holidayDays,
        this.markedHolidayDays,
        this.calendarEntries});

  Data.fromJson(Map<String, dynamic> json) {
    workingDays = json['WorkingDays'];
    presentDays = json['PresentDays'];
    leaveDays = json['LeaveDays'];
    halfDays = json['HalfDays'];
    absentDays = json['AbsentDays'];
    holidayDays = json['HolidayDays'];
    markedHolidayDays = json['MarkedHolidayDays'];
    if (json['CalendarEntries'] != null) {
      calendarEntries = <CalendarEntries>[];
      json['CalendarEntries'].forEach((v) {
        calendarEntries!.add(new CalendarEntries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['WorkingDays'] = this.workingDays;
    data['PresentDays'] = this.presentDays;
    data['LeaveDays'] = this.leaveDays;
    data['HalfDays'] = this.halfDays;
    data['AbsentDays'] = this.absentDays;
    data['HolidayDays'] = this.holidayDays;
    data['MarkedHolidayDays'] = this.markedHolidayDays;
    if (this.calendarEntries != null) {
      data['CalendarEntries'] =
          this.calendarEntries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CalendarEntries {
  String? calendarDate;
  String? remarks;
  String? legendText;

  CalendarEntries({this.calendarDate, this.remarks, this.legendText});

  CalendarEntries.fromJson(Map<String, dynamic> json) {
    calendarDate = json['CalendarDate'];
    remarks = json['Remarks'];
    legendText = json['LegendText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CalendarDate'] = this.calendarDate;
    data['Remarks'] = this.remarks;
    data['LegendText'] = this.legendText;
    return data;
  }
}
