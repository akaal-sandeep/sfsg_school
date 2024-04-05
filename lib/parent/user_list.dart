
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/constants/string_constants.dart';
import 'package:web_school_manager/controller/user_controller.dart';
import 'package:web_school_manager/drawer/parent_drawer.dart';
import 'package:web_school_manager/local_storage/local_storage.dart';
import 'package:web_school_manager/parent/student_dashboard.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../parent_model/get_student_list_r1_model.dart';

class UserList extends StatelessWidget {
  GetStudentListR1Model getStudentListR1Model;
   UserList({Key? key,required this.getStudentListR1Model}) : super(key: key);


Future<bool> checkExit()async{
bool myExit = false;
  var exit =await  switchDialog(exit: myExit)
      .then((value){
    return value;
  });
  return exit;
}
  @override
  Widget build(BuildContext context) {
  return WillPopScope(
      onWillPop: () async{
        bool exit = await checkExit();
        myLog(label: "exit", value: exit);
        return Future.value(exit);
        },
      child: Scaffold(
        key: UserController.drawerState,
        drawer: ParentDrawer(),
        body: myPadding(child: Column(
          children: [
            CommonHeader(title: "",showDrawer: true,hideStudentName: true,),
            largeSpace(),
            Expanded(child: ListView.builder(
                itemCount: getStudentListR1Model.data!.length,
                itemBuilder: (context,i){
                  return InkWell(
                    onTap: (){
                      LocalStorage().writeModel(key: StringConstants.parentProfileModel, model: getStudentListR1Model.data![i]);
                      Get.to(()=>StudentDashboard(data:getStudentListR1Model.data![i] ,));
                    },
                    child: listCard(imageUrl: getStudentListR1Model.data![i].profilePictureUrlForMobileApp??"", content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(getStudentListR1Model.data![i].name??"",style: CommonDecoration.subHeaderStyle),
                                  SizedBox(height: 5,),
                                  Text("Class : ${getStudentListR1Model.data![i].className} [${getStudentListR1Model.data![i].classSectionName}]",style: CommonDecoration.bigLabel),
                                  Text("Roll No : ${getStudentListR1Model.data![i].rollNumber}",style: CommonDecoration.bigLabel),
                                ],
                              ),
                    ),
                  );
            }))
          ],
        )),
      ),
    );
  }
}
