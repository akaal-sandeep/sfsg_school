import 'dart:convert';

import 'package:web_school_manager/api/api_client.dart';
import 'package:web_school_manager/api/api_url.dart';
import 'package:web_school_manager/constants/string_constants.dart';
import 'package:web_school_manager/principal_model/student_list_by_class_section_model.dart';
import 'package:web_school_manager/reception_model/gate_pass_detail_model.dart';
import 'package:web_school_manager/reception_model/get_pass_list_model.dart';
import 'package:web_school_manager/reception_model/inward_gate_pass_model.dart';
import 'package:web_school_manager/reception_model/out_ward_get_pass_model.dart';
import 'package:web_school_manager/reception_model/verification_id_proof_list_model.dart';
import 'package:web_school_manager/teacher_model/get_class_list_model.dart';
import 'package:web_school_manager/teacher_model/get_class_section_list_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';

class ReceptionController {

  Future saveInstituteOutwardGetPass(
      {required OutWardGetPassModel outWardGetPassModel}) async {
    showLoader();
    myLog(label: "data", value: outWardGetPassModel.toJson());
    var response = await ApiClient().postWithTokenAndEncoding(
        ApiUrls.SaveInstituteOutwardGatepass, jsonEncode(outWardGetPassModel.toJson()));
    hideLoader();
    if(response['statuscode']==StringConstants.success){
      hideLoader();
    }else{
      showMessage(msg: response['message']);
    }
  }

  Future saveInstituteInwardGetPass(
      {required InwardGatePassModel inwardGatePassModel}) async {
    showLoader();
    myLog(label: "Save Inward", value: inwardGatePassModel.toJson());
    var response = await ApiClient().postWithTokenAndEncoding(
        ApiUrls.SaveInstituteInwardGatepass, jsonEncode(inwardGatePassModel.toJson()));
    hideLoader();
    if(response['statuscode']==StringConstants.success){
      hideLoader();
    }else{
      showMessage(msg: response['message']);
    }
  }

  Future<GetClassListModel> getClassList() async {
    var response = await ApiClient().postWithToken(ApiUrls.GetClassList, {});
    GetClassListModel getClassListModel = GetClassListModel.fromJson(response);
    return getClassListModel;
  }

  Future<VerificationIdProofListModel> getVisitorIdProof()async{
    var response = await ApiClient().postWithToken(ApiUrls.GetVisitorIdentityProofList, {});
    VerificationIdProofListModel verificationIdProofListModel = VerificationIdProofListModel.fromJson(response);
    return verificationIdProofListModel;
  }

  Future<GetClassSectionListModel> getClassSectionList({
    required String id,
  }) async {
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetClassSectionList, {"Id": id});
    GetClassSectionListModel getClassSectionListModel =
        GetClassSectionListModel.fromJson(response);
    return getClassSectionListModel;
  }

  Future<GetPassListModel> getOutwardGatePassList() async {
    showLoader();
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetInstituteOutwardGatepassList, {
      "RecordCount": "10",
      "GatepassNumber": "0",
      "StudentName": "",
      "EmployeeName": "",
      "VisitorName": "",
      "VisitorMobileNumber": "",
      "GatepassDateFrom": "null",
      "GatepassDateTo": "null",
      "GatepassFor": "A"
    });
    hideLoader();
    return GetPassListModel.fromJson(response);
  }

  Future<GetPassListModel> getInwardGatePassList() async {
    showLoader();
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetInstituteInwardGatepassList, {
      "RecordCount": "10",
      "GatepassNumber": "0",
      "StudentName": "",
      "EmployeeName": "",
      "VisitorName": "",
      "VisitorMobileNumber": "",
      "GatepassDateFrom": "null",
      "GatepassDateTo": "null"
    });
    hideLoader();
    return GetPassListModel.fromJson(response);
  }

  Future<GatePassDetailModel> getGatePassDetails({required String id}) async {
    showLoader();
    var response = await ApiClient()
        .postWithToken(ApiUrls.GetInstituteInwardGatepassDetailByGatepassNumber, {
      "GatepassNumber": id
    });
    hideLoader();
    return GatePassDetailModel.fromJson(response);
  }


  Future<StudentListByClassSectionModel> getStudentListByClassSection({
    required String classMasterId,
    required String classMasterSectionId,
  }) async {
    showLoader();
    var raw = {
      "AdmissionNumber": "",
      "ClassMasterId": "$classMasterId",
      "ClassSectionMasterId": "$classMasterSectionId",
      "EmployeeMasterId": "1",
      "FromDate": "",
      "Id": "",
      "SectionMasterId": "",
      "SubjectMasterId": "",
      "ToDate": ""
    };

    var response = await ApiClient()
        .postWithToken(ApiUrls.getStudentListByClassSection, raw);

    StudentListByClassSectionModel studentListByClassSectionModel =
        StudentListByClassSectionModel.fromJson(response);
hideLoader();
    if (studentListByClassSectionModel.statuscode == StringConstants.success) {
      return studentListByClassSectionModel;
    } else {
     return StudentListByClassSectionModel();
    }
  }
}
