
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/controller/coordinator_controller.dart';
import 'package:web_school_manager/controller/parent_controller.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/drawer/module/contact_us.dart';
import 'package:web_school_manager/teacher/holiday_homework_teacher/holiday_home_work_subject.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/button.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../parent_model/get_class_home_work_with_read_status.dart';

class StudentHomework extends StatefulWidget {
  String title;
  GetClassHomeWorkWithReadStatusModel getClassHomeWorkWithReadStatusModel;

  StudentHomework(
      {Key? key, required this.getClassHomeWorkWithReadStatusModel, required this.title})
      : super(key: key);

  @override
  State<StudentHomework> createState() => _StudentHomeworkState();
}

class _StudentHomeworkState extends State<StudentHomework> {
  DateTime time = DateTime.now();
  Future getTime() async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now(),

    );
    return picker;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (widget.title == "Home Work")
          ? InkWell(
        onTap: () {
          getTime().then((value) {
            time = value;
            ParentController().getClassHomeWork(
              navigate: true,
              homeWorkDate:
              apiTimeFormat(DateTime.parse(time.toString())),
            );
            myLog(
              label: "My Selected date",
              value: apiTimeFormat(DateTime.parse(time.toString())),
            );
            setState(() {});
          });
        },
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(left: 30),
          decoration: BoxDecoration(
            boxShadow: myShadow,
            borderRadius: BorderRadius.circular(100),
            color: Colors.blue,
          ),
          child: Text(
            DateFormat("dd MMM, yyyy").format(time),
            style:
            CommonDecoration.listStyle.copyWith(color: Colors.white),
          ),
        ),
      )
          : isTeacher()
          ? InkWell(
        onTap: () {
          TeacherController()
              .getHolidayHomeworkSubjectList(
              classMasterId: widget
                  .getClassHomeWorkWithReadStatusModel
                  .classMasterId ??
                  "",
              classSectionMasterId: widget
                  .getClassHomeWorkWithReadStatusModel
                  .classSectionMasterId ??
                  "")
              .then((value) {
            Get.to(() => HolidayWorkSubject(
              getHolidayHomeworkSubjectListModel: value,
              classMasterId: widget
                  .getClassHomeWorkWithReadStatusModel
                  .classMasterId ??
                  "",
              sectionMasterId: widget
                  .getClassHomeWorkWithReadStatusModel
                  .classSectionMasterId ??
                  "",
              className: widget
                  .getClassHomeWorkWithReadStatusModel
                  .className ??
                  "",
            ))!
                .then((value) async {
              widget.getClassHomeWorkWithReadStatusModel =
              await CoordinatorController()
                  .getHolidayHomeWorkWithReadStatus(
                  className: widget
                      .getClassHomeWorkWithReadStatusModel
                      .className,
                  classMasterId: widget
                      .getClassHomeWorkWithReadStatusModel
                      .classMasterId ??
                      "",
                  classSectionMasterId: widget
                      .getClassHomeWorkWithReadStatusModel
                      .classSectionMasterId ??
                      "",
                  shouldNavigate: false);
              setState(() {});
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
          : SizedBox(),
      body: myPadding(
        child: Column(
          children: [
            CommonHeader(title: widget.title),
            smallSpace(),
            Expanded(
                child: widget
                    .getClassHomeWorkWithReadStatusModel.data!.length ==
                    0
                    ? myImage(
                    isNetwork: false, source: "assets/icons/empty.png")
                    : ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    itemCount: widget
                        .getClassHomeWorkWithReadStatusModel.data!.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: ()  {

                          // Get.to(DateHomeWork());
                          widget.getClassHomeWorkWithReadStatusModel
                              .data![i].showDocuments =
                          !widget.getClassHomeWorkWithReadStatusModel
                              .data![i].showDocuments;
                          setState(() {});
                        },
                        child: listCard(
                            imageUrl: "s",
                            showImage: false,
                            showArrow: false,
                            content: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 70,
                                      child: myImage(
                                          isNetwork: false,
                                          source: "assets/icons/home-work.png"),
                                    ),

                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget
                                              .getClassHomeWorkWithReadStatusModel
                                              .data![i].subjectName ??
                                              "",
                                          style:
                                          CommonDecoration.subHeaderStyle,
                                        ),
                                        Text(
                                          getTimeFormat(DateTime.parse(widget
                                              .getClassHomeWorkWithReadStatusModel
                                              .data![i]
                                              .homeWorkDate ??
                                              "")),
                                          style: CommonDecoration.smallLabel,
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    RotatedBox(
                                        quarterTurns: !widget
                                            .getClassHomeWorkWithReadStatusModel
                                            .data![i]
                                            .showDocuments ? 0 : 45,
                                        child: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Colors.grey,))
                                  ],
                                ),
                                AnimatedCrossFade(
                                    firstChild: Container(),
                                    secondChild: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text("Home work - " +
                                            widget
                                                .getClassHomeWorkWithReadStatusModel
                                                .data![i].homeWork.toString(),
                                          style: CommonDecoration.smallLabel,
                                        ),
                                        SizedBox(height: 10,),
                                        Text("Documents :",
                                          style: CommonDecoration.smallLabel,
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: widget
                                                .getClassHomeWorkWithReadStatusModel
                                                .data![i].documentsList!.length,
                                            itemBuilder: (context, j) {
                                              return InkWell(
                                                onTap: () {
                                                  if (widget
                                                      .getClassHomeWorkWithReadStatusModel
                                                      .data![i]
                                                      .documentsList![j]
                                                      .fileUrl!.split(".").last == "YOUTUBE_VIDEO_LINK") {
                                                    Get.to(() =>
                                                        ContactUs(
                                                            upperTitle: "Web View",
                                                            link: widget
                                                            .getClassHomeWorkWithReadStatusModel
                                                            .data![i]
                                                            .documentsList![j]
                                                            .documentName ?? ""));
                                                    return;
                                                  }

                                                  viewDocument(
                                                      fileSource: widget
                                                          .getClassHomeWorkWithReadStatusModel
                                                          .data![i]
                                                          .documentsList![j]
                                                          .fileUrl ?? "",
                                                      fromUrl: true);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  decoration: BoxDecoration(

                                                    boxShadow: myShadow,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      widget
                                                          .getClassHomeWorkWithReadStatusModel
                                                          .data![i]
                                                          .documentsList![j]
                                                          .fileUrl!.split(".").last == "YOUTUBE_VIDEO_LINK"?Icon(Icons.link, color: Colors.grey,): Icon(Icons
                                                          .document_scanner_sharp,
                                                        color: Colors.grey,),
                                                      SizedBox(width: 10,),
                                                      Expanded(
                                                        child: Text(widget
                                                            .getClassHomeWorkWithReadStatusModel
                                                            .data![i]
                                                            .documentsList![j]
                                                            .documentName ?? "",
                                                        overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                     // Spacer(),
                                                      Icon(Icons.remove_red_eye,
                                                        color: Colors.grey,)
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                        smallSpace(),
                                        if(widget.title=="Home Work")
                                        InkWell(
                                            onTap: () {
                                              ParentController()
                                                  .getUploadHomeWorkBySubjectData(
                                                className: "",
                                                  subjectName:widget
                                                      .getClassHomeWorkWithReadStatusModel
                                                      .data![i].subjectName.toString() ,
                                                  classHomeWorkId:widget
                                                      .getClassHomeWorkWithReadStatusModel
                                                      .data![i].id.toString(),
                                                  homeWorkUploadDate: widget
                                                      .getClassHomeWorkWithReadStatusModel
                                                      .data![i].homeWorkDate??"",
                                                  subjectMasterId: widget
                                                      .getClassHomeWorkWithReadStatusModel
                                                      .data![i].subjectMasterId.toString());
                                              //  Get.to(UploadHomeWork(classMasterId: classMasterId, subjectName: subjectName, classSectionMasterId: classSectionMasterId, className: className, homeWorkId: homeWorkId, rowVersion: rowVersion, subjectMasterId: subjectMasterId))
                                            },
                                            child: MyButton(text: "Upload",
                                              borderRadius: 10,
                                              color: Colors.blue,
                                              iconButton: Icons.upload,))
                                      ],
                                    ),
                                    crossFadeState: !widget
                                        .getClassHomeWorkWithReadStatusModel
                                        .data![i]
                                        .showDocuments
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                                    duration: Duration(milliseconds: 400)),
                              ],
                            )),
                      );
                    }))
          ],
        ),
      ),
    );
  }







}
