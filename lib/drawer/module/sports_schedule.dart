import 'package:flutter/material.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../model/get_sports_schedule_list_model.dart';

class SportsSchedule extends StatelessWidget {
  GetSportsScheduleListModel getSportsScheduleListModel;
   SportsSchedule({Key? key,required this.getSportsScheduleListModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
        child: Column(
          children: [
            CommonHeader(title: "Sports Schedule"),
            smallSpace(),
            Expanded(child: ListView.builder(
                itemCount: getSportsScheduleListModel.data!.length,
                itemBuilder: (context,i){
                  return listCard(imageUrl: "ss",showArrow: false,showImage: false, content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${getSportsScheduleListModel.data![i].scheduleTimeString}, ${getTimeFormat(DateTime.parse(getSportsScheduleListModel.data![i].scheduleDate??""))}",style: CommonDecoration.subHeaderStyle,),
                      SizedBox(height: 3,),
                      Text(getSportsScheduleListModel.data![i].remarks??"",style: CommonDecoration.bigLabel,),
                    ],
                  ));
                }))
          ],
        ),
      ),
    );
  }
}
