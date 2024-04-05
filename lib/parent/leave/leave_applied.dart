import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/controller/teacher_state_controller.dart';
import 'package:web_school_manager/controller/temp_principal_controller.dart';
import 'package:web_school_manager/principal/screen/leave_details.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../utility/custom_decoration.dart';

class LeaveApplied extends StatefulWidget {
  String fromDateT;
  String toDateT;

  LeaveApplied({Key? key, required this.fromDateT, required this.toDateT})
      : super(key: key);

  @override
  State<LeaveApplied> createState() => _LeaveAppliedState();
}

class _LeaveAppliedState extends State<LeaveApplied> {
  final teacherStateController = Get.put(TeacherStateController());

  DateTime toDate = DateTime.now().subtract(Duration(days: 365));
  DateTime fromDate = DateTime.now();

  Future getTime() async {
    DateTime? picker = await showDatePicker(
        context: context,
        initialDate: fromDate,
        firstDate: DateTime.now().subtract(Duration(days: 300)),
        lastDate: DateTime.now());
    return picker;
  }

  @override
  void initState() {
    // TODO: implement initState
    toDate = DateFormat("dd MMM, yyyy").parse(widget.toDateT);
    fromDate = DateFormat("dd MMM, yyyy").parse(widget.fromDateT);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isTeacher() ? InkWell(
        onTap: () {
          TeacherController().getReasonList();
          // Get.to(()=>ApplyLeave());
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
      ) : Container(),
      body: myPadding(
          child: Column(
            children: [
              CommonHeader(title: "Leave Applied"),
              smallSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      getTime().then((value) {
                        fromDate = value;
                        if (isTeacher()) {
                          TeacherController().getEmployeeLeaveApplyList(
                              fromDate: getTimeFormat(fromDate),
                              toDate: getTimeFormat(toDate)).then((value) {
                            setState(() {});
                          });
                        } else {
                          TempPrincipalController().getEmployeeLeaveApplyList(
                              fromDate: getTimeFormat(fromDate),
                              toDate: getTimeFormat(toDate)).then((value) {
                            setState(() {});
                          });
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
                      getTime().then((value) {
                        toDate = value;
                        if (isTeacher()) {
                          TeacherController().getEmployeeLeaveApplyList(
                              fromDate: getTimeFormat(fromDate),
                              toDate: getTimeFormat(toDate)).then((value) {
                            setState(() {});
                          });
                        } else {
                          TempPrincipalController().getEmployeeLeaveApplyList(
                              fromDate: getTimeFormat(fromDate),
                              toDate: getTimeFormat(toDate)).then((value) {
                            setState(() {});
                          });
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
              SizedBox(height: 30,),


              GetBuilder(
                  init: teacherStateController,
                  builder: (context) {
                    return Expanded(
                      child: teacherStateController
                          .getEmployeeLeaveApplyListModel.data!.length
                          .isEqual(0)
                          ? myImage(
                          isNetwork: false, source: "assets/icons/empty.png")
                          : ListView.builder(
                          itemCount: teacherStateController
                              .getEmployeeLeaveApplyListModel.data!
                              .length,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: () {
                                if (!isTeacher()) {
                                  Get.to(() =>
                                      LeaveDetails(
                                        data: teacherStateController
                                            .getEmployeeLeaveApplyListModel
                                            .data![i],
                                          id:teacherStateController
                                              .getEmployeeLeaveApplyListModel
                                              .data![i].id.toString() ,
                                          rowVersion: teacherStateController
                                              .getEmployeeLeaveApplyListModel
                                              .data![i].rowVersion.toString(),
                                          fromDate: getTimeFormat(DateTime.parse(
                                          teacherStateController
                                              .getEmployeeLeaveApplyListModel
                                              .data![i].fromDate
                                              .toString())),
                                          toDate: getTimeFormat(DateTime.parse(
                                              teacherStateController
                                                  .getEmployeeLeaveApplyListModel
                                                  .data![i].toDate
                                                  .toString())),
                                          reason: teacherStateController
                                              .getEmployeeLeaveApplyListModel
                                              .data![i].employeeLeaveReasonName.toString(),
                                          totalDays:teacherStateController
                                              .getEmployeeLeaveApplyListModel
                                              .data![i].leaveDays.toString() ,
                                          status: teacherStateController
                                              .getEmployeeLeaveApplyListModel
                                              .data![i].isApproved.toString(),
                                          teacherName: teacherStateController
                                              .getEmployeeLeaveApplyListModel
                                              .data![i].employeeName.toString(),
                                          teacherRemarks: teacherStateController
                                              .getEmployeeLeaveApplyListModel
                                              .data![i].remarks.toString()));
                                }
                              },
                              child: listCard(imageUrl: "S",
                                  showImage: false,
                                  backgroundColor: teacherStateController
                                      .getEmployeeLeaveApplyListModel
                                      .data![i].isApproved==true?Colors.blue.withOpacity(.2):teacherStateController
                                      .getEmployeeLeaveApplyListModel
                                      .data![i].isRejected==true?Colors.red.withOpacity(.2):Colors.white,
                                  content: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if(!isTeacher())
                                        Column(
                                          children: [
                                            Text(teacherStateController
                                                .getEmployeeLeaveApplyListModel
                                                .data![i].employeeName
                                                .toString(),
                                                style: CommonDecoration
                                                    .listStyle),
                                            SizedBox(height: 5,),

                                          ],
                                        ),
                                      Text("${getTimeFormat(DateTime.parse(
                                          teacherStateController
                                              .getEmployeeLeaveApplyListModel
                                              .data![i].fromDate
                                              .toString()))} - ${getTimeFormat(
                                          DateTime.parse(teacherStateController
                                              .getEmployeeLeaveApplyListModel
                                              .data![i].toDate
                                              .toString()))}",
                                          style: CommonDecoration.listStyle),
                                      SizedBox(height: 5,),
                                      Text(teacherStateController
                                          .getEmployeeLeaveApplyListModel
                                          .data![i].employeeLeaveReasonName
                                          .toString(),
                                          style: CommonDecoration.smallLabel),
                                      Text("Your Remarks: " +
                                          teacherStateController
                                              .getEmployeeLeaveApplyListModel
                                              .data![i].remarks
                                              .toString(),
                                          style: CommonDecoration.smallLabel),
                                    ],
                                  )),
                            );
                          }),
                    );
                  }
              )
            ],
          )),
    );
  }
}
