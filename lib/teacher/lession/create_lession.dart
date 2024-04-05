import 'dart:io';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/controller/temp_principal_controller.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/button.dart';
import 'package:web_school_manager/widget/dialog.dart';
import 'package:web_school_manager/widget/header.dart';
import 'package:web_school_manager/widget/mytextfield.dart';
import '../../controller/teacher_controller.dart';
import '../../teacher_model/get_lesson_plan_list.dart' as lesson;
import '../../teacher_model/teacher_class_homework_model.dart';
import '../../teacher_model/teacher_class_list_model.dart';

class CreateLesson extends StatefulWidget {
  TeacherClassesListModel? classList;
  TeacherClassHomeworkModel? subjectList;
  lesson.Data? data;
  bool? notEditable;
  bool? principalSide;

  CreateLesson(
      {Key? key,
        this.data,
        this.classList,
        this.subjectList,
        this.principalSide,
        this.notEditable})
      : super(key: key);

  @override
  State<CreateLesson> createState() => _CreateLessonState();
}

class _CreateLessonState extends State<CreateLesson> {
  File? finalImage;

  final globalKey = GlobalKey<FormState>();

  DateTime toDate = DateTime.now().add(Duration(days: 10));
  DateTime fromDate = DateTime.now();

  bool filled = false;

  TextEditingController classController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController objectiveController = TextEditingController();
  TextEditingController warmupActivityController = TextEditingController();
  TextEditingController teachingProcedureController = TextEditingController();
  TextEditingController followupController = TextEditingController();
  TextEditingController evaluationController = TextEditingController();
  TextEditingController principalRemarksController = TextEditingController();

  FocusNode classFocus = FocusNode();
  FocusNode subjectFocus = FocusNode();
  FocusNode objectiveFocus = FocusNode();
  FocusNode warmupFocus = FocusNode();
  FocusNode teachingFocus = FocusNode();
  FocusNode followupFocus = FocusNode();
  FocusNode evaluationFocus = FocusNode();
  FocusNode principalRemarksFocus = FocusNode();

  late PDFDocument doc;
  String fileSource = "";

  Future getTime(DateTime dateTime) async {
    if (((widget.notEditable ?? false) || (widget.principalSide ?? false))) {
      return;
    }
    DateTime? picker = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    myLog(label: "difference", value: toDate.difference(fromDate).inDays);

    return picker;
  }

  List<PopupMenuItem> classList = [];
  List<PopupMenuItem> subjectList = [];
  int classIndex = 100;
  int subjectIndex = 100;

  updateSubjectList() {
    TeacherController()
        .teacherClassHomeWork(
        classMasterid:
        widget.classList!.data![classIndex].classMasterId.toString(),
        navigate: false,
        classSectionMasterid: widget
            .classList!.data![classIndex].classSectionMasterId
            .toString(),
        className: widget.classList!.data![classIndex].className.toString())
        .then((value) {
      widget.subjectList = value;
      subjectList = [];
      for (int i = 0; i < widget.subjectList!.data!.length; i++) {
        subjectList.add(PopupMenuItem(
            value: i,
            child: Text(widget.subjectList!.data![i].subjectName ?? "")));
      }
      setState(() {});
    });
  }

  bool documentFromUrl = false;

  @override
  void initState() {
    if (widget.data != null) {
      generateDoc();
      documentFromUrl = true;
      filled = true;
      fromDate = DateTime.parse(widget.data?.fromDate ?? "");
      toDate = DateTime.parse(widget.data?.toDate ?? "");
      classController.text = widget.data!.className.toString();
      subjectController.text = widget.data!.subjectName.toString();
      objectiveController.text = widget.data!.objectives.toString();
      warmupActivityController.text = widget.data!.warmUpActivities.toString();
      teachingProcedureController.text =
          widget.data!.teachingProcedure.toString();
      followupController.text = widget.data!.followUpActivities.toString();
      evaluationController.text = widget.data!.evaluation.toString();
      principalRemarksController.text = widget.data!.principalRemarks.toString();
    } else {
      classIndex = 0;
      classController.text =
      "${widget.classList!.data![classIndex].className} - ${widget.classList!.data![classIndex].classSectionName}";
    }

    if (widget.classList?.data != null) {
      for (int i = 0; i < widget.classList!.data!.length; i++) {
        classList.add(PopupMenuItem(
            value: i,
            child: Text(
                "${widget.classList!.data![i].className} - ${widget.classList!.data![i].classSectionName}")));
      }
    }

    if (widget.subjectList?.data != null) {
      for (int i = 0; i < widget.subjectList!.data!.length; i++) {
        subjectList.add(PopupMenuItem(
            value: i,
            child: Text(widget.subjectList!.data![i].subjectName ?? "")));
      }
    }

    // TODO: implement initState
    super.initState();
  }

  PDFDocument urlDoc = PDFDocument();

  bool isPdf = false;

  generateDoc() async {
    if (widget.data!.absoluteDocumentPath!.isEmpty) return;
    myLog(label: "call", value: "call");
    if (widget.data!.absoluteDocumentPath!.split(".").last == "pdf") {
      myLog(label: "call", value: "call");
      urlDoc =
      await PDFDocument.fromURL(widget.data!.absoluteDocumentPath ?? "");
      isPdf = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    if(toDate.difference(fromDate).inDays<=0){
      toDate= fromDate;
    }
    // myLog(label: "documents", value: widget.data!.toJson().toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: myPadding(
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                CommonHeader(
                  title: filled ? "Lesson Details" : "Create Lesson",
                  hideStudentName: true,
                ),
                smallSpace(),
                Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          detailsCard(
                            label: "Select Dates",
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("From Date"),
                                    InkWell(
                                      onTap: () {
                                        getTime(fromDate).then((value) {
                                          fromDate = value;
                                          setState(() {});
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: ((widget.notEditable ?? false) ||
                                                (widget.principalSide ?? false))
                                                ? Colors.grey.withOpacity(.1)
                                                : Colors.white,
                                            border: Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(5)),
                                        child: Row(
                                          children: [
                                            Text(DateFormat("dd MMM, yyyy")
                                                .format(fromDate)),
                                            Icon(
                                              Icons.calendar_month,
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text("-"),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("To Date"),
                                    InkWell(
                                      onTap: () {
                                        getTime(toDate).then((value) {
                                          toDate = value;
                                          setState(() {});
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: ((widget.notEditable ?? false) ||
                                                (widget.principalSide ?? false))
                                                ? Colors.grey.withOpacity(.1)
                                                : Colors.white,
                                            border: Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(5)),
                                        child: Row(
                                          children: [
                                            Text(DateFormat("dd MMM, yyyy")
                                                .format(toDate)),
                                            Icon(
                                              Icons.calendar_month,
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          smallSpace(),
                          if (filled && fileSource == "" && documentFromUrl == true)
                            InkWell(
                              onTap: () {
                                myLog(label: "I am working", value: "1");
                                viewDocument(
                                    fileSource: widget.data?.absoluteDocumentPath ?? "",
                                    fromUrl: true);
                              },
                              child: detailsCard(
                                label: "Document(optional)",
                                content: Stack(
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      width: double.infinity,
                                      child: isPdf
                                          ? viewPdf(doc: urlDoc)
                                          : myImage(
                                          isNetwork: true,
                                          source:
                                          widget.data?.absoluteDocumentPath ??
                                              ""),
                                    ),
                                    (widget.notEditable==true || widget.principalSide==true)? Container(): Align(
                                      alignment: Alignment.topRight,
                                      child: InkWell(
                                        onTap: () {
                                          documentFromUrl = false;
                                          setState(() {});
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.red, width: 1),
                                              borderRadius: BorderRadius.circular(5)),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Clear",
                                                style: TextStyle(
                                                    color: Colors.red, fontSize: 10),
                                              ),
                                              Icon(
                                                Icons.delete_forever_outlined,
                                                color: Colors.red,
                                                size: 13,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          if (!filled || fileSource != "" || documentFromUrl == false)
                            documentPicker(),
                          Column(
                            children: [
                              smallSpace(),
                              PopupMenuButton(
                                itemBuilder: (context) => classList,
                                onSelected: (v) {
                                  classIndex = int.parse(v.toString());
                                  classController.text =
                                  "${widget.classList!.data![classIndex].className} - ${widget.classList!.data![classIndex].classSectionName}";
                                  subjectController.clear();
                                  updateSubjectList();
                                },
                                position: PopupMenuPosition.under,
                                child: AbsorbPointer(
                                  child: MyTextFieldDrop(
                                      hint: "Select Class",
                                      inputType: TextInputType.text,
                                      textEditingController: classController,
                                      focusNode: classFocus,
                                      borderColor: Colors.grey,
                                      borderRadius: 10,
                                      filled: ((widget.notEditable ?? false) ||
                                          (widget.principalSide ?? false)),
                                      icon: Icon(Icons.create_sharp),
                                      isValidate: true),
                                ),
                              ),
                              smallSpace(),
                              PopupMenuButton(
                                itemBuilder: (context) => subjectList,
                                position: PopupMenuPosition.under,
                                onSelected: (v) {
                                  subjectIndex = int.parse(v.toString());
                                  subjectController.text = widget.subjectList!
                                      .data![subjectIndex].subjectName ??
                                      "";
                                },
                                child: AbsorbPointer(
                                  child: MyTextFieldDrop(
                                      hint: "Select Subject",
                                      inputType: TextInputType.text,
                                      textEditingController: subjectController,
                                      focusNode: subjectFocus,
                                      borderColor: Colors.grey,
                                      borderRadius: 10,
                                      filled: ((widget.notEditable ?? false) ||
                                          (widget.principalSide ?? false)),
                                      icon: Icon(Icons.create_sharp),
                                      isValidate: true),
                                ),
                              ),
                              smallSpace(),
                              MyTextFieldMulti(
                                  hint: "Objectives",
                                  inputType: TextInputType.multiline,
                                  textEditingController: objectiveController,
                                  focusNode: objectiveFocus,
                                  borderColor: Colors.grey,
                                  borderRadius: 10,
                                  filled: widget.notEditable ?? false,
                                  icon: Icon(Icons.create_sharp),
                                  isValidate: true),
                              smallSpace(),
                              MyTextFieldMulti(
                                  hint: "Warm Up Activities",
                                  inputType: TextInputType.multiline,
                                  textEditingController: warmupActivityController,
                                  focusNode: warmupFocus,
                                  borderColor: Colors.grey,
                                  borderRadius: 10,
                                  filled: widget.notEditable ?? false,
                                  icon: Icon(Icons.create_sharp),
                                  isValidate: true),
                              smallSpace(),
                              MyTextFieldMulti(
                                  hint: "Teaching Procedure",
                                  inputType: TextInputType.multiline,
                                  textEditingController: teachingProcedureController,
                                  focusNode: teachingFocus,
                                  borderColor: Colors.grey,
                                  borderRadius: 10,
                                  filled: widget.notEditable ?? false,
                                  icon: Icon(Icons.create_sharp),
                                  isValidate: true),
                              smallSpace(),
                              MyTextFieldMulti(
                                  hint: "Follow Up Activities",
                                  inputType: TextInputType.multiline,
                                  textEditingController: followupController,
                                  focusNode: followupFocus,
                                  borderColor: Colors.grey,
                                  borderRadius: 10,
                                  filled: widget.notEditable ?? false,
                                  icon: Icon(Icons.create_sharp),
                                  isValidate: true),
                              smallSpace(),
                              MyTextFieldMulti(
                                  hint: "Evaluation",
                                  inputType: TextInputType.multiline,
                                  textEditingController: evaluationController,
                                  focusNode: evaluationFocus,
                                  borderColor: Colors.grey,
                                  borderRadius: 10,
                                  filled: widget.notEditable ?? false,
                                  icon: Icon(Icons.create_sharp),
                                  isValidate: true),
                              smallSpace(),
                              if (widget.principalSide == true)
                                MyTextFieldMulti(
                                    hint: "Principal Remarks(Optional)",
                                    inputType: TextInputType.multiline,
                                    textEditingController: principalRemarksController,
                                    focusNode: principalRemarksFocus,
                                    borderColor: Colors.grey,
                                    borderRadius: 10,
                                    filled: widget.notEditable ?? false,
                                    icon: Icon(Icons.create_sharp),
                                    isValidate: false),
                              smallSpace(),
                            ],
                          )
                        ],
                      ),
                    )),
                smallSpace(),
                if (widget.principalSide == true && widget.notEditable == null)
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              if (globalKey.currentState!.validate()) {
                                confirmDialog(text: "reject").then((value) {
                                  if(value){
                                    TempPrincipalController().rejectLessonPlan(
                                        id: widget.data!.id.toString(),
                                        rowVersion: widget.data!.rowVersion
                                            .toString());
                                  }
                                });

                              }
                            },
                            child: MyButton(
                                text: "Reject",
                                borderRadius: 10,
                                color: Colors.red)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              if (globalKey.currentState!.validate()) {
                                confirmDialog(text: "approve").then((value) {
                                  if(value){
                                    approveLesson();
                                  }
                                });
                              }
                            },
                            child: MyButton(
                                text: "Approve",
                                borderRadius: 10,
                                color: Colors.blue)),
                      ),
                    ],
                  ),
                if (widget.notEditable == false ||
                    widget.notEditable == null && widget.principalSide == null)
                  InkWell(
                      onTap: () {
                        if (globalKey.currentState!.validate()) {
                          saveLesson();
                        }
                      },
                      child: MyButton(
                          text: "Save", borderRadius: 10, color: Colors.blue)),
                smallSpace()
              ],
            ),
          )),
    );
  }

  Future confirmDialog({required String text}) async {
    bool confirm = false;
    confirm = await showDialog(
        context: context,
        builder: (context) => AlertDialogCustom(
          icon: Icons.warning_amber,
          iconColor: Colors.red,
          description: "Do you want to $text this lesson?",
          showNegative: true,
          negativeCall: () {
            Get.back();
          },
          positiveCall: () {
            confirm = true;
            Get.back();
          },
        )).then((value){
      return confirm;
    });
    return confirm;
  }

  approveLesson() {
    TempPrincipalController().UpdateLessonPlan(
        principalRemark: principalRemarksController.value.text,
        fileUrl: widget.data?.absoluteDocumentPath ?? "",
        fileSource: fileSource == "" ? null : fileSource,
        classMasterId: (filled && classIndex == 100)
            ? widget.data!.classMasterId.toString()
            : widget.classList!.data![classIndex].classMasterId.toString(),
        evaluation: evaluationController.value.text,
        fromDate: DateFormat("MMM dd, yyyy").format(fromDate),
        toDate: DateFormat("MMM dd, yyyy").format(toDate),
        id: filled ? widget.data!.id.toString() : "0",
        objective: objectiveController.value.text,
        rowVersion: filled ? widget.data!.rowVersion.toString() : "1",
        sectionMasterId: (filled && classIndex == 100)
            ? widget.data!.sectionMasterId.toString()
            : widget.classList!.data![classIndex].classSectionMasterId
            .toString(),
        subjectMasterId: (filled && subjectIndex == 100)
            ? widget.data!.subjectMasterId.toString()
            : widget.subjectList!.data![subjectIndex].subjectMasterId
            .toString(),
        teacherProcedure: teachingProcedureController.value.text,
        warmUpActivity: warmupActivityController.value.text,
        followUpActivity: followupController.value.text);
  }


  saveLesson() {
    TeacherController().saveLessonPlan(
        fileUrl: widget.data?.absoluteDocumentPath ?? "",
        fileSource: fileSource == "" ? null : fileSource,
        classMasterId: (filled && classIndex == 100)
            ? widget.data!.classMasterId.toString()
            : widget.classList!.data![classIndex].classMasterId.toString(),
        evaluation: evaluationController.value.text,
        fromDate: DateFormat("MMM dd, yyyy").format(fromDate),
        toDate: DateFormat("MMM dd, yyyy").format(toDate),
        id: filled ? widget.data!.id.toString() : "0",
        objective: objectiveController.value.text,
        rowVersion: filled ? widget.data!.rowVersion.toString() : "1",
        sectionMasterId: (filled && classIndex == 100)
            ? widget.data!.sectionMasterId.toString()
            : widget.classList!.data![classIndex].classSectionMasterId
            .toString(),
        subjectMasterId: (filled && subjectIndex == 100)
            ? widget.data!.subjectMasterId.toString()
            : widget.subjectList!.data![subjectIndex].subjectMasterId
            .toString(),
        teacherProcedure: teachingProcedureController.value.text,
        warmUpActivity: warmupActivityController.value.text,
        followUpActivity: followupController.value.text);
  }

  documentPicker() {
    return detailsCard(
        label: "Document(optional)",
        content: InkWell(
          onTap: () async {
            _pickerDialog();

          },
          child: Stack(
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: fileSource.isEmpty
                    ? Center(
                  child: Text(
                    "+ Click here to Upload document",
                    style: CommonDecoration.smallLabel,
                  ),
                )
                    : fileSource.split(".").last == "pdf"
                    ? PDFViewer(
                  document: doc,
                )
                    : Image.file(File(fileSource)),
              ),
              if (fileSource.isNotEmpty)
                widget.notEditable==true? Container():  Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      fileSource = "";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Clear",
                            style: TextStyle(color: Colors.red, fontSize: 10),
                          ),
                          Icon(
                            Icons.delete_forever_outlined,
                            color: Colors.red,
                            size: 13,
                          )
                        ],
                      ),
                    ),
                  ),
                )
            ],
          ),
        ));
  }

  _pickerDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          insetPadding: EdgeInsets.zero,
          alignment: Alignment.center,
          title: Center(
            child: Text(
              "Select Attachment from",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _iconText(
                    title: "Camera",
                    iconImage: "assets/icons/camera.png",
                    onTab: () {
                      pickImage(
                          source: ImageSource.camera,
                          selectedImg: finalImage)
                          .then((value) async {
                        myLog(label: "file source", value: value.path.toString().isEmpty);
                        fileSource = value.path;
                        myLog(label: "file source", value: fileSource);
                        setState(() {

                        });
                      });
                    }),
                SizedBox(
                  width: 10,
                ),
                _iconText(
                    title: "Gallery",
                    iconImage: "assets/icons/gallery.png",
                    onTab: () {
                      pickImage(
                          source: ImageSource.gallery,
                          selectedImg: finalImage)
                          .then((value) async {

                        fileSource = value.path;
                        myLog(label: "file source", value: fileSource);
                        setState(() {});

                      });
                    }),
                SizedBox(
                  width: 10,
                ),
                _iconText(
                    title: "File",
                    iconImage: "assets/icons/document.png",
                    onTab: () async {
                      FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['jpg', 'pdf'],
                      );

                      if (result != null) {
                        fileSource = result.files.single.path!;
                        if (fileSource
                            .split(".")
                            .last == "pdf") {
                          doc = await PDFDocument.fromFile(
                              File(fileSource));
                        }
                        setState(() {});
                      } else {
                        // User canceled the picker
                      }
                    }),

              ],
            )
          ],
        );
      },
    );
  }



  Future pickImage({source, selectedImg}) async {
    try{
      final image = await ImagePicker().pickImage(source: source,imageQuality:10,);

      File selectedImg = File(image?.path ?? "");
      return selectedImg;
    }on PlatformException {
      return null;
    }

  }

  _iconText({iconImage, title, onTab}) {
    return InkWell(
      onTap: () {
        Get.back();
        onTab();
      },
      child: Container(
        width: 74,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                spreadRadius: 1.0,
                blurRadius: 1.0,
                color: Colors.grey.withOpacity(0.3))
          ],
          // shape: BoxShape.circle,
        ),
        child: Column(
          children: [
            SizedBox(
                width: 50, child: myImage(isNetwork: false, source: iconImage)),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
