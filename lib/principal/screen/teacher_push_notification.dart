import 'package:flutter/material.dart';
import 'package:web_school_manager/constants/color_constants.dart';
import 'package:web_school_manager/controller/principal_controller.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/button.dart';
import 'package:web_school_manager/widget/header.dart';
import 'package:web_school_manager/widget/mytextfield.dart';

class TeacherPushNotification extends StatelessWidget {
  TeacherPushNotification({Key? key}) : super(key: key);
  TextEditingController subjectController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  FocusNode subjectFocus = FocusNode();
  FocusNode contentFocus = FocusNode();
  FocusNode remarkFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: myPadding(
              child: Form(
                key: _formKey,
                child: Column(
        children: [
          CommonHeader(title: "Teacher Push Notification"),
          largeSpace(),
          MyTextFieldWithWidget(
                hint: "Notification Subject",
                inputType: TextInputType.name,
                textEditingController: subjectController,
                focusNode: subjectFocus,
                borderColor: ColorConstants.themeColor,
                borderRadius: 10,
                filled: false,
                prefixWidget: Icon(Icons.subject),
                isValidate: true),
          smallSpace(),
          MyTextFieldWithWidget(
                hint: "Notification Content",
                inputType: TextInputType.name,
                textEditingController: contentController,
                focusNode: contentFocus,
                borderColor: ColorConstants.themeColor,
                borderRadius: 10,
                filled: false,
                prefixWidget: Icon(Icons.edit),
                isValidate: true),
          smallSpace(),
          MyTextFieldWithWidget(
                hint: "Notification Remark",
                inputType: TextInputType.name,
                textEditingController: remarkController,
                focusNode: remarkFocus,
                borderColor: ColorConstants.themeColor,
                borderRadius: 10,
                filled: false,
                prefixWidget: Icon(Icons.edit),
                isValidate: false),
          largeSpace(),
          InkWell(
              onTap: (){
                if(_formKey.currentState!.validate()){
                  PrincipalController().pushTeacherNotification(subject: subjectController.value.text, content: contentController.value.text,remark: remarkController.value.text);
                }
              },
              child: MyButton(text: "Push Notification", borderRadius: 10, color: ColorConstants.themeColor))
        ],
      ),
              ))),
    );
  }
}
