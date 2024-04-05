import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/constants/string_constants.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/generated/assets.dart';
import 'package:web_school_manager/local_storage/local_storage.dart';
import 'package:web_school_manager/teacher/bag_components/screen/bag_component_screen.dart';
import 'package:web_school_manager/teacher/teacher_bag_component_list_screen.dart';
import 'package:web_school_manager/teacher_model/bag_components_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../principal_model/get_subject_list_for_class_model.dart';
import '../../teacher/holiday_homework_teacher/upload_homework_teacher.dart';
import '../../teacher_model/get_class_homework_by_subject_model.dart';

class SubjectListScreen extends StatelessWidget {
  GetSubjectListForClassModel getSubjectListForClassModel;
  String classMasterId;
  String classSectionMasterId;
  String className;
  String sectionName;
  bool? fromBagComponents;

  SubjectListScreen({
    Key? key,
    required this.getSubjectListForClassModel,
    this.fromBagComponents,
    required this.sectionName,
    required this.className,
    required this.classSectionMasterId,
    required this.classMasterId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
          child: Column(
        children: [
          CommonHeader(title: "Subjects"),
          Text(className + ", " + sectionName),
          largeSpace(),
          if(getSubjectListForClassModel.data?.length.isEqual(0)??true)
            Expanded(child:Image.asset(Assets.iconsEmpty,width: double.infinity,)),
          if(getSubjectListForClassModel.data!.length>0)
          Expanded(
            child: ListView.builder(
                itemCount: getSubjectListForClassModel.data!.length,
                itemBuilder: (context, i) {
                  if (getSubjectListForClassModel.data![i].id.toString() ==
                      "-1") return Container();
                  return InkWell(
                      onTap: () async {
                        if (fromBagComponents == true) {
                          if (StringConstants.principleType ==
                              LocalStorage()
                                  .read(key: StringConstants.userType) || StringConstants.coordinatorType ==
                              LocalStorage()
                                  .read(key: StringConstants.userType)) {
                            TeacherController()
                                .getBagPlanList(
                                    sectionMasterId: classSectionMasterId,
                                    classMasterId: classMasterId,
                                    subjectMasterId: getSubjectListForClassModel
                                        .data![i].subjectId
                                        .toString(),
                                    date: DateTime.now()
                                        .add(Duration(days: 1))
                                        .toString())
                                .then((value) {
                              if (value != null) {
                                Get.to(() => TeacherBagComponentListScreen(
                                    sectionMasterId: classSectionMasterId,
                                    classMasterId: classMasterId,
                                    subjectMasterId: getSubjectListForClassModel
                                        .data![i].subjectId
                                        .toString(),
                                    teacherBagComponentModel: value));
                              }
                            });
                            return;
                          } else {
                            BagComponentModel model =
                                await TeacherController().getBagComponentList();
                            Get.to(() => BagComponentScreen(
                                  classId: classMasterId,
                                  className: className ?? "Not found",
                                  sectionId: classSectionMasterId,
                                  sectionName: sectionName,
                                  subjectName: getSubjectListForClassModel
                                          .data![i].name ??
                                      "",
                                  subjectId: getSubjectListForClassModel
                                      .data![i].subjectId
                                      .toString(),
                                  model: model,
                                ));
                            return;
                          }
                        }

                        TeacherController()
                            .getClassHomeWorkBySubjectDate(
                                classMasterId: classMasterId,
                                subjectMasterId: getSubjectListForClassModel
                                    .data![i].id
                                    .toString(),
                                classSectionMasterId: classSectionMasterId,
                                navigate: false)
                            .then((value) {
                          GetClassHomeWorkBySubjectDateModel
                              getClassHomeWorkBySubjectDateModel = value;
                          Get.to(() => UploadHomeWork(
                                title: "",
                                documents: getClassHomeWorkBySubjectDateModel
                                    .data!.documentsList!,
                                classSectionMasterId: classSectionMasterId,
                                rowVersion: getClassHomeWorkBySubjectDateModel
                                    .data!.rowVersion
                                    .toString(),
                                classMasterId: classMasterId,
                                subjectMasterId: getSubjectListForClassModel
                                    .data![i].id
                                    .toString(),
                                className: className,
                                subjectName: getSubjectListForClassModel
                                    .data![i].name
                                    .toString(),
                                homeWorkId: getSubjectListForClassModel
                                    .data![i].id
                                    .toString(),
                                getClassHomeWorkBySubjectDateModel:
                                    getClassHomeWorkBySubjectDateModel,
                                filled: true,
                              ));
                        });
                      },
                      child: subjectCard(
                          subjectName: getSubjectListForClassModel.data![i].name
                              .toString()));
                }),
          )
        ],
      )),
    );
  }
}
