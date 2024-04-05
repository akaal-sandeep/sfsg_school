import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/constants/string_constants.dart';
import 'package:web_school_manager/controller/drawer_controller.dart';
import 'package:web_school_manager/controller/parent_controller.dart';
import 'package:web_school_manager/controller/parent_state_controller.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/drawer/module/contact_us.dart';
import 'package:web_school_manager/local_storage/local_storage.dart';
import 'package:web_school_manager/model/login_scuccess_model.dart';
import 'package:web_school_manager/parent/student_attendence.dart';
import 'package:web_school_manager/parent/student_details.dart';
import 'package:web_school_manager/parent/video/video_list.dart';
import 'package:web_school_manager/parent_model/parent_module_list_model.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';
import '../parent_model/get_student_list_r1_model.dart';
import '../parent_model/get_student_list_r1_model.dart' as parentModel;

class StudentDashboard extends StatefulWidget {
  parentModel.StudentData data;

  StudentDashboard({Key? key, required this.data}) : super(key: key);

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  StudentData studentData =
  LocalStorage().readStudentModel(key: StringConstants.parentProfileModel);

  LoginSuccessModel loginSuccessModel =
  LocalStorage().readModel(key: StringConstants.parentLoginSuccessModel);

  ParentModuleListModel model = LocalStorage()
      .readParentModuleList(key: StringConstants.parentModuleList);

  final controller = Get.put(ParentStateController());

  List assets = [
    "assets/icons/profile.png",
    "assets/icons/attendance.png",
    "assets/icons/home-work.png",
    "assets/icons/holiday-home-work.png",
    "assets/common/lesson-plan.png",
    "assets/icons/time-table.png",
    "assets/icons/class-room.png",
    "assets/icons/MCQ.png",
    "assets/icons/syllabus.png",
    "assets/icons/fee-ledger.png",
    "assets/icons/fee-payment.png",
    "assets/icons/video.png",
    "assets/icons/apply-leave.png",
    "assets/icons/classroom-camera.png",
    "assets/icons/appointment.png",
    "assets/icons/date-sheet.png",
    "assets/icons/circular.png",
    "assets/icons/bus-tracking.png",
    "assets/icons/bag_components.png"
  ];

  List label = [
    "Profile",
    "Attendance",
    "Home Work",
    "Holidays Homework",
    "Lesson Plan",
    "Time Table",
    "Class Test",
    "MCQ Test",
    "Syllabus",
    "Fee Ledger",
    "Fee Payment",
    "Videos",
    "Apply Leave",
    "Class Room Camera",
    "Request Appointment",
    "Date Sheet",
    "Circular",
    'Bus Tracker',
    "Bag Component",
  ];

  List newMap = [];
  List<int> removeIndex = [];

  @override
  void initState() {
    myLog(label: "Moduel List", value: model.toJson());

    newMap = [];
    for (int i = 0; i < label.length; i++) {
      newMap.add(listMapIndex(label[i], i));
    }

    ///---------module check-------

    if (model.data?.attendanceModuleApplicable == false) {
      removeIndex.add(1);
    }
    if (model.data?.homeWorkModuleApplicable == false) {
      removeIndex.add(2);
    }
    if (model.data?.parentHolidayHomeWorkModuleApplicable == false) {
      removeIndex.add(3);
    }
    if (model.data?.lessonManagementModuleApplicable == false) {
      removeIndex.add(4);
    }
    if (model.data?.timeTableModuleApplicable == false) {
      removeIndex.add(5);
    }
    if (model.data?.classTestModuleApplicable == false) {
      removeIndex.add(6);
    }
    if (model.data?.mCQTestModuleApplicable == false) {
      removeIndex.add(7);
    }
    if (model.data?.syllabusModuleApplicable == false) {
      removeIndex.add(8);
    }
    if (model.data?.feeLedgerModuleApplicable == false) {
      removeIndex.add(9);
    }
    if (model.data?.onlineFeePayModuleApplicable == false) {
      removeIndex.add(10);
    }
    if (model.data?.videosModuleApplicable == false) {
      removeIndex.add(11);
    }
    if (model.data?.applyLeaveModuleApplicable == false) {
      removeIndex.add(12);
    }
    if (model.data?.parentCameraModuleApplicable == false) {
      removeIndex.add(13);
    }
    if (model.data?.parentAppointmentModuleApplicable == false) {
      removeIndex.add(14);
    }
    if (model.data?.parentDateSheetModuleApplicable == false) {
      removeIndex.add(15);
    }
    if (model.data?.parentCircularModuleApplicable == false) {
      removeIndex.add(16);
    }
    if (model.data?.parentGPSTrackingModuleApplicable == false) {
      removeIndex.add(17);
    }
    if (model.data?.parentBagPlanModuleApplicable == false) {
      removeIndex.add(18);
    }

    for (int i = removeIndex.length - 1; i >= 0; i--) {
      newMap.removeAt(removeIndex[i]);
      assets.removeAt(removeIndex[i]);
      myLog(label: "removed", value: removeIndex[i]);
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder(
                  init: controller,
                  builder: (context) {
                    return CommonHeader(
                        title: controller.studentData.name ?? "");
                  }),
              smallSpace(),
              InkWell(
                onTap: () {
                  ParentDrawerController().getNotificationList();
                  // Get.to(TimelineScreen());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      boxShadow: myShadow,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          height: 30,
                          child: Image.asset("assets/icons/timeline.png")),
                      SizedBox(width: 10,),
                      Text("Notifications")
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2,),
              Expanded(
                child: AnimationLimiter(
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    itemCount: newMap.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 120,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0),
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 1000),
                        columnCount: 3,
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: InkWell(
                              onTap: () {
                                switch (newMap[index]['index']) {
                                  case 0:
                                    Get.to(() =>
                                        StudentDetails(
                                          data: controller.studentData,
                                        ));
                                    break;
                                  case 1:
                                    ParentController()
                                        .getStudentAttendance(
                                        month: DateTime
                                            .now()
                                            .month
                                            .toString(),
                                        year: DateTime
                                            .now()
                                            .year
                                            .toString())
                                        .then((value) {
                                      Get.to(() =>
                                          Attendance(
                                            studentAttendanceModel: value,
                                          ));
                                    });

                                    break;
                                  case 2:
                                    ParentController()
                                        .getClassHomeWorkWithReadStatus();
                                    break;
                                  case 3:
                                    ParentController()
                                        .getHolidayHomeWorkWithReadStatus();
                                    break;
                                  case 4:
                                    ParentController()
                                        .getLessonPlanListForStudent();
                                    break;
                                  case 5:
                                    ParentController().getStudentTimeTable();
                                    break;
                                  case 6:
                                    ParentController().getClassTestSubject();
                                    break;
                                  case 7:
                                    var studentToken = studentData.token ?? "";

                                    var loginAccessToken =
                                        loginSuccessModel.data!.accessToken ??
                                            "";

                                    var link =
                                        "https://erp.akaalwebsoft.in/DirectView/MCQTest/TestList?AccessToken=${loginAccessToken}&Token=${studentToken}";

                                    Get.to(() =>
                                        ContactUs(
                                          link: link,
                                          upperTitle: "MCQ Test",
                                        ));
                                    break;
                                  case 8:
                                    StudentData studentData = LocalStorage()
                                        .readStudentModel(
                                        key: StringConstants.profileModel);
                                    TeacherController()
                                        .getSyllabusListByClassSection(
                                        classSectionMasterId:
                                        studentData.classSectionMasterId
                                            .toString(),
                                        classMasterId:
                                        studentData.classMasterId.toString());
                                    break;
                                  case 9:
                                    ParentController().getFeeLedger();
                                    break;
                                  case 10:
                                    var loginAccessToken =
                                        loginSuccessModel.data!.accessToken ??
                                            "";
                                    var studentAdmissionNumber =
                                        studentData.admissionNumber ?? "";
                                    var feePaymentLink =
                                        "https://erp.akaalwebsoft.in/Parent/Login/OnlineFeePaymentForStudent?AccessToken=${loginAccessToken}&AdmissionNumber=${studentAdmissionNumber}";
                                    Get.to(() =>
                                        ContactUs(
                                          link: feePaymentLink,
                                          upperTitle: "Fee Payment",
                                        ));
                                    break;
                                  case 11:
                                    Get.to(() => VideoList());
                                    break;
                                  case 12:
                                    ParentController().getStudentLeaveApplyList(
                                        fromDate: getTimeFormat(
                                            DateTime.now().subtract(
                                                Duration(days: 90))),
                                        toDate: getTimeFormat(
                                            DateTime.now().add(
                                                Duration(days: 90))));
                                    break;
                                  case 13:

                                  ///camera
                                    break;
                                  case 14:
                                    ParentController().getRequestedAppointment(
                                        fromDate: getTimeFormat(
                                            DateTime.now()));
                                    break;
                                  case 15:
                                    ParentController().getDateSheet();
                                    break;
                                  case 16:
                                    ParentController().getCircular();
                                    break;
                                  case 17:
                                    ParentController().getUserDeviceListWSM();
                                    break;
                                  case 18:
                                    ParentController().getBagComponent(
                                        homeWorkDate: DateTime
                                            .now()
                                            .hour > 9
                                            ? DateTime.now().add(
                                            Duration(days: 1)).toString()
                                            : DateTime.now().toString());
                                    break;
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: myShadow),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      assets[index],
                                      height: 60,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      newMap[index]['name'],
                                      textAlign: TextAlign.center,
                                      style: CommonDecoration.dashBoardList,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }
}
