import 'package:flutter/material.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../utility/custom_decoration.dart';

class StudentClassWork extends StatefulWidget {
  const StudentClassWork({Key? key}) : super(key: key);

  @override
  State<StudentClassWork> createState() => _StudentClassWorkState();
}

class _StudentClassWorkState extends State<StudentClassWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(child: Column(
        children: [
          CommonHeader(title: "Class Work"),
          smallSpace(),
          Text(
            "aaa",
            style: CommonDecoration.subHeaderStyle,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, i) {
                    return InkWell(
                        onTap: () {
                          // TeacherController().getTeacherClassTestListBySubject(
                          //     classMasterId: classMasterId,
                          //     navigate: true,
                          //     classTestListModel: classTestListModel,
                          //     classSectionMasterId: classSectionMasterId,
                          //     subjectMasterId:
                          //     classTestListModel.data![i].id.toString(),
                          //     subjectName:
                          //     classTestListModel.data![i].subjectName ?? "",
                          //     className: className);
                          // Get.to(() => SubjectChapterTest());
                        },
                        child: subjectCard(
                            subjectName:
                            "aaa"));
                  }))

        ],
      )),

    );
  }
}
