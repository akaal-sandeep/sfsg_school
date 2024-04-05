import 'package:flutter/material.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/teacher/get_result_card/model/resultcard_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

class ResultCardSubjectScreen extends StatelessWidget {
  ResultSubjectModel resultSubjectModel;
  String classId;
  String className;
  String sectionId;
  String sectionName;
  String termName;
  String termID;
  String termType;
  String termTypeId;

  ResultCardSubjectScreen(
      {super.key,
      required this.resultSubjectModel,
      required this.className,
      required this.sectionName,
      required this.sectionId,
      required this.classId,
      required this.termID,
      required this.termName,
      required this.termType,
      required this.termTypeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
        child: Column(
          children: [
            CommonHeader(
              title: "Result Card Subject List",
              hideStudentName: true,
            ),
            Text(className.toString() + "-" + sectionName + "-" + termName+" ( $termType )"),
            largeSpace(),
            Expanded(
              child: ListView.builder(
                  itemCount: resultSubjectModel.data!.length,
                  itemBuilder: (context, i) {
                    if (resultSubjectModel.data![i].id.toString() == "-1")
                      return Container();
                    return InkWell(
                        onTap: () async {
                         TeacherController().getStudentListForRemark(classId: classId, sectionId: sectionId, termsId: termID, examId: termTypeId, subjectMasterId: resultSubjectModel.data![i].id.toString());
                        },
                        child: subjectCard(
                            subjectName:
                            resultSubjectModel.data![i].name.toString()));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
