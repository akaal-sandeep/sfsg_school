import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/controller/parent_controller.dart';
import 'package:web_school_manager/controller/parent_state_controller.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../../utility/custom_decoration.dart';


class LeaveAppliedParent extends StatefulWidget {
  String fromDateT;
  String toDateT;

  LeaveAppliedParent({Key? key, required this.fromDateT, required this.toDateT})
      : super(key: key);

  @override
  State<LeaveAppliedParent> createState() => _LeaveAppliedParentState();
}

class _LeaveAppliedParentState extends State<LeaveAppliedParent> {
  final parentStateController = Get.put(ParentStateController());

  DateTime toDate = DateTime.now().subtract(Duration(days: 365));
  DateTime fromDate = DateTime.now();

  Future getTime() async {
    DateTime? picker = await showDatePicker(
        context: context,
        initialDate: fromDate,
        firstDate: DateTime.now().subtract(Duration(days: 300)),
        lastDate: DateTime.now());
    return picker;
  }

  @override
  void initState() {
    // TODO: implement initState
    toDate = DateFormat("dd MMM, yyyy").parse(widget.toDateT);
    fromDate = DateFormat("dd MMM, yyyy").parse(widget.fromDateT);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          TeacherController().getReasonList();
          // Get.to(()=>ApplyLeave());
        },
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            boxShadow: myShadow,
            borderRadius: BorderRadius.circular(100),
            color: Colors.blue,
          ),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: myPadding(
          child: Column(
            children: [
              CommonHeader(title: "Apply Leave"),
              smallSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      getTime().then((value) {
                        fromDate = value;
                        ParentController().getStudentLeaveApplyList(fromDate: getTimeFormat(fromDate),toDate: getTimeFormat(toDate),navigate: false).then((value) {
                          setState(() {});
                        });
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Text(DateFormat("dd MMM, yyyy").format(fromDate)),
                          Icon(
                            Icons.calendar_month,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ),
                  Text("-"),
                  InkWell(
                    onTap: () {
                      getTime().then((value) {
                        toDate = value;
                        ParentController().getStudentLeaveApplyList(fromDate: getTimeFormat(fromDate),toDate: getTimeFormat(toDate),navigate: false);

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
                          Text(DateFormat("dd MMM, yyyy").format(toDate)),
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
              SizedBox(height: 30,),


              GetBuilder(
                  init: parentStateController,
                  builder: (context) {
                    return Expanded(
                      child:parentStateController.studentLeaveModel.value.data!.length.isEqual(0)?myImage(isNetwork: false, source: "assets/icons/empty.png"): ListView.builder(
                          itemCount: parentStateController.studentLeaveModel.value.data!.length,
                          itemBuilder: (context,i){
                            return listCard(
                                backgroundColor: parentStateController.studentLeaveModel.value
                                    .data![i].isApproved==true?Colors.blue.withOpacity(.2):parentStateController.studentLeaveModel.value
                                    .data![i].isRejected==true?Colors.red.withOpacity(.2):Colors.white,
                                imageUrl: "S",showImage: false, content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${getTimeFormat(DateTime.parse(parentStateController.studentLeaveModel.value.data![i].fromDate.toString()))} - ${getTimeFormat(DateTime.parse(parentStateController.studentLeaveModel.value.data![i].toDate.toString()))}",style: CommonDecoration.listStyle),
                                SizedBox(height: 5,),
                                Text(parentStateController.studentLeaveModel.value.data![i].studentLeaveReasonName.toString(),style: CommonDecoration.smallLabel),
                                Text("Your Remarks: "+parentStateController.studentLeaveModel.value.data![i].remarks.toString(),style: CommonDecoration.smallLabel),
                                if(parentStateController.studentLeaveModel.value
                                    .data![i].isApproved==true)
                                Text("Approved Remarks: "+parentStateController.studentLeaveModel.value.data![i].approveRemarks.toString(),style: CommonDecoration.smallLabel),
                                if(parentStateController.studentLeaveModel.value
                                    .data![i].isRejected==true)
                                Text("Reject Remarks: "+parentStateController.studentLeaveModel.value.data![i].rejectRemarks.toString(),style: CommonDecoration.smallLabel),
                              ],
                            ));
                          }),
                    );
                  }
              )
            ],
          )),
    );
  }
}
