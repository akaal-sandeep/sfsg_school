import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_school_manager/constants/string_constants.dart';
import 'package:web_school_manager/controller/parent_state_controller.dart';
import 'package:web_school_manager/model/login_scuccess_model.dart';
import 'package:web_school_manager/parent_model/parent_module_list_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import '../parent_model/get_student_list_r1_model.dart';
import '../principal_model/principal_module_list_model.dart';
import '../principal_model/principal_profile_model.dart';
import '../teacher_model/employee_profile_model.dart';
import '../teacher_model/teacher_module_model.dart';

class LocalStorage {
  final storage = GetStorage();

  read({required String key}) {
    var result = storage.read(key);
    return result;
  }

  write({required String key, var data}) {
    myLog(label: "write " + key, value: data.toString());
    storage.write(key, data.toString());
  }

  writeModel({required String key, required var model}) {
    if (key == StringConstants.parentProfileModel) {
      final controller = Get.put(ParentStateController());
      controller.updateStudentData(model: model);
    }
    storage.write(key, model.toJson());
  }

  readModel({required String key}) {
    var data = storage.read(key);
    LoginSuccessModel model = LoginSuccessModel.fromJson(data);
    myLog(label: "read $key", value: model.toJson());
    return model;
  }

  readTeacherModuleModel({required String key}) {
    var data = storage.read(key);
    TeacherModuleListModel model = TeacherModuleListModel.fromJson(data);
    return model;
  }

  readTeacherProfileModel({required String key}) {
    var data = storage.read(StringConstants.teacherProfileModel);
    EmployeeProfileModel model = EmployeeProfileModel.fromJson(data);
    return model;
  }

  readParentModuleList({required String key}) {
    var data = storage.read(key);
    ParentModuleListModel parentModuleListModel =
    ParentModuleListModel.fromJson(data);
    return parentModuleListModel;
  }

  readStudentModel({required String key}) {
    var data = storage.read(StringConstants.parentProfileModel);
    StudentData studentData = StudentData();
    if (data != null) {
      var value = StudentData.fromJson(data);
      studentData = value;
    }
    return studentData;
  }

  readPrincipalModuleList() {
    var data = storage.read(StringConstants.principalModuleList);
    PrincipalModuleListModel principalModuleListModel =
    PrincipalModuleListModel();
    if (data != null) {
      var value = PrincipalModuleListModel.fromJson(data);
      principalModuleListModel = value;
    }
    return principalModuleListModel;
  }

  writePrincipalProfile({required var model}) {
    storage.write(StringConstants.principalProfileModel, model.toJson());
  }

  readPrincipalProfileModel() {
    var json = storage.read(StringConstants.principalProfileModel);
    PrincipalProfileModel principalProfileModel =
    PrincipalProfileModel.fromJson(json);
    return principalProfileModel;
  }

  writeStudentList({required var model}) {
    storage.write(StringConstants.studentList, model.toJson());
  }

  readStudentList() {
    var json = storage.read(StringConstants.studentList);
    GetStudentListR1Model getStudentListR1Model = GetStudentListR1Model
        .fromJson(json);
    return getStudentListR1Model;
  }

  bool? isBioMetricEnable() {
    return storage.read(StringConstants.bioMetric);
  }

  saveBioMetricStatus(bool status) {
     storage.write(StringConstants.bioMetric, status);
  }

  eraseData() {
    String userType = storage.read(StringConstants.userType);
    myLog(label: "loginType", value: userType);
    if (userType == StringConstants.teacherType) {
      storage.write(StringConstants.teacherAccessToken, null);
      myLog(label: "Teacher logout", value: "done");
    } else if (userType == StringConstants.parentType) {
      storage.write(StringConstants.parentAccessToken, null);
      myLog(label: "Parent logout", value: "done");
    } else if (userType == StringConstants.coordinatorType) {
      storage.write(StringConstants.coordinatorAccessToken, null);
      myLog(label: "coodi logout", value: "done");
    } else if (userType == StringConstants.principleType) {
      storage.write(StringConstants.principalAccessToken, null);
      myLog(label: "Principal logout", value: "done");
    } else {
      storage.write(StringConstants.receptionAccessToken, null);
      myLog(label: "reception logout", value: "done");
    }
  }
}
