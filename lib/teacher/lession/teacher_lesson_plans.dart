import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/controller/teacher_state_controller.dart';
import 'package:web_school_manager/teacher/lession/approved.dart';
import 'package:web_school_manager/teacher/lession/create_lession.dart';
import 'package:web_school_manager/teacher/lession/pending.dart';
import 'package:web_school_manager/teacher/lession/rejected.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../common-functions.dart';
import '../../controller/temp_principal_controller.dart';
import '../../teacher_model/get_lesson_plan_list.dart';

import '../../utility/custom_decoration.dart';

class TeacherLessonPlans extends StatefulWidget {
  String fromDate;
  String toDate;

  TeacherLessonPlans({Key? key, required this.toDate, required this.fromDate})
      : super(key: key);

  @override
  State<TeacherLessonPlans> createState() => _TeacherLessonPlansState();
}

class _TeacherLessonPlansState extends State<TeacherLessonPlans>
    with TickerProviderStateMixin {
  ///------controller-----------
  late TabController tabController;

  final teacherStateController = Get.put(TeacherStateController());

  ///------------------------------

  DateTime toDate = DateTime.now().subtract(Duration(days: 365));
  DateTime fromDate = DateTime.now();

  Future getTime({required DateTime dateTime}) async {
    DateTime? picker = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: fromDate,
        lastDate: DateTime.now().add(Duration(days: 365)));
    return picker;
  }

  List<Data> pendingList = [];
  List<Data> approvedList = [];
  List<Data> rejectList = [];

  @override
  void initState() {
    toDate = DateFormat("MMM dd, yyyy").parse(widget.toDate);
    fromDate = DateFormat("MMM dd, yyyy").parse(widget.fromDate);
    tabController = TabController(length: 3, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isTeacher()
          ? InkWell(
        onTap: () {
          TeacherController().returnTeacherClassList().then((classList) {
            TeacherController()
                .teacherClassHomeWork(
                classMasterid:
                classList.data![0].classMasterId.toString(),
                classSectionMasterid: classList
                    .data![0].classSectionMasterId
                    .toString(),
                className: classList.data![0].className ?? "",
                navigate: false)
                .then((subjectList) {
              Get.to(() => CreateLesson(
                subjectList: subjectList,
                classList: classList,
              ));
            });
          });
        },
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            boxShadow: myShadow,
            borderRadius: BorderRadius.circular(100),
            color: Colors.blue,
          ),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      )
          : Container(),
      body: myPadding(
          child: Column(
            children: [
              CommonHeader(
                title: "Lesson Plan",
                hideStudentName: true,
              ),
              largeSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      getTime(dateTime: fromDate).then((value) {
                        fromDate = value;
                        setState(() {});
                        if(isTeacher()){
                          TeacherController().getLessonPlanList(
                              navigate: false,
                              fromDate: DateFormat("MMM dd, yyyy").format(fromDate),
                              toDate: DateFormat("MMM dd, yyyy").format(toDate));
                        }else{
                          TempPrincipalController().getLessonPlanList(
                              navigate: false,
                              fromDate: DateFormat("MMM dd, yyyy").format(fromDate),
                              toDate: DateFormat("MMM dd, yyyy").format(toDate));
                        }

                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Text(DateFormat("dd MMM, yyyy").format(fromDate)),
                          Icon(
                            Icons.calendar_month,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ),
                  Text("-"),
                  InkWell(
                    onTap: () {
                      getTime(dateTime: toDate).then((value) {
                        toDate = value;
                        if(isTeacher()){
                          TeacherController().getLessonPlanList(
                              navigate: false,
                              fromDate: DateFormat("MMM dd, yyyy").format(fromDate),
                              toDate: DateFormat("MMM dd, yyyy").format(toDate));
                        }else{
                          TempPrincipalController().getLessonPlanList(
                              navigate: false,
                              fromDate: DateFormat("MMM dd, yyyy").format(fromDate),
                              toDate: DateFormat("MMM dd, yyyy").format(toDate));
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Text(DateFormat("dd MMM, yyyy").format(toDate)),
                          Icon(
                            Icons.calendar_month,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              TabBar(
                labelColor: Colors.black,
                controller: tabController,
                tabs: [
                  Tab(
                    child: Text(
                      "Pending",
                      style: CommonDecoration.smallLabel
                          .copyWith(fontSize: 12, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Approved",
                      style: CommonDecoration.smallLabel
                          .copyWith(fontSize: 12, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Rejected",
                      style: CommonDecoration.smallLabel
                          .copyWith(fontSize: 12, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              Expanded(
                  child: GetBuilder(
                      init: teacherStateController,
                      builder: (context) {
                        approvedList = [];
                        rejectList = [];
                        pendingList = [];
                        for (int i = 0;
                        i <
                            teacherStateController
                                .getLessonPlanListModel.data!.length;
                        i++) {
                          Data data = teacherStateController
                              .getLessonPlanListModel.data![i];
                          if (data.isApproved ?? false) {
                            approvedList.add(data);
                          } else if (data.isRejected ?? false) {
                            rejectList.add(data);
                          } else {
                            pendingList.add(data);
                          }
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: TabBarView(controller: tabController, children: [
                            PendingLesson(
                              data: pendingList,
                            ),
                            ApprovedLesson(data: approvedList),
                            RejectedLesson(data: rejectList),
                          ]),
                        );
                      }))
            ],
          )),
    );
  }
}
