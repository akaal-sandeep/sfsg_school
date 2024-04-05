import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:web_school_manager/controller/parent_controller.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../constants/color_constants.dart';
import '../parent_model/student_attendance_model.dart';

class Attendance extends StatefulWidget {
  StudentAttendanceModel studentAttendanceModel;
  String? admissionNumber;

  Attendance({Key? key, required this.studentAttendanceModel,this.admissionNumber})
      : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  List absent = [];
  List present = [];
  List leave = [];
  List holiday = [];

  List halfDay = [];
  List holidayReasonList = [];
  List _holidaysDate=[];
  List markedHolidayReasonList = [];
  List _markedHolidaysDate=[];


  DateTime selectedDate = DateTime.now();
  //2022-07-02
  @override
  void initState() {
    for (int i = 0; i < widget.studentAttendanceModel.data!.calendarEntries!.length;
    i++) {
      if (widget.studentAttendanceModel.data!.calendarEntries![i].legendText ==
          "Holiday"||widget.studentAttendanceModel.data!.calendarEntries![i].legendText =="Marked Holiday") {

        holiday.add(DateFormat("yyyy-MM-dd").format(DateTime.parse(widget
            .studentAttendanceModel
            .data!
            .calendarEntries![i]
            .calendarDate ??
            "")));

        if(widget.studentAttendanceModel.data!.calendarEntries![i].legendText == "Holiday"){
          holidayReasonList.add(widget
              .studentAttendanceModel
              .data!
              .calendarEntries![i]
              .remarks);



          _holidaysDate.add(DateFormat("yyyy-MM-dd").format(DateTime.parse(widget
              .studentAttendanceModel
              .data!
              .calendarEntries![i]
              .calendarDate ??
              "")));
        }

        if(widget.studentAttendanceModel.data!.calendarEntries![i].legendText == "Marked Holiday"){
          markedHolidayReasonList.add(widget
              .studentAttendanceModel
              .data!
              .calendarEntries![i]
              .remarks);



          _markedHolidaysDate.add(DateFormat("yyyy-MM-dd").format(DateTime.parse(widget
              .studentAttendanceModel
              .data!
              .calendarEntries![i]
              .calendarDate ??
              "")));
        }


      }



      if (widget.studentAttendanceModel.data!.calendarEntries![i].legendText ==
          "Present") {
        present.add(DateFormat("yyyy-MM-dd").format(DateTime.parse(widget
            .studentAttendanceModel
            .data!
            .calendarEntries![i]
            .calendarDate ??
            "")));
      }

      if (widget.studentAttendanceModel.data!.calendarEntries![i].legendText ==
          "Leave") {
        leave.add(DateFormat("yyyy-MM-dd").format(DateTime.parse(widget
            .studentAttendanceModel
            .data!
            .calendarEntries![i]
            .calendarDate ??
            "")));
      }

      if (widget.studentAttendanceModel.data!.calendarEntries![i].legendText ==
          "Half Day") {
        halfDay.add(DateFormat("yyyy-MM-dd").format(DateTime.parse(widget
            .studentAttendanceModel
            .data!
            .calendarEntries![i]
            .calendarDate ??
            "")));
      }

      if (widget.studentAttendanceModel.data!.calendarEntries![i].legendText ==
          "Absent") {
        absent.add(DateFormat("yyyy-MM-dd").format(DateTime.parse(widget
            .studentAttendanceModel
            .data!
            .calendarEntries![i]
            .calendarDate ??
            "")));
      }

    }

    myLog(label: "present", value: present.toString());
    // TODO: implement initState
    super.initState();
  }

  Widget absentMark() {
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(10)),
      child: Text(
        "A",
        style: TextStyle(
          fontSize: 8,
          color: Colors.white
        ),
      ),
    );
  }

  Widget presentMark() {
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(10)),
      child:Text(
        "P",
        style: TextStyle(
            fontSize: 8,

            color: Colors.white
        ),
      ),
    );
  }

  Widget leaveMark() {
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: ColorConstants.themeColor, borderRadius: BorderRadius.circular(10)),
      child: Text(
        "L",
        style: TextStyle(
            fontSize: 8,

            color: Colors.white
        ),
      ),
    );
  }

  Widget halfDayMark() {
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.orange, borderRadius: BorderRadius.circular(10)),
      child: Text(
        "HD",

        style: TextStyle(
            fontSize: 8,
            color: Colors.white
        ),
      ),

    );
  }

  Widget holidayMark() {
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.pinkAccent, borderRadius: BorderRadius.circular(10)),
      child: Text(
        "HO",

        style: TextStyle(
            fontSize: 8,
            color: Colors.white
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: myPadding(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CommonHeader(title: "Attendance"),
                TableCalendar(
                  headerStyle: HeaderStyle(
                      titleCentered: true
                  ),
                  onFormatChanged: (format) {


                  },

                  availableCalendarFormats: {
                    CalendarFormat.month: 'Month',


                    // CalendarFormat.week: 'This month'

                  },
                  onPageChanged: (v) {
                    selectedDate = v;
                    absent = [];
                    present = [];
                    leave = [];
                    holiday = [];
                    halfDay = [];
                    holidayReasonList = [];
                    markedHolidayReasonList = [];
                    _markedHolidaysDate=[];
                    ParentController()
                        .getStudentAttendance(
                      admissionNumber: widget.admissionNumber,
                        month: v.month.toString(), year: v.year.toString())
                        .then((value) {
                      widget.studentAttendanceModel = value;
                      for (int i = 0;
                      i <
                          widget.studentAttendanceModel.data!.calendarEntries!
                              .length;
                      i++) {
                        if (widget.studentAttendanceModel.data!.calendarEntries![i].legendText ==
                            "Holiday"||widget.studentAttendanceModel.data!.calendarEntries![i].legendText =="Marked Holiday") {

                          holiday.add(DateFormat("yyyy-MM-dd").format(DateTime.parse(widget
                              .studentAttendanceModel
                              .data!
                              .calendarEntries![i]
                              .calendarDate ??
                              "")));

                          if(widget.studentAttendanceModel.data!.calendarEntries![i].legendText == "Holiday"){
                            holidayReasonList.add(widget
                                .studentAttendanceModel
                                .data!
                                .calendarEntries![i]
                                .remarks);



                            _holidaysDate.add(DateFormat("yyyy-MM-dd").format(DateTime.parse(widget
                                .studentAttendanceModel
                                .data!
                                .calendarEntries![i]
                                .calendarDate ??
                                "")));
                          }

                          if(widget.studentAttendanceModel.data!.calendarEntries![i].legendText == "Marked Holiday"){
                            markedHolidayReasonList.add(widget
                                .studentAttendanceModel
                                .data!
                                .calendarEntries![i]
                                .remarks);



                            _markedHolidaysDate.add(DateFormat("yyyy-MM-dd").format(DateTime.parse(widget
                                .studentAttendanceModel
                                .data!
                                .calendarEntries![i]
                                .calendarDate ??
                                "")));
                          }


                        }
                        if (widget.studentAttendanceModel.data!.calendarEntries![i]
                            .legendText ==
                            "Present") {
                          present.add(DateFormat("yyyy-MM-dd").format(DateTime.parse(
                              widget.studentAttendanceModel.data!.calendarEntries![i]
                                  .calendarDate ??
                                  "")));
                        }
                        if (widget.studentAttendanceModel.data!.calendarEntries![i]
                            .legendText ==
                            "Leave") {
                          leave.add(DateFormat("yyyy-MM-dd").format(DateTime.parse(
                              widget.studentAttendanceModel.data!.calendarEntries![i]
                                  .calendarDate ??
                                  "")));
                        }
                        if (widget.studentAttendanceModel.data!.calendarEntries![i]
                            .legendText ==
                            "Half Day") {
                          halfDay.add(DateFormat("yyyy-MM-dd").format(DateTime.parse(
                              widget.studentAttendanceModel.data!.calendarEntries![i]
                                  .calendarDate ??
                                  "")));
                        }
                        if (widget.studentAttendanceModel.data!.calendarEntries![i]
                            .legendText ==
                            "Absent") {
                          absent.add(DateFormat("yyyy-MM-dd").format(DateTime.parse(
                              widget.studentAttendanceModel.data!.calendarEntries![i]
                                  .calendarDate ??
                                  "")));
                        }
                      }
                      setState(() {});
                    });
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (BuildContext context, date, events) {
                      if (absent.contains(date.toString().split(" ")[0])) {
                        return absentMark();
                      }
                      if (present.contains(date.toString().split(" ")[0])) {
                        return presentMark();
                      }
                      if (leave.contains(date.toString().split(" ")[0])) {
                        return leaveMark();
                      }
                      if (halfDay.contains(date.toString().split(" ")[0])) {
                        return halfDayMark();
                      }
                      if (holiday.contains(date.toString().split(" ")[0])) {
                        return holidayMark();
                      }
                      return null;

                    },
                  ),
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.now(),
                  weekendDays: [DateTime.sunday],
                  focusedDay:selectedDate,

                ),
                smallSpace(),
                greyLine(),
                smallSpace(),
                Container(

                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Text(
                                      "P",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text("Present(${widget.studentAttendanceModel.data!.presentDays})")
                                ],
                              ),
                              smallSpace(),
                              Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Text(
                                      "HD",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text("Half Day(${widget.studentAttendanceModel.data!.halfDays})")
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Text(
                                      "A",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text("Absent(${widget.studentAttendanceModel.data!.absentDays})")
                                ],
                              ),
                              smallSpace(),
                              Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.pinkAccent,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Text(
                                      "HO",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text("Holiday(${holiday.length})")
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: ColorConstants.themeColor,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Text(
                                      "L",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text("Leave(${widget.studentAttendanceModel.data!.leaveDays})")
                                ],
                              ),
                              smallSpace(),
                              Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.cyan,
                                        borderRadius: BorderRadius.circular(20)),
                                    child: Text(
                                      "W",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text("Working(${widget.studentAttendanceModel.data!.workingDays})")
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                smallSpace(),
                greyLine(),
                smallSpace(),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Holidays Details",
                      style: CommonDecoration.smallLabel,
                    )),
                holidayReasonList.isEmpty? Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "    - No holiday this month",
                      style: CommonDecoration.smallLabel,
                    )):ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: holidayReasonList.length,
                        itemBuilder: (context,i){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "    - ${holidayReasonList[i]}"+"-${_holidaysDate[i]}",
                              style: CommonDecoration.smallLabel,
                            ),
                          );
                        }),
                smallSpace(),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Marked Holidays Details",
                      style: CommonDecoration.smallLabel,
                    )),
                markedHolidayReasonList.isEmpty? Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "    - No marked holiday this month",
                      style: CommonDecoration.smallLabel,
                    )):ListView.builder(
                  primary: false,
                        shrinkWrap: true,
                        itemCount: markedHolidayReasonList.length,
                        itemBuilder: (context,i){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "    - ${markedHolidayReasonList[i]}"+"-${_markedHolidaysDate[i]}",
                              style: CommonDecoration.smallLabel,
                            ),
                          );
                        }),
              ],
            ),
          )),
    );
  }
}
