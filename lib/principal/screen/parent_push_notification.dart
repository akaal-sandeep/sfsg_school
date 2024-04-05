import 'package:flutter/material.dart';
import 'package:web_school_manager/constants/color_constants.dart';
import 'package:web_school_manager/controller/principal_controller.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/button.dart';
import 'package:web_school_manager/widget/header.dart';
import 'package:web_school_manager/widget/mytextfield.dart';

import '../../principal_model/getClassNotificationListModel.dart';

class ParentPushNotification extends StatefulWidget {
  GetClassSectionListForPushNotificationModel
      getClassSectionListForPushNotificationModel;

  ParentPushNotification(
      {Key? key, required this.getClassSectionListForPushNotificationModel})
      : super(key: key);

  @override
  State<ParentPushNotification> createState() => _ParentPushNotificationState();
}

class _ParentPushNotificationState extends State<ParentPushNotification> {
  TextEditingController subjectController = TextEditingController();

  TextEditingController contentController = TextEditingController();

  TextEditingController remarkController = TextEditingController();

  FocusNode subjectFocus = FocusNode();

  FocusNode contentFocus = FocusNode();

  FocusNode remarkFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  bool allClass = false;


  selectClass(){
    if(allClass){
      for(int i=0;i<widget.getClassSectionListForPushNotificationModel.data!.length;i++){
        widget.getClassSectionListForPushNotificationModel.data![i].isSelected=true;
      }
    }else{
      for(int i=0;i<widget.getClassSectionListForPushNotificationModel.data!.length;i++){
        widget.getClassSectionListForPushNotificationModel.data![i].isSelected=false;
      }
    }
    setState(() {

    });
  }

  checkCheck(){
    bool findFalse =false;

    for(int i=0;i<widget.getClassSectionListForPushNotificationModel.data!.length;i++){


      if(widget.getClassSectionListForPushNotificationModel.data![i].isSelected==false && allClass){
        allClass = false;
        findFalse = true;
      }

      if(findFalse == false){
        allClass = true;
      }

    }
  }

  @override
  Widget build(BuildContext context) {
   checkCheck();




    return Scaffold(
      body: SafeArea(
          child: myPadding(
              child: Form(
        key: _formKey,
        child: Column(
          children: [
            CommonHeader(title: "Parent Push Notification"),
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
            //smallSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("All Classes"),
                Checkbox(value: allClass, onChanged: (value){
                  allClass = value!;
                  selectClass();
                })
              ],
            ),
            smallSpace(),
            _allClassList(),
            smallSpace(),
            InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    PrincipalController().pushParentNotification(
                        subject: subjectController.value.text,
                        content: contentController.value.text,
                        remark: remarkController.value.text,
                        classList: widget
                            .getClassSectionListForPushNotificationModel.data!);
                  }
                },
                child: MyButton(
                    text: "Push Notification",
                    borderRadius: 10,
                    color: ColorConstants.themeColor)),
            smallSpace(),
          ],
        ),
      ))),
    );
  }

  _allClassList(){
    return Expanded(
        child: GridView.builder(
            itemCount: widget
                .getClassSectionListForPushNotificationModel
                .data!
                .length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, i) => InkWell(
              onTap: () {
                widget.getClassSectionListForPushNotificationModel
                    .data![i].isSelected =
                !widget
                    .getClassSectionListForPushNotificationModel
                    .data![i]
                    .isSelected!;
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    boxShadow: myShadow,
                    color:
                    widget.getClassSectionListForPushNotificationModel
                        .data![i].isSelected ==
                        true
                        ? ColorConstants.themeColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  widget.getClassSectionListForPushNotificationModel
                      .data![i].classSectionName ??
                      "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:
                    widget.getClassSectionListForPushNotificationModel
                        .data![i].isSelected ==
                        true
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            )));
  }

}
