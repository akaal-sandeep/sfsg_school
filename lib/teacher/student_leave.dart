import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/constants/color_constants.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/teacher/leave/student_leave_screen.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../teacher_model/student_leave_apply_list_model.dart';
import '../utility/custom_decoration.dart';

class StudentLeave extends StatefulWidget {
  StudentLeaveApplyList studentLeaveApplyList;

  StudentLeave({Key? key, required this.studentLeaveApplyList})
      : super(key: key);

  @override
  State<StudentLeave> createState() => _StudentLeaveState();
}

class _StudentLeaveState extends State<StudentLeave> {
  DateTime time = DateTime.now();

  Future getTime(DateTime dateTime) async {
    DateTime? picker = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime.now().subtract(Duration(days: 90)),
        lastDate: DateTime.now().add(Duration(days: 90)));
    return picker;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          getTime(time).then((value) {
            time = value;
            TeacherController()
                .getStudentLeaveApplyList(
                    fromDate: getTimeFormat(time), navigate: false)
                .then((value) {
              widget.studentLeaveApplyList = value;
              setState(() {});
            });
          });
        },
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(left: 30),
          decoration: BoxDecoration(
            boxShadow: myShadow,
            borderRadius: BorderRadius.circular(100),
            color: ColorConstants.themeColor,
          ),
          child: Text(
            DateFormat("dd MMM, yyyy").format(time),
            style: CommonDecoration.listStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
      body: myPadding(
          child: Column(
        children: [
          CommonHeader(
            title: "Students Leave",
            hideStudentName: true,
          ),
          smallSpace(),
          Expanded(
              child: widget.studentLeaveApplyList.data!.length.isEqual(0)
                  ? myImage(isNetwork: false, source: "assets/icons/empty.png")
                  : ListView.builder(
                      padding: EdgeInsets.only(bottom: 100),
                      itemCount: widget.studentLeaveApplyList.data!.length,
                      itemBuilder: (context, i) => GestureDetector(
                            onTap: () {
                              Get.to(() => StudentLeaveDetails(
                                  data: widget.studentLeaveApplyList.data![i],
                                  id:widget.studentLeaveApplyList.data![i].id.toString() ,
                                  rowVersion: widget.studentLeaveApplyList.data![i].rowVersion.toString(),
                                  fromDate: getTimeFormat(DateTime.parse(
                                      widget.studentLeaveApplyList.data![i].fromDate
                                          .toString())),
                                  toDate: getTimeFormat(DateTime.parse(
                                      widget.studentLeaveApplyList.data![i].toDate
                                          .toString())),
                                  reason: widget.studentLeaveApplyList.data![i].studentLeaveReasonName.toString(),
                                  totalDays:widget.studentLeaveApplyList.data![i].leaveDays.toString() ,
                                  status: widget.studentLeaveApplyList.data![i].isApproved.toString(),
                                  studentName: widget.studentLeaveApplyList.data![i].studentName.toString(),
                                  teacherRemarks: widget.studentLeaveApplyList.data![i].remarks.toString()))!.then((value){

                                TeacherController()
                                    .getStudentLeaveApplyList(
                                    fromDate: getTimeFormat(time), navigate: false)
                                    .then((value) {
                                  widget.studentLeaveApplyList = value;
                                  setState(() {});
                                });

                              });
                            },
                            child: listCard(
                                backgroundColor: widget.studentLeaveApplyList
                                    .data![i].isApproved==true?Colors.blue.withOpacity(.2):widget.studentLeaveApplyList
                                    .data![i].isRejected==true?Colors.red.withOpacity(.2):Colors.white,
                                showArrow: true,
                                imageUrl: widget.studentLeaveApplyList.data![i]
                                        .profilePictureUrlForMobileApp ??
                                    " ",
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.studentLeaveApplyList.data![i]
                                              .studentName ??
                                          "",
                                      style: CommonDecoration.listStyle,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Roll.No : ${widget.studentLeaveApplyList.data![i].rollNumber}",
                                      style: CommonDecoration.smallLabel,
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        "ADM No : ${widget.studentLeaveApplyList.data![i].admissionNumber}",
                                        style: CommonDecoration.smallLabel),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        "${widget.studentLeaveApplyList.data![i].className}[${widget.studentLeaveApplyList.data![i].sectionName}]",
                                        style: CommonDecoration.smallLabel),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        "${getTimeFormat(DateTime.parse(widget.studentLeaveApplyList.data![i].fromDate ?? ''))} - ${getTimeFormat(DateTime.parse(widget.studentLeaveApplyList.data![i].toDate ?? ''))}",
                                        style: CommonDecoration.smallLabel),
                                  ],
                                )),
                          )))
        ],
      )),
    );
  }
}
