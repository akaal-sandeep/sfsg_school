import 'package:flutter/material.dart';

class RemarkStudentListModel {
  String? statuscode;
  String? message;
  Data? data;

  RemarkStudentListModel({this.statuscode, this.message, this.data});

  RemarkStudentListModel.fromJson(Map<String, dynamic> json) {
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
  bool? isLocked;
  String? responseText;
  DataStudent? data;
  String? marksEntryType;
  var maximumMarks;
  var examDate;

  Data(
      {this.isLocked,
        this.responseText,
        this.data,
        this.marksEntryType,
        this.maximumMarks,
        this.examDate});

  Data.fromJson(Map<String, dynamic> json) {
    isLocked = json['IsLocked'];
    responseText = json['ResponseText'];
    data = json['data'] != null ? new DataStudent.fromJson(json['data']) : null;
    marksEntryType = json['MarksEntryType'];
    maximumMarks = json['MaximumMarks'];
    examDate = json['ExamDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsLocked'] = this.isLocked;
    data['ResponseText'] = this.responseText;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['MarksEntryType'] = this.marksEntryType;
    data['MaximumMarks'] = this.maximumMarks;
    data['ExamDate'] = this.examDate;
    return data;
  }
}

class DataStudent {
  var employeeMasterId;
  var employeeName;
  var id;
  String? examDate;
  var classMasterId;
  String? className;
  var classSectionMasterId;
  String? classSectionName;
  var termMasterId;
  String? termName;
  var examMasterId;
  String? examName;
  var subjectMasterId;
  String? subjectName;
  String? subjectType;
  var maximumMarks;
  bool? isLocked;
  List<LstStudent>? lstStudent;
  var encryptedId;
  var serialNumber;
  var rowVersion;
  bool? isActive;
  String? remarks;
  var checkSumValue;
  String? gUID;
  String? databaseTableName;
  String? token;
  String? cRCValue;
  String? superAdminName;
  var createdByUserId;
  String? createdByUserName;
  String? createDate;
  var modifiedByUserId;
  String? modifiedByUserName;
  String? modifyDate;
  var recordCount;
  var errorMessage;
  var timeStamp;
  var timeStampValue;
  var timeStampString;
  var qRFileName;

  DataStudent(
      {this.employeeMasterId,
        this.employeeName,
        this.id,
        this.examDate,
        this.classMasterId,
        this.className,
        this.classSectionMasterId,
        this.classSectionName,
        this.termMasterId,
        this.termName,
        this.examMasterId,
        this.examName,
        this.subjectMasterId,
        this.subjectName,
        this.subjectType,
        this.maximumMarks,
        this.isLocked,
        this.lstStudent,
        this.encryptedId,
        this.serialNumber,
        this.rowVersion,
        this.isActive,
        this.remarks,
        this.checkSumValue,
        this.gUID,
        this.databaseTableName,
        this.token,
        this.cRCValue,
        this.superAdminName,
        this.createdByUserId,
        this.createdByUserName,
        this.createDate,
        this.modifiedByUserId,
        this.modifiedByUserName,
        this.modifyDate,
        this.recordCount,
        this.errorMessage,
        this.timeStamp,
        this.timeStampValue,
        this.timeStampString,
        this.qRFileName});

  DataStudent.fromJson(Map<String, dynamic> json) {
    employeeMasterId = json['EmployeeMasterId'];
    employeeName = json['EmployeeName'];
    id = json['Id'];
    examDate = json['ExamDate'];
    classMasterId = json['ClassMasterId'];
    className = json['ClassName'];
    classSectionMasterId = json['ClassSectionMasterId'];
    classSectionName = json['ClassSectionName'];
    termMasterId = json['TermMasterId'];
    termName = json['TermName'];
    examMasterId = json['ExamMasterId'];
    examName = json['ExamName'];
    subjectMasterId = json['SubjectMasterId'];
    subjectName = json['SubjectName'];
    subjectType = json['SubjectType'];
    maximumMarks = json['MaximumMarks'];
    isLocked = json['IsLocked'];
    if (json['LstStudent'] != null) {
      lstStudent = <LstStudent>[];
      json['LstStudent'].forEach((v) {
        lstStudent!.add(new LstStudent.fromJson(v));
      });
    }
    encryptedId = json['EncryptedId'];
    serialNumber = json['SerialNumber'];
    rowVersion = json['RowVersion'];
    isActive = json['IsActive'];
    remarks = json['Remarks'];
    checkSumValue = json['CheckSumValue'];
    gUID = json['GUID'];
    databaseTableName = json['DatabaseTableName'];
    token = json['Token'];
    cRCValue = json['CRCValue'];
    superAdminName = json['SuperAdminName'];
    createdByUserId = json['CreatedByUserId'];
    createdByUserName = json['CreatedByUserName'];
    createDate = json['CreateDate'];
    modifiedByUserId = json['ModifiedByUserId'];
    modifiedByUserName = json['ModifiedByUserName'];
    modifyDate = json['ModifyDate'];
    recordCount = json['RecordCount'];
    errorMessage = json['ErrorMessage'];
    timeStamp = json['TimeStamp'];
    timeStampValue = json['TimeStampValue'];
    timeStampString = json['TimeStampString'];
    qRFileName = json['QRFileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeMasterId'] = this.employeeMasterId;
    data['EmployeeName'] = this.employeeName;
    data['Id'] = this.id;
    data['ExamDate'] = this.examDate;
    data['ClassMasterId'] = this.classMasterId;
    data['ClassName'] = this.className;
    data['ClassSectionMasterId'] = this.classSectionMasterId;
    data['ClassSectionName'] = this.classSectionName;
    data['TermMasterId'] = this.termMasterId;
    data['TermName'] = this.termName;
    data['ExamMasterId'] = this.examMasterId;
    data['ExamName'] = this.examName;
    data['SubjectMasterId'] = this.subjectMasterId;
    data['SubjectName'] = this.subjectName;
    data['SubjectType'] = this.subjectType;
    data['MaximumMarks'] = this.maximumMarks;
    data['IsLocked'] = this.isLocked;
    if (this.lstStudent != null) {
      data['LstStudent'] = this.lstStudent!.map((v) => v.toJson()).toList();
    }
    data['EncryptedId'] = this.encryptedId;
    data['SerialNumber'] = this.serialNumber;
    data['RowVersion'] = this.rowVersion;
    data['IsActive'] = this.isActive;
    data['Remarks'] = this.remarks;
    data['CheckSumValue'] = this.checkSumValue;
    data['GUID'] = this.gUID;
    data['DatabaseTableName'] = this.databaseTableName;
    data['Token'] = this.token;
    data['CRCValue'] = this.cRCValue;
    data['SuperAdminName'] = this.superAdminName;
    data['CreatedByUserId'] = this.createdByUserId;
    data['CreatedByUserName'] = this.createdByUserName;
    data['CreateDate'] = this.createDate;
    data['ModifiedByUserId'] = this.modifiedByUserId;
    data['ModifiedByUserName'] = this.modifiedByUserName;
    data['ModifyDate'] = this.modifyDate;
    data['RecordCount'] = this.recordCount;
    data['ErrorMessage'] = this.errorMessage;
    data['TimeStamp'] = this.timeStamp;
    data['TimeStampValue'] = this.timeStampValue;
    data['TimeStampString'] = this.timeStampString;
    data['QRFileName'] = this.qRFileName;
    data['SectionMasterId'] = this.classSectionMasterId;
    data['ResultCardTermMasterId'] = this.termMasterId;
    data['ResultCardPersonalityTraitsId'] = this.subjectMasterId;
    return data;
  }
}

class LstStudent {
  var studentMasterId;
  String? admissionNumber;
  String? studentName;
  String? fatherName;
  String? mobileNumber;
  var rollNumber;
  String? attendanceStatus;
  var marksObtained;
  String? gradeObtained;
  var remarks2;
  var customRemarks;
  var encryptedId;
  var serialNumber;
  var rowVersion;
  bool? isActive;
  String? remarks;
  var checkSumValue;
  String? gUID;
  String? databaseTableName;
  String? token;
  String? cRCValue;
  String? superAdminName;
  var createdByUserId;
  String? createdByUserName;
  String? createDate;
  var modifiedByUserId;
  String? modifiedByUserName;
  String? modifyDate;
  var recordCount;
  var errorMessage;
  var timeStamp;
  var timeStampValue;
  var timeStampString;
  var qRFileName;
  TextEditingController? marksController = TextEditingController();
  TextEditingController? customRemark = TextEditingController();

  LstStudent(
      {this.studentMasterId,
        this.admissionNumber,
        this.studentName,
        this.fatherName,
        this.mobileNumber,
        this.rollNumber,
        this.attendanceStatus,
        this.marksObtained,
        this.gradeObtained,
        this.remarks2,
        this.customRemarks,
        this.encryptedId,
        this.serialNumber,
        this.rowVersion,
        this.isActive,
        this.remarks,
        this.checkSumValue,
        this.gUID,
        this.databaseTableName,
        this.token,
        this.cRCValue,
        this.superAdminName,
        this.createdByUserId,
        this.createdByUserName,
        this.createDate,
        this.modifiedByUserId,
        this.modifiedByUserName,
        this.modifyDate,
        this.recordCount,
        this.errorMessage,
        this.timeStamp,
        this.timeStampValue,
        this.timeStampString,
        this.qRFileName,
        this.marksController,
        this.customRemark
      });

  LstStudent.fromJson(Map<String, dynamic> json) {
    studentMasterId = json['StudentMasterId'];
    admissionNumber = json['AdmissionNumber'];
    studentName = json['StudentName'];
    fatherName = json['FatherName'];
    mobileNumber = json['MobileNumber'];
    rollNumber = json['RollNumber'];
    attendanceStatus = json['AttendanceStatus'];
    marksObtained = json['MarksObtained'];
    marksController!.text = json['MarksObtained'].toString();
    gradeObtained = json['GradeObtained'];
    remarks2 = json['Remarks2'];
    customRemarks = json['CustomRemarks'];
    customRemark!.text = json['CustomRemarks']??"";
    encryptedId = json['EncryptedId'];
    serialNumber = json['SerialNumber'];
    rowVersion = json['RowVersion'];
    isActive = json['IsActive'];
    remarks = json['Remarks'];
    checkSumValue = json['CheckSumValue'];
    gUID = json['GUID'];
    databaseTableName = json['DatabaseTableName'];
    token = json['Token'];
    cRCValue = json['CRCValue'];
    superAdminName = json['SuperAdminName'];
    createdByUserId = json['CreatedByUserId'];
    createdByUserName = json['CreatedByUserName'];
    createDate = json['CreateDate'];
    modifiedByUserId = json['ModifiedByUserId'];
    modifiedByUserName = json['ModifiedByUserName'];
    modifyDate = json['ModifyDate'];
    recordCount = json['RecordCount'];
    errorMessage = json['ErrorMessage'];
    timeStamp = json['TimeStamp'];
    timeStampValue = json['TimeStampValue'];
    timeStampString = json['TimeStampString'];
    qRFileName = json['QRFileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StudentMasterId'] = this.studentMasterId;
    data['AdmissionNumber'] = this.admissionNumber;
    data['StudentName'] = this.studentName;
    data['FatherName'] = this.fatherName;
    data['MobileNumber'] = this.mobileNumber;
    data['RollNumber'] = this.rollNumber;
    data['AttendanceStatus'] = this.attendanceStatus;
    data['MarksObtained'] = this.marksObtained;
    data['MarksObtained'] = this.marksController!.value.text;
    data['GradeObtained'] = this.gradeObtained;
    data['Remarks2'] = this.remarks2;
    data['CustomRemarks'] = this.customRemarks;
    data['CustomRemarks'] = this.customRemark?.value.text??"";
    data['EncryptedId'] = this.encryptedId;
    data['SerialNumber'] = this.serialNumber;
    data['RowVersion'] = this.rowVersion;
    data['IsActive'] = this.isActive;
    data['Remarks'] = this.remarks;
    data['CheckSumValue'] = this.checkSumValue;
    data['GUID'] = this.gUID;
    data['DatabaseTableName'] = this.databaseTableName;
    data['Token'] = this.token;
    data['CRCValue'] = this.cRCValue;
    data['SuperAdminName'] = this.superAdminName;
    data['CreatedByUserId'] = this.createdByUserId;
    data['CreatedByUserName'] = this.createdByUserName;
    data['CreateDate'] = this.createDate;
    data['ModifiedByUserId'] = this.modifiedByUserId;
    data['ModifiedByUserName'] = this.modifiedByUserName;
    data['ModifyDate'] = this.modifyDate;
    data['RecordCount'] = this.recordCount;
    data['ErrorMessage'] = this.errorMessage;
    data['TimeStamp'] = this.timeStamp;
    data['TimeStampValue'] = this.timeStampValue;
    data['TimeStampString'] = this.timeStampString;
    data['QRFileName'] = this.qRFileName;
    return data;
  }
}
