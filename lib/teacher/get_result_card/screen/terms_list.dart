import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/teacher/get_result_card/screen/result_card_list.dart';
import 'package:web_school_manager/teacher_model/get_reult_terms_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';


class GetClassTermsList extends StatelessWidget {
  GetResultTermsModel getResultTermsModel;
  String classId;
  String className;
  String sectionId;
  String sectionName;

  GetClassTermsList({
    Key? key,
    required this.getResultTermsModel,
    required this.classId,
    required this.className,
    required this.sectionId,
    required this.sectionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
          child: Column(
        children: [
          CommonHeader(
            title: "Terms List",
            hideStudentName: true,
          ),
          Text(className.toString() + "-" + sectionName),
          largeSpace(),
          Expanded(
            child: ListView.builder(
                itemCount: getResultTermsModel.data!.length,
                itemBuilder: (context, i) {
                  if (getResultTermsModel.data![i].id.toString() == "-1")
                    return Container();
                  return InkWell(
                      onTap: ()async {
                        Get.to(ResultListScreen(
                          getResultCardModel:await TeacherController().getResultCard() ,
                          classId: classId,
                          className: className,
                          sectionId: sectionId,
                          sectionName: sectionName,
                          termID: getResultTermsModel.data![i].id.toString(),
                          termName: getResultTermsModel.data![i].name??"",
                        ));
                      },
                      child: subjectCard(
                          subjectName:
                              getResultTermsModel.data![i].name.toString()));
                }),
          )
        ],
      )),
    );
  }
}
