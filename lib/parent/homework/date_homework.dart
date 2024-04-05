import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/controller/parent_controller.dart';
import 'package:web_school_manager/drawer/module/contact_us.dart';
import 'package:web_school_manager/model/date_class_homework_parent_model.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/button.dart';
import 'package:web_school_manager/widget/header.dart';

class DateHomeWork extends StatefulWidget {
  String title;
  DateHomeWorkParentModel dateHomeWorkParentModel = DateHomeWorkParentModel();

  DateHomeWork(
      {Key? key, required this.title, required this.dateHomeWorkParentModel})
      : super(key: key);

  @override
  State<DateHomeWork> createState() => _DateHomeWorkState();
}

class _DateHomeWorkState extends State<DateHomeWork> {
  DateTime time = DateTime.now();

  Future getTime() async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now().subtract(Duration(days: 90)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    return picker;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          getTime().then((value) {
            time = value;
            ParentController()
                .getClassHomeWork(
              navigate: false,
              homeWorkDate: apiTimeFormat(DateTime.parse(time.toString())),
            )
                .then((value) {
              widget.dateHomeWorkParentModel = value;
              setState(() {});
            });

            myLog(
              label: "My Selected date",
              value: apiTimeFormat(DateTime.parse(time.toString())),
            );
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          children: <Widget>[
            CommonHeader(title: "Home Work"),
            smallSpace(),
            Expanded(
                child: widget.dateHomeWorkParentModel.data!.length == 0
                    ? myImage(
                        isNetwork: false, source: "assets/icons/empty.png")
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        itemCount: widget.dateHomeWorkParentModel.data!.length,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () {
                              widget.dateHomeWorkParentModel.data![i]
                                      .showModel =
                                  !widget.dateHomeWorkParentModel.data![i]
                                      .showModel;
                              setState(() {});
                            },
                            child: listCard(
                                imageUrl: "s",
                                showImage: false,
                                showArrow: false,
                                content: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 70,
                                          child: myImage(
                                              isNetwork: false,
                                              source:
                                                  "assets/icons/home-work.png"),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.dateHomeWorkParentModel
                                                      .data![i].subjectName ??
                                                  "",
                                              style: CommonDecoration
                                                  .subHeaderStyle,
                                            ),
                                            Text(
                                              widget.dateHomeWorkParentModel
                                                      .data![i].homeWork ??
                                                  "",
                                              style:
                                                  CommonDecoration.smallLabel,
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        RotatedBox(
                                            quarterTurns: !widget
                                                    .dateHomeWorkParentModel
                                                    .data![i]
                                                    .showModel
                                                ? 0
                                                : 45,
                                            child: Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: Colors.grey,
                                            ))
                                      ],
                                    ),
                                    AnimatedCrossFade(
                                        firstChild: Container(),
                                        secondChild: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Home work - " +
                                                  widget.dateHomeWorkParentModel
                                                      .data![i].homeWork
                                                      .toString(),
                                              style:
                                                  CommonDecoration.smallLabel,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Documents :",
                                              style:
                                                  CommonDecoration.smallLabel,
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: widget
                                                    .dateHomeWorkParentModel
                                                    .data![i]
                                                    .documentsList!
                                                    .length,
                                                itemBuilder: (context, j) {
                                                  return InkWell(
                                                    onTap: () {
                                                      if (widget
                                                              .dateHomeWorkParentModel
                                                              .data![i]
                                                              .documentsList![j]
                                                              .isYoutubeLink ==
                                                          true) {
                                                        Get.to(() => ContactUs(
                                                            link: widget
                                                                    .dateHomeWorkParentModel
                                                                    .data![i]
                                                                    .documentsList![
                                                                        j]
                                                                    .fileUrl ??
                                                                ""));
                                                        return;
                                                      }
                                                      viewDocument(
                                                          fileSource: widget
                                                                  .dateHomeWorkParentModel
                                                                  .data![i]
                                                                  .documentsList![
                                                                      j]
                                                                  .fileUrl ??
                                                              "",
                                                          fromUrl: true);
                                                    },
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      decoration: BoxDecoration(
                                                        boxShadow: myShadow,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .document_scanner_sharp,
                                                            color: Colors.grey,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(widget
                                                                  .dateHomeWorkParentModel
                                                                  .data![i]
                                                                  .documentsList![
                                                                      j]
                                                                  .documentName ??
                                                              ""),
                                                          Spacer(),
                                                          Icon(
                                                            Icons
                                                                .remove_red_eye,
                                                            color: Colors.grey,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }),
                                            smallSpace(),
                                            if (widget.title == "Home Work")
                                              InkWell(
                                                  onTap: () {
                                                    ParentController().getUploadHomeWorkBySubjectData(
                                                        className: "",
                                                        subjectName: widget
                                                            .dateHomeWorkParentModel
                                                            .data![i]
                                                            .subjectName
                                                            .toString(),
                                                        classHomeWorkId: widget
                                                            .dateHomeWorkParentModel
                                                            .data![i]
                                                            .id
                                                            .toString(),
                                                        homeWorkUploadDate: widget
                                                                .dateHomeWorkParentModel
                                                                .data![i]
                                                                .homeWork ??
                                                            "",
                                                        subjectMasterId: widget
                                                            .dateHomeWorkParentModel
                                                            .data![i]
                                                            .subjectMasterId
                                                            .toString());
                                                    //  Get.to(UploadHomeWork(classMasterId: classMasterId, subjectName: subjectName, classSectionMasterId: classSectionMasterId, className: className, homeWorkId: homeWorkId, rowVersion: rowVersion, subjectMasterId: subjectMasterId))
                                                  },
                                                  child: MyButton(
                                                    text: "Upload",
                                                    borderRadius: 10,
                                                    color: Colors.blue,
                                                    iconButton: Icons.upload,
                                                  ))
                                          ],
                                        ),
                                        crossFadeState: !widget
                                                .dateHomeWorkParentModel
                                                .data![i]
                                                .showModel
                                            ? CrossFadeState.showFirst
                                            : CrossFadeState.showSecond,
                                        duration: Duration(milliseconds: 400)),
                                  ],
                                )),
                          );
                        }))
          ],
        ),
      ),
    );
  }
}
