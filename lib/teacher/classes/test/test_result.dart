import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/controller/teacher_state_controller.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/dialog.dart';
import 'package:web_school_manager/widget/header.dart';
import 'package:web_school_manager/widget/mytextfield.dart';

import '../../../common-functions.dart';
import '../../../constants/string_constants.dart';
import '../../../controller/teacher_controller.dart';
import '../../../teacher_model/class_test_model.dart';
import '../../../teacher_model/mange_class_test_main.dart';
import '../../../utility/custom_decoration.dart';
import '../../../widget/button.dart';

class TestResult extends StatefulWidget {
 
  bool filled;
  int selectedSubjectIndex;
  String selectedDate, topic, maxMarks, subject, className, subjectName;
  ManageClassTestMainModel model;
  ClassTestListModel classTestListModel;

  TestResult(
      {Key? key,
        required this.filled,
      required this.classTestListModel,
      required this.selectedSubjectIndex,
      required this.model,
      required this.maxMarks,
      required this.topic,
      required this.selectedDate,
      required this.subject,
      required this.className,
      required this.subjectName})
      : super(key: key);

  @override
  State<TestResult> createState() => _TestResultState();
}


class _TestResultState extends State<TestResult> {
  final teacherStateController = Get.put(TeacherStateController());

  String sortBy = "Roll No.";

  sortByOption({required String sortBySelected}) {
    return Expanded(
        child: InkWell(
          onTap: () {
            sortBy = sortBySelected;
            setState(() {});
            if(sortBy=="Name"){
              teacherStateController.sort(StringConstants.sortByAlphabet);
            }
            if(sortBy=="ADM No."){
              teacherStateController.sort(StringConstants.sortByAdmission);
            }
            if(sortBy=="Roll No."){
              teacherStateController.sort(StringConstants.sortByRollNo);
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


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GetBuilder(
        init: teacherStateController,
        builder: (c) {
          return InkWell(
            onTap: () {

              showDialog(context: context, builder: (context)=>AlertDialogCustom(
                icon: Icons.warning_amber,
                iconColor: Colors.red,
                description: "Do you want to lock this test?",
                showNegative: true,
                positiveCall: (){
                  Navigator.pop(context);
                  if(teacherStateController
                      .manageClassTestInvModel.locked||!widget.filled)return;

                  TeacherController().lockClassTest(id: teacherStateController
                      .manageClassTestInvModel.data!.id.toString(), isLocked: true.toString(), rowVersion: teacherStateController
                      .manageClassTestInvModel.data!.rowVersion.toString()).then((value){
                    if(value){
                      TeacherController()
                          .getTeacherClassTestListBySubject(
                          classMasterId: widget
                              .model.data!.classMasterId
                              .toString(),
                          navigate: false,
                          classSectionMasterId: widget
                              .model.data!.classSectionMasterId
                              .toString(),
                          subjectMasterId: widget
                              .model.data!.subjectMasterId
                              .toString(),
                          subjectName:
                          widget.model.data!.subjectName.toString(),
                          className: widget.className);
                    }
                  });
                },
                negativeCall: (){
                  Navigator.pop(context);
                },
              ));



            },
            child: Container(
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              ),
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  boxShadow: myShadow,
                  borderRadius: BorderRadius.circular(100),
                  color:teacherStateController
                      .manageClassTestInvModel.locked||!widget.filled?Colors.grey: Colors.red,
                ),
                child: Icon(
                  teacherStateController
                      .manageClassTestInvModel.locked?Icons.lock: Icons.lock_open,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }
      ),
      body: myPadding(
          child: Column(
        children: [
          CommonHeader(
            title: "Student Marks",
            hideStudentName: true,
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
              child: GetBuilder(
                init: teacherStateController,
                builder: (context) {
                  return ListView.builder(
                      padding: EdgeInsets.only(bottom: 100),
                      itemCount: teacherStateController
                          .manageClassTestInvModel.data!.studentList!.length,
                      itemBuilder: (context, i) {
                        return AbsorbPointer(
                            absorbing: (teacherStateController
                                .manageClassTestInvModel.locked | widget.filled),
                            child: resultCard(i:i));
                      });
                }
              )),
          GetBuilder(
            init: teacherStateController,
            builder: (context) {
              return Row(
                children: [
                  Expanded(
                      child: AbsorbPointer(
                    absorbing: teacherStateController
                        .manageClassTestInvModel.locked || !widget.filled,
                    child: InkWell(
                      onTap: () {
                        widget.filled = false;
                        setState(() {});
                      },
                      child: MyButton(
                          text: "Edit",
                          borderRadius: 0,
                          color: (teacherStateController
                                    .manageClassTestInvModel.locked || !widget.filled)
                              ? Colors.grey
                              : Colors.blue),
                    ),
                  )),
                  // SizedBox(
                  //   width: 15,
                  // ),
                  Expanded(
                      child: AbsorbPointer(
                    absorbing: teacherStateController
                                    .manageClassTestInvModel.locked || widget.filled,
                    child: InkWell(
                      onTap: () {
                        final teacherStateController =
                            Get.put(TeacherStateController());

                        if (widget.selectedSubjectIndex != 100) {
                          teacherStateController.manageClassTestInvModel.data!
                                  .subjectMasterId =
                              widget.classTestListModel
                                  .data![widget.selectedSubjectIndex].id
                                  .toString();
                        }

                        TeacherController()
                            .saveClassTest(
                                model: widget.model,
                                manageClassTestInvModel: teacherStateController
                                    .manageClassTestInvModel,
                                selectedDate: widget.selectedDate,
                                subject: widget.subject,
                                topic: widget.topic,
                                maxMarks: widget.maxMarks)
                            .then((value) {
                          if (value) {
                            widget.filled = true;
                            TeacherController()
                                .manageClassTestMain(
                                    id: teacherStateController
                                        .manageClassTestMainModel.data!.id
                                        .toString(),
                                    className: widget.className.toString(),
                                    subjectName: widget.subjectName,
                                    navigate: false,
                                    isLocked: teacherStateController
                                    .manageClassTestInvModel.locked)
                                .then((value) {
                              TeacherController()
                                  .getTeacherClassTestListBySubject(
                                      classMasterId: widget
                                          .model.data!.classMasterId
                                          .toString(),
                                      navigate: false,
                                      classSectionMasterId: widget
                                          .model.data!.classSectionMasterId
                                          .toString(),
                                      subjectMasterId: widget
                                          .model.data!.subjectMasterId
                                          .toString(),
                                      subjectName:
                                          widget.model.data!.subjectName.toString(),
                                      className: widget.className)
                                  .then((v) => {
                                        TeacherController()
                                            .manageClassTestInv(
                                                model: teacherStateController
                                                    .manageClassTestMainModel,
                                                isLocked: teacherStateController
                                    .manageClassTestInvModel.locked,
                                                filled: widget.filled,
                                                classTestListModel:
                                                    widget.classTestListModel,
                                                selectedSubjectIndex:
                                                    widget.selectedSubjectIndex,
                                                navigate: false)
                                            .then((value) => {
                                                  setState(() {}),
                                                })
                                      });
                            });
                          }
                        });
                      },
                      child: MyButton(
                          text: "Update",
                          borderRadius: 0,
                          color: (teacherStateController
                                    .manageClassTestInvModel.locked || widget.filled)
                              ? Colors.grey
                              : Colors.blue),
                    ),
                  )),
                ],
              );
            }
          ),
          SizedBox(height: 5,)
        ],
      )),
    );
  }

  Widget resultCard({required int i}) {
    TextEditingController marksController = TextEditingController();
    TextEditingController remarksController = TextEditingController();
    FocusNode remarksFocus = FocusNode();
    FocusNode marksFocus = FocusNode();



    marksController.text = (teacherStateController
        .manageClassTestInvModel.data!.studentList![i].marksObtained??"0").toString();
    remarksController.text = teacherStateController
        .manageClassTestInvModel.data!.studentList![i].remarks
        .toString();
    marksController.addListener(() {
      if (marksController.text.isNotEmpty) {
        if (teacherStateController
                .manageClassTestInvModel.data!.maximumMarks <
            double.parse(marksController.text)) {
          showMessage(msg: "Please enter valid marks");
          marksController.clear();
          return;
        }
        teacherStateController.manageClassTestInvModel.data!
            .studentList![i].marksObtained = marksController.text;
        double percentage = (double.parse(teacherStateController
                    .manageClassTestInvModel
            .data!
                    .studentList![i]
                    .marksObtained
                    .toString()) /
                double.parse(teacherStateController
                    .manageClassTestInvModel.data!.maximumMarks
                    .toString())) * 100;
        teacherStateController.manageClassTestInvModel.data!.studentList![i]
            .marksPercentage = percentage;
      }
    });

    remarksController.addListener(() {
      teacherStateController.manageClassTestInvModel.data!.studentList![i]
          .remarks = remarksController.text;
    });

    return AbsorbPointer(
      absorbing: teacherStateController
                                .manageClassTestInvModel.locked,
      child: listCard(
        imageUrl: teacherStateController.manageClassTestInvModel.data!
            .studentList![i].studentProfilePicturePath
            .toString(),
        showArrow: false,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                teacherStateController
                    .manageClassTestInvModel.data!.studentList![i].name
                    .toString(),
                style: CommonDecoration.listStyle),
            greyLine(),

            GetBuilder(
                init: teacherStateController,
                builder: (context) {
                  return Text(
                      "Percentage : ${teacherStateController.manageClassTestInvModel.data!.studentList![i].marksPercentage==null?"0":double.parse(teacherStateController.manageClassTestInvModel.data!.studentList![i].marksPercentage.toString()).toStringAsFixed(1)}%",
                      style: CommonDecoration.listStyle);
                }),
            greyLine(),

            Text(
                "Roll No : ${teacherStateController.manageClassTestInvModel.data!.studentList![i].rollNumber.toString()}",
                style: CommonDecoration.listStyle),
            greyLine(),
            Text(
                "ADM No : ${teacherStateController.manageClassTestInvModel.data!.studentList![i].admissionNumber.toString()}",
                style: CommonDecoration.listStyle),
            if(teacherStateController.manageClassTestInvModel
                .data!.studentList![i].attendanceStatus=="P")
              Column(
                children: [
                  greyLine(),

                  SizedBox(
                      height: 35,
                      child: MyTextField(

                          hint: "Marks",
                          inputType: TextInputType.numberWithOptions(decimal: true,signed: false),
                          textEditingController: marksController,
                          focusNode: marksFocus,
                          borderColor: Colors.grey,
                          borderRadius: 10,

                          filled: teacherStateController
                              .manageClassTestInvModel.locked,
                          icon: Icon(Icons.numbers),
                          isValidate: false)),
                  greyLine(),
                  SizedBox(
                      height: 35,
                      child: MyTextField(
                          hint: "Remarks",
                          inputType: TextInputType.text,
                          textEditingController: remarksController,
                          focusNode: remarksFocus,
                          borderColor: Colors.grey,
                          borderRadius: 10,
                          filled: teacherStateController
                              .manageClassTestInvModel.locked,
                          icon: Icon(Icons.bookmark),
                          isValidate: false)),
                ],
              ),

            greyLine(),
            Row(
              children: [
                attendanceOption(option: "L", index: i),
                SizedBox(
                  width: 5,
                ),
                attendanceOption(option: "A", index: i),
                SizedBox(
                  width: 5,
                ),
                attendanceOption(option: "P", index: i),
              ],
            )
            //Text("Attendance : Present",style: CommonDecoration.listStyle),
          ],
        ),
      ),
    );
  }

  Widget attendanceOption({required String option, required int index}) {
    return GetBuilder(
        init: teacherStateController,
        builder: (context) {
          return Expanded(
              child: InkWell(
            onTap: () {
              teacherStateController.updateClassTestInvModelAttendance(
                  i: index, attendance: option);
            },
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: teacherStateController.manageClassTestInvModel
                              .data!.studentList![index].attendanceStatus ==
                          option
                      ? optionColor(option: option)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: teacherStateController
                                  .manageClassTestInvModel

                                  .data!
                                  .studentList![index]
                                  .attendanceStatus ==
                              option
                          ? optionColor(option: option)
                          : Colors.grey)),
              child: Text(
                findLabel(option),
                style: teacherStateController.manageClassTestInvModel
                            .data!.studentList![index].attendanceStatus ==
                        option
                    ? CommonDecoration.smallLabel.copyWith(color: Colors.white)
                    : CommonDecoration.smallLabel,
              ),
            ),
          ));
        });
  }
  
  Color optionColor({required String option}){
    if(option=="A"){
      return Colors.red;
    }
   else if(option=="P"){
      return Colors.green;
    }else{
      return Colors.blue;
    }
  }

  Widget greyLine() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      width: double.infinity,
      height: 1,
      color: Colors.grey.withOpacity(.3),
    );
  }
}
