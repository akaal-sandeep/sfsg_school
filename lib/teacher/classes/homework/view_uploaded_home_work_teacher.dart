import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../../teacher_model/get_student_list_for_upload_class_home_work_model.dart';

class ViewUploadedHomeWork extends StatefulWidget {
  GetStudentListforUploadClassHomeWorkModel
      getStudentListforUploadClassHomeWorkModel;
  String classMasterId;
  String sectionMasterId;
  String subjectMasterId;

  ViewUploadedHomeWork(
      {Key? key,
      required this.getStudentListforUploadClassHomeWorkModel,
      required this.subjectMasterId,
      required this.classMasterId,
      required this.sectionMasterId})
      : super(key: key);

  @override
  State<ViewUploadedHomeWork> createState() => _ViewUploadedHomeWorkState();
}

class _ViewUploadedHomeWorkState extends State<ViewUploadedHomeWork> {
  List attendance = [];
  String sortBy = "Roll No.";

  DateTime time = DateTime.now();

  Future getTime() async {
    DateTime? picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(days: 1)),
        firstDate: DateTime.now().subtract(Duration(days: 10)),
        lastDate: DateTime.now().add(Duration(days: 365)));
    return picker;
  }

  @override
  void initState() {
    for (int i = 0; i < 10; i++) {
      attendance.add("Present");
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          getTime().then((value) {
            time = value;
            TeacherController()
                .getStudentListForClassHomeWork(
                    classMasterId: widget.classMasterId,
                    classSectionMasterId: widget.sectionMasterId,
                    subjectMasterId: widget.subjectMasterId,
                    navigate: false,
                    homeWorkUploadDate: getTimeFormat(time))
                .then((value) {
              widget.getStudentListforUploadClassHomeWorkModel = value;
              setState(() {});
            });
          });
        },
        child: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(left: 30),
          decoration: BoxDecoration(
            boxShadow: myShadow,
            borderRadius: BorderRadius.circular(100),
            color: Colors.blue,
          ),
          child: Text(
            DateFormat("dd MMM, yyyy").format(time),
            style: CommonDecoration.listStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
      body: myPadding(
          child: Column(
        children: [
          CommonHeader(
            title: "View Home work",
            hideStudentName: true,
          ),
          smallSpace(),
          Text(
            DateFormat("dd MMM, yyyy").format(time),
            style: CommonDecoration.subHeaderStyle,
          ),
          smallSpace(),
          Row(
            children: [
              sortByOption(sortBySelected: "Roll No."),
              SizedBox(
                width: 10,
              ),
              sortByOption(sortBySelected: "ADM No."),
              SizedBox(
                width: 10,
              ),
              sortByOption(sortBySelected: "Name"),
            ],
          ),
          smallSpace(),
          Expanded(
              child: widget.getStudentListforUploadClassHomeWorkModel.data!
                          .length ==
                      0
                  ? myImage(isNetwork: false, source: "assets/icons/empty.png")
                  : ListView.builder(
                      padding: EdgeInsets.only(bottom: 70),
                      itemCount: widget
                          .getStudentListforUploadClassHomeWorkModel
                          .data!
                          .length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            TeacherController()
                                .getUploadClassHomeWorkListForStudent(
                                    admissionNo: widget
                                        .getStudentListforUploadClassHomeWorkModel
                                        .data![i]
                                        .admissionNumber
                                        .toString(),
                                    classMasterId: widget.classMasterId,
                                    homeWorkUplaodDate: time,
                                    classSectionMasterId:
                                        widget.sectionMasterId,
                                    subjectMasterID: widget.subjectMasterId);
                          },
                          child: listCard(
                              imageUrl: widget
                                      .getStudentListforUploadClassHomeWorkModel
                                      .data![i]
                                      .studentProfilePicturePath ??
                                  "",
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.getStudentListforUploadClassHomeWorkModel
                                            .data![i].name ??
                                        "",
                                    style: CommonDecoration.subHeaderStyle,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Roll no : ${widget.getStudentListforUploadClassHomeWorkModel.data![i].rollNumber}",
                                    style: CommonDecoration.smallLabel,
                                  ),
                                  Text(
                                    "ADM no : ${widget.getStudentListforUploadClassHomeWorkModel.data![i].admissionNumber}",
                                    style: CommonDecoration.smallLabel,
                                  )
                                ],
                              )),
                        );
                      })),
          smallSpace(),
        ],
      )),
    );
  }

  attendanceOption({required String option, required int index}) {
    return Expanded(
        child: InkWell(
           onTap: () {
        attendance[index] = option;
        setState(() {});
          },
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: attendance[index] == option ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color:
                    attendance[index] == option ? Colors.blue : Colors.grey)),
        child: Text(
          option,
          style: attendance[index] == option
              ? CommonDecoration.smallLabel.copyWith(color: Colors.white)
              : CommonDecoration.smallLabel,
        ),
      ),
    ));
  }

  sortByOption({required String sortBySelected}) {
    return Expanded(
        child: InkWell(
      onTap: () {
        sortBy = sortBySelected;
        setState(() {});
      },
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
              color: sortBy == sortBySelected ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.blue)),
          child: Text(
            sortBySelected,
            style: CommonDecoration.smallLabel.copyWith(
                color: sortBy == sortBySelected ? Colors.white : Colors.blue),
          )),
    ));
  }
}
