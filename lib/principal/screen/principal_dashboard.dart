import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/controller/drawer_controller.dart';
import 'package:web_school_manager/controller/parent_controller.dart';
import 'package:web_school_manager/controller/principal_controller.dart';
import 'package:web_school_manager/controller/temp_principal_controller.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/controller/user_controller.dart';
import 'package:web_school_manager/drawer/parent_drawer.dart';
import 'package:web_school_manager/local_storage/local_storage.dart';
import 'package:web_school_manager/principal/screen/principal_profile.dart';
import 'package:web_school_manager/principal/screen/teacher_push_notification.dart';
import 'package:web_school_manager/principal_model/principal_module_list_model.dart';
import 'package:web_school_manager/principal_model/principal_profile_model.dart';
import 'package:web_school_manager/principal_model/student_teacher_attendance_model.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

class PrincipalDashboard extends StatefulWidget {
  StudentTeacherAttendanceModel studentTeacherAttendanceModel;
  PrincipalProfileModel principalProfileModel;

  PrincipalDashboard(
      {Key? key,
      required this.studentTeacherAttendanceModel,
      required this.principalProfileModel})
      : super(key: key);

  @override
  State<PrincipalDashboard> createState() => _PrincipalDashboardState();
}

class _PrincipalDashboardState extends State<PrincipalDashboard> {
  List _dashList = [
    {"name": "Profile", "value": 0},
    {"name": "Students Attendance", "value": 1},
    {"name": "Teachers Attendance", "value": 2},
    {"name": "Lesson Plan", "value": 3},
    // {"name": "Classes", "value": 4},
    {"name": "Home Work", "value": 5},
    {"name": "Syllabus", "value": 6},
    {"name": "Teacher Leave Approval", "value": 7},
    {"name": "View Students Remarks", "value": 8},
    {"name": "Fixed Appointments", "value": 9},
    {"name": "Teacher Push Notification", "value": 10},
    {"name": "Parent Push Notification", "value": 11},
    {"name": "Circular", "value": 12},
    {"name": "Date Sheet", "value": 13},
    {"name": "Bag Components", "value": 14},
  ];

  List<String> _dashImages = [
    "assets/icons/profile.png",
    "assets/icons/attendance.png",
    "assets/icons/teacher-attendance.png",
    "assets/icons/learning-plan.png",
    // "assets/icons/classes.png",
    "assets/icons/home-work.png",
    "assets/icons/syllabus.png",
    "assets/icons/teacher-leave.png",
    "assets/icons/student-remarks.png",
    "assets/icons/appointment.png",
    "assets/icons/teacher_notification.png",
    "assets/icons/parent_notification.png",
    "assets/icons/circular.png",
    "assets/icons/date-sheet.png",
    "assets/icons/bag_components.png",
  ];

  var dataMapStudent = <String, double>{
    "0 Present": 5,
    "0 Absent": 3,
    "0 Leave": 3,
    "23 Pending": 2,
  };
  var dataMapTeacher = <String, double>{
    "0 Present": 5,
    "0 Absent": 3,
    "0 Leave": 3,
    "23 Pending": 2,
  };

  final colorList = <Color>[
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.grey,
  ];

  ChartType? chartType = ChartType.disc;
  bool showCenterText = true;
  double ringStrokeWidth = 32;
  double chartLegendSpacing = 32;

  bool showLegendsInRow = false;
  bool showLegends = true;
  bool showLegendLabel = false;

  bool showChartValueBackground = true;
  bool showChartValues = true;
  bool showChartValuesInPercentage = false;
  bool showChartValuesOutside = false;

  bool showGradientColors = false;

  Future<bool> checkExit() async {
    bool myExit = false;
    var exit = await switchDialog(exit: myExit).then((value) {
      return value;
    });

    return exit;
  }

  int key = 0;

  initDataMapping() {
    dataMapStudent = {
      "${widget.studentTeacherAttendanceModel.data!.table![0].pRESENTCOUNT ?? ""}" +
              " Present":
          (widget.studentTeacherAttendanceModel.data!.table![0].pRESENTCOUNT /
                      widget.studentTeacherAttendanceModel.data!.table![0]
                          .tOTALSTUDENTS ??
                  "") *
              100,
      "${widget.studentTeacherAttendanceModel.data!.table![0].aBSENTCOUNT ?? ""}" +
              " Absent":
          (widget.studentTeacherAttendanceModel.data!.table![0].aBSENTCOUNT /
                      widget.studentTeacherAttendanceModel.data!.table![0]
                          .tOTALSTUDENTS ??
                  "") *
              100,
      "${widget.studentTeacherAttendanceModel.data!.table![0].lEaveCount ?? ""}" +
              " Leave":
          (widget.studentTeacherAttendanceModel.data!.table![0].aBSENTCOUNT /
                      widget.studentTeacherAttendanceModel.data!.table![0]
                          .tOTALSTUDENTS ??
                  "") *
              100,
      "${widget.studentTeacherAttendanceModel.data!.table![0].pENDINGATTENDANCE ?? ""}" +
          " Pending": (widget.studentTeacherAttendanceModel.data!.table![0]
                      .pENDINGATTENDANCE /
                  widget.studentTeacherAttendanceModel.data!.table![0]
                      .tOTALSTUDENTS ??
              "") *
          100,
    };
    dataMapTeacher = {
      "${widget.studentTeacherAttendanceModel.data!.table1![0].pRESENTCOUNT ?? ""}" +
              " Present":
          (widget.studentTeacherAttendanceModel.data!.table1![0].pRESENTCOUNT /
                      widget.studentTeacherAttendanceModel.data!.table1![0]
                          .tOTALEMPLOYEES ??
                  "") *
              100,
      "${widget.studentTeacherAttendanceModel.data!.table1![0].aBSENTCOUNT ?? ""}" +
              " Absent":
          (widget.studentTeacherAttendanceModel.data!.table1![0].aBSENTCOUNT /
                      widget.studentTeacherAttendanceModel.data!.table1![0]
                          .tOTALEMPLOYEES ??
                  "") *
              100,
      "${widget.studentTeacherAttendanceModel.data!.table1![0].lEaveCount ?? ""}" +
              " Leave":
          (widget.studentTeacherAttendanceModel.data!.table1![0].lEaveCount /
                      widget.studentTeacherAttendanceModel.data!.table1![0]
                          .tOTALEMPLOYEES ??
                  "") *
              100,
      "${widget.studentTeacherAttendanceModel.data!.table1![0].pENDINGATTENDANCE ?? ""}" +
          " Pending": (widget.studentTeacherAttendanceModel.data!.table1![0]
                      .pENDINGATTENDANCE /
                  widget.studentTeacherAttendanceModel.data!.table1![0]
                      .tOTALEMPLOYEES ??
              "") *
          100,
    };
  }

  PrincipalModuleListModel principalModuleListModel =
      PrincipalModuleListModel();

  Map<dynamic, dynamic> functionList = {};
  List<int> removeIndex = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    principalModuleListModel = LocalStorage().readPrincipalModuleList();
    initDataMapping();

    myLog(label: "principal model", value: principalModuleListModel.toJson());
    if (principalModuleListModel
            .data!.principalLessonManagementModuleApplicable ==
        false) {
      removeIndex.add(3);
    }
    if (principalModuleListModel.data!.principalHomeWorkModuleApplicable ==
        false) {
      removeIndex.add(4);
    }
    if (principalModuleListModel.data!.principalSyllabusModuleApplicable ==
        false) {
      removeIndex.add(5);
    }

    if (principalModuleListModel
            .data!.principalTeacherLeaveApprovalModuleApplicable ==
        false) {
      removeIndex.add(6);
    }
    if (principalModuleListModel
            .data!.principalStudentRemarksModuleApplicable ==
        false) {
      removeIndex.add(7);
    }
    if (principalModuleListModel.data!.principalAppointmentModuleApplicable ==
        false) {
      removeIndex.add(8);
    }
    if (principalModuleListModel
            .data!.principalEmployeeNotificationModuleApplicable ==
        false) {
      removeIndex.add(9);
    }
    if (principalModuleListModel
            .data!.principalParentNotificationModuleApplicable ==
        false) {
      removeIndex.add(10);
    }
    if (principalModuleListModel.data!.principalCircularModuleApplicable ==
        false) {
      removeIndex.add(11);
    }

    for (int i = removeIndex.length - 1; i >= 0; i--) {
      _dashList.removeAt(removeIndex[i]);
      _dashImages.removeAt(removeIndex[i]);
      myLog(label: "removed", value: removeIndex[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    initDataMapping();
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
                      title:
                          widget.principalProfileModel.data?.displayName ?? "",
                      showDrawer: true,
                      hideStudentName: true),
                  smallSpace(),
                  InkWell(
                    onTap: () {
                      ParentDrawerController().getNotificationList();
                      // Get.to(TimelineScreen());
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          smallSpace(),
                          _pieContainer(),
                          _dashGridView(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }

  /*==================================================Pie Chart Container============================================================================*/

  Widget _pieContainer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: myShadow,
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Overall Attendance Summary",
              style: CommonDecoration.dashBoardList,
            ),
            smallSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _pieChart(
                    title: "Total\nStudents\n" +
                        "${widget.studentTeacherAttendanceModel.data!.table![0].tOTALSTUDENTS ?? ""}",
                    dataMap: dataMapStudent),
                SizedBox(
                  width: 20,
                ),
                _pieChart(
                    title: "Total\nTeachers\n" +
                        "${widget.studentTeacherAttendanceModel.data!.table1![0].tOTALEMPLOYEES ?? ""}",
                    dataMap: dataMapTeacher),
              ],
            )
          ],
        ),
      ),
    );
  }

/*==================================================Pie Chart View============================================================================*/
  Widget _pieChart({title, dataMap}) {
    return PieChart(
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 25,
      chartRadius: MediaQuery.of(context).size.width / 3.9,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 10,
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendShape: BoxShape.circle,
        legendTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerText: title,
      centerTextStyle: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: false,
        showChartValues: false,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
      // gradientList: ---To add gradient colors--// emptyColorGradient: ---Empty Color gradient---
    );
  }

  /*================================================Dashboard Grid View=============================================================*/
  Widget _dashGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 20),
      itemCount: _dashList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 120,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            switch (_dashList[index]['value']) {
              case 0:
                Get.to(() => PrincipalProfile(
                      principalProfileModel: widget.principalProfileModel,
                    ));
                break;
              case 1:
                PrincipalController().getStudentAttendanceDetails();
                break;
              case 2:
                PrincipalController().getTeacherList();
                break;
              case 3:
                TempPrincipalController().getLessonPlanList();
                break;
              case 4:
                break;
              case 5:
                TeacherController().getClassList(fromHomeWork: true);
                break;
              case 6:
                TeacherController().getClassList();
                break;
              case 7:
                TempPrincipalController().getEmployeeLeaveApplyList();
                break;
              case 8:
                TeacherController().getStudentRemarks(navigate: true);
                break;
              case 9:
                PrincipalController().getFixedAppointmentListForPrincipal(
                    fromdate: DateTime.now().toString());
                break;
              case 10:
                Get.to(() => TeacherPushNotification());
                break;
              case 11:
                PrincipalController().getClassListForNotification();
                break;
              case 12:
                ParentController().getCircularOther();
                break;
              case 13:
                TeacherController().getClassList(fromDateSheet: true);
                break;
              case 14:
                TeacherController().getClassList(fromBagComponents: true);
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
                Image.asset(_dashImages[index], height: 60),
                SizedBox(
                  height: 10,
                ),
                Text(
                  _dashList[index]['name'].toString(),
                  textAlign: TextAlign.center,
                  style: CommonDecoration.dashBoardList,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
