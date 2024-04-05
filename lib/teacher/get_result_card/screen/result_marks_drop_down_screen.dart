import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/constants/color_constants.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/teacher/get_result_card/model/result_card_student_list_model.dart';
import 'package:web_school_manager/teacher/get_result_card/model/resultcard_model.dart';
import 'package:web_school_manager/teacher/get_result_card/screen/result_mark_entry_screen.dart';
import 'package:web_school_manager/teacher_model/get_class_list_model.dart';
import 'package:web_school_manager/teacher_model/get_class_section_list_model.dart';
import 'package:web_school_manager/teacher_model/get_result_card_model.dart';
import 'package:web_school_manager/teacher_model/get_reult_terms_model.dart';
import 'package:web_school_manager/teacher_model/personality_list_model.dart';
import 'package:web_school_manager/teacher_model/remarks_type_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/button.dart';
import 'package:web_school_manager/widget/header.dart';
import 'package:web_school_manager/widget/mytextfield.dart';

class ResultMarkDropDownScreen extends StatefulWidget {
  GetClassListModel? getClassListModel;
  GetPersonalityListModel? getPersonalityListModel;
  bool? fromPersonalityTraits;
  bool? fromTeacherRemarks;

  ResultMarkDropDownScreen(
      {super.key, this.getClassListModel, this.getPersonalityListModel, this.fromPersonalityTraits, this.fromTeacherRemarks});

  @override
  State<ResultMarkDropDownScreen> createState() =>
      _ResultMarkDropDownScreenState();
}

class _ResultMarkDropDownScreenState extends State<ResultMarkDropDownScreen> {
  final classTextEditController = TextEditingController();

  final sectionEditController = TextEditingController();

  final termTextEditController = TextEditingController();

  final examTextEditController = TextEditingController();

  final subjectTextEditController = TextEditingController();

  String classId = "";
  String sectionId = "";
  String termId = "";
  String examId = "";
  String subjectId = "";

  List<PopupMenuItem> classPopMenu = [];
  List<PopupMenuItem> sectionPopMenu = [];
  List<PopupMenuItem> termPopMenu = [];
  List<PopupMenuItem> examPopMenu = [];
  List<PopupMenuItem> subjectPopMenu = [];

  getSection() async {
    sectionEditController.clear();
    sectionPopMenu = [];
    GetClassSectionListModel getClassSectionListModel =
        await TeacherController()
            .getClassSectionList(id: classId, navigate: false);
    getClassSectionListModel.data!.forEach((element) {
      if (element.id != -1) {
        sectionPopMenu.add(PopupMenuItem(
          onTap: () {
            sectionEditController.text = element.name ?? "";
            sectionId = element.id.toString();
            getTermList();
          },
          child: Text(element.name ?? ""),
          value: element.id,
        ));
      }
    });
  }

  getTermList() async {
    termTextEditController.clear();
    termPopMenu = [];
    GetResultTermsModel model = await TeacherController().getResultCardTerms();
    model.data!.forEach((element) {
      if (element.id != -1) {
        termPopMenu.add(PopupMenuItem(
          onTap: () {
            termTextEditController.text = element.name ?? "";
            termId = element.id.toString();
            if(widget.fromPersonalityTraits==true){
              getPersonalityList();
            }else{
              getExamList();
            }
          },
          child: Text(element.name ?? ""),
          value: element.id,
        ));
      }
    });
  }

  getExamList() async {
    examTextEditController.clear();
    examPopMenu = [];
    GetResultCardModel model = await TeacherController().getResultCard();
    model.data!.forEach((element) {
      if (element.id != -1) {
        examPopMenu.add(PopupMenuItem(
          onTap: () {
            examTextEditController.text = element.name ?? "";
            examId = element.id.toString();
            if(widget.fromPersonalityTraits==true){
              getPersonalityList();
            }else{
              getSubjectList();
            }
          },
          child: Text(element.name ?? ""),
          value: element.id ,
        ));
      }
    });
  }

  getSubjectList() async {
    subjectTextEditController.clear();
    subjectPopMenu = [];
    ResultSubjectModel model = await TeacherController().getResultSubjectList(
        classId: classId,
        sectionId: sectionId,
        termsId: termId,
        examId: examId);
    model.data!.forEach((element) {
      if (element.id != -1) {
        subjectPopMenu.add(PopupMenuItem(
          onTap: () {
            subjectTextEditController.text = element.name ?? "";
            subjectId = element.id.toString();
          },
          child: Text(element.name ?? ""),
          value: element.id,
        ));
      }
    });
  }

  getPersonalityList() async {
    subjectTextEditController.clear();
    subjectPopMenu = [];
    GetPersonalityListModel model = await TeacherController().getPersonalityTraits();
    model.data!.forEach((element) {
      if (element.id != -1) {
        subjectPopMenu.add(PopupMenuItem(
          onTap: () {
            subjectTextEditController.text = element.name ?? "";
            subjectId = element.id.toString();
          },
          child: Text(element.name ?? ""),
          value: element.id,
        ));
      }
    });
  }

  @override
  void initState() {
    widget.getClassListModel!.data!.forEach((element) {
      classPopMenu.add(PopupMenuItem(
        onTap: () {
          classTextEditController.text = element.name ?? "";
          classId = element.id.toString();
          getSection();
        },
        child: Text(element.name ?? ""),
        value: element.id,
      ));
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
        child: Column(
          children: [
            CommonHeader(title: widget.fromPersonalityTraits==true?"Personality Traits":widget.fromTeacherRemarks==true?"Teacher Remarks":"Result Marks"),
            smallSpace(),
            PopupMenuButton(
              itemBuilder: (context) => classPopMenu,
              position: PopupMenuPosition.under,
              child: MyTextFieldDrop(
                  hint: "Class",
                  inputType: TextInputType.text,
                  textEditingController: classTextEditController,
                  borderColor: ColorConstants.themeColor,
                  borderRadius: 10,
                  filled: false,
                  icon: Icon(Icons.class_outlined),
                  isValidate: false),
            ),
            smallSpace(),
            PopupMenuButton(
              itemBuilder: (context) => sectionPopMenu,
              position: PopupMenuPosition.under,
              child: MyTextFieldDrop(
                  hint: "Section",
                  inputType: TextInputType.text,
                  textEditingController: sectionEditController,
                  borderColor: ColorConstants.themeColor,
                  borderRadius: 10,
                  filled: false,
                  icon: Icon(Icons.class_outlined),
                  isValidate: false),
            ),
            smallSpace(),
            PopupMenuButton(
              itemBuilder: (context) => termPopMenu,
              position: PopupMenuPosition.under,
              child: MyTextFieldDrop(
                  hint: "Term",
                  inputType: TextInputType.text,
                  textEditingController: termTextEditController,
                  borderColor: ColorConstants.themeColor,
                  borderRadius: 10,
                  filled: false,
                  icon: Icon(Icons.indeterminate_check_box_outlined),
                  isValidate: false),
            ),
            smallSpace(),

            if(widget.fromPersonalityTraits==null && widget.fromTeacherRemarks==null)...[
              PopupMenuButton(
                itemBuilder: (context) => examPopMenu,
                position: PopupMenuPosition.under,
                child: MyTextFieldDrop(
                    hint: "Exam",
                    inputType: TextInputType.text,
                    textEditingController: examTextEditController,
                    borderColor: ColorConstants.themeColor,
                    borderRadius: 10,
                    filled: false,
                    icon: Icon(Icons.document_scanner_outlined),
                    isValidate: false),
              ),
              smallSpace(),
              PopupMenuButton(
                itemBuilder: (context) => subjectPopMenu,
                position: PopupMenuPosition.under,
                child: MyTextFieldDrop(
                    hint: "Subject",
                    inputType: TextInputType.text,
                    textEditingController: subjectTextEditController,
                    borderColor: ColorConstants.themeColor,
                    borderRadius: 10,
                    filled: false,
                    icon: Icon(Icons.subject_sharp),
                    isValidate: false),
              ),
            ]else if(widget.fromTeacherRemarks==null)...[
              PopupMenuButton(
                itemBuilder: (context) => subjectPopMenu,
                position: PopupMenuPosition.under,
                child: MyTextFieldDrop(
                    hint: "Subject",
                    inputType: TextInputType.text,
                    textEditingController: subjectTextEditController,
                    borderColor: ColorConstants.themeColor,
                    borderRadius: 10,
                    filled: false,
                    icon: Icon(Icons.subject_sharp),
                    isValidate: false),
              ),
            ],

            largeSpace(),
            GestureDetector(
                onTap: () async {
                  if (classTextEditController.value.text.isEmpty ||
                      sectionEditController.value.text.isEmpty ||
                      termTextEditController.value.text.isEmpty ||
                       (examTextEditController.value.text.isEmpty && widget.fromPersonalityTraits==null && widget.fromTeacherRemarks==null) ||
                      (subjectTextEditController.value.text.isEmpty && widget.fromTeacherRemarks==null)) {
                    showMessage(msg: "All Field Are Requires");
                  } else {
                    if(widget.fromPersonalityTraits==true){
                      RemarkStudentListModel model = await TeacherController()
                          .getStudentListForPersonalityTraits(
                          classId: classId,
                          sectionId: sectionId,
                          termsId: termId,
                          personalityTraitMasterId: subjectId);
                      model.data!.data!.classMasterId = classId;
                      model.data!.data!.classSectionMasterId = sectionId;
                      model.data!.data!.termMasterId = termId;
                      model.data!.data!.subjectMasterId = subjectId;
                      Get.to(() => ResultMarkEntryScreen(
                        fromPersonalityTraits: widget.fromPersonalityTraits,
                          remarkStudentListModel: model,));
                    }else if(widget.fromTeacherRemarks==true){
                      RemarksTypeModel remarksTypeModel = await TeacherController().getRemarks();
                      RemarkStudentListModel model = await TeacherController()
                          .GetStudentListForRemarksRemark(
                        classId: classId,
                        sectionId: sectionId,
                        termsId: termId,);
                      model.data!.data!.classMasterId = classId;
                      model.data!.data!.classSectionMasterId = sectionId;
                      model.data!.data!.termMasterId = termId;
                      model.data!.data!.subjectMasterId = subjectId;
                      Get.to(() => ResultMarkEntryScreen(
                        remarksTypeModel: remarksTypeModel,
                        remarkStudentListModel: model,
                      ));
                    }else{
                      RemarksTypeModel remarksTypeModel = await TeacherController().getRemarks();
                      RemarkStudentListModel model =  await TeacherController().getStudentListForRemark(classId: classId, sectionId: sectionId, termsId: termId, examId: examId, subjectMasterId: subjectId);

                      model.data!.data!.classMasterId = classId;
                      model.data!.data!.classSectionMasterId = sectionId;
                      model.data!.data!.termMasterId = termId;
                      model.data!.data!.subjectMasterId = subjectId;
                      model.data!.data!.examMasterId = examId;
                      Get.to(()=>ResultMarkEntryScreen(remarkStudentListModel: model,));

                    }
                  }
                },
                child: MyButton(
                  text: "Next",
                  borderRadius: 10,
                  color: ColorConstants.themeColor,
                ))
          ],
        ),
      ),
    );
  }
}
