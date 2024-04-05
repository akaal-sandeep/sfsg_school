class GetResultTermsModel {
  String? statuscode;
  String? message;
  List<Data>? data;

  GetResultTermsModel({this.statuscode, this.message, this.data});

  GetResultTermsModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? fromDate;
  String? toDate;
  int? sortId;
  Null encryptedId;
  int? serialNumber;
  int? rowVersion;
  bool? isActive;
  String? remarks;
  int? checkSumValue;
  String? gUID;
  String? databaseTableName;
  String? token;
  String? cRCValue;
  String? superAdminName;
  int? createdByUserId;
  String? createdByUserName;
  String? createDate;
  int? modifiedByUserId;
  String? modifiedByUserName;
  String? modifyDate;
  int? recordCount;
  Null errorMessage;
  int? timeStamp;
  Null timeStampValue;
  Null timeStampString;
  Null qRFileName;

  Data(
      {this.id,
        this.name,
        this.fromDate,
        this.toDate,
        this.sortId,
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
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    sortId = json['SortId'];
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
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['SortId'] = this.sortId;
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
