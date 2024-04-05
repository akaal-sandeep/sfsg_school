import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/generated/assets.dart';
import 'package:web_school_manager/teacher/get_result_card/screen/result_marks_drop_down_screen.dart';
import 'package:web_school_manager/teacher_model/get_class_list_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

class ResultCardOptionScreen extends StatelessWidget {
  const ResultCardOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
        child: Column(
          children: [
            CommonHeader(title: "Result Card"),
            largeSpace(),
            GestureDetector(
              onTap: ()async{
                GetClassListModel model = await  TeacherController().getClassList(navigate: false);
                Get.to(()=>ResultMarkDropDownScreen(getClassListModel: model,));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  boxShadow: myShadow,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Image.asset(Assets.iconsResultCardResult,height: 40,),
                    SizedBox(width: 10,),
                    Text("Marks",style: TextStyle(fontSize: 20),),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            smallSpace(),
            GestureDetector(
              onTap: ()async{
                // GetPersonalityListModel model = await TeacherController().getPersonalityTraits();
                // Get.to(()=>ResultMarkDropDownScreen(getPersonalityListModel: model,));
                GetClassListModel model = await  TeacherController().getClassList(navigate: false);
                Get.to(()=>ResultMarkDropDownScreen(getClassListModel: model,fromPersonalityTraits: true,));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    boxShadow: myShadow,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Image.asset(Assets.iconsResultPersonal,height: 40,),
                    SizedBox(width: 10,),
                    Text("Personality Traits",style: TextStyle(fontSize: 20),),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            smallSpace(),
            GestureDetector(
              onTap: ()async{
                GetClassListModel model = await  TeacherController().getClassList(navigate: false);
                Get.to(()=>ResultMarkDropDownScreen(getClassListModel: model,fromTeacherRemarks: true,));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    boxShadow: myShadow,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Image.asset(Assets.iconsResultTeacherRemark,height: 40,),
                    SizedBox(width: 10,),
                    Text("Teacher Remarks",style: TextStyle(fontSize: 20),),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
