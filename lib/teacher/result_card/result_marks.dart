import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:web_school_manager/utility/helper_widget.dart';

import '../../utility/custom_decoration.dart';
import '../../widget/button.dart';
import '../../widget/dialog.dart';
import '../../widget/header.dart';

class ResultMarks extends StatefulWidget {
  const ResultMarks({Key? key}) : super(key: key);

  @override
  State<ResultMarks> createState() => _ResultMarksState();
}

class _ResultMarksState extends State<ResultMarks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
              onTap: () {

                showDialog(context: context, builder: (context)=>AlertDialogCustom(
                  icon: Icons.warning_amber,
                  iconColor: Colors.red,
                  description: "Do you want to lock this test?",
                  showNegative: true,
                  positiveCall: (){
                    Navigator.pop(context);
                    // if(teacherStateController
                    //     .manageClassTestInvModel.locked||!widget.filled)return;
                    //
                    // TeacherController().lockClassTest(id: teacherStateController
                    //     .manageClassTestInvModel.data!.id.toString(), isLocked: true.toString(), rowVersion: teacherStateController
                    //     .manageClassTestInvModel.data!.rowVersion.toString()).then((value){
                    //   if(value){
                    //     TeacherController()
                    //         .getTeacherClassTestListBySubject(
                    //         classMasterId: widget
                    //             .model.data!.classMasterId
                    //             .toString(),
                    //         navigate: false,
                    //         classSectionMasterId: widget
                    //             .model.data!.classSectionMasterId
                    //             .toString(),
                    //         subjectMasterId: widget
                    //             .model.data!.subjectMasterId
                    //             .toString(),
                    //         subjectName:
                    //         widget.model.data!.subjectName.toString(),
                    //         className: widget.className);
                    //   }
                    // });
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
                    color:/*teacherStateController
                        .manageClassTestInvModel.locked||!widget.filled?Colors.grey:*/ Colors.red,
                  ),
                  child: Icon(
                   /* teacherStateController
                        .manageClassTestInvModel.locked?Icons.lock:*/ Icons.lock_open,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

      body: myPadding(
          child: Column(
        children: <Widget>[
          CommonHeader(
            title: "Student Marks",
            hideStudentName: true,
          ),
          smallSpace(),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true
              ,
              itemBuilder: (BuildContext context, int index) {
              return                   Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: myShadow,
                ),
                child: Row(
                  children: [
                    _profileImg(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _titleValueFun(title: "AMAN", trail: ""),
                          greyLine(),
                          _titleValueFun(
                              title: "Percentage :", trail: "98.34"),
                          greyLine(),
                          _titleValueFun(title: "Roll No. :", trail: "3"),
                          greyLine(),
                          _titleValueFun(title: "ADM No. :", trail: "AWSS"),
                          greyLine(),
                          smallSpace(),
                          Row(
                            children: [
                              statusButton(title: "Absent",onTab: (){

                              }),
                              SizedBox(width: 10,),
                              statusButton(title: "Present",onTab: (){

                              }),
                              SizedBox(width: 10,),

                              statusButton(title: "Leave",onTab: (){

                              }),

                            ],
                          )


                          // attendanceOption(option: "L", index: 1),



                        ],
                      ),
                    )
                  ],
                ),
              );


            }, separatorBuilder: (BuildContext context, int index) {
              return smallSpace();
            }, itemCount: 5,),
          ),
          Row(
                  children: [
                    Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {});
                          },
                          child: MyButton(
                              text: "Edit",
                              borderRadius: 0,
                              color:/*: (teacherStateController
                                  .manageClassTestInvModel.locked || !widget.filled)
                                  ? Colors.grey
                                  : */Colors.blue),
                        )),
                    // SizedBox(
                    //   width: 15,
                    // ),
                    Expanded(
                        child: InkWell(
                          onTap: () {
                          /*  final teacherStateController =
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
                            });*/
                          },
                          child: MyButton(
                              text: "Update",
                              borderRadius: 0,
                              color: /*(teacherStateController
                                  .manageClassTestInvModel.locked || widget.filled)
                                  ? Colors.grey
                                  :*/ Colors.blue),
                        )),
                  ],
                ),

          SizedBox(height: 5,)
        ],
      )),
    );
  }
  Widget statusButton({title,onTab}){
    return  Expanded(
      child: InkWell(

        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color:  Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  color: Colors.grey)),
          child: Text(
            title,
            style:  CommonDecoration.smallLabel,
          ),
        ),
        onTap: onTab,
      ),
    );
  }
  Widget attendanceOption({required String option, required int index}) {
    return GetBuilder(
        // init: teacherStateController,
        builder: (context) {
          return Expanded(
              child: InkWell(
                onTap: () {
               /*   teacherStateController.updateClassTestInvModelAttendance(
                      i: index, attendance: option);*/
                },
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color:
                               Colors.grey)),
                  child: Text(
                    findLabel(option),
                    style: CommonDecoration.smallLabel,
                  ),
                ),
              ));
        });
  }
  String findLabel(label){
    if(label=="H"){
      return "Half Day";
    }
    if(label == "L"){
      return "Leave";
    }
    if(label=="A"){
      return "Absent";
    }
    if(label=="P"){
      return "Present";
    }
    return "";
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
  Widget _titleValueFun({title, trail}) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          trail,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _profileImg() {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: myImage(isNetwork: false, source: "assets/icons/classes.png"),
    );
  }
}
