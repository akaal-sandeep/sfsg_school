import 'package:flutter/material.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/generated/assets.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';

import '../teacher_model/employee_profile_model.dart';

class TeacherDetails extends StatelessWidget {
  EmployeeProfileModel model;
   TeacherDetails({Key? key,required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            commonProfileBgView(headerTitle: "Profile",profileImage: model.data!.employeeProfilePicturePath!),
            smallSpace(),
            Text(model.data!.displayName!,style: CommonDecoration.subHeaderStyle,),
            smallSpace(),
            myPadding(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Teacher Details",style: CommonDecoration.subHeaderStyle),
                smallSpace(),
                detailsWithIcon(asseturl: Assets.iconsIdentification, text: model.data!.employeeId),

                detailsWithIcon(asseturl: "assets/icons/1-1.png", text: model.data!.dateOfJoining.toString().split("T")[0],),
                detailsWithIcon(asseturl: "assets/icons/vector-1.png", text: model.data!.isClassIncharge.toString()),
                smallSpace(),
                Text("Personal Details",style: CommonDecoration.subHeaderStyle), smallSpace(),
                detailsWithIcon(asseturl: "assets/icons/DOB.png", text: model.data!.dateOfBirth.toString().split("T")[0]),
                detailsWithIcon(asseturl: "assets/icons/gender.png", text: model.data!.gender!),
                //  detailsWithIcon(asseturl: Assets.iconsIdentification, text: model.data!.b),
                detailsWithIcon(asseturl: "assets/icons/phone-number.png", text: model.data!.mobileNo!),
                detailsWithIcon(asseturl: "assets/icons/email.png", text: model.data!.emailId!),
              ],
            )),



          ],
        ),
      ),
    );
  }

}
