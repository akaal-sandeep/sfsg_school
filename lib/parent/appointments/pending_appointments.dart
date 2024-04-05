import 'package:flutter/material.dart';
import 'package:web_school_manager/common-functions.dart';

import '../../utility/custom_decoration.dart';
import '../../utility/helper_widget.dart';
import '../../parent_model/get_student_requested_appointments_model.dart';
class PendingAppointments extends StatelessWidget {
  List<Data> list;
   PendingAppointments({Key? key,required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  list.isEmpty?
    myImage(isNetwork: false, source: "assets/icons/empty.png")
        :
    ListView.builder(
        itemCount: list.length,
        itemBuilder: (context,i){
          return listCard(
            backgroundColor: Colors.yellow.withOpacity(0.3),
              imageUrl: list[i].employeePhotoUrlForMobileApp??"", content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(list[i].employeeName??"",style: CommonDecoration.subHeaderStyle),
              Text(list[i].appointmentWith??"",style: CommonDecoration.bigLabel),
              Text("Visited by: ${list[i].relationName??""}",style: CommonDecoration.bigLabel),
              Text(getTimeFormat(DateTime.parse(list[i].appointmentDate??"")),style: CommonDecoration.bigLabel),
            ],
          ));
        });
  }
}
