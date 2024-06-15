import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/controller/parent_controller.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/button.dart';
import 'package:web_school_manager/widget/header.dart';
import 'package:web_school_manager/widget/mytextfield.dart';

import '../../constants/color_constants.dart';
import '../../constants/string_constants.dart';
import '../../controller/teacher_controller.dart';
import '../../local_storage/local_storage.dart';
import '../../model/leave_reason_list_model.dart';
import '../../parent_model/get_student_list_r1_model.dart';
import '../../teacher_model/employee_profile_model.dart';

class ApplyLeave extends StatefulWidget {
  LeaveReasonList leaveReasonList;

  ApplyLeave({Key? key, required this.leaveReasonList}) : super(key: key);

  @override
  State<ApplyLeave> createState() => _ApplyLeaveState();
}

class _ApplyLeaveState extends State<ApplyLeave> {
  final globalKey = GlobalKey<FormState>();

  DateTime toDate = DateTime.now();
  DateTime fromDate = DateTime.now();

  TextEditingController leaveController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  FocusNode leaveFocus = FocusNode();
  FocusNode remarkFocus = FocusNode();

  List<PopupMenuItem> popMenuItems = [];
  int selectedReasonIndex = 093;

  bool isMultipleDays = false;

  Future getTime({required DateTime start}) async {
    DateTime? picker = await showDatePicker(
        context: context,
        initialDate: start,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    return picker;
  }

  @override
  void initState() {
    for (int i = 0; i < widget.leaveReasonList.data!.length; i++) {
      popMenuItems.add(PopupMenuItem(
          value: i,
          child: Text(widget.leaveReasonList.data![i].name.toString())));
    }
    // TODO: implement initState
    super.initState();
  }

  EmployeeProfileModel employeeProfileModel = EmployeeProfileModel();
  StudentData studentData = StudentData();

  @override
  Widget build(BuildContext context) {
    if(toDate.difference(fromDate).inDays<=0){
      toDate = fromDate;
    }
    String userType = LocalStorage().read(key: StringConstants.userType);
    if (userType == StringConstants.teacherType) {
      employeeProfileModel =
          LocalStorage().readTeacherProfileModel(
              key: StringConstants.teacherProfileModel);
    } else {
      studentData = LocalStorage().readStudentModel(
          key: StringConstants.parentProfileModel);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: myPadding(
          child: Form(
            key: globalKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CommonHeader(title: "Apply Leave"),
                  smallSpace(),
                  detailsCard(label: "Multiple Days", content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text("Enable Multiple Days")),
                      Transform.scale(
                        scale: .7,
                        child: CupertinoSwitch(value: isMultipleDays,
                            activeColor: ColorConstants.themeColor,
                            onChanged: (v){
                          isMultipleDays = v;
                          setState(() {

                          });
                        }),
                      )
                    ],
                  )),
                  smallSpace(),
                  detailsCard(
                    label: isMultipleDays?"Select Dates":"Select Date",
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(isMultipleDays)
                            Text("From Date"),
                            InkWell(
                              onTap: () {
                                getTime(start: fromDate).then((value) {
                                  fromDate = value;
                                  setState(() {});
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  children: [
                                    Text(DateFormat("dd MMM, yyyy").format(
                                        fromDate)),
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
                        if(isMultipleDays)
                        Padding(
                          padding: EdgeInsets.only(top: 18.0),
                          child: Text("-"),
                        ),
                        if(isMultipleDays)

                          Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("To Date"),
                            InkWell(
                              onTap: () {
                                getTime(start: toDate).then((value) {
                                  toDate = value;
                                  setState(() {});
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  children: [
                                    Text(DateFormat("dd MMM, yyyy").format(
                                        toDate)),
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
                  PopupMenuButton(
                    itemBuilder: (context) => popMenuItems,
                    position: PopupMenuPosition.under,
                    onSelected: (v) {
                      int index = int.parse(v.toString());
                      leaveController.text =
                          widget.leaveReasonList.data![index].name.toString();
                      selectedReasonIndex =
                          widget.leaveReasonList.data![index].id ?? 0;
                      setState(() {});
                    },
                    child: AbsorbPointer(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          MyTextField(
                              hint: "Leave Reason",
                              inputType: TextInputType.name,
                              textEditingController: leaveController,
                              focusNode: leaveFocus,
                              borderColor: Colors.grey,
                              borderRadius: 10,
                              filled: false,
                              icon: Icon(Icons.create_sharp),
                              isValidate: true),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_drop_down),
                              ))
                        ],
                      ),
                    ),
                  ),
                  smallSpace(),
                  MyTextField(
                      hint: "Remarks(Optional)",
                      inputType: TextInputType.name,
                      textEditingController: remarkController,
                      focusNode: remarkFocus,
                      borderColor: Colors.grey,
                      borderRadius: 10,
                      filled: false,
                      icon: Icon(Icons.create_sharp),
                      isValidate: false),
                  largeSpace(),
                  InkWell(
                      onTap: () {

                        if(!isMultipleDays){
                          toDate = fromDate;
                        }

                        if (globalKey.currentState!.validate()) {
                          myLog(label: "leave gap", value: toDate
                              .difference(fromDate)
                              .inDays);
                          if (userType == StringConstants.teacherType) {
                            TeacherController().teacherApplyLeave(
                                id: employeeProfileModel.data!.id.toString(),
                                employeeMasterId: employeeProfileModel.data!
                                    .employeeId.toString(),
                                EmployeeLeaveReasonMasterId: selectedReasonIndex
                                    .toString(),
                                remarks: remarkController.value.text,
                                leaveDays: (toDate
                                    .difference(fromDate)
                                    .inDays + 1).toString(),
                                fromDate: fromDate.toString(),
                                toDate: toDate.toString()
                            );
                          } else {
                            ParentController().studentLeaveApply(
                                leaveMasterId: selectedReasonIndex
                                    .toString(),
                                leaveDays: (toDate
                                    .difference(fromDate)
                                    .inDays + 1).toString(),
                                fromDate: fromDate.toString(),
                                toDate: toDate.toString(),
                                remarks: remarkController.value.text);
                          }
                        }
                      },
                      child: MyButton(
                          text: "Apply leave",
                          borderRadius: 10,
                          color: Colors.blue))
                ],
              ),
            ),
          )),
    );
  }
}
