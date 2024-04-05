import 'dart:io';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/parent/homework/home_work_details.dart';
import 'package:web_school_manager/teacher_model/remarks_type_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/button.dart';
import 'package:web_school_manager/widget/header.dart';
import 'package:web_school_manager/widget/mytextfield.dart';

import '../../constants/string_constants.dart';
import '../../local_storage/local_storage.dart';
import '../../teacher_model/employee_profile_model.dart';
import '../../teacher_model/student_list_remarks_model.dart';
import '../../teacher_model/teacher_class_list_model.dart';
import '../../utility/custom_decoration.dart';

class CreateRemarks extends StatefulWidget {
  String? selectedDate,
      selectedClass,
      selectedStudent,
      selectedRemarkType,
      remark,
      url;
  bool filled;
  TeacherClassesListModel? classesModel;

  CreateRemarks({Key? key,
    required this.filled,
    this.remark,
    this.selectedClass,
    this.selectedDate,
    this.selectedRemarkType,
    this.selectedStudent,
    this.url,
    this.classesModel})
      : super(key: key);

  @override
  State<CreateRemarks> createState() => _CreateRemarksState();
}

class _CreateRemarksState extends State<CreateRemarks> {
  final globalKey = GlobalKey<FormState>();
  File? finalImage;


  final selectedDateController = TextEditingController();

  //-------------
  final selectClassController = TextEditingController();
  final selectStudentController = TextEditingController();
  final selectRemarkController = TextEditingController();
  final selectRemarkTypeController = TextEditingController();

  //---------

  final selectedDateFocus = FocusNode();

  final appointmentFocus = FocusNode();

  final selectedTeacherFocus = FocusNode();

  final visitByFocus = FocusNode();

  final remarkDateFocus = FocusNode();

  Future getTime() async {
    DateTime? picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 10)));
    return picker;
  }

  late PDFDocument doc;
  String fileSource = "";

  List<PopupMenuItem> classesList = [];
  List<PopupMenuItem> studentList = [];
  List<PopupMenuItem> remarkTypeList = [];

  int selectedClassIndex = 90;
  int selectedStudentIndex = 90;
  int selectedRemarksIndex = 90;

  @override
  void initState() {
    selectedDateController.text =
        DateFormat("dd MMM, yyyy").format(DateTime.now());
    if (widget.filled) {
      selectedDateController.text = widget.selectedDate!;
      selectClassController.text = widget.selectedClass!;
      selectStudentController.text = widget.selectedStudent!;
      selectRemarkTypeController.text = widget.selectedRemarkType!;
      selectRemarkController.text = widget.remark!;
      fileSource = widget.url!;
    } else {
      for (int i = 0; i < widget.classesModel!.data!.length; i++) {
        classesList.add(PopupMenuItem(
            value: i,
            child: Text(widget.classesModel!.data![i].className.toString())));
      }
    }

    // TODO: implement initState
    super.initState();
  }

  StudentListForRemarksModel studentListForRemarksModel = StudentListForRemarksModel();
  RemarksTypeModel remarksTypeModel = RemarksTypeModel();

     EmployeeProfileModel employeeProfileModel=EmployeeProfileModel() ;

  @override
  Widget build(BuildContext context) {
    if(LocalStorage().read(key: StringConstants.userType)==StringConstants.teacherType){
    employeeProfileModel=
      LocalStorage().readTeacherProfileModel(key: StringConstants.profileModel);
    }



    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: widget.filled
          ? Container()
          : myPadding(
          child: InkWell(
            onTap: () {
                if (globalKey.currentState!.validate()) {
                  TeacherController().uploadRemarks(id: employeeProfileModel.data!.id.toString(),
                      entryDate: selectedDateController.value.text,
                      studentMasterId: studentListForRemarksModel.data![selectedStudentIndex].id.toString(),
                      remarkMasterId: remarksTypeModel.data![selectedRemarksIndex].id.toString(),
                      remarksDetails: selectRemarkController.value.text,
                      fileSource: fileSource);
                }
              },
              child: MyButton(
                  text: "Save", borderRadius: 10, color: Colors.blue))),
      body: myPadding(
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                CommonHeader(
                  title: widget.filled?"Remarks Details":"Create Remarks",
                  hideStudentName: true,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: AbsorbPointer(
                      absorbing: widget.filled,
                      child: Column(
                        children: [
                          largeSpace(),
                          InkWell(
                            onTap: () {
                              getTime().then((value) {
                                selectedDateController.text =
                                    DateFormat("dd MMM, yyyy").format(value);
                                setState(() {});
                              });
                            },
                            child: AbsorbPointer(
                              child: MyTextField(
                                  hint: "Selected Date",
                                  inputType: TextInputType.text,
                                  textEditingController: selectedDateController,
                                  focusNode: selectedDateFocus,
                                  borderColor: Colors.grey,
                                  borderRadius: 10,
                                  filled: widget.filled,
                                  filledColor: Colors.grey.withOpacity(.1),
                                  icon: Icon(Icons.calendar_month),
                                  isValidate: true),
                            ),
                          ),
                          smallSpace(),
                          PopupMenuButton(
                            itemBuilder: (context) => classesList,
                            position: PopupMenuPosition.under,
                            onSelected: (v) {
                              selectedClassIndex = int.parse(v.toString());
                              selectClassController.text = widget.classesModel!
                                  .data![selectedClassIndex].className
                                  .toString();
                              TeacherController().getStudentListForRemarks(
                                  classMasterId: widget.classesModel!
                                      .data![int.parse(v.toString())]
                                      .classMasterId
                                      .toString(),
                                  sectionMasteMasterId: widget
                                      .classesModel!
                                      .data![int.parse(v.toString())]
                                      .classSectionMasterId
                                      .toString()).then((value) {
                                studentListForRemarksModel = value;
                                for (int i = 0; i < value.data!.length; i++) {
                                  studentList.add(PopupMenuItem(
                                      value: i,
                                      child: Text(
                                          value.data![i].name.toString())));
                                }

                                TeacherController().getRemarksType().then((
                                    remarkType) {
                                  remarksTypeModel = remarkType;
                                  for (int i = 0; i <
                                      remarkType.data!.length; i++) {
                                    remarkTypeList.add(PopupMenuItem(
                                        value: i,
                                        child: Text(remarkType.data![i].name
                                            .toString())));
                                  }
                                  setState(() {

                                  });
                                });
                              });
                            },
                            child: AbsorbPointer(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  MyTextFieldDrop(
                                      hint: "Select Class",
                                      inputType: TextInputType.text,
                                      textEditingController: selectClassController,
                                      focusNode: appointmentFocus,
                                      borderColor: Colors.grey,
                                      borderRadius: 10,
                                      filled: widget.filled,
                                      filledColor: Colors.grey.withOpacity(.1),
                                      icon: Icon(Icons.person),
                                      isValidate: true),
                                  // Align(
                                  //   alignment: Alignment.centerRight,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(10.0),
                                  //     child: Icon(Icons.arrow_drop_down),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          ),
                          smallSpace(),
                          PopupMenuButton(
                            itemBuilder: (context) => studentList,
                            position: PopupMenuPosition.under,
                            onSelected: (v) {
                              selectedStudentIndex = int.parse(v.toString());
                              selectStudentController.text =
                                  studentListForRemarksModel
                                      .data![selectedStudentIndex].name
                                      .toString();
                            },
                            child: AbsorbPointer(
                              child: MyTextFieldDrop(
                                  hint: "Selected Student",
                                  inputType: TextInputType.text,
                                  textEditingController: selectStudentController,
                                  focusNode: selectedTeacherFocus,
                                  borderColor: Colors.grey,
                                  borderRadius: 10,
                                  filled: widget.filled,
                                  filledColor: Colors.grey.withOpacity(.1),
                                  icon: Icon(Icons.person),
                                  isValidate: true),
                            ),
                          ),
                          smallSpace(),
                          PopupMenuButton(
                            itemBuilder: (context) => remarkTypeList,
                            position: PopupMenuPosition.under,
                            onSelected: (v) {
                              selectedRemarksIndex = int.parse(v.toString());
                              selectRemarkTypeController.text =
                                  remarksTypeModel.data![selectedRemarksIndex]
                                      .name.toString();
                            },
                            child: AbsorbPointer(
                              child: MyTextFieldDrop(
                                  hint: "Select Remarks Type",
                                  inputType: TextInputType.text,
                                  textEditingController: selectRemarkTypeController,
                                  focusNode: visitByFocus,
                                  borderColor: Colors.grey,
                                  borderRadius: 10,
                                  filled: widget.filled,
                                  filledColor: Colors.grey.withOpacity(.1),
                                  icon: Icon(Icons.person),
                                  isValidate: true),
                            ),
                          ),
                          smallSpace(),
                          MyTextFieldMulti(
                              hint: "Remarks",
                              inputType: TextInputType.multiline,
                              textEditingController: selectRemarkController,
                              focusNode: visitByFocus,
                              borderColor: Colors.grey,
                              borderRadius: 10,
                              filled: widget.filled,
                              filledColor: Colors.grey.withOpacity(.1),
                              icon: Icon(Icons.edit),
                              isValidate: true),
                          smallSpace(),
                          if (!widget.filled)
                            detailsCard(
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
                                            style:
                                            CommonDecoration.smallLabel,
                                          ),
                                        )
                                            : fileSource
                                            .split(".")
                                            .last == "pdf"
                                            ? PDFViewer(
                                          document: doc,
                                        )
                                            : Image.file(File(fileSource)),
                                      ),
                                      if (fileSource.isNotEmpty)
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: InkWell(
                                            onTap: () {
                                              fileSource = "";
                                              setState(() {});
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.red,
                                                      width: 1),
                                                  borderRadius:
                                                  BorderRadius.circular(5)),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Clear",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 10),
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .delete_forever_outlined,
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
                                )),
                          if (widget.filled)
                            SizedBox(
                              height: 200,
                              child: myImage(
                                  isNetwork: true,
                                  source: widget.url.toString()),
                            ),
                          largeSpace(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
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
