import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/constants/string_constants.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/local_storage/local_storage.dart';
import 'package:web_school_manager/teacher/holiday_homework_teacher/upload_homework_teacher.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';
import '../../teacher_model/get_class_homework_by_subject_model.dart';
import '../../teacher_model/get_holiday_home_work_subject_list_model.dart';

class HolidayWorkSubject extends StatelessWidget {
  GetHolidayHomeworkSubjectListModel getHolidayHomeworkSubjectListModel;
  String className;
  String classMasterId;
  String sectionMasterId;

  HolidayWorkSubject(
      {Key? key,
      required this.getHolidayHomeworkSubjectListModel,
      required this.className,
      required this.classMasterId,
      required this.sectionMasterId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
          child: Column(
        children: [
          CommonHeader(
            title: "Subject",
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
            itemCount: getHolidayHomeworkSubjectListModel.data!.length,
            itemBuilder: (context, i) {
              return InkWell(
                  onTap: () {
                    TeacherController()
                        .getHolidayHomeWorkSubjectDate(

                            classMasterId: classMasterId,
                            subjectMasterId: getHolidayHomeworkSubjectListModel
                                .data![i].subjectMasterId
                                .toString(),
                            classSectionMasterId: sectionMasterId,
                            navigate: false
                    )
                        .then((value) {
                      GetClassHomeWorkBySubjectDateModel getClassHomeWorkBySubjectDateModel = value;
                      myLog(label: "my date", value: getClassHomeWorkBySubjectDateModel.toJson());
                      String userType = LocalStorage().read(key: StringConstants.userType);
                      Get.to(() => UploadHomeWork(
                        student: true,
                        fromHolidayWork: true,
                        title: getClassHomeWorkBySubjectDateModel.data!.homeWork??"",
                            documents: getClassHomeWorkBySubjectDateModel.data!.documentsList??[],
                            classSectionMasterId: sectionMasterId,
                            rowVersion: getClassHomeWorkBySubjectDateModel.data!.rowVersion.toString(),
                            classMasterId: classMasterId,
                            subjectMasterId:getHolidayHomeworkSubjectListModel
                                .data![i].subjectMasterId.toString(),
                            className: className,
                            subjectName: getHolidayHomeworkSubjectListModel
                                .data![i].subjectName.toString(),
                            homeWorkId: getHolidayHomeworkSubjectListModel
                                .data![i].id.toString(),
                        getClassHomeWorkBySubjectDateModel: getClassHomeWorkBySubjectDateModel,
                        filled: StringConstants.parentType==userType,
                          ));
                    });
                    //
                  },
                  child: subjectCard(
                      subjectName: getHolidayHomeworkSubjectListModel
                              .data![i].subjectName ??
                          ""));
            },
          ))
        ],
      )),
    );
  }
}
