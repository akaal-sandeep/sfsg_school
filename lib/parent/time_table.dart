import 'package:flutter/material.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../parent_model/student_timetable_model.dart';

class TimeTable extends StatefulWidget {
  StudentTimeTableModel studentTimeTableModel;

  TimeTable({Key? key, required this.studentTimeTableModel}) : super(key: key);

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
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
                itemCount: widget.studentTimeTableModel.data!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      widget.studentTimeTableModel.data![i].showData =
                          !widget.studentTimeTableModel.data![i].showData;
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          rowHeight(
                              index: -1,
                              child: Stack(
                                children: [
                                  Center(
                                      child: myText(
                                          widget.studentTimeTableModel.data![i]
                                                  .weekDayName ??
                                              "",
                                          true)),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: RotatedBox(
                                          quarterTurns: widget
                                                  .studentTimeTableModel
                                                  .data![i]
                                                  .showData
                                              ? -45
                                              : 45,
                                          child: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: Colors.white,
                                          ),
                                        )),
                                  )
                                ],
                              )),
                          AnimatedCrossFade(
                            duration: Duration(seconds: 1),
                            crossFadeState:
                                widget.studentTimeTableModel.data![i].showData
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                            firstChild: Container(),
                            secondChild: Column(
                              children: [
                                rowHeight(
                                  index: 0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: Center(
                                              child: myText("Period", true))),
                                      Expanded(
                                          child: Center(
                                              child: myText("Subject", true))),
                                      Expanded(
                                          child: Center(
                                              child: myText("Teacher", true))),
                                    ],
                                  ),
                                ),
                                ListView.builder(
                                    itemCount: widget.studentTimeTableModel
                                        .data![i].periodList!.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, j) {
                                      var periodList = widget
                                          .studentTimeTableModel
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
                                                        periodList
                                                            .employeeMasterName
                                                            .toString(),
                                                        false))),
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            ),
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
      textAlign: TextAlign.center,
      style: CommonDecoration.bigLabel.copyWith(
          color: isWhite ? Colors.white : Color(0xFF5e5f61), fontSize: 13),
    );
  }
}
