import 'package:flutter/material.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../teacher_model/teacher_class_list_model.dart';

class TeacherClass extends StatelessWidget {
  TeacherClassesListModel model;

  TeacherClass({Key? key, required this.model}) : super(key: key);


  navigateToHomeWork({required String classMasterid, required String classSectionMasterid, required String className}){
    TeacherController().teacherClassHomeWork( classMasterid: classMasterid,
        classSectionMasterid: classSectionMasterid,className:className );
  }


  @override
  Widget build(BuildContext context) {

    List<Data> allClass = [];
    List<Data> inChargeClass = [];

    for (int i = 0; i < model.data!.length; i++) {
      if (model.data![i].isClassIncharge ?? false) {
        inChargeClass.add(model.data![i]);
      } else {
        allClass.add(model.data![i]);
      }
    }

    return Scaffold(
      body: myPadding(
          child: Column(
        children: [
          CommonHeader(
            title: "Classes",
            hideStudentName: true,
          ),
          smallSpace(),
          ListView.builder(
            itemCount: inChargeClass.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              Data data = inChargeClass[i];
              return Container(
                margin: EdgeInsets.only(bottom: 10 ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                    boxShadow: myShadow,
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Text(
                      data.className.toString() +
                          "-" +
                          data.classSectionName.toString(),
                      style: CommonDecoration.subHeaderStyle
                          .copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: InkWell(
                              onTap: () {
                                TeacherController().getStudentListForAttendance(
                                    classMasterId: data.classMasterId.toString(),
                                    sectionMasterId: data.classSectionMasterId.toString(),
                                    attendanceDate: getTimeFormat(DateTime.now()));
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.white)),
                                  child: Text(
                                    "Attendance",
                                    style: CommonDecoration.smallLabel
                                        .copyWith(color: Colors.white),
                                  )),
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: InkWell(
                              onTap: () {
                                navigateToHomeWork( classMasterid: data.classMasterId.toString(),
                                    classSectionMasterid: data.classSectionMasterId.toString(),className:data.className.toString() +
                                        "-" +
                                        data.classSectionName.toString());
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.white)),
                                  child: Text(
                                    "Home Work",
                                    style: CommonDecoration.smallLabel
                                        .copyWith(color: Colors.white),
                                  )),
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: InkWell(
                              onTap: () {
                                TeacherController().GetClassTestList(classMasterId: data.classMasterId.toString(), classSectionMasterId:  data.classSectionMasterId.toString(), className: data.className.toString() +
                                    "-" +
                                    data.classSectionName.toString());
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.white)),
                                  child: Text(
                                    "Test",
                                    style: CommonDecoration.smallLabel
                                        .copyWith(color: Colors.white),
                                  )),
                            )),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
          Expanded(
              child: ListView.builder(
            itemCount: allClass.length,
            itemBuilder: (context, i) {
              Data data = allClass[i];
              return Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                    boxShadow: myShadow,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Text(
                      data.className.toString() +
                          "-" +
                          data.classSectionName.toString(),
                      style: CommonDecoration.subHeaderStyle
                          .copyWith(color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: InkWell(
                              onTap: (){
                                navigateToHomeWork( classMasterid: data.classMasterId.toString(),
                                    classSectionMasterid: data.classSectionMasterId.toString(),className:data.className.toString() +
                                        "-" +
                                        data.classSectionName.toString());
                              },
                          child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black)),
                              child: Text(
                                "Home Work",
                                style: CommonDecoration.smallLabel
                                    .copyWith(color: Colors.black),
                              )),
                        )),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: InkWell(
                              onTap:(){
                                TeacherController().GetClassTestList(classMasterId: data.classMasterId.toString(), classSectionMasterId:  data.classSectionMasterId.toString(), className: data.className.toString() +
                                    "-" +
                                    data.classSectionName.toString());
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.black)),
                                  child: Text(
                                    "Test",
                                    style: CommonDecoration.smallLabel
                                        .copyWith(color: Colors.black),
                                  )),
                            )),
                      ],
                    )
                  ],
                ),
              );
            },
          ))
        ],
      )),
    );
  }


}
