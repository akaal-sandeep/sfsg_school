import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/constants/color_constants.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/teacher/students_remarks/create_remarks.dart';
import 'package:web_school_manager/teacher_model/get_student_remarks_list.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';
import 'package:web_school_manager/widget/mytextfield.dart';

import '../../controller/teacher_state_controller.dart';
import '../../utility/custom_decoration.dart';

class StudentsRemarks extends StatefulWidget {
  GetStudentRemarksListModel getStudentRemarksListModel;
  StudentsRemarks({Key? key, required this.getStudentRemarksListModel})
      : super(key: key);

  @override
  State<StudentsRemarks> createState() => _StudentsRemarksState();
}

class _StudentsRemarksState extends State<StudentsRemarks> {
  final teacherStateController = Get.put(TeacherStateController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    teacherStateController.searchController!.addListener(() {
      teacherStateController.searchList=[];

      for(var element in widget.getStudentRemarksListModel.data!){
        if(element.studentName!.toUpperCase().contains(teacherStateController.searchController!.value.text.toUpperCase())){
        teacherStateController.searchList.add(element);
        }

      }
      setState(() {

      });
    });

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    teacherStateController.searchController!.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:isTeacher()? InkWell(
        onTap: () {
          TeacherController().returnTeacherClassList().then((value) {
            Get.to(() => CreateRemarks(
              filled: false,
              classesModel: value,
            ))!.then((value) {
              myLog(label: "update list", value: true);
              TeacherController().getStudentRemarks(navigate: false).then((value) {
                widget.getStudentRemarksListModel = value;
                setState(() {});
              });
            });;
          });//Get.to(()=>TakeAppointment());
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
      ):Container(),
      body: myPadding(
          child: Column(
        children: [

          CommonHeader(
            title: "Students Remark",
            hideStudentName: true,
          ),
          smallSpace(),

          _searchField(),
          smallSpace(),
          Expanded(

            child: SingleChildScrollView(
              child: Column(
                children: [
                  teacherStateController.searchController!.value.text.length.isEqual(0)?
                  widget.getStudentRemarksListModel.data!.length
                      .isEqual(0)
                      ? myImage(
                      isNetwork: false,
                      source: "assets/icons/empty.png")
                      :

                  ListView.builder(
                    shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: widget.getStudentRemarksListModel.data!.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            Get.to(() => CreateRemarks(
                              filled: true,
                              selectedClass:
                              widget.getStudentRemarksListModel.data![i].className,
                              selectedDate: getTimeFormat(DateTime.parse(widget.getStudentRemarksListModel.data![i].entryDate.toString())),
                              selectedRemarkType: widget.getStudentRemarksListModel.data![i].remarksTypeName,
                              selectedStudent: widget.getStudentRemarksListModel.data![i].studentName,
                              url: widget.getStudentRemarksListModel.data![i].absoluteDocumentPath,
                              remark: widget.getStudentRemarksListModel.data![i].remarksDetail,
                            ))!.then((value) {
                              myLog(label: "update list", value: true);
                              TeacherController().getStudentRemarks(navigate: false).then((value) {
                                widget.getStudentRemarksListModel = value;
                              });
                            });
                          },
                          child: listCard(
                            imageUrl: widget.getStudentRemarksListModel
                                .data![i].studentProfilePicturePath
                                .toString(),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    widget.getStudentRemarksListModel.data![i].studentName
                                        .toString() +
                                        "[" +
                                        widget.getStudentRemarksListModel
                                            .data![i].admissionNumber
                                            .toString() +
                                        "]",
                                    style: CommonDecoration.listStyle),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                    widget.getStudentRemarksListModel.data![i].className
                                        .toString() +
                                        "  |  " +
                                        widget.getStudentRemarksListModel
                                            .data![i].sectionName
                                            .toString(),
                                    style: CommonDecoration.smallLabel),
                                Text(
                                    getTimeFormat(DateTime.parse(
                                        widget.getStudentRemarksListModel
                                            .data![i].entryDate
                                            .toString())),
                                    style: CommonDecoration.smallLabel),
                                if(!isTeacher())
                                  Column(
                                    children: [
                                      SizedBox(height: 5,),
                                      Text("Remarks Uploaded By : " +
                                          widget.getStudentRemarksListModel
                                              .data![i].employeeName
                                              .toString(),
                                          style: CommonDecoration.smallLabel),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        );
                      }):
                  teacherStateController.searchList.length
                      .isEqual(0)
                      ? myImage(
                      isNetwork: false,
                      source: "assets/icons/empty.png")
                      :
                  ListView.builder(
                      physics: BouncingScrollPhysics(),

                      shrinkWrap: true,
                      itemCount:  teacherStateController.searchList.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            Get.to(() => CreateRemarks(
                              filled: true,
                              selectedClass:
                              teacherStateController.searchList[i].className,
                              selectedDate: getTimeFormat(DateTime.parse( teacherStateController.searchList[i].entryDate.toString())),
                              selectedRemarkType:  teacherStateController.searchList[i].remarksTypeName,
                              selectedStudent:  teacherStateController.searchList[i].studentName,
                              url:  teacherStateController.searchList[i].absoluteDocumentPath,
                              remark: teacherStateController.searchList[i].remarksDetail,
                            ));
                          },
                          child: listCard(
                            imageUrl:  teacherStateController.searchList[i].studentProfilePicturePath
                                .toString(),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    teacherStateController.searchList[i].studentName
                                        .toString() +
                                        "[" +
                                        teacherStateController.searchList[i].admissionNumber
                                            .toString() +
                                        "]",
                                    style: CommonDecoration.listStyle),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                    teacherStateController.searchList[i].className
                                        .toString() +
                                        "  |  " +
                                        teacherStateController.searchList[i].sectionName
                                            .toString(),
                                    style: CommonDecoration.smallLabel),
                                Text(
                                    getTimeFormat(DateTime.parse(
                                        teacherStateController.searchList[i].entryDate
                                            .toString())),
                                    style: CommonDecoration.smallLabel),
                                if(!isTeacher())
                                  Column(
                                    children: [
                                      SizedBox(height: 5,),
                                      Text("Remarks Uploaded By : " +
                                          teacherStateController.searchList[i].employeeName
                                              .toString(),
                                          style: CommonDecoration.smallLabel),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          )

        ],
      )),
    );
  }

  Widget _searchField(){
    return MyTextFieldWithWidget(

        hint: "Search", inputType: TextInputType.emailAddress,
        textEditingController: teacherStateController.searchController!,
        focusNode: teacherStateController.searchNode!,
        borderColor: ColorConstants.themeColor,
        borderRadius: 10,
        filled: false,
        prefixWidget: Icon(Icons.search),
        isValidate: false);
  }
}
