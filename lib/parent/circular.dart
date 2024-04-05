import 'package:flutter/material.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../parent_model/get_circular_list_model.dart';

class CircularParent extends StatelessWidget {
  CircularListModel circularListModel;
   CircularParent({Key? key,required this.circularListModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(child: Column(
        children: [
          CommonHeader(title: "Circular"),
          smallSpace(),
          Expanded(
            child: ListView.builder(
              itemCount: circularListModel.data!.length,
              shrinkWrap: true,
              itemBuilder: (context,i){
                return InkWell(
                  onTap: (){
                   viewDocument(fileSource: circularListModel.data![i].absoluteImagePath??"", fromUrl: true);
                  },
                  child: listCard(imageUrl: circularListModel.data![i].absoluteImagePath??"", showArrow:false,content:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(getTimeFormat(DateTime.parse(circularListModel.data![i].createDate??""))),
                      Text(circularListModel.data![i].title??""),
                    ],
                  )),
                );
              },
            ),
          )

        ],
      )),
    );
  }
}
