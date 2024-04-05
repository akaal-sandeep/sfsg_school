import 'package:flutter/material.dart';
import 'package:web_school_manager/utility/helper_widget.dart';



class LogoutButton extends StatefulWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell
      (
      onTap: () {
      logoutDialog();
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
          Icons.power_settings_new,color: Colors.red,)
        ,
      )
      ,
    );
  }
}


