import 'package:flutter/material.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../../../teacher_model/get_upload_class_home_work_list_for_student.dart';

class ViewHomeWorkList extends StatelessWidget {
  GetUploadClassHomeWorkListForStudentModel
      getUploadClassHomeWorkListForStudentModel;

  ViewHomeWorkList(
      {Key? key, required this.getUploadClassHomeWorkListForStudentModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(
          child: Column(
        children: [
          CommonHeader(
            title: "Uploaded Home Work",
            hideStudentName: true,
          ),
          smallSpace(),
          Expanded(
              child: ListView.builder(
                  itemCount:
                      getUploadClassHomeWorkListForStudentModel.data!.length,
                  itemBuilder: (context, i) => listCard(
                    showArrow: false,
                      imageUrl: "",
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "Assigned Date ${getTimeFormat(DateTime.parse(getUploadClassHomeWorkListForStudentModel.data![i].homeWorkDate??""))}",style: CommonDecoration.smallLabel.copyWith(fontSize: 10),),
                              Text(
                                  "Uploaded Date ${getTimeFormat(DateTime.parse(getUploadClassHomeWorkListForStudentModel.data![i].homeWorkUploadDate??""))}",style: CommonDecoration.smallLabel.copyWith(fontSize: 10)),
                            ],
                          ),
                          SizedBox(height: 3,),
                          Text(
                              "Remarks ${getUploadClassHomeWorkListForStudentModel.data![i].remarks}",style: CommonDecoration.smallLabel,),
                          smallSpace(),
                          Text(
                            "Attached Documents : ",style: CommonDecoration.smallLabel,),
                          smallSpace(),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:getUploadClassHomeWorkListForStudentModel.data![i].documentsList!.length ,
                            itemBuilder: (context,j){
                              return InkWell(
                                onTap: (){
                                  viewDocument(fileSource: getUploadClassHomeWorkListForStudentModel.data![i].documentsList![j].fileUrl??"", fromUrl: true);
                                },
                                child: listCard(imageUrl:getUploadClassHomeWorkListForStudentModel.data![i].documentsList![j].fileUrl??"" , content:        Text(
                                  getUploadClassHomeWorkListForStudentModel.data![i].documentsList![j].documentName??"",style: CommonDecoration.smallLabel,), ),
                              );
                            },
                          )

                        ],
                      ),
                      showImage: false)))
        ],
      )),
    );
  }
}
