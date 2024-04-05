import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTextField extends StatelessWidget {
  String hint;
  double borderRadius;
  bool filled;
  Color? filledColor;
  Color borderColor;
  String? error;
  bool isValidate;
  FocusNode? focusNode;
  TextEditingController textEditingController;
  TextInputType inputType;
  Icon icon;
  Function? onChange;


  MyTextField(
      {Key? key,
        required this.hint,
        required this.inputType,
        required this.textEditingController,
         this.focusNode,
        required this.borderColor,
        required this.borderRadius,
        this.error,
        required this.filled,
        this.filledColor,
        required this.icon,
        required this.isValidate,
        this.onChange
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: filled,
      child: TextFormField(
        onChanged: (v){
          if(onChange!=null){
            onChange!();
          }
        },
        controller: textEditingController,
        autovalidateMode: isValidate?AutovalidateMode.onUserInteraction:AutovalidateMode.disabled,
        keyboardType: inputType,
        validator: (v) {
          if (v!.isEmpty && isValidate) {
            return "The $hint is required";
          }
          return null;
        },

        decoration: InputDecoration(
          labelText: hint,
            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          filled: filled,
          fillColor: filled?filledColor:Colors.red,
            prefixIcon: icon,
            border:OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: borderColor)
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: Colors.grey)
              //   borderSide: BorderSide(color: borderColor)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: borderColor)
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              //borderSide: BorderSide(color: borderColor)
            )
        ),
      ),
    );
  }
}

class MyTextFieldOverLay extends StatelessWidget {
  String hint;
  double borderRadius;
  bool filled;
  Color? filledColor;
  Color borderColor;
  String? error;
  bool isValidate;
  FocusNode? focusNode;
  TextEditingController textEditingController;
  TextInputType inputType;
  Icon icon;


  MyTextFieldOverLay(
      {Key? key,
        required this.hint,
        required this.inputType,
        required this.textEditingController,
        this.focusNode,
        required this.borderColor,
        required this.borderRadius,
        this.error,
        required this.filled,
        this.filledColor,
        required this.icon,
        required this.isValidate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: filled,
      child: TextFormField(
        focusNode: focusNode,
        controller: textEditingController,
        autovalidateMode: isValidate?AutovalidateMode.onUserInteraction:AutovalidateMode.disabled,
        keyboardType: inputType,
        validator: (v) {
          if (v!.isEmpty && isValidate) {
            return "The $hint is required";
          }
          return null;
        },

        decoration: InputDecoration(
            labelText: hint,
            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            filled: filled,
            fillColor: filled?filledColor:Colors.red,
            prefixIcon: icon,
            border:OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: borderColor)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: Colors.grey)
              //   borderSide: BorderSide(color: borderColor)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: borderColor)
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              //borderSide: BorderSide(color: borderColor)
            )
        ),
      ),
    );
  }
}

class MyTextFieldDrop extends StatelessWidget {
  String hint;
  double borderRadius;
  bool filled;
  Color? filledColor;
  Color borderColor;
  String? error;
  bool isValidate;
  FocusNode? focusNode;
  TextEditingController textEditingController;
  TextInputType inputType;
  Icon icon;


  MyTextFieldDrop(
      {Key? key,
        required this.hint,
        required this.inputType,
        required this.textEditingController,
         this.focusNode,
        required this.borderColor,
        required this.borderRadius,
        this.error,
        required this.filled,
        this.filledColor,
        required this.icon,
        required this.isValidate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: TextFormField(
        controller: textEditingController,
        autovalidateMode: isValidate?AutovalidateMode.onUserInteraction:AutovalidateMode.disabled,
        keyboardType: inputType,
        validator: (v) {
          if (v!.isEmpty && isValidate) {
            return "The $hint is required";
          }
          return null;
        },

        decoration: InputDecoration(
            labelText: hint,
            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            filled: filled,
            fillColor: filled?filledColor:Colors.red,
            prefixIcon: icon,
            suffixIcon: Icon(Icons.arrow_drop_down),
            border:OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: borderColor)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: Colors.grey)
              //   borderSide: BorderSide(color: borderColor)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: borderColor)
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              //borderSide: BorderSide(color: borderColor)
            )
        ),
      ),
    );
  }
}

class MyTextFieldWithWidget extends StatelessWidget {
  String hint;
  double borderRadius;
  bool filled;
  Color? filledColor;
  Color borderColor;
  String? error;
  bool isValidate;
  FocusNode focusNode;
  TextEditingController textEditingController;
  TextInputType inputType;
  Widget prefixWidget;


  MyTextFieldWithWidget(
      {Key? key,
        required this.hint,
        required this.inputType,
        required this.textEditingController,
        required this.focusNode,
        required this.borderColor,
        required this.borderRadius,
        this.error,
        required this.filled,
        this.filledColor,
        required this.prefixWidget,
        required this.isValidate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      autovalidateMode: isValidate?AutovalidateMode.onUserInteraction:AutovalidateMode.disabled,
      keyboardType: inputType,
      validator: (v) {
        if (v!.isEmpty && isValidate) {
          return "The $hint is required";
        }
        return null;
      },

      decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          filled: filled,
          fillColor: filled?filledColor:Colors.red,
          prefixIcon: prefixWidget,
          border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: Colors.grey)
            //   borderSide: BorderSide(color: borderColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor)
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            //borderSide: BorderSide(color: borderColor)
          )
      ),
    );
  }
}


class EmailField extends StatelessWidget {
  String hint;
  double borderRadius;
  bool filled;
  Color? filledColor;
  Color borderColor;
  String? error;
  bool isValidate;
  FocusNode focusNode;
  TextEditingController textEditingController;
  TextInputType inputType;


  EmailField(
      {Key? key,
        required this.hint,
        required this.inputType,
        required this.textEditingController,
        required this.focusNode,
        required this.borderColor,
        required this.borderRadius,
        this.error,
        required this.filled,
        this.filledColor,

        required this.isValidate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: TextFormField(
        controller: textEditingController,
        autovalidateMode: isValidate?AutovalidateMode.onUserInteraction:AutovalidateMode.disabled,
        keyboardType: inputType,
        validator: (v) {
          if (!GetUtils.isEmail(v!)&&isValidate ) {
            return "Please enter valid email";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hint,
            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          filled: filled,
          fillColor: filled?filledColor:Colors.red,
          prefixIcon: Icon(Icons.email_outlined),
          border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
           borderSide: BorderSide(color: Colors.grey)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor)
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              //borderSide: BorderSide(color: borderColor)
          ),
        ),
      ),
    );
  }
}


class PasswordField extends StatefulWidget {
  String hint;
  double borderRadius;
  bool filled;
  Color? filledColor;
  Color borderColor;
  String? error;
  bool isValidate;
  FocusNode focusNode;
  TextEditingController textEditingController;
  TextInputType inputType;
  bool obscure;


  PasswordField(
      {Key? key,
        required this.hint,
        required this.inputType,
        required this.textEditingController,
        required this.focusNode,
        required this.borderColor,
        required this.borderRadius,
        this.error,
        required this.filled,
        this.filledColor,
        required this.obscure,
        required this.isValidate})
      : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {

  bool hideText = true;

  changeTextShowStatus(){
    hideText = !hideText;
    setState((){});
  }



  @override
  Widget build(BuildContext context) {
    return Container(

      child: TextFormField(
        controller: widget.textEditingController,
        autovalidateMode: widget.isValidate?AutovalidateMode.onUserInteraction:AutovalidateMode.disabled,
        keyboardType: widget.inputType,
        obscureText: hideText,
        validator: (v) {
          if (v!.length<8) {
            return "Your password must have 8 character";
          }
          return null;
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          filled: widget.filled,
          fillColor: widget.filled?widget.filledColor:Colors.red,
          prefixIcon: Icon(Icons.lock),
          suffixIcon:InkWell(
              onTap: (){
                changeTextShowStatus();
              },
              child: hideText?Icon(Icons.remove_red_eye):Icon(Icons.remove_red_eye)) ,
          border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(color: widget.borderColor)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            //   borderSide: BorderSide(color: borderColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(color: widget.borderColor)
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            //borderSide: BorderSide(color: borderColor)
          ),
        ),
      ),
    );
  }
}


class PhoneField extends StatelessWidget {
  String hint;
  double borderRadius;
  bool filled;
  Color? filledColor;
  Color borderColor;
  String? error;
  bool isValidate;
  FocusNode focusNode;
  TextEditingController textEditingController;
  TextInputType inputType;


  PhoneField(
      {Key? key,
        required this.hint,
        required this.inputType,
        required this.textEditingController,
        required this.focusNode,
        required this.borderColor,
        required this.borderRadius,
        this.error,
        required this.filled,
        this.filledColor,

        required this.isValidate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: TextFormField(
        controller: textEditingController,
        autovalidateMode: isValidate?AutovalidateMode.onUserInteraction:AutovalidateMode.disabled,
        keyboardType: inputType,
        validator: (v) {
          if (!GetUtils.isNumericOnly(v!)) {
            return "Please enter valid number";
          }

          if(v.length<10 || v.length>10){
            return "Please enter 10 digit number";
          }

          return null;
        },

        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          filled: filled,
          fillColor: filled?filledColor:Colors.red,
         prefixIcon: Icon(Icons.phone),

          border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            //  borderSide: BorderSide(color: borderColor)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: Colors.grey)
              // borderSide: BorderSide(color: borderColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: borderColor)
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            //borderSide: BorderSide(color: borderColor)
          ),
        ),
      ),
    );
  }
}

class MyTextFieldMulti extends StatelessWidget {
  String hint;
  double borderRadius;
  bool filled;
  Color? filledColor;
  Color borderColor;
  String? error;
  bool isValidate;
  FocusNode focusNode;
  TextEditingController textEditingController;
  TextInputType inputType;
  Icon icon;


  MyTextFieldMulti(
      {Key? key,
        required this.hint,
        required this.inputType,
        required this.textEditingController,
        required this.focusNode,
        required this.borderColor,
        required this.borderRadius,
        this.error,
        required this.filled,
        this.filledColor,
        required this.icon,
        required this.isValidate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: filled,
      child: TextFormField(
        maxLines: 5,
        minLines: 1,
        controller: textEditingController,
        autovalidateMode: isValidate?AutovalidateMode.onUserInteraction:AutovalidateMode.disabled,
        keyboardType: inputType,
        validator: (v) {
          if (v!.isEmpty && isValidate) {
            return "The $hint is required";
          }
          return null;
        },

        decoration: InputDecoration(
            labelText: hint,
            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            filled: filled,
            fillColor: filled?filledColor:Colors.red,
            prefixIcon: icon,
            border:OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: borderColor)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: Colors.grey)
              //   borderSide: BorderSide(color: borderColor)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: borderColor)
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              //borderSide: BorderSide(color: borderColor)
            )
        ),
      ),
    );
  }
}