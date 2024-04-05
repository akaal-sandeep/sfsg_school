class TestDetailsModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  TestDetailsModel({this.statuscode, this.message, this.data});

  TestDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? subjectName;
  String? testDate;
  String? testTopic;
  var maximumMarks;
  var highestMarks;
  String? highestMarksText;
  var highestMarksPercentage;
  String? highestMarksPercentageText;
  bool? isLocked;
  List<StudentDataTest>? studentData;

  Data(
      {this.subjectName,
        this.testDate,
        this.testTopic,
        this.maximumMarks,
        this.highestMarks,
        this.highestMarksText,
        this.highestMarksPercentage,
        this.highestMarksPercentageText,
        this.isLocked,
        this.studentData});

  Data.fromJson(Map<String, dynamic> json) {
    subjectName = json['SubjectName'];
    testDate = json['TestDate'];
    testTopic = json['TestTopic'];
    maximumMarks = json['MaximumMarks'];
    highestMarks = json['HighestMarks'];
    highestMarksText = json['HighestMarksText'];
    highestMarksPercentage = json['HighestMarksPercentage'];
    highestMarksPercentageText = json['HighestMarksPercentageText'];
    isLocked = json['IsLocked'];
    if (json['StudentData'] != null) {
      studentData = <StudentDataTest>[];
      json['StudentData'].forEach((v) {
        studentData!.add(new StudentDataTest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SubjectName'] = this.subjectName;
    data['TestDate'] = this.testDate;
    data['TestTopic'] = this.testTopic;
    data['MaximumMarks'] = this.maximumMarks;
    data['HighestMarks'] = this.highestMarks;
    data['HighestMarksText'] = this.highestMarksText;
    data['HighestMarksPercentage'] = this.highestMarksPercentage;
    data['HighestMarksPercentageText'] = this.highestMarksPercentageText;
    data['IsLocked'] = this.isLocked;
    if (this.studentData != null) {
      data['StudentData'] = this.studentData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentDataTest {
  String? attendanceStatus;
  var marksObtained;
  var marksPercentage;
  String? marksObtainedText;
  String? marksPercentageText;
  String? remarks;

  StudentDataTest(
      {this.attendanceStatus,
        this.marksObtained,
        this.marksPercentage,
        this.marksObtainedText,
        this.marksPercentageText,
        this.remarks});

  StudentDataTest.fromJson(Map<String, dynamic> json) {
    attendanceStatus = json['AttendanceStatus'];
    marksObtained = json['MarksObtained'];
    marksPercentage = json['MarksPercentage'];
    marksObtainedText = json['MarksObtainedText'];
    marksPercentageText = json['MarksPercentageText'];
    remarks = json['Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AttendanceStatus'] = this.attendanceStatus;
    data['MarksObtained'] = this.marksObtained;
    data['MarksPercentage'] = this.marksPercentage;
    data['MarksObtainedText'] = this.marksObtainedText;
    data['MarksPercentageText'] = this.marksPercentageText;
    data['Remarks'] = this.remarks;
    return data;
  }
}
