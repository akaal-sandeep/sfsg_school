import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/constants/string_constants.dart';
import 'package:web_school_manager/controller/drawer_controller.dart';
import 'package:web_school_manager/controller/parent_controller.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/controller/user_controller.dart';
import 'package:web_school_manager/drawer/parent_drawer.dart';
import 'package:web_school_manager/local_storage/local_storage.dart';
import 'package:web_school_manager/teacher/get_result_card/screen/result_card_option.dart';
import 'package:web_school_manager/teacher/teacher_bag_component_list_screen.dart';
import 'package:web_school_manager/teacher/holiday_homework_teacher/holiday_work_classes.dart';
import 'package:web_school_manager/teacher/teacher_profile.dart';
import 'package:web_school_manager/teacher_model/employee_profile_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../teacher_model/teacher_module_model.dart';
import '../utility/custom_decoration.dart';

class TeacherDashboard extends StatefulWidget {
  TeacherDashboard({Key? key}) : super(key: key);

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  Future<bool> checkExit() async {
    bool myExit = false;
    var exit = await switchDialog(exit: myExit).then((value) {
      return value;
    });
    return exit;
  }

  TeacherModuleListModel teacherModuleListModel = LocalStorage()
      .readTeacherModuleModel(key: StringConstants.teacherModuleList);

  EmployeeProfileModel employeeProfileModel =
      LocalStorage().readTeacherProfileModel(key: StringConstants.profileModel);

  List assets = [
    "assets/icons/profile.png",
    "assets/icons/time-table.png",
    "assets/icons/classwork.png",
    "assets/icons/class-room.png",
    "assets/icons/learning-plan.png",
    "assets/icons/syllabus.png",
    "assets/icons/fee-payment.png",
    "assets/icons/attendance.png",
    "assets/icons/teacher-leave.png",
    "assets/icons/apply-leave.png",
    "assets/icons/student-remark.png",
    "assets/icons/appointment.png",
    "assets/icons/holiday-home-work.png",
    "assets/icons/circular.png",
    "assets/icons/result_card.png",
    "assets/icons/date-sheet.png",
    "assets/icons/bag_components.png"
    /*  "assets/student.png",
    "assets/students.png",*/
  ];

  List label = [
    "Profile",
    "Time Table",
    "Class Work",
    "Classes",
    "Lesson Plan",
    "Syllabus",
    "Salary Slip",
    "Mark Attendance",
    "Apply Leave",
    "Students Leave",
    "Students Remark",
    "Fixed Appointments",
    "Holiday home work",
    "Circular",
    "Result Card",
    "Date Sheet",
    "Bag Components"
  ];
  List<int> removeIndex = [];
  List newMap = [];

  @override
  void initState() {
    myLog(label:"teacher module", value: jsonEncode(teacherModuleListModel.toJson()));
    // TODO: implement initState
    super.initState();
    newMap = [];
    for (int i = 0; i < label.length; i++) {
      newMap.add(listMapIndex(label[i], i));
    }

    ///-------------module listing --------------
    if (teacherModuleListModel.data?.teacherTimeTableModuleApplicable ==
        false) {
      removeIndex.add(1);
    }
    if (teacherModuleListModel.data?.teacherClassWorkModuleApplication ==
        false) {
      removeIndex.add(2);
    }
    if (teacherModuleListModel.data?.teacherClassModuleApplicable == false) {
      removeIndex.add(3);
    }

    if (teacherModuleListModel.data?.teacherLessonManagementModuleApplicable ==
        false) {
      removeIndex.add(4);
    }

    if (teacherModuleListModel.data?.teacherSyllabusModuleApplicable == false) {
      removeIndex.add(5);
    }
    if (teacherModuleListModel.data?.teacherSalarySlipModuleApplicable ==
        false) {
      removeIndex.add(6);
    }
    if (teacherModuleListModel.data?.teacherMarkAttendanceModuleApplicable ==
        false) {
      removeIndex.add(7);
    }
    if (teacherModuleListModel.data?.teacherApplyLeaveModuleApplicable ==
        false) {
      removeIndex.add(8);
    }
    if (teacherModuleListModel
            .data?.teacherStudentsListWhoAppliedForLeaveModuleApplicable ==
        false) {
      removeIndex.add(9);
    }
    if (teacherModuleListModel.data?.teacherStudentRemarksModuleApplicable ==
        false) {
      removeIndex.add(10);
    }
    if (teacherModuleListModel.data?.teacherAppointmentModuleApplicable ==
        false) {
      removeIndex.add(11);
    }
    if (teacherModuleListModel.data?.teacherHolidayHomeWorkModuleApplicable ==
        false) {
      removeIndex.add(12);
    }
    if (teacherModuleListModel.data?.teacherCircularModuleApplicable == false) {
      removeIndex.add(13);
    }
    if (teacherModuleListModel.data?.teacherResultCardModuleApplication ==
        false) {
      removeIndex.add(14);
    }
    if (teacherModuleListModel.data?.teacherDateSheetModuleApplicable ==
        false) {
      removeIndex.add(15);
    }
    if (teacherModuleListModel.data?.teacherBagPlanModuleApplicable ==
        false) {
      removeIndex.add(16);
    }
/*    if (teacherModuleListModel.data?.teacherHolidayHomeWorkModuleApplicable ==false) {
      removeIndex.add(12);

    }*/

    for (int i = removeIndex.length - 1; i >= 0; i--) {
      newMap.removeAt(removeIndex[i]);
      assets.removeAt(removeIndex[i]);
      myLog(label: "removed", value: removeIndex[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    myLog(label: "my model", value: teacherModuleListModel.toJson());

    return WillPopScope(
      onWillPop: () async {
        bool exit = await checkExit();
        myLog(label: "exit", value: exit);
        return Future.value(exit);
      },
      child: Scaffold(
        key: UserController.drawerState,
        drawer: ParentDrawer(),
        body: myPadding(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonHeader(
              title: employeeProfileModel.data?.displayName ?? "",
              showDrawer: true,
              hideStudentName: true,
            ),
            largeSpace(),
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
                    borderRadius: BorderRadius.circular(100)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                        height: 30,
                        child: Image.asset("assets/icons/timeline.png")),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Notifications")
                  ],
                ),
              ),
            ),
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
                                  Get.to(() => TeacherDetails(
                                        model: employeeProfileModel,
                                      ));
                                  break;
                                case 1:
                                  TeacherController().getTimeTable();
                                  break;
                                case 2:
                                  TeacherController()
                                      .getClassList(classWorkTeacher: true);
                                  break;
                                case 3:
                                  TeacherController().getTeacherClassList();
                                  break;
                                case 4:
                                  TeacherController().getLessonPlanList();
                                  break;
                                case 5:
                                  TeacherController().getClassList();
                                  break;
                                case 6:
                                  TeacherController().getSalarySlip();
                                  break;
                                case 7:
                                  markAttendanceAlert(context);
                                  break;
                                case 8:
                                  TeacherController()
                                      .getEmployeeLeaveApplyList();
                                  break;
                                case 9:
                                  TeacherController()
                                      .getStudentLeaveApplyList();
                                  break;
                                case 10:
                                  TeacherController()
                                      .getStudentRemarks(navigate: true);
                                  break;
                                case 11:
                                  TeacherController()
                                      .getFixedAppointmentsListForTeacher();
                                  break;
                                case 12:
                                  TeacherController()
                                      .returnTeacherClassList()
                                      .then((value) {
                                    if (value.statuscode ==
                                        StringConstants.success) {
                                      Get.to(() => HolidayWorkClasses(
                                            model: value,
                                          ));
                                    } else {
                                      showMessage(msg: value.message);
                                    }
                                  });
                                  break;
                                case 13:
                                  ParentController().getCircularOther();
                                  break;
                                case 14:
                                  Get.to(()=>ResultCardOptionScreen());
                                  // TeacherController()
                                  //     .getClassList(fromResultCard: true);
                                  break;
                                case 15:
                                  TeacherController()
                                      .getClassList(fromDateSheet: true);
                                  ;
                                  break;
                                case 16:
                                  TeacherController().getBagPlanList(date: DateTime.now().add(Duration(days: 1)).toString()).then((value) {
                                    if(value!=null){
                                      Get.to(()=>TeacherBagComponentListScreen(teacherBagComponentModel: value));
                                    }
                                  });
                                  // TeacherController()
                                  //     .getClassList(fromBagComponents: true);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 9),
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
                                  Spacer(),
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
      ),
    );
  }

  markAttendanceAlert(context) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        insetPadding: EdgeInsets.all(0),
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text("I am"),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
              TeacherController().markAttendance(attendance: "P");
            },
            child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(color: Colors.grey, width: 1))),
                child: Text(
                  "Present",
                  style: TextStyle(color: Colors.green),
                )),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              TeacherController().markAttendance(attendance: "A");
            },
            child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(color: Colors.grey, width: 1))),
                child: Text("Absent", style: TextStyle(color: Colors.red))),
          )
        ]),
      ),
    );
  }
}
