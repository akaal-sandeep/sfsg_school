import 'package:flutter/material.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/principal_model/principal_profile_model.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';

class PrincipalProfile extends StatefulWidget {
  PrincipalProfileModel principalProfileModel;

  PrincipalProfile({Key? key, required this.principalProfileModel})
      : super(key: key);

  @override
  State<PrincipalProfile> createState() => _PrincipalProfileState();
}

class _PrincipalProfileState extends State<PrincipalProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            commonProfileBgView(
              profileImage:
                  "${widget.principalProfileModel.data!.employeeProfilePicturePath}",
              headerTitle: "Principal",
            ),
            Text(
              "${widget.principalProfileModel.data!.displayName ?? ""}",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            Text(
              "Principal",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            largeSpace(),
            myPadding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Text("Principal Info",style: CommonDecoration.subHeaderStyle),
                  smallSpace(),
                  detailsWithIcon(
                      asseturl: "assets/icons/employee-id.png",
                      text:
                      "${widget.principalProfileModel.data!.employeeId ?? ""}"),
                  detailsWithIcon(
                      asseturl: "assets/icons/date-icon.png",
                      text: getTimeFormat(DateTime.parse(
                          "${widget.principalProfileModel.data!.dateOfJoining ?? ""}"))),
                  detailsWithIcon(
                      asseturl: "assets/icons/attendance-icon.png",
                      text: "Attendence Status : " +
                          "${widget.principalProfileModel.data!.attendanceStatus!.isEmpty ? "Pending" : "${widget.principalProfileModel.data!.attendanceStatus}"}"),
                  smallSpace(),
                  Text(
                      "Personal Info",style: CommonDecoration.subHeaderStyle),
                  smallSpace(),
                  detailsWithIcon(
                      asseturl: "assets/icons/email.png",
                      text:
                      "${widget.principalProfileModel.data!.emailId ?? ""}"),
                  detailsWithIcon(
                      asseturl: "assets/icons/phone-number.png",
                      text:
                      "${widget.principalProfileModel.data!.mobileNo ?? ""}"),
                  detailsWithIcon(
                      asseturl: "assets/icons/date-icon.png",
                      text: getTimeFormat(DateTime.parse(
                          "${widget.principalProfileModel.data!.dateOfBirth ?? ""}"))),
                  detailsWithIcon(
                      asseturl: "assets/icons/gender.png",
                      text:
                      "${widget.principalProfileModel.data!.gender ?? ""}"),
                ],
              ),
            ),



            /*      CommonHeader(title: "Principal",
            ),
            smallSpace(),
           _principalImage(),
            _tileWidPrincipal(),
            _tileWidPersonal(),*/
          ],
        ),
      ),
    );
  }
}
