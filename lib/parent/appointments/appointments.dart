import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/constants/string_constants.dart';
import 'package:web_school_manager/controller/parent_controller.dart';
import 'package:web_school_manager/controller/parent_state_controller.dart';
import 'package:web_school_manager/parent/appointments/cancelled_appointments.dart';
import 'package:web_school_manager/parent/appointments/fix_appointments.dart';
import 'package:web_school_manager/parent/appointments/pending_appointments.dart';
import 'package:web_school_manager/parent/appointments/take_appointment.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../parent_model/get_student_requested_appointments_model.dart';
import '../../utility/helper_widget.dart';

class Appointment extends StatefulWidget {

   Appointment({Key? key}) : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment>  with TickerProviderStateMixin{

   late TabController tabController;

   final parentStateController = Get.put(ParentStateController());

   List<Data> fixedList=[];
   List<Data> pendingList=[];
   List<Data> cancelledList=[];
   DateTime time = DateTime.now();
   Future getTime() async {
     DateTime? picker = await showDatePicker(
         context: context,
       initialDate: DateTime.now(),
       firstDate: DateTime.now(),
       lastDate: DateTime.now().add(Duration(days: 365)),

     );
     return picker;
   }

   @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     RequestedAppointmentStudentModel requestedAppointmentStudentModel = parentStateController.requestedAppointmentStudentModel.value;
     myLog(label: "My model data", value: requestedAppointmentStudentModel.toJson());
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              getTime().then((value) {
                time = value;
                ParentController().getRequestedAppointment(fromDate: time.toString(),navigate: false);
                myLog(label: "My Selected date", value: time);
                setState(() {
                  
                });
              });
            },
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(left: 30),
              decoration: BoxDecoration(
                boxShadow: myShadow,
                borderRadius: BorderRadius.circular(100),
                color: Colors.blue,
              ),
              child: Text(DateFormat("dd MMM, yyyy").format(time),style: CommonDecoration.listStyle.copyWith(color: Colors.white),),
            ),
          ),
          InkWell(
            onTap: (){
              ParentController().getRelationList().then((relation) => {
                if(relation.statuscode==StringConstants.success){

              ParentController().getEmployeeListForAppointment().then((employeeList){
                if(employeeList.statuscode==StringConstants.success){

                  Get.to(()=>TakeAppointment(employeeListForAppointmentModel: employeeList, relationModel: relation,));

                }else{
                  showMessage(msg: employeeList.message);
                }
              })

                }else{
                  showMessage(msg: relation.message),
                }
              });
             // Get.to(()=>TakeAppointment());
            },
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                boxShadow: myShadow,
                borderRadius: BorderRadius.circular(100),
                color: Colors.blue,
              ),
              child: Icon(Icons.add,color: Colors.white,),
            ),
          ),
        ],
      ),
      body: myPadding(
        child: Column(
          children: [
            CommonHeader(title: "Appointments",),
            smallSpace(),
            TabBar(

              labelColor: Colors.black,
              controller:tabController ,
              tabs: [
                Tab(child: Text("Fixed",style: CommonDecoration.smallLabel.copyWith(fontSize: 12,color: Colors.black),textAlign: TextAlign.center,),),
                Tab(child: Text("Pending",style: CommonDecoration.smallLabel.copyWith(fontSize: 12,color: Colors.black),textAlign: TextAlign.center,),),
                Tab(child: Text("Cancelled",style: CommonDecoration.smallLabel.copyWith(fontSize: 12,color: Colors.black),textAlign: TextAlign.center,),)
              ],
            ),
            GetBuilder(
              init: parentStateController,
              builder: (context) {
                fixedList = [];
                pendingList = [];
                cancelledList = [];
                for(int i=0;i<parentStateController.requestedAppointmentStudentModel.value.data!.length;i++){
                  Data data = parentStateController.requestedAppointmentStudentModel.value.data![i];
                  if(data.isActive==false){
                    cancelledList.add(data);
                  }else if(data.appointmentDate!=null && data.appointmentTime!=null){
                    fixedList.add(data);
                  }else{
                    pendingList.add(data);
                  }

                }
                return Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 10),
                  child: TabBarView(
                      controller: tabController,
                      children: [
                    FixAppointments(list: fixedList,),
                    PendingAppointments(list: pendingList,),
                    CancelledAppointments(list: cancelledList),
                  ]),
                ));
              }
            )
          ],
        )
      ),
    );
  }
}
