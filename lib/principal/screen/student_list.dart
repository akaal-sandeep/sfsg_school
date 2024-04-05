import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/constants/color_constants.dart';
import 'package:web_school_manager/controller/parent_controller.dart';
import 'package:web_school_manager/controller/principal_controller.dart';
import 'package:web_school_manager/parent/student_attendence.dart';
import 'package:web_school_manager/principal_model/student_list_by_class_section_model.dart';
import 'package:web_school_manager/principal_model/student_list_by_class_section_model.dart'
    as data;
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/button.dart';
import 'package:web_school_manager/widget/header.dart';
import 'package:web_school_manager/widget/mytextfield.dart';

class StudentListScreen extends StatefulWidget {
  StudentListByClassSectionModel studentListByClassSectionModel;

  StudentListScreen({Key? key, required this.studentListByClassSectionModel})
      : super(key: key);

  @override
  State<StudentListScreen> createState() => _StudentListState();
}

class _StudentListState extends State<StudentListScreen> {
  List<data.Data> _searchList = [];
  final controller = Get.put(PrincipalController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.searchController!.addListener(() {
      _searchList = [];
      for (var element in widget.studentListByClassSectionModel.data!) {
        if (element.name!
            .toUpperCase()
            .contains(controller.searchController!.value.text.toUpperCase())) {
          _searchList.add(element);
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
          CommonHeader(
            title: "Student List",
          ),
          smallSpace(),
          _searchField(),
          smallSpace(),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                smallSpace(),
                controller.searchController!.value.text.length.isEqual(0)
                    ? widget.studentListByClassSectionModel.data!.length
                            .isEqual(0)
                        ? myImage(
                            isNetwork: false, source: "assets/icons/empty.png")
                        : ListView.separated(
                            padding: EdgeInsets.only(bottom: 20),
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 60, left: 10, right: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        boxShadow: heavyShadow,
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: <Widget>[
                                        largeSpace(),
                                        largeSpace(),
                                        Text(
                                          "${widget.studentListByClassSectionModel.data![index].name ?? ""}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                        _subtitleText(
                                          index: index,
                                          subTitle: "Class : " +
                                              "${widget.studentListByClassSectionModel.data![index].className ?? ""}",
                                        ),
                                        _subtitleText(
                                          index: index,
                                          subTitle: "Admission Number : " +
                                              "${widget.studentListByClassSectionModel.data![index].admissionNumber ?? ""}",
                                        ),
                                        _subtitleText(
                                          index: index,
                                          subTitle: "Attendance Status : " +
                                              "${widget.studentListByClassSectionModel.data![index].attendanceStatus!.isEmpty ? "Pending" : "${widget.studentListByClassSectionModel.data![index].attendanceStatus == "P" ? "Present" : "Absent"}"}",
                                        ),
                                        Theme(
                                          data: ThemeData().copyWith(
                                              dividerColor: Colors.transparent),
                                          child: ExpansionTile(
                                            tilePadding: EdgeInsets.zero,
                                            title: Text(
                                              "More Details",
                                              style: CommonDecoration
                                                  .expensionStyle,
                                            ),
                                            children: <Widget>[
                                              _rowTextFun(
                                                  title: "Section :",
                                                  subTitle:
                                                      "${widget.studentListByClassSectionModel.data![index].classSectionName ?? ""}"),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              _rowTextFun(
                                                  title: "Roll No. :",
                                                  subTitle:
                                                      "${widget.studentListByClassSectionModel.data![index].rollNumber ?? ""}"),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              _rowTextFun(
                                                  title: "Gender :",
                                                  subTitle:
                                                      "${widget.studentListByClassSectionModel.data![index].gender ?? ""}"),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              _rowTextFun(
                                                  title: "DOB :",
                                                  subTitle: getTimeFormat(
                                                      DateTime.parse(
                                                          "${widget.studentListByClassSectionModel.data![index].dateOfBirth ?? ""}"))),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              _rowTextFun(
                                                  title: "Father :",
                                                  subTitle:
                                                      "${widget.studentListByClassSectionModel.data![index].fatherName ?? ""}"),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              _rowTextFun(
                                                  title: "Mother :",
                                                  subTitle:
                                                      "${widget.studentListByClassSectionModel.data![index].motherName ?? ""}"),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              _rowTextFun(
                                                  title: "Father's Mobile :",
                                                  subTitle:
                                                      "${widget.studentListByClassSectionModel.data![index].fatherMobile ?? ""}"),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              _rowTextFun(
                                                  title: "Mother's Mobile :",
                                                  subTitle:
                                                      "${widget.studentListByClassSectionModel.data![index].motherMobile ?? ""}"),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                            onTap: (){
                                              ParentController()
                                                  .getStudentAttendance(
                                                admissionNumber: widget.studentListByClassSectionModel.data![index].admissionNumber,
                                                  month: DateTime.now().month.toString(),
                                                  year: DateTime.now().year.toString())
                                                  .then((value) {
                                                Get.to(() => Attendance(
                                                  studentAttendanceModel: value,
                                                  admissionNumber: widget.studentListByClassSectionModel.data![index].admissionNumber,
                                                ));
                                              });
                                            },
                                            child: MyButton(text: 'View Attandace Calender',color: ColorConstants.themeColor, borderRadius: 10,))
                                      ],
                                    ),
                                  ),
                                  _profileImage(index),
                                ],
                              );
                            },
                            itemCount: widget
                                .studentListByClassSectionModel.data!.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return smallSpace();
                            },
                          )
                    : _searchList.length.isEqual(0)
                        ? myImage(
                            isNetwork: false, source: "assets/icons/empty.png")
                        : ListView.separated(
                            padding: EdgeInsets.only(bottom: 20),
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 60, left: 10, right: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        boxShadow: heavyShadow,
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      children: <Widget>[
                                        largeSpace(),
                                        largeSpace(),
                                        Text(
                                          "${_searchList[index].name ?? ""}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                        _subtitleText(
                                          index: index,
                                          subTitle: "Class : " +
                                              "${_searchList[index].className ?? ""}",
                                        ),
                                        _subtitleText(
                                          index: index,
                                          subTitle: "Admission Number : " +
                                              "${_searchList[index].admissionNumber ?? ""}",
                                        ),
                                        _subtitleText(
                                          index: index,
                                          subTitle: "Attendance Status : " +
                                              "${_searchList[index].attendanceStatus!.isEmpty ? "Pending" : "${widget.studentListByClassSectionModel.data![index].attendanceStatus ?? ""}"}",
                                        ),
                                        Theme(
                                          data: ThemeData().copyWith(
                                              dividerColor: Colors.transparent),
                                          child: ExpansionTile(
                                            tilePadding: EdgeInsets.zero,
                                            title: Text(
                                              "More Details",
                                              style: CommonDecoration
                                                  .expensionStyle,
                                            ),
                                            children: <Widget>[
                                              _rowTextFun(
                                                  title: "Section :",
                                                  subTitle:
                                                      "${_searchList[index].classSectionName ?? ""}"),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              _rowTextFun(
                                                  title: "Roll No. :",
                                                  subTitle:
                                                      "${_searchList[index].rollNumber ?? ""}"),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              _rowTextFun(
                                                  title: "Gender :",
                                                  subTitle:
                                                      "${_searchList[index].gender ?? ""}"),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              _rowTextFun(
                                                  title: "DOB :",
                                                  subTitle: getTimeFormat(
                                                      DateTime.parse(
                                                          "${_searchList[index].dateOfBirth ?? ""}"))),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              _rowTextFun(
                                                  title: "Father :",
                                                  subTitle:
                                                      "${_searchList[index].fatherName ?? ""}"),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              _rowTextFun(
                                                  title: "Mother :",
                                                  subTitle:
                                                      "${_searchList[index].motherName ?? ""}"),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              _rowTextFun(
                                                  title: "Father's Mobile :",
                                                  subTitle:
                                                      "${_searchList[index].fatherMobile ?? ""}"),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              _rowTextFun(
                                                  title: "Mother's Mobile :",
                                                  subTitle:
                                                      "${_searchList[index].motherMobile ?? ""}"),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  _profileImage(index),
                                ],
                              );
                            },
                            itemCount: _searchList.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return smallSpace();
                            },
                          )
              ],
            ),
          ))
        ],
      )),
    );
  }

  Widget _rowTextFun({title, subTitle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 13, color: Colors.black),
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subTitle,
              style: TextStyle(fontSize: 13, color: Colors.grey),
            )
          ],
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }

  Widget _subtitleText({index, subTitle}) {
    return Text(
      subTitle,
      style: TextStyle(fontSize: 14, color: Colors.grey),
    );
  }

  Widget _moreDetailsText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "More Details : ",
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  Widget _profileImage(index) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: heavyShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: myImage(
            isNetwork: true,
            source:
                "${widget.studentListByClassSectionModel.data![index].profilePictureUrlForMobileApp}"),
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
