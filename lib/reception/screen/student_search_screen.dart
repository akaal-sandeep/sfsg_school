import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/constants/color_constants.dart';
import 'package:web_school_manager/controller/principal_controller.dart';
import 'package:web_school_manager/controller/reception_controller.dart';
import 'package:web_school_manager/principal_model/student_list_by_class_section_model.dart';
import 'package:web_school_manager/principal_model/student_list_by_class_section_model.dart'
as student_data;
import 'package:web_school_manager/principal_model/teacher_list_model.dart';
import 'package:web_school_manager/reception_model/gate_pass_detail_model.dart';
import 'package:web_school_manager/reception_model/out_ward_get_pass_model.dart';
import 'package:web_school_manager/reception_model/verification_id_proof_list_model.dart';
import 'package:web_school_manager/teacher_model/get_class_list_model.dart';
import 'package:web_school_manager/teacher_model/get_class_section_list_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/button.dart';
import 'package:web_school_manager/widget/header.dart';
import 'package:web_school_manager/widget/mytextfield.dart';

class StudentSearchScreen extends StatefulWidget {
  StudentSearchScreen({Key? key}) : super(key: key);

  @override
  State<StudentSearchScreen> createState() => _StudentSearchScreenState();
}

class _StudentSearchScreenState extends State<StudentSearchScreen> {
  File? _image;

  File? _proof;

  List<PopupMenuItem<String>> pickingOption = [
    PopupMenuItem(
      child: Text("Father"),
      value: "Father",
    ),
    PopupMenuItem(
      child: Text("Mother"),
      value: "Mother",
    ),
    PopupMenuItem(
      child: Text("Other"),
      value: "Other",
    ),
  ];

  String classMasterId = "";
  String sectionMasterId = "";

  List<student_data.Data> studentDataList = [];

  String? visitorImage;
  String? visitorProof;

  List<PopupMenuItem<String>> classPop = [];

  List<PopupMenuItem<String>> teacherPop = [];

  List<PopupMenuItem<String>> sectionPop = [];

  List<PopupMenuItem<String>> verificationIdProof = [];

  TextEditingController gatePassId = TextEditingController();

  TextEditingController studentName = TextEditingController();

  TextEditingController className = TextEditingController();

  TextEditingController section = TextEditingController();

  TextEditingController proofText = TextEditingController();

  TextEditingController proofId = TextEditingController();

  TextEditingController picking = TextEditingController();

  TextEditingController teacherName = TextEditingController();

  TextEditingController teacherId = TextEditingController();

  TextEditingController pickingName = TextEditingController();

  TextEditingController pickingContact = TextEditingController();

  TextEditingController reasonForExit = TextEditingController();

  FocusNode studentFocus = FocusNode();

  FocusNode classFocus = FocusNode();

  FocusNode sectionFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  StudentListByClassSectionModel? studentList;
  StudentListByClassSectionModel studentSearchList =
  StudentListByClassSectionModel();

  getClassList() async {
    GetClassListModel getClassListModel =
    await ReceptionController().getClassList();
    getClassListModel.data?.forEach((element) {
      classPop.add(
        PopupMenuItem(
          onTap: () {
            className.text = element.name ?? "";
          },
          child: Text("${element.name}"),
          value: "${element.id}",
        ),
      );
    });
  }

  getTeacherList() async {
    TeacherListModel teacherListModel =
    await PrincipalController().getTeacherListReturn();
    teacherListModel.data?.forEach((element) {
      teacherPop.add(
        PopupMenuItem(
          onTap: () {
            teacherName.text = (element.displayName ?? "")+"-"+element.id.toString();
          },
          child: Text("${element.displayName}-${element.id}"),
          value: "${element.id}",
        ),
      );
    });
  }

  getSectionName({id}) async {
    classMasterId = id;
    section.clear();
    sectionPop = [];
    showLoader();
    GetClassSectionListModel getClassSectionListModel =
    await ReceptionController().getClassSectionList(id: id);
    getClassSectionListModel.data?.forEach((element) {
      if (element.id.toString() == "-1") {
        return;
      }
      sectionPop.add(
        PopupMenuItem(
          onTap: () {
            section.text = element.name ?? "";
          },
          child: Text("${element.name}"),
          value: "${element.id}",
        ),
      );
    });
    hideLoader();
    setState(() {});
  }

  getIdProof() async {
    VerificationIdProofListModel verificationIdProofListModel =
    await ReceptionController().getVisitorIdProof();
    verificationIdProofListModel.data?.forEach((element) {
      if (element.id.toString() == "-1") {
        return;
      }
      verificationIdProof.add(
        PopupMenuItem(
          onTap: () {
            proofText.text = element.name ?? "";
          },
          child: Text("${element.name}"),
          value: "${element.id}",
        ),
      );
    });
    setState(() {});
  }

  OverlayState? overlayState;
  OverlayEntry? overlay1;

  final LayerLink _layerLink = LayerLink();

  int inwardGatePass = 0;
  int gatePassFor = 0;

  /// 1 for student and 2 for teacher

  selectedInwardGatePassState(int val) {
    setState(() {
      inwardGatePass = val;
    });
  }

  selectGatePassFor(int val) {
    setState(() {
      gatePassFor = val;
    });
  }

  @override
  void initState() {
    getIdProof();
    getClassList();
    getTeacherList();
    overlayState = Overlay.of(context);
    studentFocus.addListener(() {
      if (studentFocus.hasFocus) {
        _showOverlay(context);
      } else {
        if (overlay1 != null) {
          if (overlay1?.mounted ?? false) {
            overlay1!.remove();
          }
        }
      }
    });

    studentName.addListener(() {
      studentSearchList.data = [];
      studentList!.data!.forEach((element) {
        if (element.name
            .toString()
            .toLowerCase()
            .contains(studentName.value.text.toLowerCase())) {
          studentSearchList.data!.add(element);
        }
      });
      overlayState!.setState(() {});
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CommonHeader(
                title: "Outward Gate Pass",
                hideStudentName: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      largeSpace(),
                      Row(
                        children: [
                          Text('Has Inward Gatepass No.?'),
                          Spacer(),
                          Radio<int>(
                            value: 1,
                            groupValue: inwardGatePass,
                            activeColor: Colors.green,
                            onChanged: (val) {
                              print("Radio $val");
                              selectedInwardGatePassState(val!);
                            },
                          ),
                          Text("Yes"),
                          Spacer(),
                          Radio<int>(
                            value: 2,
                            groupValue: inwardGatePass,
                            activeColor: Colors.red,
                            onChanged: (val) {
                              print("Radio $val");
                              selectedInwardGatePassState(val!);
                            },
                          ),
                          Text("No"),
                        ],
                      ),
                      if(inwardGatePass == 1)...[
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: MyTextField(hint: "Gate Pass No.",
                                  inputType: TextInputType.text,
                                  textEditingController: gatePassId,
                                  borderColor: ColorConstants.themeColor,
                                  borderRadius: 10,
                                  filled: false,
                                  icon: Icon(Icons.credit_card),
                                  isValidate: false),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                                flex: 1,
                                child: GestureDetector(
                                    onTap: ()async{
                                      if(gatePassId.value.text.isNotEmpty){
                                        GatePassDetailModel model =  await ReceptionController().getGatePassDetails(id: gatePassId.value.text);
                                        if(model.data?.isForStudent==true){
                                          selectGatePassFor(1);
                                          picking.text = model.data?.visitorRelationName??"";
                                          pickingName.text = model.data?.visitorName??"";
                                          pickingContact.text = model.data?.visitorMobileNumber??"";
                                          reasonForExit.text = model.data?.reasonForEntry??"";
                                          // visitorImage = model.data?.visitorPhotoUrlForMobileApp??"";
                                          // visitorProof = model.data?.visitorIDProofPhotoUrlForMobileApp??"";
                                        }else{
                                          selectGatePassFor(2);
                                        }
                                        setState(() {});
                                      }
                                    },
                                    child: MyButton(text: "Search", borderRadius: 10, color: ColorConstants.themeColor)))
                          ],
                        ),
                        smallSpace(),
                      ],



                      Row(
                        children: [
                          Text('Gate Pass for ?'),
                          Spacer(),
                          Radio<int>(
                            value: 1,
                            groupValue: gatePassFor,
                            activeColor: Colors.blue,
                            onChanged: (val) {
                              print("Radio $val");
                              selectGatePassFor(val!);
                            },
                          ),
                          Text("Student"),
                          Spacer(),
                          Radio<int>(
                            value: 2,
                            groupValue: gatePassFor,
                            activeColor: Colors.blue,
                            onChanged: (val) {
                              print("Radio $val");
                              selectGatePassFor(val!);
                            },
                          ),
                          Text("Teacher"),
                        ],
                      ),
                      smallSpace(),
                      if(gatePassFor==1)
                        _studentForm(),
                      if(gatePassFor==2)
                        _teacherForm(),

                      smallSpace(),
                      InkWell(
                          onTap: () async {
                            if(gatePassFor==2){
                              if(_formKey.currentState!.validate()) {
                                showLoader();
                                OutWardGetPassModel outWardGetPassModel =
                                OutWardGetPassModel();

                                outWardGetPassModel.id = "0";
                                outWardGetPassModel.isForStudent = false;
                                outWardGetPassModel.isForStaff = true;
                                outWardGetPassModel.employeeMasterId = int.parse(teacherId.value.text);
                                outWardGetPassModel.reasonForExit =
                                    reasonForExit.value.text;
                                outWardGetPassModel.visitorName = "";
                                outWardGetPassModel.visitorMobileNumber ="";
                                outWardGetPassModel.rowVersion = 1;
                                outWardGetPassModel.visitorCapturedPhoto ="";
                                outWardGetPassModel.visitorIDProofCapturedPhoto ="";
                                outWardGetPassModel.visitorIDProofId =0;
                                outWardGetPassModel.visitorIDProofNumber = "";
                                outWardGetPassModel.employeePhotoCapturedPhoto = "";
                                outWardGetPassModel.lstStudent = [];
                                hideLoader();
                                myLog(
                                    label: "json",
                                    value: outWardGetPassModel.toJson());
                                ReceptionController().saveInstituteOutwardGetPass(
                                    outWardGetPassModel: outWardGetPassModel);
                              }
                            }else{
                              if (_image == null) {
                                showMessage(msg: "Please select visitor photo");
                                return;
                              }
                              if (_formKey.currentState!.validate()) {
                                showLoader();
                                OutWardGetPassModel outWardGetPassModel =
                                OutWardGetPassModel();

                                outWardGetPassModel.id = "0";
                                outWardGetPassModel.isForStudent = true;
                                outWardGetPassModel.isForStaff = false;
                                outWardGetPassModel.employeeMasterId = 0;
                                outWardGetPassModel.reasonForExit =
                                    reasonForExit.value.text;
                                outWardGetPassModel.visitorName =
                                    pickingName.value.text;
                                outWardGetPassModel.visitorMobileNumber =
                                    pickingContact.value.text;
                                outWardGetPassModel.rowVersion = 1;
                                outWardGetPassModel.visitorCapturedPhoto =
                                await covertFileAsBytesReception(
                                    fileSource: _image!.path)
                                    .then((value) {
                                  return "data:image/jpeg;base64," + value;
                                });
                                outWardGetPassModel.visitorIDProofCapturedPhoto =
                                _proof == null
                                    ? ""
                                    : await covertFileAsBytesReception(
                                    fileSource: _proof!.path)
                                    .then((value) {
                                  return "data:image/jpeg;base64," +
                                      value;
                                });
                                outWardGetPassModel.visitorIDProofId =
                                    int.parse(proofId.value.text);
                                outWardGetPassModel.visitorIDProofNumber = "";
                                outWardGetPassModel.employeePhotoCapturedPhoto =
                                "";
                                outWardGetPassModel.lstStudent = [];
                                for (var student in studentDataList) {
                                  outWardGetPassModel.lstStudent!.add(LstStudent(
                                    admissionNumber: student.admissionNumber,
                                    visitorRelationId:
                                    picking.value.text == "Father"
                                        ? "1"
                                        : picking.value.text == "Mother"
                                        ? "2"
                                        : "3",
                                    otherRelationName: picking.value.text,
                                  ));
                                }
                                hideLoader();
                                myLog(
                                    label: "json",
                                    value: outWardGetPassModel.toJson());
                                ReceptionController().saveInstituteOutwardGetPass(
                                    outWardGetPassModel: outWardGetPassModel);
                              }
                            }

                          },
                          child: MyButton(
                              text: "Next",
                              borderRadius: 10,
                              color: ColorConstants.themeColor))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _teacherForm(){
    return  Column(
      children: [
        MyTextField(
            hint: "Reason For Leaving",
            inputType: TextInputType.text,
            textEditingController: reasonForExit,
            focusNode: studentFocus,
            borderColor: ColorConstants.themeColor,
            borderRadius: 10,
            filled: false,
            icon: Icon(Icons.format_indent_increase_outlined),
            isValidate: true),
        smallSpace(),
        PopupMenuButton<String>(
          itemBuilder: (context) => teacherPop,
          onSelected: (v) {
            teacherId.text = v;
          },
          position: PopupMenuPosition.under,
          child: MyTextFieldDrop(
              hint: "Select Teacher",
              inputType: TextInputType.name,
              textEditingController: teacherName,
              borderColor: ColorConstants.themeColor,
              borderRadius: 10,
              filled: false,
              icon: Icon(Icons.person),
              isValidate: true),
        ),
      ],
    );
  }

  _studentForm(){
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: PopupMenuButton(
                  position: PopupMenuPosition.under,
                  itemBuilder: (context) => classPop,
                  onSelected: (id) {
                    getSectionName(id: id);
                    //  className.text = v.toString();
                  },
                  child: MyTextFieldDrop(
                      hint: "Class",
                      inputType: TextInputType.name,
                      textEditingController: className,
                      focusNode: classFocus,
                      borderColor: ColorConstants.themeColor,
                      borderRadius: 10,
                      filled: false,
                      icon: Icon(Icons.clear_all_sharp),
                      isValidate: true),
                )),
            if (className.value.text.isNotEmpty) ...[
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: PopupMenuButton(
                    position: PopupMenuPosition.under,
                    itemBuilder: (context) => sectionPop,
                    onSelected: (id) async {
                      studentName.clear();
                      studentList = await ReceptionController()
                          .getStudentListByClassSection(
                          classMasterId: classMasterId,
                          classMasterSectionId: id.toString());
                      setState(() {});
                    },
                    child: MyTextFieldDrop(
                        hint: "Section",
                        inputType: TextInputType.name,
                        textEditingController: section,
                        focusNode: sectionFocus,
                        borderColor: ColorConstants.themeColor,
                        borderRadius: 10,
                        filled: false,
                        icon: Icon(Icons.security),
                        isValidate: true),
                  )),
            ],
          ],
        ),
        if (section.value.text.isNotEmpty) ...[
          smallSpace(),
          CompositedTransformTarget(
            link: _layerLink,
            child: MyTextFieldOverLay(
                hint: "Student Name",
                inputType: TextInputType.name,
                textEditingController: studentName,
                focusNode: studentFocus,
                borderColor: ColorConstants.themeColor,
                borderRadius: 10,
                filled: false,
                icon: Icon(Icons.person),
                isValidate: true),
          ),
        ],
        if (studentDataList.isNotEmpty)
          GridView.builder(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: studentDataList.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, i) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: Image.network(
                            studentDataList[i]
                                .studentProfilePicturePath ??
                                "",
                          ),
                        ),
                        Text(studentDataList[i].name ?? ""),
                        Text(
                            "${studentDataList[i]
                                .className}-${studentDataList[i]
                                .classSectionName}"),
                        Text(studentDataList[i].admissionNumber ??
                            ""),
                      ],
                    ),
                    Positioned(
                        top: 0,
                        right: 10,
                        child: InkWell(
                            onTap: () {
                              studentDataList.removeAt(i);
                              setState(() {});
                            },
                            child: Icon(
                              Icons.clear,
                              color: Colors.red,
                            )))
                  ],
                );
              }),
        smallSpace(),
        PopupMenuButton<String>(
          itemBuilder: (context) => pickingOption,
          onSelected: (v) {
            picking.text = v;
          },
          position: PopupMenuPosition.under,
          child: MyTextFieldDrop(
              hint: "Relation With Student?",
              inputType: TextInputType.name,
              textEditingController: picking,
              borderColor: ColorConstants.themeColor,
              borderRadius: 10,
              filled: false,
              icon: Icon(Icons.person),
              isValidate: true),
        ),
        smallSpace(),
        MyTextField(
            hint: "Visitor's Name",
            inputType: TextInputType.name,
            textEditingController: pickingName,
            focusNode: studentFocus,
            borderColor: ColorConstants.themeColor,
            borderRadius: 10,
            filled: false,
            icon: Icon(Icons.person),
            isValidate: true),
        smallSpace(),
        MyTextField(
            hint: "Visitor's Contact Number",
            inputType: TextInputType.number,
            textEditingController: pickingContact,
            focusNode: studentFocus,
            borderColor: ColorConstants.themeColor,
            borderRadius: 10,
            filled: false,
            icon: Icon(Icons.phone),
            isValidate: true),
        smallSpace(),
        MyTextField(
            hint: "Reason For Leaving",
            inputType: TextInputType.text,
            textEditingController: reasonForExit,
            focusNode: studentFocus,
            borderColor: ColorConstants.themeColor,
            borderRadius: 10,
            filled: false,
            icon: Icon(Icons.format_indent_increase_outlined),
            isValidate: true),
        smallSpace(),
        PopupMenuButton<String>(
          itemBuilder: (context) => verificationIdProof,
          onSelected: (v) {
            proofId.text = v;
          },
          position: PopupMenuPosition.under,
          child: MyTextFieldDrop(
              hint: "Type Of Proof",
              inputType: TextInputType.name,
              textEditingController: proofText,
              borderColor: ColorConstants.themeColor,
              borderRadius: 10,
              filled: false,
              icon: Icon(Icons.insert_drive_file_outlined),
              isValidate: true),
        ),
        smallSpace(),
        Row(
          children: [
            InkWell(
              onTap: () async {
                visitorImage = null;
                XFile? xFile = await ImagePicker().pickImage(
                    source: ImageSource.camera, imageQuality: 10);
                _image = File(xFile!.path);
                setState(() {});
              },
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(5),
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey)),
                      alignment: Alignment.center,
                      child:visitorImage!=null?Image.network(visitorImage!) :_image == null
                          ? Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt_outlined),
                          Text("Add Photo"),
                        ],
                      )
                          : Image.file(_image!)),
                  Text("Visitor Photo")
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () async {
                visitorProof = null;
                XFile? xFile = await ImagePicker().pickImage(
                    source: ImageSource.camera, imageQuality: 10);
                _proof = File(xFile!.path);
                setState(() {});
              },
              child: Column(children: [
                Container(
                    height: 100,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)),
                    child:visitorProof!=null?Image.network(visitorProof!) : _proof == null
                        ? Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt_outlined),
                        Text(
                          "Add Photo\n(Optional)",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                        : Image.file(_proof!)),
                Text("ID Photo")
              ]),
            )
          ],
        ),
      ],
    );
  }

  void _showOverlay(BuildContext context) async {
    overlay1 = OverlayEntry(builder: (context) {
      myLog(label: "overlay", value: "rebuild");
      return myPadding(
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          //   offset: Offset(0.0, 500 + 5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              alignment: Alignment.topCenter,
              color: Colors.transparent,
              margin: EdgeInsets.only(top: 50, left: 4, right: 4),
              child: Material(
                elevation: 3,
                child: studentName.value.text.isNotEmpty
                    ? _searchList()
                    : _allStudentList(),
              ),
            ),
          ),
        ),
      );
    });

    overlayState?.insert(overlay1!);
  }

  _searchList() {
    return Container(
      height: (studentSearchList.data?.length ?? 0) * 35,
      decoration: BoxDecoration(color: Colors.white, boxShadow: myShadow),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: studentSearchList.data?.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () {
                if (studentDataList.contains(studentSearchList.data![i])) {
                  showMessage(msg: "Student Already selected");
                  return;
                }
                studentDataList.add(studentSearchList.data![i]);
                studentName.text = studentSearchList.data![i].name ?? "";
                studentFocus.unfocus();
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    SizedBox(
                        height: 15,
                        width: 15,
                        child: Image.network(
                          studentSearchList
                              .data?[i].studentProfilePicturePath ??
                              "",
                          fit: BoxFit.cover,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${studentSearchList.data?[i].name}",
                      style: TextStyle(
                        height: 1,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  _allStudentList() {
    return Container(
      height: (studentList?.data?.length ?? 0) * 35,
      decoration: BoxDecoration(color: Colors.white, boxShadow: myShadow),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: studentList?.data?.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            if (studentName.value.text.isNotEmpty &&
                !(studentList!.data![i].name
                    .toString()
                    .toLowerCase()
                    .contains(studentName.value.text.toLowerCase()))) {
              return SizedBox();
            }

            return InkWell(
              onTap: () {
                if (studentDataList.contains(studentList!.data![i])) {
                  showMessage(msg: "Student Already selected");
                  return;
                }
                studentDataList.add(studentList!.data![i]);
                studentName.text = studentList!.data![i].name ?? "";
                studentFocus.unfocus();
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    SizedBox(
                        height: 15,
                        width: 15,
                        child: Image.network(
                          studentList?.data?[i].studentProfilePicturePath ?? "",
                          fit: BoxFit.cover,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${studentList?.data?[i].name}",
                      style: TextStyle(
                        height: 1,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
