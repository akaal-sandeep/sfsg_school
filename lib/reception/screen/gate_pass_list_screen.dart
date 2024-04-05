import 'package:flutter/material.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/reception_model/get_pass_list_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

class GatePassListScreen extends StatelessWidget {
  GetPassListModel getPassListModel;
  bool outward;

  GatePassListScreen({super.key, required this.getPassListModel,required this.outward});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
        child: Column(
          children: [
            CommonHeader(
              title: outward?"Outward":"Inward"+" Gate Pass List",
              hideStudentName: true,
            ),
            smallSpace(),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 10),
                  itemCount: getPassListModel.data?.length ?? 0,
                  separatorBuilder: (context, i) => smallSpace(),
                  itemBuilder: (context, i) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: myShadow,
                        color: Colors.white
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: GestureDetector(
                              onTap: (){
                                viewDocument(fileSource: getPassListModel.data![i].visitorPhotoUrlForMobileApp ?? "", fromUrl: true);
                              },
                              child: SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: Image.network(getPassListModel
                                          .data![i].visitorPhotoUrlForMobileApp ??
                                      "",fit: BoxFit.cover,)),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Gate Pass Number : ${getPassListModel.data![i].gatepassNumber}"),
                              Text(
                                  "Visitor Name : ${getPassListModel.data![i].visitorName}"),
                              if(outward)
                              Text(
                                  "Reason : ${getPassListModel.data![i].reasonForExit}"),
                              Text(
                                  "Time : ${commonTimeConvert(DateTime.parse(getPassListModel.data![i].createDate??""))}"),

                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
