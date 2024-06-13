import 'package:get/get.dart';
import 'package:web_school_manager/api/api_client.dart';
import 'package:web_school_manager/coordinator/coordinator_class_list.dart';
import 'package:web_school_manager/parent/homework/student_homework.dart';
import 'package:web_school_manager/parent_model/get_class_home_work_with_read_status.dart';
import 'package:web_school_manager/teacher/syllabus/teacher_syllabus.dart';
import 'package:web_school_manager/teacher_model/get_class_list_model.dart';
import 'package:web_school_manager/teacher_model/get_class_list_model.dart'as get_class_list;
import 'package:web_school_manager/utility/helper_widget.dart';

import '../api/api_url.dart';
import '../constants/string_constants.dart';
import '../coordinator/coordinator_pending_subject_list.dart';
import '../coordinator_model/pending_work_list_model.dart';
import '../teacher_model/teacher_class_list_model.dart';

class CoordinatorController{


 Future getClassList({bool? navigate,required bool uploaded})async{
    showLoader();
    var response =await ApiClient().postWithToken(ApiUrls.GetCoordinatorClassList, {});
    hideLoader();
    TeacherClassesListModel teacherClassesListModel  = TeacherClassesListModel.fromJson(response);
    if(teacherClassesListModel.statuscode == StringConstants.success){
      if(navigate==false){
        return teacherClassesListModel;
      }
      Get.to(()=>CoordinatorClassList(model: teacherClassesListModel,uploaded: uploaded,));
    }else{
      showMessage(msg:teacherClassesListModel.message );
    }
  }

 Future getClassListForBagComponent({bool? navigate})async{
   showLoader();
   var response =await ApiClient().postWithToken(ApiUrls.GetCoordinatorClassList, {});
   hideLoader();
   TeacherClassesListModel teacherClassesListModel  = TeacherClassesListModel.fromJson(response);
   if(teacherClassesListModel.statuscode == StringConstants.success){
     if(navigate==false){
       return teacherClassesListModel;
     }

     GetClassListModel getClassListModel = GetClassListModel(data: []);
     teacherClassesListModel.data!.forEach((element) {
       getClassListModel.data!.add(get_class_list.Data(
         id: element.classMasterId,
         name: element.className
       ));
     });

     Get.to(() => TeacherSyllabus(
       getClassListModel: getClassListModel,
       fromBagComponents: true,
     ));
   }else{
     showMessage(msg:teacherClassesListModel.message );
   }
 }

  getPendingHomeList({required String className})async{
    showLoader();
    var response =await ApiClient().postWithToken(ApiUrls.GetPendingHomeWork, {"not working with that":"True"});
    hideLoader();
    PendingHomeWorkListModel pendingHomeWorkListModel  = PendingHomeWorkListModel.fromJson(response);
    if(pendingHomeWorkListModel.statuscode == StringConstants.success){
      Get.to(()=>CoordinatorPendingSubjectList(model: pendingHomeWorkListModel,),arguments:className );
    }else{
      showMessage(msg:pendingHomeWorkListModel.message );
    }
  }

 Future getHolidayHomeWorkWithReadStatus(
     {String? classMasterId, String? classSectionMasterId,String? className,bool? shouldNavigate}) async {
   showLoader();

   var principalRaw = {
     "ClassMasterId": classMasterId.toString(),
     "ClassSectionMasterId": classSectionMasterId.toString()
   };

   var response = await ApiClient()
       .postWithToken(ApiUrls.GetHolidayHomeWorkWithReadStatus, principalRaw);
   hideLoader();
   GetClassHomeWorkWithReadStatusModel getClassHomeWorkWithReadStatusModel =
   GetClassHomeWorkWithReadStatusModel.fromJson(response);

   getClassHomeWorkWithReadStatusModel.classMasterId = classMasterId;
   getClassHomeWorkWithReadStatusModel.classSectionMasterId = classSectionMasterId;
   getClassHomeWorkWithReadStatusModel.className = className;

   if(shouldNavigate==null){
     Get.to(() => StudentHomework(
       getClassHomeWorkWithReadStatusModel:
       getClassHomeWorkWithReadStatusModel,
       title: 'Holiday Home Work',
     ));
   }else{
     return  getClassHomeWorkWithReadStatusModel;
   }

 }

}