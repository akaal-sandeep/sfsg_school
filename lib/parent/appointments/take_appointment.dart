import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/controller/parent_controller.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/button.dart';
import 'package:web_school_manager/widget/header.dart';
import 'package:web_school_manager/widget/mytextfield.dart';

import '../../parent_model/employee_list_for appointment_model.dart';
import '../../parent_model/relation_model.dart';

class TakeAppointment extends StatefulWidget {
  EmployeeListForAppointmentModel employeeListForAppointmentModel;
  RelationModel relationModel;

  TakeAppointment(
      {Key? key,
      required this.employeeListForAppointmentModel,
      required this.relationModel})
      : super(key: key);

  @override
  State<TakeAppointment> createState() => _TakeAppointmentState();
}

class _TakeAppointmentState extends State<TakeAppointment> {
  final globalKey = GlobalKey<FormState>();

  final selectedDateController = TextEditingController();

  final appointmentWithController = TextEditingController();

  final selectedTeacherController = TextEditingController();

  final visitByController = TextEditingController();

  final remarksController = TextEditingController();

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

  List<PopupMenuItem> teacher = [];
  List<PopupMenuItem> relation = [];
  List<PopupMenuItem> appointmentWith = [];
  int selectedTeacherIndex = 0;
  int selectedRelation = 0;

  @override
  void initState() {
    appointmentWith
        .add(PopupMenuItem(value: "TEACHER", child: Text("TEACHER")));
    appointmentWith
        .add(PopupMenuItem(value: "PRINCIPAL", child: Text("PRINCIPAL")));
    appointmentWith.add(
        PopupMenuItem(value: "TRANSPORT HEAD", child: Text("TRANSPORT HEAD")));

    for (int i = 0;
        i < widget.employeeListForAppointmentModel.data!.length;
        i++) {
      teacher.add(PopupMenuItem(
          value: i,
          child: Text(widget
              .employeeListForAppointmentModel.data![i].displayName
              .toString())));
    }

    for (int i = 0; i < widget.relationModel.data!.length; i++) {
      relation.add(PopupMenuItem(
          value: i,
          child: Text(widget.relationModel.data![i].name.toString())));
    }

    selectedDateController.text =
        DateFormat("dd MMM, yyyy").format(DateTime.now());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
          child: SingleChildScrollView(
            child: Form(
        key: globalKey,
        child: Column(
            children: [
              CommonHeader(title: "Book Appointment"),
              smallSpace(),
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
                      filled: false,
                      icon: Icon(Icons.calendar_month),
                      isValidate: true),
                ),
              ),
              smallSpace(),
              PopupMenuButton(
                itemBuilder: (context) => appointmentWith,
                position: PopupMenuPosition.under,
                onSelected: (v) {
                  appointmentWithController.text = v.toString();
                  setState(() {});
                },
                child: MyTextFieldDrop(
                    hint: "Appointment With",
                    inputType: TextInputType.text,
                    textEditingController: appointmentWithController,
                    focusNode: appointmentFocus,
                    borderColor: Colors.grey,
                    borderRadius: 10,
                    filled: false,
                    icon: Icon(Icons.person),
                    isValidate: true),
              ),
              if (appointmentWithController.value.text == "TEACHER")
                smallSpace(),
              if (appointmentWithController.value.text == "TEACHER")
                PopupMenuButton(
                  itemBuilder: (context) => teacher,
                  position: PopupMenuPosition.under,
                  onSelected: (v) {
                    selectedTeacherIndex = int.parse(v.toString());
                    selectedTeacherController.text = widget
                            .employeeListForAppointmentModel
                            .data![selectedTeacherIndex]
                            .displayName ??
                        "";
                    setState(() {});
                  },
                  child: MyTextFieldDrop(
                      hint: "Selected Teacher",
                      inputType: TextInputType.text,
                      textEditingController: selectedTeacherController,
                      focusNode: selectedTeacherFocus,
                      borderColor: Colors.grey,
                      borderRadius: 10,
                      filled: false,
                      icon: Icon(Icons.person),
                      isValidate: true),
                ),
              smallSpace(),
              PopupMenuButton(
                itemBuilder: (context) => relation,
                position: PopupMenuPosition.under,
                onSelected: (v) {
                  selectedRelation = int.parse(v.toString());
                  visitByController.text =
                      widget.relationModel.data![selectedRelation].name ?? "";
                  setState(() {});
                },
                child: MyTextFieldDrop(
                    hint: "Visit By",
                    inputType: TextInputType.text,
                    textEditingController: visitByController,
                    focusNode: visitByFocus,
                    borderColor: Colors.grey,
                    borderRadius: 10,
                    filled: false,
                    icon: Icon(Icons.person),
                    isValidate: true),
              ),
              smallSpace(),
              MyTextField(
                  hint: "Remarks",
                  inputType: TextInputType.text,
                  textEditingController: remarksController,
                  focusNode: visitByFocus,
                  borderColor: Colors.grey,
                  borderRadius: 10,
                  filled: false,
                  icon: Icon(Icons.edit),
                  isValidate: true),
              largeSpace(),
              InkWell(
                  onTap: () {
                    if (globalKey.currentState!.validate()) {
                      ParentController().saveAppointment(
                          date: selectedDateController.value.text,
                          appointmentWith: appointmentWithController.value.text,
                          empMasterId:appointmentWithController.value.text=="TEACHER"?widget.employeeListForAppointmentModel
                              .data![selectedTeacherIndex].id.toString():"0",

                          relationMasterId: widget
                              .relationModel.data![selectedRelation].id
                              .toString(),
                          remark: remarksController.value.text);
                    }
                  },
                  child: MyButton(
                      text: "Request Appointment",
                      borderRadius: 10,
                      color: Colors.blue)
              )
            ],
        ),
      ),
          )),
    );
  }
}
