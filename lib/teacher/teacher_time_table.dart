import 'package:flutter/material.dart';
import 'package:web_school_manager/teacher_model/teacher_timetable_model.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

class TeacherTimeTable extends StatefulWidget {
  TeacherTimeTableModel teacherTimeTableModel;

  TeacherTimeTable({Key? key, required this.teacherTimeTableModel})
      : super(key: key);

  @override
  State<TeacherTimeTable> createState() => _TeacherTimeTableState();
}

class _TeacherTimeTableState extends State<TeacherTimeTable> {
  var timeTableData = {
    "timeTable": [
      {
        "day": "Monday",
        "period": [
          {"id": "1", "subject": "Hindi", "teacher": "unknown"},
          {"id": "2", "subject": "English", "teacher": "unknown"}
        ],
      },
      {
        "day": "Tuesday",
        "period": [
          {"id": "1", "subject": "Science", "teacher": "unknown"},
          {"id": "2", "subject": "Math", "teacher": "unknown"}
        ],
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
          child: Column(
        children: [
          CommonHeader(title: "Time Table"),
          SizedBox(
            height: 30,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: ListView.builder(
                itemCount: widget.teacherTimeTableModel.data!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      widget.teacherTimeTableModel.data![i].showData =
                          !widget.teacherTimeTableModel.data![i].showData;
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        boxShadow: myShadow
                      ),
                      child: Column(
                        children: [
                          rowHeight(
                              index: -1,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Center(
                                      child: myText(
                                          widget.teacherTimeTableModel.data![i]
                                                  .weekDayName ??
                                              "",
                                          true)),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: RotatedBox(quarterTurns:widget.teacherTimeTableModel.data![i].showData?-45:45,child: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,),)),
                                  )
                                ],
                              )),

                          AnimatedCrossFade(
                            crossFadeState:
                                widget.teacherTimeTableModel.data![i].showData
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                            firstChild: Container(),
                            secondChild: Column(
                              children: [
                                rowHeight(
                                  index: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child:
                                          Center(child: myText("Period", true))),
                                      Expanded(
                                          child:
                                          Center(child: myText("Subject", true))),
                                      Expanded(
                                          child:
                                          Center(child: myText("Class", true))),
                                    ],
                                  ),
                                ),
                                ListView.builder(
                                    itemCount: widget.teacherTimeTableModel.data![i]
                                        .periodList!.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, j) {
                                      PeriodList? periodList = widget
                                          .teacherTimeTableModel
                                          .data![i]
                                          .periodList![j];
                                      return rowHeight(
                                        index: j + 1,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                child: Center(
                                                    child: myText(
                                                        periodList.periodNo
                                                            .toString(),
                                                        false))),
                                            Expanded(
                                                child: Center(
                                                    child: myText(
                                                        periodList.subjectName
                                                            .toString(),
                                                        false))),
                                            Expanded(
                                                child: Center(
                                                    child: myText(
                                                        periodList.classMasterName
                                                                .toString() +
                                                            "-" +
                                                            periodList
                                                                .classSectionMasterName
                                                                .toString(),
                                                        false))),
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            ),
                            duration: Duration(seconds: 1),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ))
        ],
      )),
    );
  }

  Widget rowHeight({required Widget child, required int index}) {
    return Container(
      height: 50,
      width: double.infinity,
      color: index == -1
          ? Color(0xFF093880)
          : index == 0
              ? Color(0xFF093880).withOpacity(.5)
              : index.isEven
                  ? Color(0xFFebeff2)
                  : Colors.white.withOpacity(.8),
      child: child,
    );
  }

  Widget myText(String text, bool isWhite) {
    return Text(
      text,
      style: CommonDecoration.bigLabel.copyWith(
          color: isWhite ? Colors.white : Color(0xFF5e5f61), fontSize: 13),
    );
  }
}
