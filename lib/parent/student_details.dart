import 'package:flutter/material.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/generated/assets.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import '../parent_model/get_student_list_r1_model.dart';
class StudentDetails extends StatelessWidget {
  StudentData data;
   StudentDetails({Key? key,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child: Column(
          children: <Widget>[
            commonProfileBgView(
              headerTitle: "Student Details",
              profileImage: data.profilePictureUrlForMobileApp??""
            ),
            Text(data.name??"",style: CommonDecoration.subHeaderStyle,),
            smallSpace(),
            myPadding(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Student Details",style: CommonDecoration.subHeaderStyle),
                smallSpace(),
                detailsWithIcon(asseturl: Assets.iconsIdentification, text: data.admissionNumber??""),
                detailsWithIcon(asseturl: "assets/icons/DOB.png", text: getTimeFormat(DateTime.parse(data.dateOfAdmission??""))),
                detailsWithIcon(asseturl: "assets/icons/class.png", text: "${data.className} [${data.classSectionName}]"),
                smallSpace(),
                Text("Personal Details",style: CommonDecoration.subHeaderStyle), smallSpace(),
                detailsWithIcon(asseturl: "assets/icons/DOB.png", text:getTimeFormat(DateTime.parse(data.dateOfBirth??"")) ),
                detailsWithIcon(asseturl: "assets/icons/gender.png", text: data.gender??""),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Father Details : ",style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w500
                  ),),
                ),
                SizedBox(
                  height: 5,
                ),
                detailsWithIcon(asseturl: Assets.iconsIdentification, text:  data.fatherName??""),
                detailsWithIcon(asseturl: "assets/icons/phone-number.png", text:  data.fatherMobile??""),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Mother Details : ",style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w500
                  ),),
                ),
                SizedBox(
                  height: 5,
                ),
                detailsWithIcon(asseturl: Assets.iconsIdentification, text:data.motherName??"" ),
                detailsWithIcon(asseturl:"assets/icons/phone-number.png", text: data.motherMobile??""),
              ],
            )),



          ],
        ),
      )
    );
  }
}
