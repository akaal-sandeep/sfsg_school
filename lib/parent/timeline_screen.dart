import 'package:flutter/material.dart';

import '../utility/custom_decoration.dart';
import '../utility/helper_widget.dart';
import '../widget/header.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(child: Column(
        children: [
          CommonHeader(title: "Timeline",hideStudentName: true,),
          smallSpace(),
          Expanded(child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context,i){
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 3),
                  child: listCard(imageUrl: "",showImage: false,showArrow: false, content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Timeline",style: CommonDecoration.subHeaderStyle.copyWith(decoration: TextDecoration.underline),),
                        SizedBox(height: 10,),
                        Text("timeline",style: CommonDecoration.smallLabel,),
                      ],
                    ),
                  )),
                );
              }))
        ],
      )),
    );
  }
}
