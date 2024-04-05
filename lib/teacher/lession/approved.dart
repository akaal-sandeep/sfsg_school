import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import '../../common-functions.dart';
import '../../teacher_model/get_lesson_plan_list.dart' as that;

import '../../teacher_model/teacher_class_homework_model.dart';
import '../../teacher_model/teacher_class_list_model.dart';
import '../../utility/custom_decoration.dart';
import 'create_lession.dart';

class ApprovedLesson extends StatelessWidget {
  List<that.Data> data;
   ApprovedLesson({Key? key,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(data.length.isEqual(0)){
      return myImage(isNetwork: false, source: "assets/icons/empty.png");
    }
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context,i){
          return InkWell(
            onTap: () {
              TeacherClassHomeworkModel teacherClassHomeworkModel =
              TeacherClassHomeworkModel();
              TeacherClassesListModel teacherClassesListModel = TeacherClassesListModel();
              Get.to(() => CreateLesson(
                data: data[i],
                notEditable: true,
                principalSide: true,
                subjectList: teacherClassHomeworkModel,
                classList: teacherClassesListModel,
              ));
              },
            child: listCard(
                showImage: false,
                backgroundColor: Colors.blue.withOpacity(.2),
                imageUrl: "sdsd",
                content:(isTeacher()||isParent())? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(data[i].subjectName ?? "",
                        style: CommonDecoration.subHeaderStyle),
                    SizedBox(
                      height: 5,
                    ),
                    Text("${data[i].className}-${data[i].sectionName}",
                        style: CommonDecoration.smallLabel),
                    Text(
                        "${getTimeFormat(DateTime.parse(data[i].fromDate.toString()))} - ${getTimeFormat(DateTime.parse(data[i].toDate.toString()))}",
                        style: CommonDecoration.smallLabel),
                  ],
                ):Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(data[i].employeeName ?? "",
                        style: CommonDecoration.subHeaderStyle),
                    SizedBox(
                      height: 5,
                    ),
                    Text("${data[i].className}-${data[i].subjectName}",
                        style: CommonDecoration.smallLabel),
                    Text("${data[i].className}-${data[i].sectionName}",
                        style: CommonDecoration.smallLabel),
                    Text(
                        "${getTimeFormat(DateTime.parse(data[i].fromDate.toString()))} - ${getTimeFormat(DateTime.parse(data[i].toDate.toString()))}",
                        style: CommonDecoration.smallLabel),
                  ],
                )
            ),
          );
        });;
  }
}
