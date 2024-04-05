import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/utility/helper_widget.dart';

import '../constants/string_constants.dart';
import '../teacher_model/GetTeacherClassTestListBySubjectModel.dart';
import '../teacher_model/get_employee_leave_apply_list_model.dart';
import '../teacher_model/get_lesson_plan_list.dart';
import '../teacher_model/get_student_remarks_list.dart';
import '../teacher_model/manage_class_test_inv_model.dart';
import '../teacher_model/mange_class_test_main.dart';

import 'package:web_school_manager/teacher_model/get_student_remarks_list.dart'as data;

import 'package:web_school_manager/teacher_model/get_student_remarks_list.dart';

class   TeacherStateController extends GetxController{
    TextEditingController? searchController;
    FocusNode? searchNode;
    var remarksStudentModel = GetStudentRemarksListModel();
    var listBySubjectModel = GetTeacherClassTestListBySubjectModel();
    var manageClassTestMainModel = ManageClassTestMainModel();
    var manageClassTestInvModel = ManageClassTestInvModel();
    var getLessonPlanListModel = GetLessonPlanListModel();
    var getEmployeeLeaveApplyListModel = GetEmployeeLeaveApplyListModel();

    var classMasterId = "".obs;
    var sectionMasterId = "".obs;
    List<data.Data> searchList=[];
    GetStudentRemarksListModel getStudentRemarksListModel=GetStudentRemarksListModel();

    @override
    void onInit() {
        // TODO: implement onInit
        super.onInit();
        searchController = TextEditingController();
        searchNode = FocusNode();
    }

    void updateStudentPercentage({required int i, required double percentage}){
        manageClassTestInvModel.data!.studentList![i]
            .marksPercentage = percentage;
        update();
    }

    void lockClassTest(){
        manageClassTestMainModel.locked = true;
        manageClassTestInvModel.locked = true;
        update();
    }

    void updateGetEmployeeLeaveApplyListModel({required GetEmployeeLeaveApplyListModel model}){
        getEmployeeLeaveApplyListModel = model;
        update();
    }

    void updateGetLessonPlanListModel({required GetLessonPlanListModel model}){
        getLessonPlanListModel = model;
        update();
    }

    void updateController({required GetStudentRemarksListModel getStudentRemarksListModel}){
        remarksStudentModel = getStudentRemarksListModel;
        update();
    }

    void updateManageClassTestMainModel({required ManageClassTestMainModel model}){
        manageClassTestMainModel = model;
        update();
    }

    void updateGetTeacherClassTestListBySubjectModel({required GetTeacherClassTestListBySubjectModel model}){
        listBySubjectModel = model;
        update();
    }

    void updateClassTestInvModel({required ManageClassTestInvModel model}){
        manageClassTestInvModel = model;
        update();
    }

    void updateClassTestInvModelAttendance({required int i,required String attendance}){
        manageClassTestInvModel.data!.studentList![i].attendanceStatus = attendance;
        update();
    }

    void updateClassTestInvModelAttendancePercentage({required int i,required percentage}){
        manageClassTestInvModel.data!.studentList![i].marksPercentage = percentage;
        update();
    }

    void sort(String sort){
        switch(sort){
            case StringConstants.sortByAdmission:
                manageClassTestInvModel.data!.studentList!.sort((a, b) {
                    return a.admissionNumber!
                        .compareTo(b.admissionNumber!);});
                break;
            case StringConstants.sortByAlphabet:
                manageClassTestInvModel.data!.studentList!.sort((a, b) {
                    return a.name
                        .toString()
                        .toLowerCase()
                        .compareTo(b.name.toString().toLowerCase());});
                break;
            case StringConstants.sortByRollNo:
                manageClassTestInvModel.data!.studentList!.sort((a, b) {
                    return a.rollNumber
                        .compareTo(b.rollNumber);});
                myLog(label: "rollNo", value: "check");
                break;
        }
        update();
        }

    }

