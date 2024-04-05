import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/teacher/get_result_card/model/resultcard_model.dart';
import 'package:web_school_manager/teacher/get_result_card/screen/result_card_subject_list_screen.dart';
import 'package:web_school_manager/teacher_model/get_result_card_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';


class ResultListScreen extends StatelessWidget {
  GetResultCardModel getResultCardModel;
  String classId;
  String className;
  String sectionId;
  String sectionName;
  String termName;
  String termID;

  ResultListScreen(
      {Key? key,
      required this.getResultCardModel,
      required this.classId,
      required this.className,
      required this.sectionId,
      required this.sectionName,
      required this.termID,
      required this.termName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
          child: Column(
        children: [
          CommonHeader(
            title: "Result Card List",
            hideStudentName: true,
          ),
          Text(className.toString() + "-" + sectionName + "-" + termName),
          largeSpace(),
          Expanded(
            child: ListView.builder(
                itemCount: getResultCardModel.data!.length,
                itemBuilder: (context, i) {
                  if (getResultCardModel.data![i].id.toString() == "-1")
                    return Container();
                  return InkWell(
                      onTap: () async {
                        myLog(label: "check", value: "check");
                        ResultSubjectModel model = await TeacherController()
                            .getResultSubjectList(
                                classId: classId,
                                sectionId: sectionId,
                                termsId: termID,
                                examId:
                                    getResultCardModel.data![i].id.toString());
                        Get.to(() => ResultCardSubjectScreen(
                              resultSubjectModel: model,
                              classId: classId,
                              className: className,
                              sectionId: sectionId,
                              sectionName: sectionName,
                              termID: termID,
                              termName: termName,
                              termType:
                                  getResultCardModel.data![i].name.toString(),
                              termTypeId:
                                  getResultCardModel.data![i].id.toString(),
                            ));
                      },
                      child: subjectCard(
                          subjectName:
                              getResultCardModel.data![i].name.toString()));
                }),
          )
        ],
      )),
    );
  }
}
