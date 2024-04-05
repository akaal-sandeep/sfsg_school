import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/constants/color_constants.dart';

import 'package:web_school_manager/principal_model/student_attendance_details.dart';
import 'package:web_school_manager/principal_model/student_attendance_details.dart'
    as data;

import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';
import 'package:web_school_manager/widget/mytextfield.dart';

import '../../controller/principal_controller.dart';

class StudentAttendanceSummary extends StatefulWidget {
  StudentAttendanceDetailsModel studentAttendanceDetails;
  bool? fromCoordinator;

  StudentAttendanceSummary(
      {Key? key, required this.studentAttendanceDetails, this.fromCoordinator})
      : super(key: key);

  @override
  State<StudentAttendanceSummary> createState() =>
      _StudentAttendanceSummaryState();
}

class _StudentAttendanceSummaryState extends State<StudentAttendanceSummary> {
  List<data.Data> _searchAttendanceList = [];
  final controller = Get.put(PrincipalController());
  bool isExpanded = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      controller.searchController!.clear();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.searchController!.addListener(() {
      _searchAttendanceList = [];

      for (var element in widget.studentAttendanceDetails.data!) {
        if (element.cLASSNAME!
            .toUpperCase()
            .contains(controller.searchController!.value.text.toUpperCase())) {
          myLog(
              label: controller.searchController!.value.text,
              value: element.cLASSNAME);
          _searchAttendanceList.add(element);
        }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
        child: Column(
          children: <Widget>[
            CommonHeader(title: "Student Attendance"),
            smallSpace(),
            _searchField(),
            smallSpace(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    smallSpace(),
                    controller.searchController!.value.text.length.isEqual(0)
                        ? widget.studentAttendanceDetails.data!.length
                                .isEqual(0)
                            ? myImage(
                                isNetwork: false,
                                source: "assets/icons/empty.png")
                            : ListView.separated(
                                padding: EdgeInsets.only(bottom: 20),
                                shrinkWrap: true,
                                itemCount: widget
                                    .studentAttendanceDetails.data!.length,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Theme(
                                    data: ThemeData().copyWith(
                                        dividerColor: Colors.transparent),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: ExpansionTile(
                                        collapsedTextColor: Colors.white,
                                        tilePadding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 0),
                                        collapsedIconColor: Colors.white,
                                        textColor: ColorConstants.themeColor,
                                        collapsedBackgroundColor:
                                            ColorConstants.themeColor,
                                        childrenPadding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        title: Text(
                                          "${widget.studentAttendanceDetails.data![index].cLASSNAME ?? ""}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            // color: ColorConstants.themeColor
                                          ),
                                        ),
                                        children: <Widget>[
                                          _rowTextFun(
                                              title: "Total Students in Class",
                                              subTitle:
                                                  "${widget.studentAttendanceDetails.data![index].tOTALSTUDENTS ?? ""}",
                                              index: index),
                                          _rowTextFun(
                                              title: "Total Present",
                                              subTitle:
                                                  "${widget.studentAttendanceDetails.data![index].pRESENTCOUNT ?? ""}",
                                              index: index),
                                          _rowTextFun(
                                              title: "Total Absent",
                                              subTitle:
                                                  "${widget.studentAttendanceDetails.data![index].aBSENTCOUNT ?? ""}",
                                              index: index),
                                          _rowTextFun(
                                              title: "Total Pending",
                                              subTitle:
                                                  "${widget.studentAttendanceDetails.data![index].pENDINGATTENDANCE ?? ""}",
                                              index: index),
                                          smallSpace(),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return smallSpace();
                                },
                              )
                        : _searchAttendanceList.length.isEqual(0)
                            ? myImage(
                                isNetwork: false,
                                source: "assets/icons/empty.png")
                            : ListView.separated(
                                padding: EdgeInsets.only(bottom: 20),
                                shrinkWrap: true,
                                itemCount: _searchAttendanceList.length,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Theme(
                                    data: ThemeData().copyWith(
                                        dividerColor: Colors.transparent),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: ExpansionTile(
                                        collapsedTextColor: Colors.white,
                                        tilePadding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 0),
                                        collapsedIconColor: Colors.white,
                                        textColor: ColorConstants.themeColor,
                                        collapsedBackgroundColor:
                                            ColorConstants.themeColor,
                                        childrenPadding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        title: Text(
                                          "${_searchAttendanceList[index].cLASSNAME ?? ""}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            // color: ColorConstants.themeColor
                                          ),
                                        ),
                                        children: <Widget>[
                                          _rowTextFun(
                                              title: "Total Students in Class",
                                              subTitle:
                                                  "${_searchAttendanceList[index].tOTALSTUDENTS ?? ""}"),
                                          _rowTextFun(
                                              title: "Total Present",
                                              subTitle:
                                                  "${_searchAttendanceList[index].pRESENTCOUNT ?? ""}"),
                                          _rowTextFun(
                                              title: "Total Absent",
                                              subTitle:
                                                  "${_searchAttendanceList[index].aBSENTCOUNT ?? ""}"),
                                          _rowTextFun(
                                              title: "Total Pending",
                                              subTitle:
                                                  "${_searchAttendanceList[index].pENDINGATTENDANCE ?? ""}"),
                                          smallSpace(),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return smallSpace();
                                },
                              ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rowTextFun({title, subTitle, index}) {
    return InkWell(
      onTap: () {
        PrincipalController().getStudentListByClassSection(
            filter: title.toString().contains("Total Students in Class")
                ? "all"
                : title.toString().contains("Total Present")
                    ? "present"
                    : title.toString().contains("Total Absent")
                        ? "absent"
                        : "pending",
            admissionNumber: "",
            classMasterId: widget
                .studentAttendanceDetails.data![index].cLASSMASTERID
                .toString(),
            classMasterSectionId: widget
                .studentAttendanceDetails.data![index].cLASSSECTIONMASTERID
                .toString(),
            employeeMasterId: 1.toString(),
            fromDate: "",
            id: "",
            sectionMasterId: "",
            subjectMasterId: "",
            toDate: "");
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 13, color: Colors.black),
            ),
            Text(
              subTitle,
              style: TextStyle(fontSize: 13, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  Widget _searchField() {
    return MyTextFieldWithWidget(
        hint: "Search",
        inputType: TextInputType.emailAddress,
        textEditingController: controller.searchController!,
        focusNode: controller.searchNode!,
        borderColor: ColorConstants.themeColor,
        borderRadius: 10,
        filled: false,
        prefixWidget: Icon(Icons.search),
        isValidate: false);
  }
}
