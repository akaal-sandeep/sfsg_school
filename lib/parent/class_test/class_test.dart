import 'package:flutter/material.dart';
import 'package:web_school_manager/controller/parent_controller.dart';
import 'package:web_school_manager/parent_model/class_test_list_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';



class ClassTest extends StatelessWidget {
  ClassTestListModelStudent classTestListModel;
   ClassTest({Key? key,required this.classTestListModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(child: Column(
        children: [
          CommonHeader(title: "Class Test"),
          smallSpace(),
          Expanded(child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 20),
              itemCount: classTestListModel.data!.length,
              itemBuilder: (context,i){
                return InkWell(
                    onTap: (){
                      ParentController().getClassTestList(subjectMasterId: classTestListModel.data![i].subjectMasterId.toString());
                    },
                    child: subjectCard(subjectName: classTestListModel.data![i].subjectName??""));
              })
          )
        ],
      )),
    );
  }
}
