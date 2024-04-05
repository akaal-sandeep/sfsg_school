import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/teacher/holiday_homework_teacher/holiday_home_work_subject.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../teacher_model/teacher_class_list_model.dart';

class HolidayWorkClasses extends StatelessWidget {
  TeacherClassesListModel model;

  HolidayWorkClasses({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
          child: Column(
        children: [
          CommonHeader(
            title: "Classes",
            hideStudentName: true,
          ),
          smallSpace(),
          Expanded(
              child: ListView.builder(
            itemCount: model.data!.length,
            itemBuilder: (context, i) {
              return InkWell(
                  onTap: () {
                    TeacherController()
                        .getHolidayHomeworkSubjectList(
                            classMasterId:
                                model.data![i].classMasterId.toString(),
                            classSectionMasterId:
                                model.data![i].classSectionMasterId.toString())
                        .then((value) {
                      Get.to(() => HolidayWorkSubject(
                            getHolidayHomeworkSubjectListModel: value,
                            classMasterId:model.data![i].classMasterId.toString() ,
                            sectionMasterId: model.data![i].classSectionMasterId.toString(),
                            className:
                                "${model.data![i].className} - ${model.data![i].classSectionName}",
                          ));
                    });
                  },
                  child: subjectCard(
                      subjectName:
                          "${model.data![i].className} - ${model.data![i].classSectionName}"));
            },
          ))
        ],
      )),
    );
  }
}
