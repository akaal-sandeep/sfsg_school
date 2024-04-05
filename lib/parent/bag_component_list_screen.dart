import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_school_manager/controller/parent_controller.dart';
import 'package:web_school_manager/generated/assets.dart';
import 'package:web_school_manager/parent_model/student_bag_component_model.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

class BagComponentListScreen extends StatefulWidget {
  StudentBagComponentModel studentBagComponentModel;

  BagComponentListScreen({super.key, required this.studentBagComponentModel});

  @override
  State<BagComponentListScreen> createState() => _BagComponentListScreenState();
}

class _BagComponentListScreenState extends State<BagComponentListScreen> {

  DateTime time = DateTime.now().hour>9?DateTime.now().add(Duration(days: 1)):DateTime.now();

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
      floatingActionButton: InkWell(
        onTap: () {
          getTime().then((value) async {
            time = value;
            widget.studentBagComponentModel = await ParentController()
                .getBagComponent(
                    navigate: false, homeWorkDate: time.toString());
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
              if (widget.studentBagComponentModel.data!.length == 0)
                Expanded(child: Image.asset(Assets.iconsEmpty)),
              if (widget.studentBagComponentModel.data!.length != 0)
                Expanded(
                  child: ListView.separated(
                      padding: EdgeInsets.only(bottom: 100),
                      itemCount: widget.studentBagComponentModel.data!.length,
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
                                    "Subject : ${widget.studentBagComponentModel.data![i]
                                        .subjectName}",
                                    style: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.w700),
                                  ),

                                ],
                              ),
                              SizedBox(height: 5,),
                              for (int j = 0;
                              j <
                                  widget.studentBagComponentModel.data![i]
                                      .bagComponents!.length;
                              j++)...[
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Image.asset(Assets.iconsStationery,height: 20,),
                                    SizedBox(width: 5,),
                                    Text(
                                      (widget.studentBagComponentModel.data![i]
                                          .bagComponents![j].name ??
                                          ""),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],

                              if (widget.studentBagComponentModel.data![i]
                                  .otherComponentName!.isNotEmpty)...[
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Image.asset(Assets.iconsStationery,height: 20,),
                                    SizedBox(width: 5,),
                                    Text(
                                      (widget.studentBagComponentModel.data?[i]
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
