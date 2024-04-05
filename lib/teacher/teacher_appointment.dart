import 'package:flutter/material.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/constants/string_constants.dart';
import 'package:web_school_manager/controller/principal_controller.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/local_storage/local_storage.dart';
import 'package:web_school_manager/principal_model/fixed_appointment_list_principal_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../teacher_model/get_fixed_appointments_list_for_teacher.dart';
import '../utility/custom_decoration.dart';

class TeacherAppointment extends StatefulWidget {
  GetFixedAppointmentsListforTeacher getFixedAppointmentsListforTeacher;

  TeacherAppointment(
      {Key? key, required this.getFixedAppointmentsListforTeacher})
      : super(key: key);

  @override
  State<TeacherAppointment> createState() => _TeacherAppointmentState();
}

class _TeacherAppointmentState extends State<TeacherAppointment> {
  var type;
  DateTime time = DateTime.now();
  FixedAppointmentListModel fixedAppointmentListModel =
      FixedAppointmentListModel();

  Future getTime() async {
    DateTime? picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 365)),
        lastDate: DateTime.now());
    return picker;
  }

  @override
  Widget build(BuildContext context) {
    type = LocalStorage().read(key: StringConstants.userType);

    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          getTime().then((value) {
            time = value;
            type == StringConstants.principleType
                ? PrincipalController()
                    .getFixedAppointmentListForPrincipal(
                        fromdate: getTimeFormat(time), navigate: false)
                    .then((value) {
                    widget.getFixedAppointmentsListforTeacher = value;
                    setState(() {});
                  })
                : TeacherController()
                    .getFixedAppointmentsListForTeacher(
                        navigate: false, fromDate: getTimeFormat(time))
                    .then((value) {
                    widget.getFixedAppointmentsListforTeacher = value;
                    setState(() {});
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
          child: Text(
           getTimeFormat(time),
            style: CommonDecoration.listStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
      body: myPadding(
          child: Column(
        children: [
          CommonHeader(
            title: "Appointments",
            hideStudentName: true,
          ),
          smallSpace(),
          Expanded(
              child: widget.getFixedAppointmentsListforTeacher.data!.isEmpty
                  ? myImage(isNetwork: false, source: "assets/icons/empty.png")
                  : ListView.builder(
                      itemCount: widget
                          .getFixedAppointmentsListforTeacher.data!.length,
                      itemBuilder: (context, i) {
                        return listCard(
                            showArrow: false,
                            imageUrl: widget.getFixedAppointmentsListforTeacher
                                    .data![i].studentPhotoUrlForMobileApp ??
                                "",
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.getFixedAppointmentsListforTeacher
                                          .data![i].studentName ??
                                      "",
                                  style: CommonDecoration.subHeaderStyle,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    "${widget.getFixedAppointmentsListforTeacher.data![i].className} [${widget.getFixedAppointmentsListforTeacher.data![i].classSectionName}]",
                                    style: CommonDecoration.smallLabel),
                                Text(
                                    "Visited by : ${widget.getFixedAppointmentsListforTeacher.data![i].relationName}",
                                    style: CommonDecoration.smallLabel),
                                Text(
                                    "${getTimeFormat(DateTime.parse(widget.getFixedAppointmentsListforTeacher.data![i].appointmentDate ?? ""))} ${widget.getFixedAppointmentsListforTeacher.data![i].appointmentTimeString}",
                                    style: CommonDecoration.smallLabel),
                              ],
                            ));
                      }))
        ],
      )),
    );
  }
}
