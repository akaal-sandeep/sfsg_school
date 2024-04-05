
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/constants/color_constants.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/controller/teacher_state_controller.dart';
import 'package:web_school_manager/teacher/get_result_card/model/result_card_student_list_model.dart';
import 'package:web_school_manager/teacher_model/remarks_type_model.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/button.dart';
import 'package:web_school_manager/widget/header.dart';
import 'package:web_school_manager/widget/mytextfield.dart';

class ResultMarkEntryScreen extends StatefulWidget {
  RemarkStudentListModel remarkStudentListModel;
  bool? fromPersonalityTraits;
  RemarksTypeModel? remarksTypeModel;

  ResultMarkEntryScreen(
      {super.key,
      required this.remarkStudentListModel,
      this.fromPersonalityTraits,
      this.remarksTypeModel});

  @override
  State<ResultMarkEntryScreen> createState() => _ResultMarkEntryScreenState();
}

class _ResultMarkEntryScreenState extends State<ResultMarkEntryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
        child: Column(
          children: [
            CommonHeader(
                title: widget.fromPersonalityTraits == true
                    ? "Student List Personality Traits"
                    : widget.remarksTypeModel != null
                        ? "Teacher Remarks"
                        : "Student List For Mark"),
            if (widget.fromPersonalityTraits != true &&
                widget.remarksTypeModel == null)
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                      "Max. Marks: ${widget.remarkStudentListModel.data?.maximumMarks.toString()}")),
            smallSpace(),
            Expanded(
              child: ListView.separated(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  separatorBuilder: (context, i) => smallSpace(),
                  itemCount: widget.remarkStudentListModel.data?.data
                          ?.lstStudent?.length ??
                      0,
                  itemBuilder: (context, i) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: myShadow,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Name : ${widget.remarkStudentListModel.data?.data?.lstStudent?[i].studentName}"),
                          greyLine(),
                          Text(
                              "Roll no : ${widget.remarkStudentListModel.data?.data?.lstStudent?[i].rollNumber}"),
                          greyLine(),
                          Text(
                              "Admission no : ${widget.remarkStudentListModel.data?.data?.lstStudent?[i].admissionNumber}"),
                          if (widget.fromPersonalityTraits == true) ...[
                            greyLine(),
                            Row(
                              children: [
                                Text("Result : "),
                                Expanded(
                                  child: PopupMenuButton(
                                    position: PopupMenuPosition.under,
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Text("A+"),
                                        onTap: () {
                                          widget
                                              .remarkStudentListModel
                                              .data
                                              ?.data
                                              ?.lstStudent?[i]
                                              .gradeObtained = "A+";
                                          setState(() {});
                                        },
                                      ),
                                      PopupMenuItem(
                                        child: Text("A"),
                                        onTap: () {
                                          widget
                                              .remarkStudentListModel
                                              .data
                                              ?.data
                                              ?.lstStudent?[i]
                                              .gradeObtained = "A";
                                          setState(() {});
                                        },
                                      ),
                                      PopupMenuItem(
                                        child: Text("B+"),
                                        onTap: () {
                                          widget
                                              .remarkStudentListModel
                                              .data
                                              ?.data
                                              ?.lstStudent?[i]
                                              .gradeObtained = "B+";
                                          setState(() {});
                                        },
                                      ),
                                      PopupMenuItem(
                                        child: Text("B"),
                                        onTap: () {
                                          widget
                                              .remarkStudentListModel
                                              .data
                                              ?.data
                                              ?.lstStudent?[i]
                                              .gradeObtained = "B";
                                          setState(() {});
                                        },
                                      ),
                                      PopupMenuItem(
                                        child: Text("C+"),
                                        onTap: () {
                                          widget
                                              .remarkStudentListModel
                                              .data
                                              ?.data
                                              ?.lstStudent?[i]
                                              .gradeObtained = "C+";
                                          setState(() {});
                                        },
                                      ),
                                      PopupMenuItem(
                                        child: Text("C"),
                                        onTap: () {
                                          widget
                                              .remarkStudentListModel
                                              .data
                                              ?.data
                                              ?.lstStudent?[i]
                                              .gradeObtained = "C";
                                          setState(() {});
                                        },
                                      ),
                                      PopupMenuItem(
                                        child: Text("D+"),
                                        onTap: () {
                                          widget
                                              .remarkStudentListModel
                                              .data
                                              ?.data
                                              ?.lstStudent?[i]
                                              .gradeObtained = "D+";
                                          setState(() {});
                                        },
                                      ),
                                      PopupMenuItem(
                                        child: Text("D"),
                                        onTap: () {
                                          widget
                                              .remarkStudentListModel
                                              .data
                                              ?.data
                                              ?.lstStudent?[i]
                                              .gradeObtained = "D";
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                    child: Stack(
                                      alignment: Alignment.centerRight,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey
                                                        .withOpacity(.7)),
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                            child: Text(
                                                "${widget.remarkStudentListModel.data?.data?.lstStudent?[i].gradeObtained}")),
                                        Icon(Icons.arrow_drop_down)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                          if (widget.remarksTypeModel != null) ...[
                            greyLine(),
                            Row(
                              children: [
                                Text("Remark : "),
                                Expanded(
                                  child: PopupMenuButton(
                                    position: PopupMenuPosition.under,
                                    itemBuilder: (context) => List.generate(
                                        widget.remarksTypeModel?.data?.length ??
                                            0,
                                        (j) => PopupMenuItem(
                                            onTap: () {
                                              widget
                                                  .remarkStudentListModel
                                                  .data
                                                  ?.data
                                                  ?.lstStudent?[i]
                                                  .remarks = widget
                                                      .remarksTypeModel
                                                      ?.data?[j]
                                                      .id
                                                      .toString() ??
                                                  "";
                                              widget
                                                  .remarkStudentListModel
                                                  .data
                                                  ?.data
                                                  ?.lstStudent?[i]
                                                  .remarks2 = widget
                                                      .remarksTypeModel
                                                      ?.data?[j]
                                                      .name
                                                      .toString() ??
                                                  "";
                                              setState(() {});
                                            },
                                            child: Text(widget.remarksTypeModel
                                                    ?.data?[j].name ??
                                                "",style: TextStyle(fontSize: 12),))),
                                    child: Stack(
                                      alignment: Alignment.centerRight,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey
                                                        .withOpacity(.7)),
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                            child: Text((widget
                                                            .remarkStudentListModel
                                                            .data
                                                            ?.data
                                                            ?.lstStudent?[i]
                                                            .remarks
                                                            .toString()
                                                            .trim()
                                                            .isEmpty ==
                                                        true ||
                                                    widget
                                                            .remarkStudentListModel
                                                            .data
                                                            ?.data
                                                            ?.lstStudent?[i]
                                                            .remarks
                                                            .toString() ==
                                                        widget
                                                            .remarkStudentListModel
                                                            .data
                                                            ?.data
                                                            ?.lstStudent?[i]
                                                            .customRemark!
                                                            .value
                                                            .text
                                                            .toString() ||
                                                    widget.remarkStudentListModel.data?.data?.lstStudent?[i].remarks.toString() == "0")
                                                ? "Not Selected"
                                                : "${widget.remarksTypeModel?.data?[widget.remarksTypeModel!.data!.indexWhere((element) => element.id.toString() == widget.remarkStudentListModel.data?.data?.lstStudent?[i].remarks.toString()) == -1 ? 0 : widget.remarksTypeModel!.data!.indexWhere((element) => element.id.toString() == widget.remarkStudentListModel.data?.data?.lstStudent?[i].remarks.toString())].name}",style: TextStyle(fontSize: 12),)),
                                        Icon(Icons.arrow_drop_down)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            greyLine(),
                            SizedBox(
                                height: 35,
                                child: MyTextField(
                                    hint: "Custom Remark",
                                    inputType: TextInputType.text,
                                    textEditingController: widget
                                            .remarkStudentListModel
                                            .data
                                            ?.data
                                            ?.lstStudent?[i]
                                            .customRemark ??
                                        TextEditingController(),
                                    borderColor: ColorConstants.themeColor,
                                    borderRadius: 10,
                                    filled: false,
                                    icon: Icon(
                                        Icons.mark_unread_chat_alt_outlined),
                                    isValidate: false)),
                          ],
                          if (widget.fromPersonalityTraits == null &&
                              widget.remarksTypeModel == null) ...[
                            if (widget.remarkStudentListModel.data?.data
                                    ?.lstStudent?[i].attendanceStatus ==
                                "P") ...[
                              greyLine(),
                              SizedBox(
                                  height: 35,
                                  child: MyTextField(
                                      hint: "Marks",
                                      onChange: () {
                                        double maxMark = double.parse(widget
                                                .remarkStudentListModel
                                                .data
                                                ?.maximumMarks
                                                .toString() ??
                                            "0");
                                        double getMark = double.parse((widget
                                                .remarkStudentListModel
                                                .data
                                                ?.data
                                                ?.lstStudent?[i]
                                                .marksController
                                                ?.value
                                                .text ??
                                            "0"));
                                        if (getMark > maxMark) {
                                          widget
                                              .remarkStudentListModel
                                              .data
                                              ?.data
                                              ?.lstStudent?[i]
                                              .marksController
                                              ?.clear();
                                        }

                                        // if(double.parse(widget.remarkStudentListModel.data?.data?.lstStudent?[i].marksController?.value.text??"0")>double.parse(widget.remarkStudentListModel.data?.maximumMarks.toString()??"0")){
                                        //   widget.remarkStudentListModel.data?.data?.lstStudent?[i].marksController?.clear();
                                        // }
                                      },
                                      inputType: TextInputType.number,
                                      textEditingController: widget
                                              .remarkStudentListModel
                                              .data
                                              ?.data
                                              ?.lstStudent?[i]
                                              .marksController ??
                                          TextEditingController(),
                                      borderColor: ColorConstants.themeColor,
                                      borderRadius: 10,
                                      filled: false,
                                      icon: Icon(Icons.numbers),
                                      isValidate: false)),
                            ],
                            greyLine(),
                            Row(
                              children: [
                                attendanceOption(option: "L", index: i),
                                SizedBox(
                                  width: 5,
                                ),
                                attendanceOption(option: "A", index: i),
                                SizedBox(
                                  width: 5,
                                ),
                                attendanceOption(option: "P", index: i),
                              ],
                            )
                          ],
                        ],
                      ),
                    );
                  }),
            ),
            smallSpace(),
            GestureDetector(
                onTap: () {
                  if (widget.fromPersonalityTraits == true) {
                    TeacherController()
                        .savePersonalityTraits(
                            remarkStudentListModel:
                                widget.remarkStudentListModel)
                        .then((value) {
                      Get.back();
                      showMessage(msg: value.message);
                    });
                  } else if (widget.remarksTypeModel != null) {
                    TeacherController()
                        .saveRemark(
                            remarkStudentListModel:
                                widget.remarkStudentListModel)
                        .then((value) {
                      Get.back();
                      showMessage(msg: value.message);
                    });
                  } else {
                    widget.remarkStudentListModel.data!.data!.maximumMarks =
                        widget.remarkStudentListModel.data?.maximumMarks;
                    TeacherController()
                        .saveResultMarks(
                            remarkStudentListModel:
                                widget.remarkStudentListModel)
                        .then((value) {
                      Get.back();
                      showMessage(msg: value.message);
                    });
                  }
                },
                child: MyButton(
                    text: "Save", borderRadius: 10, color: Colors.blue)),
            smallSpace(),
          ],
        ),
      ),
    );
  }

  Widget attendanceOption({required String option, required int index}) {
    return GetBuilder(
        init: TeacherStateController(),
        builder: (ctx) {
          return Expanded(
              child: InkWell(
            onTap: () {
              widget.remarkStudentListModel.data?.data?.lstStudent?[index]
                  .attendanceStatus = option;
              setState(() {});
            },
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: widget.remarkStudentListModel.data?.data
                              ?.lstStudent?[index].attendanceStatus ==
                          option
                      ? optionColor(option: option)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: widget.remarkStudentListModel.data?.data
                                  ?.lstStudent?[index].attendanceStatus ==
                              option
                          ? optionColor(option: option)
                          : Colors.grey)),
              child: Text(
                findLabel(option),
                style: widget.remarkStudentListModel.data?.data
                            ?.lstStudent?[index].attendanceStatus ==
                        option
                    ? CommonDecoration.smallLabel.copyWith(color: Colors.white)
                    : CommonDecoration.smallLabel,
              ),
            ),
          ));
        });
  }

  Color optionColor({required String option}) {
    if (option == "A") {
      return Colors.red;
    } else if (option == "P") {
      return Colors.green;
    } else {
      return Colors.blue;
    }
  }

  Widget greyLine() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      width: double.infinity,
      height: 1,
      color: Colors.grey.withOpacity(.3),
    );
  }
}
