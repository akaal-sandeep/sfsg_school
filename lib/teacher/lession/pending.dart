import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/teacher/lession/create_lession.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import '../../teacher_model/get_lesson_plan_list.dart';
import '../../utility/custom_decoration.dart';

class PendingLesson extends StatelessWidget {
  List<Data> data;

  PendingLesson({Key? key, required this.data}) : super(key: key);


  teacherSide({required int i}){
    TeacherController().returnTeacherClassList().then((classList) {
      TeacherController()
          .teacherClassHomeWork(
          classMasterid: data[i].classMasterId.toString(),
          navigate: false,
          classSectionMasterid:
          data[i].sectionMasterId.toString(),
          className: data[i].className.toString())
          .then((value) {
        Get.to(() => CreateLesson(
          data: data[i],
          subjectList: value,
          classList: classList,
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data.length.isEqual(0)) {
      return myImage(isNetwork: false, source: "assets/icons/empty.png");
    }
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {
              if (isTeacher()) {
               teacherSide(i: i);
              }else{
                Get.to(() => CreateLesson(data: data[i],principalSide:true));
              }
            },
            child: listCard(
                showImage: false,
                imageUrl: "sdsd",
                content:isTeacher()? Column(
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
        });
  }
}
