
class ApiUrls{

  static const baseUrl = "https://erp.sfsjschool.com/API/Data/";
  static const resultCardBaseUrl = "https://resultcard.akaalwebsoft.in/API/ResultCard/";
  static const vanTrackerBaseUrl = "https://track.webschoolmanager.com/api/Data/";

  ///**************************result card***********************

  static const GetResultCardTerms = resultCardBaseUrl+"GetResultCardTerms";
  static const GetResultCardExams = resultCardBaseUrl+"GetResultCardExams";
  static const GetSubjects = resultCardBaseUrl+"GetSubjects";
  static const GetRemarkStudentList = resultCardBaseUrl+"GetStudentList";
  static const SaveResultMarks = resultCardBaseUrl+"SaveMarks";

  static const GetPersonalityTraits = resultCardBaseUrl+"GetPersonalityTraits";
  static const GetRemarks = resultCardBaseUrl+"GetRemarks";
  static const GetStudentListForPeronalityTraits = resultCardBaseUrl+"GetStudentListForPeronalityTraits";
  static const SavePersonaityTraits = resultCardBaseUrl+"SavePersonaityTraits";
  static const GetStudentListForRemarks = resultCardBaseUrl+"GetStudentListForRemarks";
  static const SaveRemarks = resultCardBaseUrl+"SaveRemarks";


  ///=================van tracker============================================================================
  static const GetUserDeviceListWSM = vanTrackerBaseUrl+"GetUserDeviceListWSM";
  static const GetCoordinatesByDeviceIdList = vanTrackerBaseUrl+"GetCoordinatesByDeviceIdListWSM";
  static const GetLimitedCoordinatesByDeviceIdWSM = vanTrackerBaseUrl+"GetLimitedCoordinatesByDeviceIdWSM";
  ///===========================================================================================================

  static const ValidateUserCredentials = baseUrl+"ValidateUserCredentials";
  static const ValidateLoginOTPR1 = baseUrl+"ValidateLoginOTPR2";
  static const LogoutMobileUser = baseUrl+"LogoutMobileUser";

///  teacher urls
  static const EmployeeProfile = baseUrl+"EmployeeProfile";
  static const GetTeacherClassList = baseUrl+"GetTeacherClassList";
  static const GetStudentListForAttendance = baseUrl+"GetStudentListForAttendance";
  static const GetModuleList = baseUrl+"GetModuleList";

  static const SaveStudentDailyAttendance = baseUrl+"SaveStudentDailyAttendance";
  static const TeacherTimeTable = baseUrl+"TeacherTimeTable";
  static const GetClassHomeworkSubjectList = baseUrl+"GetClassHomeworkSubjectList";
  static const SaveHomeWorkWithMultipleDocuments = baseUrl+"SaveHomeWorkWithMultipleDocuments";

  static const SaveEmployeeLeaveApply = baseUrl+"SaveEmployeeLeaveApply";
  static const GetEmployeeLeaveReasonList = baseUrl+"GetEmployeeLeaveReasonList";
  static const GetLessonPlanListByTeacher = baseUrl+"GetLessonPlanListByTeacher";
  static const GetStudentRemarks = baseUrl+"GetStudentRemarks";
  static const GetRemarksTypeList = baseUrl+"GetRemarksTypeList";
  static const GetStudentListForRemarksEntry = baseUrl+"GetStudentListForRemarksEntry";
  static const SaveStudentRemarks = baseUrl+"SaveStudentRemarks";

  static const GetClassTestSubjectList = baseUrl+"GetClassTestSubjectList";
  static const GetTeacherClassTestListBySubject = baseUrl+"GetTeacherClassTestListBySubject";
  static const ManageClassTestMain = baseUrl+"ManageClassTestMain";
  static const ManageClassTestInv = baseUrl+"ManageClassTestInv";
  static const SaveClassTest = baseUrl+"SaveClassTest";


  static const LockClassTest = baseUrl+"LockClassTest";
  static const DeleteClassTest = baseUrl+"DeleteClassTest";
  static const GetClassList = baseUrl+"GetClassList";
  static const GetClassSectionList = baseUrl+"GetClassSectionList";

  static const SaveEmployeeDailyAttendance = baseUrl+"SaveEmployeeDailyAttendance";



  static const GetClassHomeWorkBySubjectDate = baseUrl+"GetClassHomeWorkBySubjectDate";
  static const GetHolidayHomeworkSubjectList = baseUrl+"GetHolidayHomeworkSubjectList";
  static const SalarySlip = baseUrl+"SalarySlip";
  static const GetStudentLeaveApplyList = baseUrl+"GetStudentLeaveApplyList";
  static const GetFixedAppointmentsListForTeacher = baseUrl+"GetFixedAppointmentsListForTeacher";

  static const GetHolidayHomeWorkBySubjectDate = baseUrl+"GetHolidayHomeWorkBySubjectDate";

  static const ApproveStudentLeaveApply = baseUrl+"ApproveStudentLeaveApply";
  static const RejectStudentLeaveApply = baseUrl+"RejectStudentLeaveApply";
  static const GetBagComponentList = baseUrl+"GetBagComponentList";
  static const SaveBagPlan = baseUrl+"SaveBagPlan";
  static const GetBagPlanList = baseUrl+"GetBagPlanList";

  /// drawer api's
  static const ParentNoticeBoardList = baseUrl+"ParentNoticeBoardList";
  static const GetHolidaysList = baseUrl+"GetHolidaysList";
  static const GetGalleryData = baseUrl+"GetGalleryData";
  static const ParentPressRelease = baseUrl+"ParentPressRelease";
  static const ParentPressReleaseImages = baseUrl+"ParentPressReleaseImages";
  static const GetNotificationList = baseUrl+"GetNotificationList";
  static const GetSportsScheduleList = baseUrl+"GetSportsScheduleList";
  static const GetClassWorkSubjectList = baseUrl+"GetClassWorkSubjectList";
  static const GetClassWorkBySubjectDate = baseUrl+"GetClassWorkBySubjectDate";
  static const SaveClassWorkWithMultipleDocuments = baseUrl+"SaveClassWorkWithMultipleDocuments";
  static const ContactUs = baseUrl+"ContactUs";

  ///--------students-------------------------------------------
  static const GetStudentListR1 = baseUrl+"GetStudentListR1";
  static const StudentAttendance = baseUrl+"StudentAttendance";
  static const GetClassHomeWorkWithReadStatus = baseUrl+"GetClassHomeWorkWithReadStatus";

  static const GetStudentListForUploadClassHomeWork = baseUrl+"GetStudentListForUploadClassHomeWork";
  static const UpdateUploadHomeWorkReadStatus = baseUrl+"UpdateUploadHomeWorkReadStatus";
  static const GetUploadClassHomeWorkListForStudent = baseUrl+"GetUploadClassHomeWorkListForStudent";
  static const GetHolidayHomeWorkWithReadStatus = baseUrl+"GetHolidayHomeWorkWithReadStatus";
  static const GetLessonPlanListForStudent = baseUrl+"GetLessonPlanListForStudent";

  static const StudentTimeTable = baseUrl+"StudentTimeTable";
  static const GetSubjectListForClassTest = baseUrl+"GetSubjectListForClassTest";
  static const GetClassTestList = baseUrl+"GetClassTestList";
  static const GetSyllabusListByClassSectionSubject = baseUrl+"GetSyllabusListByClassSectionSubject";
  static const FeeLeggerR2 = baseUrl+"FeeLedgerR2";
  static const GetClassCircularList = baseUrl+"GetClassCircularList";
  static const GetDateSheetListByClassSection = baseUrl+"GetDateSheetListByClassSection";

  static const GetStudentLeaveReasonList = baseUrl+"GetStudentLeaveReasonList";
  static const SaveStudentLeaveApply = baseUrl+"SaveStudentLeaveApply";
  static const GetRequestedAppointments = baseUrl+"GetRequestedAppointments";
  static const GetUploadClassHomeWorkBySubjectDateR1 = baseUrl+"GetUploadClassHomeWorkBySubjectDateR1";
  static const SaveUploadHomeworkWithMultipleDocuments = baseUrl+"SaveUploadHomeworkWithMultipleDocuments";

  static const GetEmployeeListForAppointmentRequest = baseUrl+"GetEmployeeListForAppointmentRequest";
  static const GetRelationList = baseUrl+"GetRelationList";
  static const SaveAppointmentRequest = baseUrl+"SaveAppointmentRequest";

  static const GetClassHomeWorkList = baseUrl+"GetClassHomeWork";
  static const GetBagPlanListForStudent = baseUrl+"GetBagPlanListForStudent";

  static const GetEmployeeListForStudent = baseUrl+"GetEmployeeListForStudent";





  ///Principal Url's------------------------------------
  static const getStudentTeacherAttendanceSummary = baseUrl+"GetStudentTeacherAttendanceSummaryForPrincipal";
  static const getPrincipalProfile = baseUrl+"PrincipalProfile";
  static const getStudentAttendanceDetails = baseUrl+"GetStudentAttendanceDetails";
  static const getStudentListByClassSection = baseUrl+"GetStudentListByClassSection";
  static const getTeacherList = baseUrl+"GetEmployeesList";
  static const getFixedAppointmentListForPrincipal = baseUrl+"GetFixedAppointmentsListForPrincipal";
  static const SaveTeacherNotificationLog = baseUrl+"SaveTeacherNotificationLog";
  static const GetClassSectionListForPushNotification = baseUrl+"GetClassSectionListForPushNotification";
  static const SaveParentNotificationLog = baseUrl+"SaveParentNotificationLog";


  ///------------principal model--------------------

  static const GetLessonPlanList = baseUrl+"GetLessonPlanList";
  static const RejectLessonPlan = baseUrl+"RejectLessonPlan";
  static const ApproveLessonPlan = baseUrl+"ApproveLessonPlan";
  static const SaveLessonPlan = baseUrl+"SaveLessonPlan";
  static const UpdateLessonPlan = baseUrl+"UpdateLessonPlan";
  static const GetEmployeeLeaveApplyList = baseUrl+"GetEmployeeLeaveApplyList";

  static const ApproveEmployeeLeaveApply = baseUrl+"ApproveEmployeeLeaveApply";
  static const RejectEmployeeLeaveApply = baseUrl+"RejectEmployeeLeaveApply";

  static const GetSubjectListForClass = baseUrl+"GetSubjectListForClass";
  static const GetClassHomeWorkListByClassSection = baseUrl+"GetClassHomeWorkListByClassSection";



  ///----------coordinator--------------------

  static const GetCoordinatorClassList = baseUrl+"GetCoordinatorClassList";
  static const GetPendingHomeWork = baseUrl+"GetPendingHomeWork";

  ///---------reception-------------------------------------

  static const SaveInstituteOutwardGatepass = baseUrl+"SaveInstituteOutwardGatepass";
  static const SaveInstituteInwardGatepass = baseUrl+"SaveInstituteInwardGatepass";
  static const GetVisitorIdentityProofList = baseUrl+"GetVisitorIdentityProofList";
  static const GetInstituteOutwardGatepassList = baseUrl+"GetInstituteOutwardGatepassList";
  static const GetInstituteInwardGatepassList = baseUrl+"GetInstituteInwardGatepassList";
  static const GetInstituteInwardGatepassDetailByGatepassNumber = baseUrl+"GetInstituteInwardGatepassDetailByGatepassNumber";


}