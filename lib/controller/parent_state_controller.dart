import 'package:get/get.dart';
import 'package:web_school_manager/parent_model/student_leave_model.dart';

import '../parent_model/get_student_list_r1_model.dart';
import '../parent_model/get_student_requested_appointments_model.dart';

class ParentStateController extends GetxController{

  var studentLeaveModel = StudentAppliedLeaveModel().obs;
  var requestedAppointmentStudentModel = RequestedAppointmentStudentModel().obs;
    var studentData = StudentData();

    void updateStudentData({required StudentData model}){
      studentData = model;
      update();
    }

  void updateStudentLeaveModel({required StudentAppliedLeaveModel model}){
    studentLeaveModel.value = model;
    update();
  }

  void updateRequestedAppointmentStudentModel({required RequestedAppointmentStudentModel model}){
    requestedAppointmentStudentModel.value = model;
    update();
  }

}