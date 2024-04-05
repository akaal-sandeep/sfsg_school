import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/constants/string_constants.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/controller/temp_principal_controller.dart';
import 'package:web_school_manager/local_storage/local_storage.dart';
import 'package:web_school_manager/teacher/get_result_card/screen/terms_list.dart';
import 'package:web_school_manager/teacher_model/get_reult_terms_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../teacher_model/get_class_section_list_model.dart';

class SectionSyllabus extends StatelessWidget {
  GetClassSectionListModel getClassSectionListModel;
  String classMasterId;
  bool? fromHomeWork;
  String? className;
  bool? fromClassWork;
  bool? fromResultCard;
  bool? fromBagComponents;

  SectionSyllabus(
      {Key? key,
      required this.getClassSectionListModel,
      required this.classMasterId,
      this.fromHomeWork,
      this.fromClassWork,
      this.className,
      this.fromResultCard,
      this.fromBagComponents})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    myLog(label: "from", value: "${fromBagComponents}");
    return Scaffold(
      body: myPadding(
          child: Column(
        children: [
          CommonHeader(
            title: "Section",
            hideStudentName: true,
          ),
          Text(className.toString()),
          largeSpace(),
          Expanded(
            child: ListView.builder(
                itemCount: getClassSectionListModel.data!.length,
                itemBuilder: (context, i) {
                  if (getClassSectionListModel.data![i].id.toString() == "-1")
                    return Container();
                  return InkWell(
                      onTap: () async {
                        if (fromBagComponents == true) {

                          // TempPrincipalController().getSubjectListForClass(
                          //     id: classMasterId.toString(),
                          //     fromBagComponents: true,
                          //     className: className,
                          //     classMasterId: classMasterId,
                          //     sectionName: getClassSectionListModel
                          //         .data![i].name
                          //         .toString(),
                          //     sectionMasterId: getClassSectionListModel
                          //         .data![i].id
                          //         .toString());

                          TeacherController().teacherClassHomeWork(
                            fromComponent: true,
                            sectionName:getClassSectionListModel
                                   .data![i].name
                                   .toString() ,
                            // fromBagComponents: fromBagComponents,
                            //   id: classMasterId.toString(),
                             className: className??"",
                              classMasterid: classMasterId,
                              // sectionName: getClassSectionListModel
                              //     .data![i].name
                              //     .toString(),
                              // sectionMasterid: getClassSectionListModel
                              //     .data![i].id
                              //     .toString(),
                            classSectionMasterid:getClassSectionListModel
                                 .data![i].id
                                 .toString()
                                   );

                          return;
                        }

                        if (fromResultCard == true) {
                          GetResultTermsModel model =
                              await TeacherController().getResultCardTerms();
                          Get.to(() => GetClassTermsList(
                              getResultTermsModel: model,
                              classId: classMasterId,
                              className: className ?? "Not found",
                              sectionId: getClassSectionListModel.data?[i].id
                                      .toString() ??
                                  "",
                              sectionName:
                                  getClassSectionListModel.data?[i].name ??
                                      ""));
                          return;
                        }

                        if (fromHomeWork == true) {
                          String userType = LocalStorage()
                              .read(key: StringConstants.userType);

                          if (StringConstants.principleType == userType) {
                            TempPrincipalController()
                                .getClassHomeWorkListByClassSection(
                                    className: className!,
                                    sectionName:
                                        getClassSectionListModel.data![i].name!,
                                    classMasterId: classMasterId,
                                    sectionMasterId: getClassSectionListModel
                                        .data![i].id
                                        .toString(),
                                    date: DateTime.now().toString());
                            return;
                          }

                          TempPrincipalController().getSubjectListForClass(
                              id: classMasterId.toString(),
                              className: className,
                              classMasterId: classMasterId,
                              sectionName: getClassSectionListModel
                                  .data![i].name
                                  .toString(),
                              sectionMasterId: getClassSectionListModel
                                  .data![i].id
                                  .toString());
                          return;
                        }
                        if (fromClassWork == true) {
                          TeacherController().getClassWorkSubjectList(
                              classMasterId: classMasterId,
                              className: className.toString() +
                                  " [${getClassSectionListModel.data![i].name.toString()}]",
                              classSectionMasterId: getClassSectionListModel
                                  .data![i].id
                                  .toString());
                          return;
                        }
                        TeacherController().getSyllabusListByClassSection(
                            classMasterId: classMasterId,
                            classSectionMasterId: getClassSectionListModel
                                .data![i].id
                                .toString());
                      },
                      child: subjectCard(
                          subjectName: getClassSectionListModel.data![i].name
                              .toString()));
                }),
          )
        ],
      )),
    );
  }
}
