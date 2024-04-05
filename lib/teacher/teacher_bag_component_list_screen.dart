import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/constants/string_constants.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/generated/assets.dart';
import 'package:web_school_manager/local_storage/local_storage.dart';
import 'package:web_school_manager/teacher/syllabus/teacher_syllabus.dart';
import 'package:web_school_manager/teacher_model/get_class_list_model.dart';
import 'package:web_school_manager/teacher_model/teacher_bag_component_model.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

class TeacherBagComponentListScreen extends StatefulWidget {
  TeacherBagComponentModel teacherBagComponentModel;
  String? classMasterId;
  String? sectionMasterId;
  String? subjectMasterId;

  TeacherBagComponentListScreen({super.key, required this.teacherBagComponentModel,this.subjectMasterId, this.sectionMasterId, this.classMasterId});

  @override
  State<TeacherBagComponentListScreen> createState() => _TeacherBagComponentListScreenState();
}

class _TeacherBagComponentListScreenState extends State<TeacherBagComponentListScreen> {
  DateTime time = DateTime.now().add(Duration(days: 1));

  Future getTime() async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: time,
      firstDate: DateTime.now().subtract(Duration(days: 30)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    return picker;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (StringConstants.teacherType ==
              LocalStorage()
                  .read(key: StringConstants.userType))
          GestureDetector(
            onTap: () {
              TeacherController()
                  .getClassList(fromBagComponents: true,navigate: false).then((value)async{
                    if(value!=null){
                      GetClassListModel getClassListModel = value;
                      Get.to(() => TeacherSyllabus(
                        getClassListModel: getClassListModel,
                        fromBagComponents: true,
                      ))!.then((value)async {
                        widget.teacherBagComponentModel = await TeacherController()
                            .getBagPlanList(date: time.toString());
                        myLog(label: "My Selected date", value: time);
                        setState(() {});
                      });
                    }

              });
            },
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(left: 30),
              decoration: BoxDecoration(
                boxShadow: myShadow,
                borderRadius: BorderRadius.circular(100),
                color: Colors.blue,
              ),
              child: Icon(Icons.add,color: Colors.white,),
            ),
          ),
          GestureDetector(
            onTap: () {
              getTime().then((value) async {
                time = value;
                widget.teacherBagComponentModel = await TeacherController()
                    .getBagPlanList(
                    sectionMasterId: widget.sectionMasterId,
                    classMasterId: widget.classMasterId,
                    subjectMasterId: widget.subjectMasterId,
                    date: time.toString());
                myLog(label: "My Selected date", value: time);
                setState(() {});
              });
            },
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(left: 30),
              decoration: BoxDecoration(
                boxShadow: myShadow,
                borderRadius: BorderRadius.circular(100),
                color: Colors.blue,
              ),
              child: Text(
                DateFormat("dd MMM, yyyy").format(time),
                style: CommonDecoration.listStyle.copyWith(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: myPadding(
          child: Column(
            children: [
              CommonHeader(title: "Bag Components"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(DateFormat("dd MMM, yyyy").format(time)),
                  SizedBox(width: 5,),
                  Icon(Icons.calendar_month,color: Colors.grey,size: 18,)
                ],
              ),
              largeSpace(),
              if (widget.teacherBagComponentModel.data!.length == 0)
                Expanded(child: Image.asset(Assets.iconsEmpty)),
              if (widget.teacherBagComponentModel.data!.length != 0)
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(bottom: 100),
                      itemCount: widget.teacherBagComponentModel.data!.length,
                      separatorBuilder: (context, i) => SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (context, i) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: myShadow,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Class : ${widget.teacherBagComponentModel.data![i]
                                        .className}-${widget.teacherBagComponentModel.data![i]
                                        .sectionName}",
                                    style: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.w700),
                                  ),
                                  Spacer(),
                                  Text(
                                    "Subject : ${widget.teacherBagComponentModel.data![i]
                                        .subjectName}",
                                    style: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.w700),
                                  ),

                                ],
                              ),
                             SizedBox(height: 5,),
                              for (int j = 0;
                              j <
                                  widget.teacherBagComponentModel.data![i]
                                      .bagComponents!.length;
                              j++)...[
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Image.asset(Assets.iconsStationery,height: 20,),
                                    SizedBox(width: 5,),
                                    Text(
                                      (widget.teacherBagComponentModel.data![i]
                                          .bagComponents![j].name ??
                                          ""),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],

                              if (widget.teacherBagComponentModel.data![i]
                                  .otherComponentName!.isNotEmpty)...[
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Image.asset(Assets.iconsStationery,height: 20,),
                                    SizedBox(width: 5,),
                                    Text(
                                      (widget.teacherBagComponentModel.data?[i]
                                          .otherComponentName ??
                                          ""),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],

                            ],
                          ),
                        );
                      }),
                )
            ],
          ),
        ),
      ),
    );
  }
}
