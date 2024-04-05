import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../../controller/teacher_state_controller.dart';
import '../../../teacher_model/GetTeacherClassTestListBySubjectModel.dart';
import '../../../teacher_model/class_test_model.dart';
import '../../../widget/dialog.dart';

class SubjectChapterTest extends StatelessWidget {
  String classMasterId;
  String classSectionMasterId;
  String subjectName;
  String className;
  String subjectMasterId;
  ClassTestListModel classTestListModel;
  GetTeacherClassTestListBySubjectModel model;

  SubjectChapterTest(
      {Key? key,
      required this.className,
      required this.classTestListModel,
      required this.model,
      required this.subjectMasterId,
      required this.classSectionMasterId,
      required this.classMasterId,
      required this.subjectName})
      : super(key: key);
  final teacherStateController = Get.put(TeacherStateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          TeacherController().manageClassTestMain(
              id: "0",
              className: className,
              classTestListModel: classTestListModel,
              subjectName: subjectName,
              navigate: true,
              isLocked: false);

          // Get.to(() => CreateTest(
          //       classname: className,
          //       subjectName: subjectName,
          //       isLocked: false,
          //       classTestListModel: classTestListModel,
          //     ));
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
      ),
      body: myPadding(
          child: Column(
        children: [
          CommonHeader(
            title: "Chapter",
            hideStudentName: true,
          ),
          smallSpace(),
          Text(
            subjectName + " [ $className ]",
            style: CommonDecoration.subHeaderStyle,
          ),
          smallSpace(),
          Expanded(
              child: GetBuilder(
                  init: teacherStateController,
                  builder: (context) {
                    model = teacherStateController.listBySubjectModel;
                    if(model.data!.length.isEqual(0)){
                      return myImage(isNetwork: false, source: "assets/icons/empty.png");
                    }
                    return ListView.builder(
                        itemCount: model.data!.length,
                        padding: EdgeInsets.only(bottom: 100),
                        itemBuilder: (context, i) {
                          return InkWell(
                            onLongPress: () {
                              if (model.data![i].isLocked!) {
                                showMessage(
                                    msg: "Locked test unable to delete");
                                return;
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialogCustom(
                                          icon: Icons.warning_amber,
                                          iconColor: Colors.red,
                                          description:
                                              "Do you want to delete this test",
                                          showNegative: true,
                                          positiveCall: () {
                                            Navigator.pop(context);
                                            TeacherController()
                                                .deleteClassTest(
                                                    Id: model.data![i].id
                                                        .toString(),
                                                    isActive: false.toString(),
                                                    rowVersion: model
                                                        .data![i].rowVersion
                                                        .toString())
                                                .then((value) {
                                              if (value) {
                                                TeacherController()
                                                    .getTeacherClassTestListBySubject(
                                                        classMasterId:
                                                            classMasterId,
                                                        classSectionMasterId:
                                                            classSectionMasterId,
                                                        subjectName:
                                                            subjectName,
                                                        className: className,
                                                        navigate: false,
                                                        subjectMasterId:
                                                            subjectMasterId);
                                              }
                                            });
                                          },
                                          negativeCall: () {
                                            Navigator.pop(context);
                                          },
                                        ));
                              }
                            },
                            onTap: () {
                              TeacherController().manageClassTestMain(
                                  id: model.data![i].id.toString(),
                                  className: className,
                                  subjectName: subjectName,
                                  isLocked: model.data![i].isLocked!,
                                  navigate: true,
                                  classTestListModel: classTestListModel);
                            },
                            child: listCard(
                              backgroundColor: model.data![i].isLocked == true
                                  ? Colors.blue.withOpacity(.1)
                                  : Colors.white,
                              showImage: false,
                              imageUrl: "assets/books.png",
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(model.data![i].testTopic ?? "",
                                      style: CommonDecoration.listStyle),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(model.data![i].subjectName ?? "",
                                      style: CommonDecoration.smallLabel),
                                  Text(
                                      getTimeFormat(DateTime.parse(model
                                              .data![i].testDate
                                              .toString()))
                                          .toString(),
                                      style: CommonDecoration.smallLabel),
                                ],
                              ),
                            ),
                          );
                        });
                  }))
        ],
      )),
    );
  }
}
