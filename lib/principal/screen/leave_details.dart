import 'package:flutter/material.dart';
import 'package:web_school_manager/controller/temp_principal_controller.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/button.dart';
import 'package:web_school_manager/widget/header.dart';
import 'package:web_school_manager/widget/mytextfield.dart';
import 'package:web_school_manager/teacher_model/get_employee_leave_apply_list_model.dart';

class LeaveDetails extends StatelessWidget {
  String teacherName;
  String reason;
  String fromDate;
  String toDate;
  String teacherRemarks;
  String totalDays;
  String status;
  String id;
  String rowVersion;
  Data data;

  LeaveDetails(
      {Key? key,
      required this.fromDate,
      required this.toDate,
      required this.reason,
      required this.status,
      required this.teacherName,
      required this.teacherRemarks,
        required this.rowVersion,
        required this.id,
        required this.data,
      required this.totalDays})
      : super(key: key);

  TextEditingController remarksController = TextEditingController();

  FocusNode remarksFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    if(data.isApproved==true){
      remarksController.text = data.approveRemarks.toString();
    }else{
      remarksController.text = data.rejectRemarks.toString();
    }
    return Scaffold(
      body: myPadding(
          child: Column(
        children: [
          CommonHeader(title: "Leave Details"),
          smallSpace(),
          listCard(
              imageUrl: "s",
              content: Column(
                children: [
                  label(label: "Teacher Name", value: teacherName),
                  label(label: "Reason", value: reason),
                  label(label: "Leave Days", value: totalDays),
                  label(label: "From Date", value: fromDate),
                  label(label: "To Date", value: toDate),
                  label(
                      label: "Approval Status",
                      value: data.isApproved == true ? "Approved" :data.isRejected == true ?  "Rejected":"Pending"),
                  smallSpace(),
                  MyTextField(
                      hint: "Remarks (Optional)",
                      inputType: TextInputType.multiline,
                      textEditingController: remarksController,
                      focusNode: remarksFocus,
                      borderColor: Colors.blue,
                      borderRadius: 10,
                      filled: data.isApproved==true||data.isRejected==true,
                      icon: Icon(Icons.edit),
                      isValidate: false),
                  smallSpace(),
                  if(data.isRejected==false&&data.isApproved==false)
                  Row(
                    children: [
                      Expanded(child: InkWell(
                          onTap: (){
                            TempPrincipalController().rejectEmployeeLeave(id: id, rowVersion: rowVersion, remarks:  remarksController.value.text);
                          },
                          child: MyButton(text: "Reject", borderRadius: 10, color: Colors.red))),
                      SizedBox(width: 10,),
                      Expanded(child: InkWell(
                          onTap: (){
                            TempPrincipalController().approveEmployeeLeave(id: id, rowVersion: rowVersion, remarks: remarksController.value.text);
                          },
                          child: MyButton(text: "Approve", borderRadius: 10, color: Colors.blue))),
                    ],
                  )
                ],
              ),
              showImage: false,
              showArrow: false)
        ],
      )),
    );
  }

  Widget label({required String label, required String value}) {
    return Row(
      children: [
        Expanded(
          child: Text(label),
        ),
        Text(":  "),
        Expanded(
          child: Text(value),
        )
      ],
    );
  }
}
