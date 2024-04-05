import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/teacher_model/bag_components_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/button.dart';
import 'package:web_school_manager/widget/header.dart';
import 'package:web_school_manager/widget/mytextfield.dart';

class BagComponentScreen extends StatefulWidget {
  BagComponentModel model;
  String className;
  String classId;
  String sectionName;
  String sectionId;
  String subjectName;
  String subjectId;

  BagComponentScreen({super.key,
    required this.model,
    required this.className,
    required this.classId,
    required this.sectionName,
    required this.sectionId,
    required this.subjectId,
    required this.subjectName
  });

  @override
  State<BagComponentScreen> createState() => _BagComponentScreenState();
}

class _BagComponentScreenState extends State<BagComponentScreen> {
  DateTime fromDate = DateTime.now().add(Duration(days: 1));

  List<PopupMenuItem> componentList = [];

  List<ComponentsModel> listOfComponentsSelected = [];

  int? selectedComponent;

  final selectedComponentTextController = TextEditingController();
  final otherTextEditController = TextEditingController();

  Future getTime({required DateTime start}) async {
    DateTime? picker = await showDatePicker(
        context: Get.context!,
        initialDate: start,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 10)));
    return picker;
  }

  @override
  void initState() {
    widget.model.data!.forEach((element) {
      componentList.add(PopupMenuItem(
          onTap: () {
            selectedComponent = element.id;
            selectedComponentTextController.text = element.name ?? "";
          },
          child: Text(element.name ?? "")));
    });



    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: myPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonHeader(
              title: "Bag Components",
              hideStudentName: true,
            ),
            smallSpace(),
            Align(
                alignment: Alignment.center,
                child: Text("${widget.subjectName}, ${widget.className}-${widget
                    .sectionName}", style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w700),)),
            smallSpace(),

            InkWell(
              onTap: () {
                getTime(start: fromDate).then((value) {
                  fromDate = value;
                  setState(() {});
                });
              },
              child: Row(
                children: [
                  Text("Date : "),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(DateFormat("dd MMM, yyyy").format(fromDate)),
                        Icon(
                          Icons.calendar_month,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            smallSpace(),
            PopupMenuButton(
              itemBuilder: (context) => componentList,
              child: MyTextFieldDrop(
                  hint: "Bag Component",
                  inputType: TextInputType.text,
                  textEditingController: selectedComponentTextController,
                  borderColor: Colors.black,
                  borderRadius: 10,
                  filled: false,
                  icon: Icon(Icons.view_compact_alt_outlined),
                  isValidate: false),
            ),
            smallSpace(),
            if(true)...[
              MyTextField(
                  hint: "Other Components",
                  inputType: TextInputType.text,
                  textEditingController: otherTextEditController,
                  borderColor: Colors.black,
                  borderRadius: 10,
                  filled: false,
                  icon: Icon(Icons.settings_input_composite_outlined),
                  isValidate: false),
              smallSpace(),
            ],
            GestureDetector(
                onTap: () {
                  if(otherTextEditController.value.text.isNotEmpty){
                    if(-1!=listOfComponentsSelected.indexWhere((element)=>element.id==-1)){
                      listOfComponentsSelected[listOfComponentsSelected.indexWhere((element)=>element.id==-1)] = ComponentsModel(
                          id:-1,
                          name: otherTextEditController.value.text);
                    }else{
                      listOfComponentsSelected.add(ComponentsModel(id: -1, name: otherTextEditController.value.text));
                    }
                  }

                  if (selectedComponentTextController.value.text.isNotEmpty) {
                    if (selectedComponent == -1) {
                      listOfComponentsSelected.add(ComponentsModel(
                          id: selectedComponent ?? 0,
                          name: otherTextEditController.value.text));
                    } else {
                      listOfComponentsSelected.add(ComponentsModel(
                          id: selectedComponent ?? 0,
                          name: selectedComponentTextController.value.text));
                    }
                  }
                  selectedComponent = null;
                  selectedComponentTextController.clear();
                  setState(() {});
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: MyButton(
                    text: "Add Components",
                    borderRadius: 10,
                    color: Colors.blue)),
            smallSpace(),
            Text(
              "Selected Components List",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            smallSpace(),
            Expanded(
                child: ListView.separated(
                    itemCount: listOfComponentsSelected.length,
                    separatorBuilder: (context, i) =>
                        SizedBox(
                          height: 2,
                        ),
                    itemBuilder: (context, i) =>
                        Container(
                          padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          color: Colors.grey.withOpacity(.2),
                          child: Row(
                            children: [
                              Text("${i + 1}. " +
                                  listOfComponentsSelected[i].name),
                              Spacer(),
                              GestureDetector(
                                  onTap: () {
                                    listOfComponentsSelected.removeAt(i);
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                        ))),
            smallSpace(),
            GestureDetector(
                onTap: () {
                  if(componentList.isNotEmpty){
                    if(listOfComponentsSelected.isEmpty){
                      return;
                    }
                    TeacherController().saveBagComponent(
                        date: DateFormat("dd MMM, yyyy").format(fromDate),
                        classMasterId: widget.classId,
                        sectionMasterId: widget.sectionId,
                        other: otherTextEditController.value.text,
                        subjectMasterId: widget.subjectId,
                        listData: listOfComponentsSelected);
                  }
                  },
                child: MyButton(
                    text: "Save Components",
                    borderRadius: 10,
                    color: Colors.green)),
            smallSpace(),
          ],
        ),
      ),
    );
  }
}

class ComponentsModel {
  int id;
  String name;

  ComponentsModel({required this.id, required this.name});
}
