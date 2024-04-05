import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/button.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../common-functions.dart';
import '../../controller/parent_controller.dart';
import '../../parent/student_attendence.dart';
import '../../teacher_model/class_attendance_model.dart';

class ClassAttendance extends StatefulWidget {
  ClassAttendanceModel model;

  ClassAttendance({Key? key, required this.model}) : super(key: key);

  @override
  State<ClassAttendance> createState() => _ClassAttendanceState();
}

class _ClassAttendanceState extends State<ClassAttendance> {
  List attendance = [];
  String sortBy = "Roll No.";

  sortByAlphabet() {
    widget.model.data!.studentList!.sort((a, b) {
      return a.studentName
          .toString()
          .toLowerCase()
          .compareTo(b.studentName.toString().toLowerCase());
    });
    setState(() {});
  }

  sortByAdmission() {
    widget.model.data!.studentList!.sort((a, b) {
      return a.admissionNo
          .toString()
          .toLowerCase()
          .compareTo(b.admissionNo.toString().toLowerCase());
    });
    setState(() {});
  }

  sortByRollNo() {
    widget.model.data!.studentList!.sort((a, b) {
      return a.rollNo
          .toString()
          .toLowerCase()
          .compareTo(b.rollNo.toString().toLowerCase());
    });
    setState(() {});
  }

  @override
  void initState() {
    for (int i = 0; i < 10; i++) {
      attendance.add("Present");
    }
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
            title: "Class Attendance",
            hideStudentName: true,
          ),
          smallSpace(),
          Text(
            DateFormat("dd MMM, yyyy").format(DateTime.now()),
            style: CommonDecoration.subHeaderStyle,
          ),
          smallSpace(),
          Row(
            children: [
              sortByOption(sortBySelected: "Roll No."),
              SizedBox(
                width: 10,
              ),
              sortByOption(sortBySelected: "ADM No."),
              SizedBox(
                width: 10,
              ),
              sortByOption(sortBySelected: "Name"),
            ],
          ),
          smallSpace(),
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 70),
                  itemCount: widget.model.data?.studentList?.length ?? 0,
                  itemBuilder: (context, i) {
                    StudentList data =
                        widget.model.data?.studentList![i] ?? StudentList();
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: myShadow),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect
                                (
                                
                                child: Container(
                                  height: 50,
                                  width: 50,

                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: myImage(isNetwork: true, source: "${data.studentProfilePicturePath}"),
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${data.studentName}(${data.admissionNo})",
                                    style: CommonDecoration.listStyle,
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Roll.no: ${data.rollNo}",
                                    style: CommonDecoration.smallLabel,
                                  )
                                ],
                              ),

                            ],
                          ),
                          smallSpace(),
                          InkWell(
                              onTap:(){
                                ParentController()
                                    .getStudentAttendance(
                                  admissionNumber: widget.model.data!.studentList![i].admissionNo,
                                    month: DateTime.now().month.toString(),
                                    year: DateTime.now().year.toString())
                                    .then((value) {
                                  Get.to(() => Attendance(
                                    studentAttendanceModel: value,
                                    admissionNumber: widget.model.data!.studentList![i].admissionNo ,
                                  ));
                                });
                              },
                              child: Text("View Attendance >", style: CommonDecoration.smallLabel.copyWith(color: Colors.blue),)),
                          smallSpace(),
                          Row(
                            children: [
                              attendanceOption(option: "H", index: i,
                                  boxColor:  widget.model.data!.studentList![i].attendanceStatus == "H" ? Colors.yellow : Colors.white,
                              borderColor:  widget.model.data!.studentList![i].attendanceStatus == "H" ? Colors.yellow : Colors.grey
                              ),

                              SizedBox(
                                width: 10,
                              ),
                              attendanceOption(option: "L", index: i,
                                  boxColor:  widget.model.data!.studentList![i].attendanceStatus == "L" ? Colors.blue : Colors.white,
                                  borderColor:  widget.model.data!.studentList![i].attendanceStatus == "L" ? Colors.blue : Colors.grey
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              attendanceOption(option: "A", index: i,
                                  boxColor:  widget.model.data!.studentList![i].attendanceStatus == "A" ? Colors.red : Colors.white,
                                  borderColor:  widget.model.data!.studentList![i].attendanceStatus == "A" ? Colors.red : Colors.grey
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              attendanceOption(option: "P", index: i,
                                  boxColor:  widget.model.data!.studentList![i].attendanceStatus == "P" ? Colors.green : Colors.white,
                                  borderColor:  widget.model.data!.studentList![i].attendanceStatus == "P" ? Colors.green : Colors.grey
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  })),
          Row(
            children: [
              Expanded(
                  child: InkWell(
                onTap: () {
                  for (int? i = 0; i!<widget.model.data!.studentList!.length; i++) {
                    widget.model.data!.studentList![i].attendanceStatus = "P";
                  }
                  setState(() {});
                },
                child: MyButton(
                    text: "Reset", borderRadius: 10, color: Colors.blue),
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: InkWell(
                    onTap: (){
                      TeacherController().saveStudentDailyAttendance(classAttendanceModel:  widget.model);

                    },
                    child: MyButton(
                        text: "Save", borderRadius: 10, color: Colors.blue),
                  )),
            ],
          ),
          smallSpace(),
        ],
      )),
    );
  }

  attendanceOption({required String option, required int index,required Color boxColor,required Color borderColor}) {
    return Expanded(
        child: InkWell(
      onTap: () {
        widget.model.data!.studentList![index].attendanceStatus = option;
        setState(() {});
      },
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color:boxColor,/* widget.model.data!.studentList![index].attendanceStatus == option ? Colors.blue : Colors.white,*/
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color:
                borderColor,
               /* widget.model.data!.studentList![index].attendanceStatus == option ? Colors.blue : Colors.grey*/)),
        child: Text(
          findLabel(option),
          style: widget.model.data!.studentList![index].attendanceStatus == option
              ? CommonDecoration.smallLabel.copyWith(color: Colors.white)
              : CommonDecoration.smallLabel,
        ),
      ),
    ));
  }



  sortByOption({required String sortBySelected}) {
    return Expanded(
        child: InkWell(
      onTap: () {
        sortBy = sortBySelected;
        setState(() {});
        if(sortBy=="Name"){
          sortByAlphabet();
        }
        if(sortBy=="ADM No."){
          sortByAdmission();
        }
        if(sortBy=="Roll No."){
          sortByRollNo();
        }
      },
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
              color: sortBy == sortBySelected ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.blue)),
          child: Text(
            sortBySelected,
            style: CommonDecoration.smallLabel.copyWith(
                color: sortBy == sortBySelected ? Colors.white : Colors.blue),
          )),
    ));
  }
}
