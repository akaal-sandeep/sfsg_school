
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/controller/temp_principal_controller.dart';
import 'package:web_school_manager/principal_model/all_section_homework_model.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

class AllSectionHomeworkScreen extends StatefulWidget {
  String className;
  String sectionName;
  String classMasterId;
  String sectionMasterId;
  AllSectionHomeWorkModel allSectionHomeWorkModel;

  AllSectionHomeworkScreen(
      {Key? key,
      required this.className,
      required this.sectionName,
      required this.allSectionHomeWorkModel,
      required this.classMasterId,
      required this.sectionMasterId})
      : super(key: key);

  @override
  State<AllSectionHomeworkScreen> createState() =>
      _AllSectionHomeworkScreenState();
}

class _AllSectionHomeworkScreenState extends State<AllSectionHomeworkScreen> {
  DateTime time = DateTime.now();

  Future getTime() async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: time,
      firstDate: DateTime.now().subtract(Duration(days: 30)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    return picker;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          getTime().then((value) async {
            time = value;
            widget.allSectionHomeWorkModel = await TempPrincipalController()
                .getClassHomeWorkListByClassSection(
                    navigate: false,
                    className: widget.className,
                    sectionName: widget.sectionName,
                    classMasterId: widget.classMasterId,
                    date: time.toString(),
                    sectionMasterId: widget.sectionMasterId);
            myLog(label: "My Selected date", value: time);
            setState(() {});
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
              title: "${widget.className} - ${widget.sectionName}",
              hideStudentName: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(DateFormat("dd MMM, yyyy").format(time)),
                SizedBox(width: 5,),
                Icon(Icons.calendar_month,color: Colors.grey,size: 18,)
              ],
            ),
            smallSpace(),
            Expanded(
                child: ListView.separated(
                    itemCount: widget.allSectionHomeWorkModel.data?.length ?? 0,
                    separatorBuilder: (context, i) => smallSpace(),
                    padding: EdgeInsets.only(bottom: 100),
                    itemBuilder: (context, i) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: myShadow),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                widget.allSectionHomeWorkModel.data?[i]
                                    .showDocument = !(widget
                                        .allSectionHomeWorkModel
                                        .data?[i]
                                        .showDocument ??
                                    false);
                                setState(() {});
                              },
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.allSectionHomeWorkModel.data?[i]
                                                .subjectName ??
                                            "",
                                        style: CommonDecoration.listStyle,
                                      ),
                                      Text(
                                        "Homework : ${widget.allSectionHomeWorkModel.data?[i].homeWork ?? ""}",
                                        style: CommonDecoration.smallLabel,
                                      ),
                                      Text(
                                        "Documents count : ${widget.allSectionHomeWorkModel.data?[i].documentCount ?? ""}",
                                        style: CommonDecoration.smallLabel,
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  RotatedBox(
                                    quarterTurns: widget.allSectionHomeWorkModel
                                                .data?[i].showDocument ==
                                            true
                                        ? 1
                                        : 0,
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            if (widget.allSectionHomeWorkModel.data?[i]
                                    .showDocument ==
                                true) ...[
                              smallSpace(),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: widget.allSectionHomeWorkModel
                                    .data?[i].documentsList?.length,
                                itemBuilder: (context, j) {
                                  return Container(
                                    padding: EdgeInsets.all(5),
                                    color: Colors.grey.withOpacity(.2),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.document_scanner_outlined,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(widget
                                                .allSectionHomeWorkModel
                                                .data?[i]
                                                .documentsList?[j]
                                                .documentName ??
                                            ""),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            viewDocument(
                                                fileSource: widget
                                                        .allSectionHomeWorkModel
                                                        .data?[i]
                                                        .documentsList?[j]
                                                        .fileUrl ??
                                                    "",
                                                fromUrl: true);
                                          },
                                          child: Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              )
                            ]
                          ],
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
