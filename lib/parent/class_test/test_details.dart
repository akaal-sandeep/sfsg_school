import 'package:flutter/material.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../parent_model/test_details_model.dart';

class TestDetails extends StatelessWidget {
  TestDetailsModel testDetailsModel;
   TestDetails({Key? key,required this.testDetailsModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(child: Column(
        children: [
          CommonHeader(title: "Test Details",),
          smallSpace(),
          Expanded(
            child: ListView.builder(
                itemCount: testDetailsModel.data!.length,
                itemBuilder: (context,i){
              return Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: myShadow
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(testDetailsModel.data![i].testTopic??"",style: CommonDecoration.bigLabel.copyWith(color: Colors.black),),
                        Text(getTimeFormat(DateTime.parse(testDetailsModel.data![i].testDate??"")),style: CommonDecoration.smallLabel,),
                      ],
                    ),
                   paddingGreyLine(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Max. Marks: ${testDetailsModel.data![i].maximumMarks}",style: CommonDecoration.smallLabel,),
                        Text("Highest Marks: ${testDetailsModel.data![i].highestMarks}",style: CommonDecoration.smallLabel,),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: paddingGreyLine()),
                        Text("Details",style: CommonDecoration.smallLabel,),
                        Expanded(child: paddingGreyLine()),

                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Remarks : ${testDetailsModel.data![i].studentData![0].remarks}",style: CommonDecoration.smallLabel,),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.grey.withOpacity(.3),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,

                            children: [
                              Text("Atnd. Status : ${testDetailsModel.data![i].studentData![0].attendanceStatus}",style: CommonDecoration.smallLabel,),
                              Text("Obt. Marks : ${testDetailsModel.data![i].studentData![0].marksObtained}",style: CommonDecoration.smallLabel,),
                              Text("Marks. Percentage : ${testDetailsModel.data![i].studentData![0].marksPercentage}",style: CommonDecoration.smallLabel,),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
          )
        ],
      )),
    );
  }

 Widget paddingGreyLine(){
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: greyLine(),
    );
  }

}
