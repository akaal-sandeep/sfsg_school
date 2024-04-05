import 'package:flutter/material.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

class DocumentView extends StatelessWidget {
  Widget child;
   DocumentView({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
        child: Column(
          children: [
            CommonHeader(title: "Document View",hideStudentName: true,),
            SizedBox(height: 10,),
            child
          ],
        ),
      ),
    );
  }
}
