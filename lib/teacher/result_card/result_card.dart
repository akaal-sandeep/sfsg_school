import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/constants/color_constants.dart';
import 'package:web_school_manager/teacher/result_card/result_marks.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/button.dart';

import '../../widget/header.dart';

class ResultCard extends StatefulWidget {
   ResultCard({Key? key,}) : super(key: key);

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  var x;
  var exam;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    x="Choose Term";
    exam="Choose Exams";
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: myPadding(
          child: Column(
        children: <Widget>[ CommonHeader(
          title: "Result Card",
          hideStudentName: true,

        ),

        smallSpace(),
        _popUpFun(),
          smallSpace(),
          _popUpExam(),
          smallSpace(),
          _maxRow(),
          smallSpace(),

          InkWell(
            onTap: (){
              Get.to(()=>ResultMarks());
            },
            child: MyButton(

                text: "Proceed", borderRadius: 10
                , color: ColorConstants.themeColor),
          ),




        ],
      )),
    );
  }

  Widget _maxRow(){
  return  Row(
    children: <Widget>[
      Text("Max Marks: ",
        style: TextStyle(
          fontSize: 15,

        ),
      ),
      SizedBox(width: 10,),
      Text("100",
        style: TextStyle(
          fontSize: 15,

        ),
      )


    ],
  );
  }
  Widget _popUpFun(){
  return Row(
    children: [
      Text("Terms",
        style: TextStyle(fontSize: 17,
            fontWeight: FontWeight.bold
        ),

      ),
      SizedBox(width: 20,),
      PopupMenuButton(
        // initialValue: "Choose Term",
        child: Row(

          children: [
            Text(
              "${x.toString()}",
              style: TextStyle(fontSize: 16,

              ),
            ),
            SizedBox(width: 10,),
            Icon(Icons.arrow_drop_down),
          ],
        ),
        color: Colors.white,
        elevation: 2,
        onSelected: (value) {
          x = value;

          setState(() {});
        },
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: "Term 1",
              child: Text(
                "Term 1",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            PopupMenuItem(
              value:"Term 2",

              child: Text(
                "Term 2",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            PopupMenuItem(
              value: "Term 3",
              child: Text(
                "Term 3",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
          ];
        },
      ),
    ],
  );
  }
  Widget _popUpExam(){
  return Row(
    children: [
      Text("Exams",
        style: TextStyle(fontSize: 17,
            fontWeight: FontWeight.bold
        ),

      ),
      SizedBox(width: 20,),
      PopupMenuButton(
        // initialValue: "Choose Term",
        child: Row(

          children: [
            Text(
              "${exam.toString()}",
              style: TextStyle(fontSize: 16,

              ),
            ),
            SizedBox(width: 10,),
            Icon(Icons.arrow_drop_down),
          ],
        ),
        color: Colors.white,
        elevation: 2,
        onSelected: (value) {
          exam= value;

          setState(() {});
        },
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: "English",
              child: Text(
                "English",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            PopupMenuItem(
              value:"Hindi",

              child: Text(
                "Hindi",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            PopupMenuItem(
              value: "Punjabi",
              child: Text(
          "Punjabi",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
          ];
        },
      ),
    ],
  );
  }
}
