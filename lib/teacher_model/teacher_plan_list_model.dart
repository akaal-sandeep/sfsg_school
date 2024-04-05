class LessonPlanListByTeacher {
  String? statuscode;
  String? message;
  List<Data>? data;

  LessonPlanListByTeacher({this.statuscode, this.message, this.data});

  LessonPlanListByTeacher.fromJson(Map<String, dynamic> json) {
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
  String? fromDate;
  String? toDate;
  int? classMasterId;
  String? className;
  int? sectionMasterId;
  String? sectionName;
  int? subjectMasterId;
  String? subjectName;
  String? lessonPlan;
  String? objectives;
  String? warmUpActivities;
  String? teachingProcedure;
  String? followUpActivities;
  String? evaluation;
  int? employeeMasterId;
  String? employeeName;
  bool? isApproved;
  bool? isLocked;
  String? absoluteDocumentPath;

  Data(
      {this.fromDate,
        this.toDate,
        this.classMasterId,
        this.className,
        this.sectionMasterId,
        this.sectionName,
        this.subjectMasterId,
        this.subjectName,
        this.lessonPlan,
        this.objectives,
        this.warmUpActivities,
        this.teachingProcedure,
        this.followUpActivities,
        this.evaluation,
        this.employeeMasterId,
        this.employeeName,
        this.isApproved,
        this.isLocked,
        this.absoluteDocumentPath});

  Data.fromJson(Map<String, dynamic> json) {
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    classMasterId = json['ClassMasterId'];
    className = json['ClassName'];
    sectionMasterId = json['SectionMasterId'];
    sectionName = json['SectionName'];
    subjectMasterId = json['SubjectMasterId'];
    subjectName = json['SubjectName'];
    lessonPlan = json['LessonPlan'];
    objectives = json['Objectives'];
    warmUpActivities = json['WarmUpActivities'];
    teachingProcedure = json['TeachingProcedure'];
    followUpActivities = json['FollowUpActivities'];
    evaluation = json['Evaluation'];
    employeeMasterId = json['EmployeeMasterId'];
    employeeName = json['EmployeeName'];
    isApproved = json['IsApproved'];
    isLocked = json['IsLocked'];
    absoluteDocumentPath = json['AbsoluteDocumentPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['ClassMasterId'] = this.classMasterId;
    data['ClassName'] = this.className;
    data['SectionMasterId'] = this.sectionMasterId;
    data['SectionName'] = this.sectionName;
    data['SubjectMasterId'] = this.subjectMasterId;
    data['SubjectName'] = this.subjectName;
    data['LessonPlan'] = this.lessonPlan;
    data['Objectives'] = this.objectives;
    data['WarmUpActivities'] = this.warmUpActivities;
    data['TeachingProcedure'] = this.teachingProcedure;
    data['FollowUpActivities'] = this.followUpActivities;
    data['Evaluation'] = this.evaluation;
    data['EmployeeMasterId'] = this.employeeMasterId;
    data['EmployeeName'] = this.employeeName;
    data['IsApproved'] = this.isApproved;
    data['IsLocked'] = this.isLocked;
    data['AbsoluteDocumentPath'] = this.absoluteDocumentPath;
    return data;
  }
}
