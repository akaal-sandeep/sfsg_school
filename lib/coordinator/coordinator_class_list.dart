import 'package:flutter/material.dart';
import 'package:web_school_manager/controller/temp_principal_controller.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../teacher_model/teacher_class_list_model.dart';
import '../controller/coordinator_controller.dart';

class CoordinatorClassList extends StatelessWidget {
  TeacherClassesListModel model;
  bool uploaded;

  CoordinatorClassList({Key? key, required this.model,required this.uploaded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
          child: Column(
            children: [
              CommonHeader(
                title:uploaded? "Uploaded Homework":"Pending Homework",
                hideStudentName: true,
              ),
              smallSpace(),
              Expanded(
                  child: ListView.builder(
                    itemCount: model.data!.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                          onTap: () {
                            if(uploaded){
                              TempPrincipalController().getSubjectListForClass(
                                  id: model.data![i].classMasterId.toString(),
                                  className: model.data![i].className,
                                  classMasterId: model.data![i].classMasterId.toString(),
                                  sectionName: model.data![i].classSectionName,
                                  sectionMasterId: model.data![i].classSectionMasterId.toString());
                            }else{
                              CoordinatorController().getPendingHomeList(className: model.data![i].className!);
                            }
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
