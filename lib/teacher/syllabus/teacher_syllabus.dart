import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/constants/color_constants.dart';
import 'package:web_school_manager/constants/string_constants.dart';
import 'package:web_school_manager/controller/parent_controller.dart';
import 'package:web_school_manager/controller/principal_controller.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/local_storage/local_storage.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';
import 'package:web_school_manager/widget/mytextfield.dart';
import '../../teacher_model/get_class_list_model.dart';
import '../../teacher_model/get_class_list_model.dart' as data;

class TeacherSyllabus extends StatefulWidget {
  GetClassListModel getClassListModel;
  bool? fromHomeWork;
  bool? classWorkTeacher;
  bool? fromClassWork;
  bool? fromResultCard;
  bool? fromBagComponents;
  bool? fromDateSheet;

  TeacherSyllabus(
      {Key? key, required this.getClassListModel, this.fromHomeWork,this.classWorkTeacher,this.fromClassWork,this.fromResultCard,this.fromBagComponents,this.fromDateSheet})
      : super(key: key);

  @override
  State<TeacherSyllabus> createState() => _TeacherSyllabusState();
}

class _TeacherSyllabusState extends State<TeacherSyllabus> {
  final controller = Get.put(PrincipalController());

  var type;

  List<data.Data> _searchList = [];

  sectionNavigation({required data.Data data}) {

    if(widget.fromBagComponents==true){
      TeacherController().getClassSectionList(
          fromBagComponents: true,
          className: data.name, id: data.id.toString());
      return;
    }

    if(widget.fromResultCard==true){
      TeacherController().getClassSectionList(
        fromResultCard: true,
           className: data.name, id: data.id.toString());
      return;

    }


    if (widget.fromHomeWork == true) {
      TeacherController().getClassSectionList(
          fromHomeWork: true, className: data.name, id: data.id.toString());
    }else if(widget.fromClassWork==true){
      TeacherController().getClassSectionList(
          fromClassWork: true, className: data.name, id: data.id.toString());
    } else {
      TeacherController().getClassSectionList(id: data.id.toString(),className: data.name);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.searchController!.addListener(() {
      _searchList = [];
      myLog(label: "items", value: 2);
      for (var element in widget.getClassListModel.data!) {
        if (element.name!
            .toUpperCase()
            .contains(controller.searchController!.value.text.toUpperCase())) {
          _searchList.add(element);
        }
      }
      myLog(label: "_searchList", value: _searchList.length);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    type = LocalStorage().read(key: StringConstants.userType);
    return Scaffold(
      body: myPadding(
          child: Column(
        children: [
          CommonHeader(
            title: widget.fromHomeWork == true ? "Homework" : "Classes",
            hideStudentName: true,
          ),
          smallSpace(),
        _searchField(),
          smallSpace(),
          controller.searchController!.value.text.length.isEqual(0)
              ? widget.getClassListModel.data!.length.isEqual(0)
                  ? myImage(isNetwork: false, source: "assets/icons/empty.png")
                  : Expanded(
                      child: ListView.builder(
                          itemCount: widget.getClassListModel.data!.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                                onTap: () {
                                  if(widget.fromDateSheet==true){
                                    ParentController().getDateSheetByClassId(classMaterId:widget.getClassListModel.data![i].id.toString() );
                                    return;
                                  }
                                  sectionNavigation(
                                      data: widget.getClassListModel.data![i]);
                                },
                                child: subjectCard(
                                    subjectName: widget
                                            .getClassListModel.data![i].name ??
                                        ""));
                          }),
                    )
              : _searchList.length.isEqual(0)
                  ? myImage(isNetwork: false, source: "assets/icons/empty.png")
                  : Expanded(
                      child: ListView.builder(
                          itemCount: _searchList.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                                onTap: () {
                                  sectionNavigation(data: _searchList[i]);
                                },
                                child: subjectCard(
                                    subjectName:
                                        _searchList[i].name.toString()));
                          }),
                    ),
        ],
      )),
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
