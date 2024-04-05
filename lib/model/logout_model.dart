class LogoutModel {
  String? statuscode;
  String? message;
  Data? data;

  LogoutModel({this.statuscode, this.message, this.data});

  LogoutModel.fromJson(Map<String, dynamic> json) {
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
  var id;
  var loginHistoryId;
  String? userCultureInfo;
  String? name;
  String? password;
  String? emailId;
  String? mobileNo;
  bool? isSuperAdmin;
  bool? isSeniorAdmin;
  bool? isOperator;
  bool? isAuditor;
  bool? isHeadOffice;
  bool? isCoordinator;
  var userImage;
  String? lastLogInDateTime;
  var pageSize;
  var payrollAttendancePageSize;
  String? dateFormat;
  String? dateTimeFormat;
  String? amountFormat;
  var digitAfterDecimalAmount;
  List<String>? lstParentMenu;
  List<String>? lstChildMenu;
  bool? canApproveEmployeeMaster;
  bool? canApproveEmployeeIncrementMaster;
  bool? canApproveHomeWork;
  String? iPAddress;
  String? browserInformation;
  var defaultFinYearMasterId;
  var defaultInstituteMasterId;
  List<String>? applicationRoles;
  List<String>? institutes;
  List<String>? receiptTypes;
  bool? canLoginOnSunday;
  bool? canLoginOnHoliday;
  bool? isTimeBound;
  String? fromTime;
  String? toTime;
  bool? extraSecurityRequired;
  String? verificationCode;
  String? resetToken;
  String? passwordResetToken;
  String? companyName;
  String? emailDisplayName;
  String? emailHostName;
  bool? emailEnableSSL;
  String? emailUserName;
  String? emailPassword;
  var emailPortNumber;
  var defaultEmployeeBloodGroupMasterId;
  var defaultEmployeeReligionMasterId;
  var defaultEmployeeCasteMasterId;
  String? newPassword;
  String? confirmPassword;
  var allocatedInstituteCount;
  var allocatedModulesCount;
  var currentModuleId;
  String? currentModuleName;
  List<String>? favoriteMenus;
  List<String>? lstModules;
  String? userType;
  String? deviceId;
  String? fCMID;
  String? deviceType;
  String? instituteCode;
  bool? isValidUser;
  bool? oTPRequired;
  String? oTPValue;
  String? accessToken;
  var employeeMasterId;
  bool? canAddStudentConcession;
  bool? canAddStudentAdditionalCharges;
  bool? canAddStudentRefund;
  bool? canAddStudentWaiveOff;
  bool? canAddStudentConveyance;
  bool? canAddStudentParking;
  bool? canAddStudentFine;
  bool? canAddStudentClass;
  bool? canAddStudentOpeningBalance;
  bool? saveSuccessMessageRequiredInPopUp;
  var lastFeeReceiptsDisplayCount;
  var feeReceiptDefaultPaymentModeId;
  var feeReceiptDefaultSubPaymentModeId;
  bool? feeReceiptPaymentModeEditable;
  bool? feeReceiptSubPaymentModeEditable;
  bool? canEditFeeSlipDueDays;
  bool? isFromMobileBrowser;
  bool? isFromMobileApplication;
  var mobileAppToken;
  var transportProductDefaultListCount;
  var appVersion;
  bool? isForceUpdate;
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
        this.loginHistoryId,
        this.userCultureInfo,
        this.name,
        this.password,
        this.emailId,
        this.mobileNo,
        this.isSuperAdmin,
        this.isSeniorAdmin,
        this.isOperator,
        this.isAuditor,
        this.isHeadOffice,
        this.isCoordinator,
        this.userImage,
        this.lastLogInDateTime,
        this.pageSize,
        this.payrollAttendancePageSize,
        this.dateFormat,
        this.dateTimeFormat,
        this.amountFormat,
        this.digitAfterDecimalAmount,
        this.lstParentMenu,
        this.lstChildMenu,
        this.canApproveEmployeeMaster,
        this.canApproveEmployeeIncrementMaster,
        this.canApproveHomeWork,
        this.iPAddress,
        this.browserInformation,
        this.defaultFinYearMasterId,
        this.defaultInstituteMasterId,
        this.applicationRoles,
        this.institutes,
        this.receiptTypes,
        this.canLoginOnSunday,
        this.canLoginOnHoliday,
        this.isTimeBound,
        this.fromTime,
        this.toTime,
        this.extraSecurityRequired,
        this.verificationCode,
        this.resetToken,
        this.passwordResetToken,
        this.companyName,
        this.emailDisplayName,
        this.emailHostName,
        this.emailEnableSSL,
        this.emailUserName,
        this.emailPassword,
        this.emailPortNumber,
        this.defaultEmployeeBloodGroupMasterId,
        this.defaultEmployeeReligionMasterId,
        this.defaultEmployeeCasteMasterId,
        this.newPassword,
        this.confirmPassword,
        this.allocatedInstituteCount,
        this.allocatedModulesCount,
        this.currentModuleId,
        this.currentModuleName,
        this.favoriteMenus,
        this.lstModules,
        this.userType,
        this.deviceId,
        this.fCMID,
        this.deviceType,
        this.instituteCode,
        this.isValidUser,
        this.oTPRequired,
        this.oTPValue,
        this.accessToken,
        this.employeeMasterId,
        this.canAddStudentConcession,
        this.canAddStudentAdditionalCharges,
        this.canAddStudentRefund,
        this.canAddStudentWaiveOff,
        this.canAddStudentConveyance,
        this.canAddStudentParking,
        this.canAddStudentFine,
        this.canAddStudentClass,
        this.canAddStudentOpeningBalance,
        this.saveSuccessMessageRequiredInPopUp,
        this.lastFeeReceiptsDisplayCount,
        this.feeReceiptDefaultPaymentModeId,
        this.feeReceiptDefaultSubPaymentModeId,
        this.feeReceiptPaymentModeEditable,
        this.feeReceiptSubPaymentModeEditable,
        this.canEditFeeSlipDueDays,
        this.isFromMobileBrowser,
        this.isFromMobileApplication,
        this.mobileAppToken,
        this.transportProductDefaultListCount,
        this.appVersion,
        this.isForceUpdate,
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
    loginHistoryId = json['LoginHistoryId'];
    userCultureInfo = json['UserCultureInfo'];
    name = json['Name'];
    password = json['Password'];
    emailId = json['EmailId'];
    mobileNo = json['MobileNo'];
    isSuperAdmin = json['IsSuperAdmin'];
    isSeniorAdmin = json['IsSeniorAdmin'];
    isOperator = json['IsOperator'];
    isAuditor = json['IsAuditor'];
    isHeadOffice = json['IsHeadOffice'];
    isCoordinator = json['IsCoordinator'];
    userImage = json['UserImage'];
    lastLogInDateTime = json['LastLogInDateTime'];
    pageSize = json['PageSize'];
    payrollAttendancePageSize = json['PayrollAttendancePageSize'];
    dateFormat = json['DateFormat'];
    dateTimeFormat = json['DateTimeFormat'];
    amountFormat = json['AmountFormat'];
    digitAfterDecimalAmount = json['DigitAfterDecimalAmount'];
    if (json['LstParentMenu'] != null) {
      lstParentMenu = <String>[];
      json['LstParentMenu'].forEach((v) {
      //  lstParentMenu!.add(new String.fromJson(v));
      });
    }
    if (json['LstChildMenu'] != null) {
      // lstChildMenu = <Null>[];
      // json['LstChildMenu'].forEach((v) {
      //   lstChildMenu!.add(new Null.fromJson(v));
      // });
    }
    canApproveEmployeeMaster = json['CanApproveEmployeeMaster'];
    canApproveEmployeeIncrementMaster =
    json['CanApproveEmployeeIncrementMaster'];
    canApproveHomeWork = json['CanApproveHomeWork'];
    iPAddress = json['IPAddress'];
    browserInformation = json['BrowserInformation'];
    defaultFinYearMasterId = json['DefaultFinYearMasterId'];
    defaultInstituteMasterId = json['DefaultInstituteMasterId'];
    if (json['ApplicationRoles'] != null) {
      // applicationRoles = <Null>[];
      // json['ApplicationRoles'].forEach((v) {
      //   applicationRoles!.add(new Null.fromJson(v));
      // });
    }
    if (json['Institutes'] != null) {
      // institutes = <Null>[];
      // json['Institutes'].forEach((v) {
      //   institutes!.add(new Null.fromJson(v));
      // });
    }
    if (json['ReceiptTypes'] != null) {
      // receiptTypes = <Null>[];
      // json['ReceiptTypes'].forEach((v) {
      //   receiptTypes!.add(new Null.fromJson(v));
      // });
    }
    canLoginOnSunday = json['CanLoginOnSunday'];
    canLoginOnHoliday = json['CanLoginOnHoliday'];
    isTimeBound = json['IsTimeBound'];
    fromTime = json['FromTime'];
    toTime = json['ToTime'];
    extraSecurityRequired = json['ExtraSecurityRequired'];
    verificationCode = json['VerificationCode'];
    resetToken = json['ResetToken'];
    passwordResetToken = json['PasswordResetToken'];
    companyName = json['CompanyName'];
    emailDisplayName = json['EmailDisplayName'];
    emailHostName = json['EmailHostName'];
    emailEnableSSL = json['EmailEnableSSL'];
    emailUserName = json['EmailUserName'];
    emailPassword = json['EmailPassword'];
    emailPortNumber = json['EmailPortNumber'];
    defaultEmployeeBloodGroupMasterId =
    json['DefaultEmployeeBloodGroupMasterId'];
    defaultEmployeeReligionMasterId = json['DefaultEmployeeReligionMasterId'];
    defaultEmployeeCasteMasterId = json['DefaultEmployeeCasteMasterId'];
    newPassword = json['NewPassword'];
    confirmPassword = json['ConfirmPassword'];
    allocatedInstituteCount = json['AllocatedInstituteCount'];
    allocatedModulesCount = json['AllocatedModulesCount'];
    currentModuleId = json['CurrentModuleId'];
    currentModuleName = json['CurrentModuleName'];
    if (json['FavoriteMenus'] != null) {
      // favoriteMenus = <Null>[];
      // json['FavoriteMenus'].forEach((v) {
      //   favoriteMenus!.add(new Null.fromJson(v));
      // });
    }
    if (json['LstModules'] != null) {
      // lstModules = <Null>[];
      // json['LstModules'].forEach((v) {
      //   lstModules!.add(new Null.fromJson(v));
      // });
    }
    userType = json['UserType'];
    deviceId = json['DeviceId'];
    fCMID = json['FCMID'];
    deviceType = json['DeviceType'];
    instituteCode = json['InstituteCode'];
    isValidUser = json['IsValidUser'];
    oTPRequired = json['OTPRequired'];
    oTPValue = json['OTPValue'];
    accessToken = json['AccessToken'];
    employeeMasterId = json['EmployeeMasterId'];
    canAddStudentConcession = json['CanAddStudentConcession'];
    canAddStudentAdditionalCharges = json['CanAddStudentAdditionalCharges'];
    canAddStudentRefund = json['CanAddStudentRefund'];
    canAddStudentWaiveOff = json['CanAddStudentWaiveOff'];
    canAddStudentConveyance = json['CanAddStudentConveyance'];
    canAddStudentParking = json['CanAddStudentParking'];
    canAddStudentFine = json['CanAddStudentFine'];
    canAddStudentClass = json['CanAddStudentClass'];
    canAddStudentOpeningBalance = json['CanAddStudentOpeningBalance'];
    saveSuccessMessageRequiredInPopUp =
    json['SaveSuccessMessageRequiredInPopUp'];
    lastFeeReceiptsDisplayCount = json['LastFeeReceiptsDisplayCount'];
    feeReceiptDefaultPaymentModeId = json['FeeReceiptDefaultPaymentModeId'];
    feeReceiptDefaultSubPaymentModeId =
    json['FeeReceiptDefaultSubPaymentModeId'];
    feeReceiptPaymentModeEditable = json['FeeReceiptPaymentModeEditable'];
    feeReceiptSubPaymentModeEditable = json['FeeReceiptSubPaymentModeEditable'];
    canEditFeeSlipDueDays = json['CanEditFeeSlipDueDays'];
    isFromMobileBrowser = json['IsFromMobileBrowser'];
    isFromMobileApplication = json['IsFromMobileApplication'];
    mobileAppToken = json['MobileAppToken'];
    transportProductDefaultListCount = json['TransportProductDefaultListCount'];
    appVersion = json['AppVersion'];
    isForceUpdate = json['IsForceUpdate'];
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
    data['LoginHistoryId'] = this.loginHistoryId;
    data['UserCultureInfo'] = this.userCultureInfo;
    data['Name'] = this.name;
    data['Password'] = this.password;
    data['EmailId'] = this.emailId;
    data['MobileNo'] = this.mobileNo;
    data['IsSuperAdmin'] = this.isSuperAdmin;
    data['IsSeniorAdmin'] = this.isSeniorAdmin;
    data['IsOperator'] = this.isOperator;
    data['IsAuditor'] = this.isAuditor;
    data['IsHeadOffice'] = this.isHeadOffice;
    data['IsCoordinator'] = this.isCoordinator;
    data['UserImage'] = this.userImage;
    data['LastLogInDateTime'] = this.lastLogInDateTime;
    data['PageSize'] = this.pageSize;
    data['PayrollAttendancePageSize'] = this.payrollAttendancePageSize;
    data['DateFormat'] = this.dateFormat;
    data['DateTimeFormat'] = this.dateTimeFormat;
    data['AmountFormat'] = this.amountFormat;
    data['DigitAfterDecimalAmount'] = this.digitAfterDecimalAmount;
    if (this.lstParentMenu != null) {
      // data['LstParentMenu'] =
      //     this.lstParentMenu!.map((v) => v.toJson()).toList();
    }
    if (this.lstChildMenu != null) {
    //  data['LstChildMenu'] = this.lstChildMenu!.map((v) => v.toJson()).toList();
    }
    data['CanApproveEmployeeMaster'] = this.canApproveEmployeeMaster;
    data['CanApproveEmployeeIncrementMaster'] =
        this.canApproveEmployeeIncrementMaster;
    data['CanApproveHomeWork'] = this.canApproveHomeWork;
    data['IPAddress'] = this.iPAddress;
    data['BrowserInformation'] = this.browserInformation;
    data['DefaultFinYearMasterId'] = this.defaultFinYearMasterId;
    data['DefaultInstituteMasterId'] = this.defaultInstituteMasterId;
    if (this.applicationRoles != null) {
      // data['ApplicationRoles'] =
      //     this.applicationRoles!.map((v) => v.toJson()).toList();
    }
    if (this.institutes != null) {
     // data['Institutes'] = this.institutes!.map((v) => v.toJson()).toList();
    }
    if (this.receiptTypes != null) {
      //data['ReceiptTypes'] = this.receiptTypes!.map((v) => v.toJson()).toList();
    }
    data['CanLoginOnSunday'] = this.canLoginOnSunday;
    data['CanLoginOnHoliday'] = this.canLoginOnHoliday;
    data['IsTimeBound'] = this.isTimeBound;
    data['FromTime'] = this.fromTime;
    data['ToTime'] = this.toTime;
    data['ExtraSecurityRequired'] = this.extraSecurityRequired;
    data['VerificationCode'] = this.verificationCode;
    data['ResetToken'] = this.resetToken;
    data['PasswordResetToken'] = this.passwordResetToken;
    data['CompanyName'] = this.companyName;
    data['EmailDisplayName'] = this.emailDisplayName;
    data['EmailHostName'] = this.emailHostName;
    data['EmailEnableSSL'] = this.emailEnableSSL;
    data['EmailUserName'] = this.emailUserName;
    data['EmailPassword'] = this.emailPassword;
    data['EmailPortNumber'] = this.emailPortNumber;
    data['DefaultEmployeeBloodGroupMasterId'] =
        this.defaultEmployeeBloodGroupMasterId;
    data['DefaultEmployeeReligionMasterId'] =
        this.defaultEmployeeReligionMasterId;
    data['DefaultEmployeeCasteMasterId'] = this.defaultEmployeeCasteMasterId;
    data['NewPassword'] = this.newPassword;
    data['ConfirmPassword'] = this.confirmPassword;
    data['AllocatedInstituteCount'] = this.allocatedInstituteCount;
    data['AllocatedModulesCount'] = this.allocatedModulesCount;
    data['CurrentModuleId'] = this.currentModuleId;
    data['CurrentModuleName'] = this.currentModuleName;
    if (this.favoriteMenus != null) {
    //  data['FavoriteMenus'] =
      //    this.favoriteMenus!.map((v) => v.toJson()).toList();
    }
    if (this.lstModules != null) {
     // data['LstModules'] = this.lstModules!.map((v) => v.toJson()).toList();
    }
    data['UserType'] = this.userType;
    data['DeviceId'] = this.deviceId;
    data['FCMID'] = this.fCMID;
    data['DeviceType'] = this.deviceType;
    data['InstituteCode'] = this.instituteCode;
    data['IsValidUser'] = this.isValidUser;
    data['OTPRequired'] = this.oTPRequired;
    data['OTPValue'] = this.oTPValue;
    data['AccessToken'] = this.accessToken;
    data['EmployeeMasterId'] = this.employeeMasterId;
    data['CanAddStudentConcession'] = this.canAddStudentConcession;
    data['CanAddStudentAdditionalCharges'] =
        this.canAddStudentAdditionalCharges;
    data['CanAddStudentRefund'] = this.canAddStudentRefund;
    data['CanAddStudentWaiveOff'] = this.canAddStudentWaiveOff;
    data['CanAddStudentConveyance'] = this.canAddStudentConveyance;
    data['CanAddStudentParking'] = this.canAddStudentParking;
    data['CanAddStudentFine'] = this.canAddStudentFine;
    data['CanAddStudentClass'] = this.canAddStudentClass;
    data['CanAddStudentOpeningBalance'] = this.canAddStudentOpeningBalance;
    data['SaveSuccessMessageRequiredInPopUp'] =
        this.saveSuccessMessageRequiredInPopUp;
    data['LastFeeReceiptsDisplayCount'] = this.lastFeeReceiptsDisplayCount;
    data['FeeReceiptDefaultPaymentModeId'] =
        this.feeReceiptDefaultPaymentModeId;
    data['FeeReceiptDefaultSubPaymentModeId'] =
        this.feeReceiptDefaultSubPaymentModeId;
    data['FeeReceiptPaymentModeEditable'] = this.feeReceiptPaymentModeEditable;
    data['FeeReceiptSubPaymentModeEditable'] =
        this.feeReceiptSubPaymentModeEditable;
    data['CanEditFeeSlipDueDays'] = this.canEditFeeSlipDueDays;
    data['IsFromMobileBrowser'] = this.isFromMobileBrowser;
    data['IsFromMobileApplication'] = this.isFromMobileApplication;
    data['MobileAppToken'] = this.mobileAppToken;
    data['TransportProductDefaultListCount'] =
        this.transportProductDefaultListCount;
    data['AppVersion'] = this.appVersion;
    data['IsForceUpdate'] = this.isForceUpdate;
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
