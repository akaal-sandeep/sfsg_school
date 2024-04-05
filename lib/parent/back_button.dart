import 'package:flutter/material.dart';

import '../constants/color_constants.dart';


class MyBackButton extends StatefulWidget {
  const MyBackButton({Key? key}) : super(key: key);

  @override
  State<MyBackButton> createState() => _MyBackButtonState();
}

class _MyBackButtonState extends State<MyBackButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell
      (
      onTap: () {
             Navigator.pop(context);
      },
      child: Container
        (
        height: 40
        ,
        width: 40
        ,


        decoration: BoxDecoration
          (
            color: Colors.white,borderRadius: BorderRadius.circular(10
        )
            ,
            boxShadow: [
              BoxShadow
                (
                  color: Colors.grey.withOpacity(.2
                  )
                  ,
                  spreadRadius: 2
                  ,
                  blurRadius: 2
              )
            ]
        )
        ,
        child: Icon
          (
          Icons.arrow_back_ios_sharp,color: ColorConstants.themeColor,)
        ,
      )
      ,
    );
  }
}


