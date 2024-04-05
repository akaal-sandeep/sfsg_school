import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/button.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../../controller/teacher_state_controller.dart';
import '../../../teacher_model/class_test_model.dart';
import '../../../teacher_model/mange_class_test_main.dart';
import '../../../widget/mytextfield.dart';

class CreateTest extends StatefulWidget {
  ManageClassTestMainModel? model;
  String subjectName;
  String classname;
  

  ClassTestListModel classTestListModel;

  CreateTest(
      {Key? key,
      this.model,
      required this.classTestListModel,
      required this.subjectName,
      required this.classname})
      : super(key: key);

  @override
  State<CreateTest> createState() => _CreateTestState();
}

class _CreateTestState extends State<CreateTest> {
  final selectedDateController = TextEditingController();
  final subjectController = TextEditingController();
  final topicController = TextEditingController();
  final maxMarksController = TextEditingController();
  final selectedDateFocus = FocusNode();
  final subjectFocus = FocusNode();
  final topicFocus = FocusNode();
  final maxMarksFocus = FocusNode();

  Future getTime() async {
    DateTime? picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 172)),
        lastDate: DateTime.now());
    return picker;
  }

  bool filled = false;
  bool newTest = false;

  List<PopupMenuItem> subjectList = [];
  int subjectIndexSelected = 100;

  @override
  void initState() {
    for (int i = 0; i < widget.classTestListModel.data!.length; i++) {
      subjectList.add(PopupMenuItem(
          value: i,
          child:
              Text(widget.classTestListModel.data![i].subjectName.toString())));
    }

    selectedDateController.text =
        DateFormat("dd MMM, yyyy").format(DateTime.now());

    if (widget.model != null) {
      if (widget.model!.data!.id != 0) {
        filled = true;
      } else {
        newTest = true;
      }

      selectedDateController.text = getTimeFormat(
          DateTime.parse(widget.model!.data!.testDate.toString()));
      subjectController.text = widget.model!.data!.subjectName.toString();
      topicController.text = widget.model!.data!.testTopic.toString();
      maxMarksController.text = widget.model!.data!.maximumMarks.toString();
    }

    if (newTest){


      for (int i = 0; i < widget.classTestListModel.data!.length; i++) {
        if (widget.subjectName.split(" [").first.toUpperCase().toString() ==
            widget.classTestListModel.data![i].subjectName) {
          subjectIndexSelected = i;
          subjectController.text = widget.classTestListModel.data![i].subjectName.toString();
          myLog(label: "found", value: i.toString());
        }
      }
    }
    addListener();
    // TODO: implement initState
    super.initState();
  }

  addListener() {
    selectedDateController.addListener(() {
      widget.model!.data!.testDate = selectedDateController.value.text;
    });
    subjectController.addListener(() {
      widget.model!.data!.subjectName = subjectController.value.text;
    });
    topicController.addListener(() {
      widget.model!.data!.testTopic = topicController.value.text;
    });
    maxMarksController.addListener(() {
      widget.model!.data!.maximumMarks = maxMarksController.value.text;
    });
  }

  final teacherStateController = Get.put(TeacherStateController());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
          child: SingleChildScrollView(
        child: GetBuilder(
            init: teacherStateController,
            builder: (Context) {

                widget.model = teacherStateController.manageClassTestMainModel;
                if (widget.model!.data!.id!=0) {
                selectedDateController.text = getTimeFormat(
                    DateTime.parse(widget.model!.data!.testDate.toString()));
                subjectController.text =
                    widget.model!.data!.subjectName.toString();
                topicController.text = widget.model!.data!.testTopic.toString();
                maxMarksController.text =
                    widget.model!.data!.maximumMarks.toString();
              }
              return Form(
                key: formKey,
                child: Column(
                  children: [
                    CommonHeader(
                      title: filled ? "Test Details" : "Create Test",
                      hideStudentName: true,
                    ),
                    AbsorbPointer(
                      absorbing: teacherStateController.manageClassTestMainModel.locked || filled,
                      child: Column(
                        children: [
                          smallSpace(),
                          Text(
                            widget.subjectName + " [ ${widget.classname} ]",
                            style: CommonDecoration.subHeaderStyle,
                          ),
                          smallSpace(),
                          Container(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    getTime().then((value) {
                                      selectedDateController.text =
                                          DateFormat("dd MMM, yyyy")
                                              .format(value);
                                      setState(() {});
                                    });
                                  },
                                  child: AbsorbPointer(
                                    child: MyTextField(
                                        hint: "Selected Date",
                                        inputType: TextInputType.text,
                                        textEditingController:
                                            selectedDateController,
                                        focusNode: selectedDateFocus,
                                        borderColor: Colors.grey,
                                        borderRadius: 10,
                                        filled: filled,
                                        filledColor:
                                            Colors.grey.withOpacity(.1),
                                        icon: Icon(Icons.calendar_month),
                                        isValidate: true),
                                  ),
                                ),
                                smallSpace(),
                                PopupMenuButton(
                                  position: PopupMenuPosition.under,
                                  itemBuilder: (context) => subjectList,
                                  onSelected: (v) {
                                    subjectIndexSelected =
                                        int.parse(v.toString());
                                    subjectController.text = widget
                                        .classTestListModel
                                        .data![subjectIndexSelected]
                                        .subjectName
                                        .toString();
                                    setState(() {});
                                  },
                                  child: AbsorbPointer(
                                    child: MyTextFieldDrop(
                                        hint: "Subject",
                                        inputType: TextInputType.text,
                                        textEditingController:
                                            subjectController,
                                        focusNode: subjectFocus,
                                        borderColor: Colors.grey,
                                        borderRadius: 10,
                                        filled: filled,
                                        filledColor:
                                            Colors.grey.withOpacity(.1),
                                        icon: Icon(Icons.subject),
                                        isValidate: true),
                                  ),
                                ),
                                smallSpace(),
                                MyTextField(
                                    hint: "Topic",
                                    inputType: TextInputType.text,
                                    textEditingController: topicController,
                                    focusNode: topicFocus,
                                    borderColor: Colors.grey,
                                    borderRadius: 10,
                                    filled: filled,
                                    filledColor: Colors.grey.withOpacity(.1),
                                    icon: Icon(Icons.topic_outlined),
                                    isValidate: true),
                                smallSpace(),
                                MyTextField(
                                    hint: "Max. Mark[1-300]",
                                    inputType: TextInputType.number,
                                    textEditingController: maxMarksController,
                                    focusNode: maxMarksFocus,
                                    borderColor: Colors.grey,
                                    borderRadius: 10,
                                    filled: filled,
                                    filledColor: Colors.grey.withOpacity(.1),
                                    icon: Icon(Icons.numbers),
                                    isValidate: true),
                                smallSpace(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: AbsorbPointer(
                          absorbing: teacherStateController.manageClassTestMainModel.locked || !filled,
                          child: InkWell(
                            onTap: () {
                              filled = false;
                              setState(() {});
                            },
                            child: MyButton(
                                text: "Edit",
                                borderRadius: 10,
                                color: (teacherStateController.manageClassTestMainModel.locked || !filled)
                                    ? Colors.grey
                                    : Colors.blue),
                          ),
                        )),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: AbsorbPointer(
                          absorbing: teacherStateController.manageClassTestMainModel.locked || filled,
                          child: InkWell(
                            onTap: () {
                              FocusScope.of(context).requestFocus(new FocusNode());
                              SystemChannels.textInput.invokeMethod("TextInput.hide");
                              if(double.parse(maxMarksController.value.text)<=0.0 ||double.parse(maxMarksController.value.text)>300.0){
                                maxMarksController.clear();
                                showMessage(msg: "Please enter valid Max. Marks");
                                return;
                              }

                              if (!formKey.currentState!.validate()) return;

                              TeacherController()
                                  .manageClassTestInv(
                                      classTestListModel:
                                          widget.classTestListModel,
                                      navigate: false,
                                      filled: true,
                                      model: widget.model!,
                                      isLocked: teacherStateController.manageClassTestMainModel.locked,
                                      selectedSubjectIndex:
                                          subjectIndexSelected)
                                  .then((value) {
                                final teacherStateController =
                                    Get.put(TeacherStateController());
                                if (subjectIndexSelected != 100) {

                                  teacherStateController.manageClassTestInvModel
                                          .data!.subjectMasterId =
                                      widget.classTestListModel
                                          .data![subjectIndexSelected].id
                                          .toString();
                                }
                                TeacherController()
                                    .saveClassTest(
                                        model: widget.model!,
                                        manageClassTestInvModel:
                                            teacherStateController
                                                .manageClassTestInvModel,
                                        selectedDate:
                                            selectedDateController.value.text,
                                        subject: subjectController.value.text,
                                        topic: topicController.value.text,
                                        maxMarks: maxMarksController.value.text)
                                    .then((value) {
                                  if (value && widget.model!.data!.id != 0) {
                                    filled = true;
                                    newTest = false;
                                    TeacherController()
                                        .manageClassTestMain(
                                            id: widget.model!.data!.id
                                                .toString(),
                                            className:
                                                widget.classname.toString(),
                                            subjectName: widget.subjectName,
                                            navigate: false,
                                            isLocked: teacherStateController.manageClassTestMainModel.locked)
                                        .then((value) {
                                      TeacherController()
                                          .getTeacherClassTestListBySubject(
                                              classMasterId: teacherStateController.manageClassTestMainModel.data!.classMasterId.toString()
                                                  .toString(),
                                              navigate: false,
                                              classSectionMasterId: teacherStateController.manageClassTestMainModel.data!.classSectionMasterId.toString(),
                                              subjectMasterId: teacherStateController.manageClassTestMainModel.data!.subjectMasterId.toString(),
                                              subjectName: widget
                                                  .model!.data!.subjectName
                                                  .toString(),
                                              className: widget.classname)
                                          .then((v) => {
                                                widget.model = value,
                                                setState(() {})
                                              });
                                    });
                                  }
                                });
                              });
                            },
                            child: MyButton(
                                text: newTest ? "Add" : "Update",
                                borderRadius: 10,
                                color: (teacherStateController.manageClassTestMainModel.locked || filled)
                                    ? Colors.grey
                                    : Colors.blue),
                          ),
                        )),
                      ],
                    ),
                    smallSpace(),
                    if (!newTest)
                      InkWell(
                          onTap: () {
                            if(!filled){
                              showMessage(msg: "First Update data!");
                              return;
                            }

                            TeacherController().manageClassTestInv(
                                filled: true,
                                navigate: true,
                                classTestListModel: widget.classTestListModel,
                                selectedSubjectIndex: subjectIndexSelected,
                                model: widget.model!,
                                isLocked: teacherStateController.manageClassTestMainModel.locked);
                            //  Get.to(() => TestResult());
                          },
                          child: MyButton(
                              text: "Student Marks",
                              borderRadius: 10,
                              color:filled?Colors.green:Colors.grey))
                  ],
                ),
              );
            }),
      )),
    );
  }
}
