import 'package:flutter/material.dart';
import 'package:web_school_manager/constants/color_constants.dart';
import 'package:web_school_manager/controller/user_controller.dart';
import 'package:web_school_manager/generated/assets.dart';
import 'package:web_school_manager/utility/common_dimensions.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/button.dart';
import 'package:web_school_manager/widget/mytextfield.dart';

class LoginPage extends StatelessWidget {
  String type;
  LoginPage({Key? key,required this.type}) : super(key: key);

  TextEditingController instuCode = TextEditingController(text: 'sfsj');
  TextEditingController mobile = TextEditingController();
  FocusNode instuFocus = FocusNode();
  FocusNode mobileFocus = FocusNode();
  final globleKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: myPadding(
            child: SingleChildScrollView(
              child: Form(
                key: globleKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
      children: [
        smallSpace(),

        Container(
          height: 200,
         child: Hero(
             tag: "logo",
             child: Image.asset(Assets.iconsNewLogo)),
        ),
        smallSpace(),
        Text(
          "Manage Your School Smartly",
          style:CommonDecoration.textWithLogo.copyWith(color: ColorConstants.themeColor),
        ),
        largeSpace(),
        Text(
          "Login",
          style: CommonDecoration.headerStyle,
        ),
        smallSpace(),
        // MyTextField(
        //         hint: "Institute Code",
        //         inputType: TextInputType.name,
        //         textEditingController: instuCode,
        //         focusNode: instuFocus,
        //         borderColor: ColorConstants.themeColor,
        //         borderRadius: 5,
        //         filled: false,
        //         icon: Icon(Icons.account_balance_outlined),
        //         isValidate: true),
        // SizedBox(height: 10,),
        PhoneField(
                hint: "Mobile Number",
                inputType: TextInputType.number,
                textEditingController: mobile,
                focusNode: mobileFocus,
                borderColor: ColorConstants.themeColor,
                borderRadius: 5,
                filled: false,
                isValidate: true),
        largeSpace(),
        InkWell(
            onTap: (){
              if(globleKey.currentState!.validate()){
              UserController().login(instiCode: instuCode.value.text, number: mobile.value.text, userType: type);
              }
            },
            child: MyButton(text: "Login", borderRadius: CommonDimension.buttonRadius, color: ColorConstants.themeColor,))
      ],
    ),
              ),
            )));
  }
}
