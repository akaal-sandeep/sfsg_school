import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/controller/principal_controller.dart';

import '../common-functions.dart';
import '../controller/coordinator_controller.dart';
import '../controller/user_controller.dart';
import '../drawer/parent_drawer.dart';
import '../principal/screen/student_attendance_summary.dart';
import '../principal_model/student_attendance_details.dart';
import '../teacher_model/teacher_class_list_model.dart';
import '../utility/custom_decoration.dart';
import '../utility/helper_widget.dart';
import '../widget/header.dart';

class CoordinatorDashboard extends StatelessWidget {
  CoordinatorDashboard({Key? key}) : super(key: key);

  List _icon = [
    "assets/icons/class-room.png",
    "assets/icons/home-work.png",
    "assets/icons/attendance.png",
    "assets/icons/teacher-attendance.png",
    "assets/icons/bag_components.png",
  ];

  List _label = [
    "Pending Homework",
    "Uploaded Homework",
    "Student Attendance",
    'Teachers Attendance'
    "Bag Components",
  ];

  Future<bool> checkExit() async {
    bool myExit = false;
    var exit = await switchDialog(exit: myExit).then((value) {
      return value;
    });
    return exit;
  }

  getStudentList() {
    CoordinatorController()
        .getClassList(navigate: false, uploaded: false)
        .then((coordinatorClass) {
      TeacherClassesListModel teacherClassListModel = TeacherClassesListModel();
      teacherClassListModel = coordinatorClass;
      PrincipalController()
          .getStudentAttendanceDetails(fromCoordinated: true)
          .then((studentList) {
        StudentAttendanceDetailsModel studentAttendanceDetails =
            StudentAttendanceDetailsModel();
        studentAttendanceDetails = studentList;
        StudentAttendanceDetailsModel coordinatorClassList =
            StudentAttendanceDetailsModel();
        coordinatorClassList.data = [];
        for (int i = 0; i < teacherClassListModel.data!.length; i++) {
          for (int j = 0; j < studentAttendanceDetails.data!.length; j++) {
            if (teacherClassListModel.data![i].classMasterId ==
                    studentAttendanceDetails.data![j].cLASSMASTERID &&
                teacherClassListModel.data![i].classSectionMasterId ==
                    studentAttendanceDetails.data![j].cLASSSECTIONMASTERID) {
              coordinatorClassList.data!.add(studentAttendanceDetails.data![j]);
            }
          }
        }
        Get.to(() => StudentAttendanceSummary(
              studentAttendanceDetails: coordinatorClassList,
              fromCoordinator: true,
            ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
            children: [
              CommonHeader(
                title: "Coordinator",
                showDrawer: true,
                hideStudentName: true,
              ),
              largeSpace(),
              Expanded(
                child: AnimationLimiter(
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    itemCount: _label.length,
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
                                switch (index) {
                                  case 0:
                                    CoordinatorController()
                                        .getClassList(uploaded: false);
                                    break;
                                  case 1:
                                    CoordinatorController()
                                        .getClassList(uploaded: true);
                                    break;
                                  case 2:
                                    getStudentList();
                                    break;
                                  case 3:
                                    PrincipalController().getTeacherList();;
                                    break;
                                  case 4:
                                    CoordinatorController()
                                        .getClassListForBagComponent();
                                    break;
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 14),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: myShadow),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      _icon[index],
                                      height: 60,
                                    ),
                                    Spacer(),
                                    Text(
                                      _label[index],
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
        ));
  }
}
