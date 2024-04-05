import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/controller/teacher_state_controller.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../../teacher_model/class_test_model.dart';

class TestSubject extends StatelessWidget {
  ClassTestListModel classTestListModel;
  String classMasterId;
  String classSectionMasterId;
  String className;

  TestSubject(
      {Key? key,
      required this.classTestListModel,
      required this.classSectionMasterId,
      required this.classMasterId,
      required this.className})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final teacherStateController = Get.put(TeacherStateController());
    teacherStateController.classMasterId.value = classMasterId;
    teacherStateController.sectionMasterId.value = classSectionMasterId;
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          TeacherController().manageClassTestMain(
              id: "0",
              className: className,
              classTestListModel: classTestListModel,
              subjectName: classTestListModel.data![0].subjectName,
              navigate: true,
              isLocked: false);
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
            title: "Test Subject",
            hideStudentName: true,
          ),
          smallSpace(),
          Text(
            className,
            style: CommonDecoration.subHeaderStyle,
          ),
          smallSpace(),
          Expanded(
              child: ListView.builder(
                  itemCount: classTestListModel.data!.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                        onTap: () {
                          TeacherController().getTeacherClassTestListBySubject(
                              classMasterId: classMasterId,
                              navigate: true,
                              classTestListModel: classTestListModel,
                              classSectionMasterId: classSectionMasterId,
                              subjectMasterId:
                                  classTestListModel.data![i].id.toString(),
                              subjectName:
                                  classTestListModel.data![i].subjectName ?? "",
                              className: className);
                          // Get.to(() => SubjectChapterTest());
                        },
                        child: subjectCard(
                            subjectName:
                                classTestListModel.data![i].subjectName ?? ""));
                  }))
        ],
      )),
    );
  }
}
