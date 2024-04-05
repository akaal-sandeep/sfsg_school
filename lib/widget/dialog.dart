import 'package:flutter/material.dart';
import 'package:web_school_manager/constants/color_constants.dart';

import '../utility/common_dimensions.dart';
import '../utility/custom_decoration.dart';
import '../utility/helper_widget.dart';
import 'button.dart';

class AlertDialogCustom extends StatefulWidget {
  String? title;
  String? description;
  String? subTitle;
  bool? showNegative = false;
  Function? positiveCall;
  Function? negativeCall;
  IconData? icon;
  String? exitText;
  String? image;
  String? switchText;
  Color? iconColor;

  AlertDialogCustom(
      {Key? key,
      this.description,
      this.negativeCall,
      this.positiveCall,
      this.showNegative,
      this.title,
      this.icon,
      this.iconColor,
      this.subTitle,
      this.image,
      this.switchText,
      this.exitText})
      : super(key: key);

  @override
  State<AlertDialogCustom> createState() => _AlertDialogCustomState();
}

class _AlertDialogCustomState extends State<AlertDialogCustom> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null &&
                (Icons.warning == widget.icon ||
                    Icons.warning_amber == widget.icon ||
                    Icons.warning_amber_outlined == widget.icon ||
                    Icons.warning_rounded == widget.icon))
              Image.asset(
                "assets/icons/warning-red.png",
                height: 100,
              ),

            // Icon(widget.icon,color: widget.iconColor,size: 60,),
            if (widget.image != null)
              SizedBox(
                height: 100,
                width: 100,
                child: myImage(isNetwork: false, source: widget.image!),
              ),

            if (widget.title != null)
              Text(
                textAlign: TextAlign.center,
                widget.title.toString(),
                style: CommonDecoration.textWithLogo.copyWith(fontSize: 18),
              ),
            if (widget.title != null || (widget.description != null))
              smallSpace(),
            if (widget.description != null)
              Text(
                textAlign: TextAlign.center,
                widget.description.toString(),
                style: CommonDecoration.textWithLogo
                    .copyWith(fontSize: 12, fontWeight: FontWeight.w300),
              ),
            smallSpace(),
            if (widget.subTitle != null)
              Text(
                textAlign: TextAlign.center,
                widget.subTitle.toString(),
                style: CommonDecoration.textWithLogo
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w300),
              ),
            if (widget.subTitle != null) smallSpace(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: InkWell(
                        onTap: () {
                          widget.positiveCall!();
                        },
                        child: MyButton(
                            text: widget.switchText ??
                                (widget.showNegative ?? false ? "Yes" : "Okay"),
                            borderRadius: CommonDimension.buttonRadius,
                            color: ColorConstants.themeColor))),
                if (widget.showNegative ?? false)
                  SizedBox(
                    width: 10,
                  ),
                if (widget.showNegative ?? false)
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            widget.negativeCall!();
                          },
                          child: MyButton(
                              text: widget.exitText ?? "No",
                              borderRadius: CommonDimension.buttonRadius,
                              color: ColorConstants.themeColor))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
