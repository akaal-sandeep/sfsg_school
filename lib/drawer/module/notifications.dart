import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';
import '../../model/get_notification_list_model.dart';


class UserNotification extends StatelessWidget {
  GetNotificationListModel getNotificationListModel;
  UserNotification({Key? key,required this.getNotificationListModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(child: Column(
        children: [
          CommonHeader(title: "Notifications",hideStudentName: true,),
          smallSpace(),
          Expanded(child: ListView.builder(
              itemCount: getNotificationListModel.data?.length??0,
              itemBuilder: (context,i){
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 3),
                  child: listCard(showImage: false,imageUrl: "y",showArrow: false, content: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset("assets/icons/school-alarm.png",height: 50,),
                        SizedBox(width: 5,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(getNotificationListModel.data![i].notificationSubject.toString(),style: CommonDecoration.subHeaderStyle,),
                              SizedBox(width: 5,),
                              Text(getNotificationListModel.data![i].notificationContents.toString(),style: CommonDecoration.smallLabel.copyWith(height: 2),),
                              Text(DateFormat("hh:mm aa, dd MMM,yyyy").format(DateTime.parse(getNotificationListModel.data![i].createDate.toString())),style: CommonDecoration.smallLabel.copyWith(height: 2),),

                            ],
                          ),
                        ),
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
