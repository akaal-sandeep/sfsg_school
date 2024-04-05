import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/teacher/holiday_homework_teacher/upload_homework_teacher.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../../teacher_model/get_class_homework_by_subject_model.dart'as homeWorkId;
import '../../../teacher_model/teacher_class_homework_model.dart';

class ClassHomeWork extends StatelessWidget {
  TeacherClassHomeworkModel teacherClassHomeworkModel;
  String className;
  String classMasterId;
  String classSectionMasterId;
  bool? fromClassWork;

  ClassHomeWork({Key? key,
    required this.teacherClassHomeworkModel,
    required this.className,
    required this.classSectionMasterId,
     this.fromClassWork,
    required this.classMasterId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
          child: Column(
            children: [
              CommonHeader(
                title:fromClassWork==true? "Class Work":"Home Work",
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
                      itemCount: teacherClassHomeworkModel.data!.length,
                      itemBuilder: (context, i) {
                        Data data = teacherClassHomeworkModel.data![i];
                        return Container(
                          height: 100,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: myShadow,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                child: myImage(
                                    isNetwork: false,
                                    source: "assets/common/homework.png"),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(60)),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.subjectName ?? "",
                                      style: CommonDecoration.subHeaderStyle,
                                    ),
                                    smallSpace(),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                if(fromClassWork==true){

                                                  TeacherController()
                                                      .getClassWorkBySubjectDate(
                                                      navigate: false,
                                                      classMasterId: classMasterId,
                                                      classSectionMasterId:
                                                      classSectionMasterId,
                                                      subjectMasterId:
                                                      teacherClassHomeworkModel
                                                          .data![i]
                                                          .subjectMasterId
                                                          .toString()).then((
                                                      value) {
                                                    homeWorkId.GetClassHomeWorkBySubjectDateModel getClassHomeWorkBySubjectDateModel = value;
                                                    Get.to(() => UploadHomeWork(
                                                      fromClassWork: true,
                                                      title:getClassHomeWorkBySubjectDateModel.data!.work.toString() ,
                                                      documents:getClassHomeWorkBySubjectDateModel.data!.documentsList!,
                                                      rowVersion:  getClassHomeWorkBySubjectDateModel.data!.rowVersion.toString(),
                                                      classMasterId:classMasterId,
                                                      classSectionMasterId: classSectionMasterId,
                                                      className: className,
                                                      homeWorkId: teacherClassHomeworkModel.data![i].id.toString(),
                                                      subjectMasterId: teacherClassHomeworkModel.data![i].subjectMasterId.toString(),
                                                      student: true,
                                                      subjectName: teacherClassHomeworkModel.data![i].subjectName.toString(),));

                                                  });
                                                  return;
                                                }
                                                
                                                TeacherController()
                                                    .getClassHomeWorkBySubjectDate(
                                                  navigate: false,
                                                    classMasterId: classMasterId,
                                                    classSectionMasterId:
                                                    classSectionMasterId,
                                                    subjectMasterId:
                                                    teacherClassHomeworkModel
                                                        .data![i]
                                                        .subjectMasterId
                                                        .toString()).then((
                                                    value) {
                                                  homeWorkId.GetClassHomeWorkBySubjectDateModel getClassHomeWorkBySubjectDateModel = value;
                                                  Get.to(() => UploadHomeWork(
                                                    title:getClassHomeWorkBySubjectDateModel.data!.homeWork.toString() ,
                                                    documents:getClassHomeWorkBySubjectDateModel.data!.documentsList!,
                                                    rowVersion:  getClassHomeWorkBySubjectDateModel.data!.rowVersion.toString(),
                                                    classMasterId:classMasterId,
                                                    classSectionMasterId: classSectionMasterId,
                                                    className: className,
                                                    homeWorkId: teacherClassHomeworkModel
                                                        .data![i].id.toString(),
                                                    subjectMasterId: teacherClassHomeworkModel
                                                        .data![i]
                                                        .subjectMasterId
                                                        .toString(),
                                                    student: true,
                                                    subjectName: teacherClassHomeworkModel
                                                        .data![i].subjectName
                                                        .toString(),));

                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5, horizontal: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                    BorderRadius.circular(5)),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  fromClassWork==true?"Upload Class\nWork":"Upload Home\nWork",
                                                  textAlign: TextAlign.center,
                                                  style: CommonDecoration
                                                      .smallLabel
                                                      .copyWith(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: InkWell(
                                              onTap: () {
                                             TeacherController().getStudentListForClassHomeWork(classMasterId: classMasterId.toString(), classSectionMasterId: classSectionMasterId.toString(), subjectMasterId: teacherClassHomeworkModel
                                                 .data![i]
                                                 .subjectMasterId
                                                 .toString(), homeWorkUploadDate: getTimeFormat(DateTime.now()));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5, horizontal: 7),
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                    BorderRadius.circular(5)),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  fromClassWork==true?"View Class\nWork": "View Home\nWork",
                                                  textAlign: TextAlign.center,
                                                  style: CommonDecoration
                                                      .smallLabel
                                                      .copyWith(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }))
            ],
          )),
    );
  }
}
