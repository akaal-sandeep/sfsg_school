class ResultSubjectModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  ResultSubjectModel({this.statuscode, this.message, this.data});

  ResultSubjectModel.fromJson(Map<String, dynamic> json) {
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
  var id;
  String? name;
  bool? isSelected;
  var instituteCount;
  var sortId;
  var examCode;
  bool? isOptional;
  bool? isPaid;
  var monthlyCharges;
  var annualCharges;
  var groupName;
  var groupSortId;
  var groupSubjectCount;
  var headName;
  var headSortId;
  var headGroupCount;
  bool? isUsedAsFeeHeadName;
  var marksEntryType;
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

  Data(
      {this.id,
        this.name,
        this.isSelected,
        this.instituteCount,
        this.sortId,
        this.examCode,
        this.isOptional,
        this.isPaid,
        this.monthlyCharges,
        this.annualCharges,
        this.groupName,
        this.groupSortId,
        this.groupSubjectCount,
        this.headName,
        this.headSortId,
        this.headGroupCount,
        this.isUsedAsFeeHeadName,
        this.marksEntryType,
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

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    isSelected = json['IsSelected'];
    instituteCount = json['InstituteCount'];
    sortId = json['SortId'];
    examCode = json['ExamCode'];
    isOptional = json['IsOptional'];
    isPaid = json['IsPaid'];
    monthlyCharges = json['MonthlyCharges'];
    annualCharges = json['AnnualCharges'];
    groupName = json['GroupName'];
    groupSortId = json['GroupSortId'];
    groupSubjectCount = json['GroupSubjectCount'];
    headName = json['HeadName'];
    headSortId = json['HeadSortId'];
    headGroupCount = json['HeadGroupCount'];
    isUsedAsFeeHeadName = json['IsUsedAsFeeHeadName'];
    marksEntryType = json['MarksEntryType'];
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
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['IsSelected'] = this.isSelected;
    data['InstituteCount'] = this.instituteCount;
    data['SortId'] = this.sortId;
    data['ExamCode'] = this.examCode;
    data['IsOptional'] = this.isOptional;
    data['IsPaid'] = this.isPaid;
    data['MonthlyCharges'] = this.monthlyCharges;
    data['AnnualCharges'] = this.annualCharges;
    data['GroupName'] = this.groupName;
    data['GroupSortId'] = this.groupSortId;
    data['GroupSubjectCount'] = this.groupSubjectCount;
    data['HeadName'] = this.headName;
    data['HeadSortId'] = this.headSortId;
    data['HeadGroupCount'] = this.headGroupCount;
    data['IsUsedAsFeeHeadName'] = this.isUsedAsFeeHeadName;
    data['MarksEntryType'] = this.marksEntryType;
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
