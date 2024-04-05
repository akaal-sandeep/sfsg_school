import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/controller/parent_controller.dart';
import 'package:web_school_manager/controller/teacher_state_controller.dart';
import 'package:web_school_manager/teacher/lession/approved.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../teacher_model/get_lesson_plan_list.dart';


class StudentLessonPlan extends StatefulWidget {
  String fromDate;
  String toDate;

  StudentLessonPlan({Key? key, required this.toDate, required this.fromDate})
      : super(key: key);

  @override
  State<StudentLessonPlan> createState() => _StudentLessonPlanState();
}

class _StudentLessonPlanState extends State<StudentLessonPlan>
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
        firstDate: fromDate.subtract(Duration(days: 365)),
        lastDate: DateTime.now().add(Duration(days: 90)));
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
                        ParentController().getLessonPlanListForStudent(
                            navigate: false,
                            fromDate: DateFormat("MMM dd, yyyy").format(fromDate),
                            toDate: DateFormat("MMM dd, yyyy").format(toDate));
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
                        ParentController().getLessonPlanListForStudent(
                            navigate: false,
                            fromDate: DateFormat("dd-MM-yyyy").format(fromDate),
                            toDate: DateFormat("dd-MM-yyyy").format(toDate));
                        setState(() {});
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
              SizedBox(height: 20,),
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
                        return  ApprovedLesson(data: approvedList);
                      }))
            ],
          )),
    );
  }
}
