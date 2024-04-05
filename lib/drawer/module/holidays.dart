import 'package:flutter/material.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../model/get_holidays_list_model.dart';

class Holidays extends StatelessWidget {
  GetHolidaysListModel getHolidaysListModel;

  Holidays({Key? key, required this.getHolidaysListModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
          child: Column(
        children: [
          CommonHeader(
            title: "Holidays",
            hideStudentName: true,
          ),
          smallSpace(),
          Expanded(
              child: ListView.builder(
                  itemCount: getHolidaysListModel.data?.length ?? 0,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 3),
                      child: listCard(
                          imageUrl: "",
                          showImage: false,
                          showArrow: false,
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getHolidaysListModel.data![i].name ?? "",
                                  style: CommonDecoration.subHeaderStyle
                                      .copyWith(
                                          decoration: TextDecoration.underline),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${getTimeFormat(DateTime.parse(getHolidaysListModel.data![i].fromDate ?? ""))} - ${getTimeFormat(DateTime.parse(getHolidaysListModel.data![i].toDate ?? ""))}",
                                  style: CommonDecoration.smallLabel,
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
