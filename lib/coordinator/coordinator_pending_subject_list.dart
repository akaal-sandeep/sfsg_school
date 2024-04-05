import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/coordinator_model/pending_work_list_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

class CoordinatorPendingSubjectList extends StatelessWidget {
  PendingHomeWorkListModel model;

  CoordinatorPendingSubjectList({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String className = Get.arguments;
    Data data = Data();
    for(int i=0;i<model.data!.length;i++){
      if(className == model.data![i].className){
        data =  model.data![i];
      }
    }
    return Scaffold(
      body: myPadding(
          child: Column(
            children: [
              CommonHeader(
                title: "Pending Homework",
                hideStudentName: true,
              ),
              smallSpace(),
              Expanded(
                  child: ListView.builder(
                    itemCount: data.subjectList!.length,
                    itemBuilder: (context, i) {
                      return subjectCard(
                          subjectName:
                          "${data.subjectList![i].subjectName}",hideArrow: true,teacherName: "Teacher : ${data.subjectList![i].employeeName}");
                    },
                  ))
            ],
          )),
    );
  }
}
