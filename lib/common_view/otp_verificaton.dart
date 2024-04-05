import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:web_school_manager/generated/assets.dart';
import 'package:web_school_manager/parent/back_button.dart';

import '../constants/color_constants.dart';
import '../controller/user_controller.dart';
import '../utility/common_dimensions.dart';
import '../utility/custom_decoration.dart';
import '../utility/helper_widget.dart';
import '../widget/button.dart';

class OtpVerificationScreen extends StatefulWidget {
  String phoneNumber;
  String instiCode;
  String userType;

  OtpVerificationScreen(
      {Key? key,
      required this.phoneNumber,
      required this.userType,
      required this.instiCode})
      : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  final otpTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            //   child: CommonHeader(
            //     title: "OTP Verification",
            //     hideStudentName: true,
            //     showLogout: true,
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CommonDimension.horizontalPadding + 10,vertical: 10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child:MyBackButton(),
                  ),
                  Text(
                      "OTP Verification",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600,height: 1,color: Colors.black
                      )
                  ),
                ],
              ),
            ),
            largeSpace(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CommonDimension.horizontalPadding + 20),
              child: Column(
                children: [
                  _otpImage(),
                  largeSpace(),
                  _otpFields(),
                  _otpSentText(),
                  largeSpace(),
                  _didntReceiveRow(),
                  largeSpace(),
                  InkWell(
                      onTap: () {
                        UserController().otpVerification(
                            number: widget.phoneNumber,
                            otpValue: otpTextController.value.text,
                            userType: widget.userType,
                            instiCode: widget.instiCode);
                      },
                      child: MyButton(
                          text: "Verify",
                          borderRadius: CommonDimension.buttonRadius,
                          color: ColorConstants.themeColor))
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _otpImage() {
    return SizedBox(
      height: 230,
      width: 200,
      child: myImage(isNetwork: false, source: Assets.iconsOtp,boxFit: BoxFit.contain),
    );
  }

  Widget _otpFields() {
    return PinCodeTextField(
      autoFocus: true,
      pinTheme: PinTheme(
        inactiveColor: Colors.grey.withOpacity(0.3),
        selectedColor: ColorConstants.themeColor,
        activeColor: Colors.grey.withOpacity(0.3),
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
        inactiveFillColor: Colors.grey,
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.grey,
      ),
      controller: otpTextController,
      keyboardType: TextInputType.number,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      animationDuration: Duration(milliseconds: 300),
      // errorAnimationController: errorController, // Pass it here
      onChanged: (value) {
        setState(() {});
      },
      appContext: context,
    );
  }

  Widget _otpSentText() {
    return Align(
        alignment: Alignment.centerRight,
        child: Text(
          "OTP sent on ${widget.phoneNumber}",
          style: CommonDecoration.smallLabel.copyWith(color: Colors.grey),
        ));
  }

  Widget _didntReceiveRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Didn't receive code?",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Text(
            "Request again",
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        )
      ],
    );
  }
}
