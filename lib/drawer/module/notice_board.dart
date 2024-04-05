import 'package:flutter/material.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';


import '../../model/parent_notice_board_list_model.dart';

class NoticeBoard extends StatelessWidget {
  ParentNoticeBoardListModel parentNoticeBoardListModel;
  NoticeBoard({Key? key,required this.parentNoticeBoardListModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(child: Column(
        children: [
          CommonHeader(title: "Notice Board",hideStudentName: true,),
          smallSpace(),
          Expanded(child: ListView.builder(
              itemCount: parentNoticeBoardListModel.data?.length??0,
              itemBuilder: (context,i){
                return InkWell(
                  onTap: (){
                    if(parentNoticeBoardListModel.data?[i].fileAbsolutePath!=null && parentNoticeBoardListModel.data?[i].fileAbsolutePath != ""){
                      viewDocument(fileSource: parentNoticeBoardListModel.data![i].fileAbsolutePath??"", fromUrl: true);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 3),
                    child: listCard(imageUrl: "",showImage: false,showArrow: false, content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                              height: 40,
                              child: myImage(isNetwork: false, source: "assets/icons/notice_board_icon.png")),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(parentNoticeBoardListModel.data![i].noticeBoardSubject??"",style: CommonDecoration.subHeaderStyle.copyWith(decoration: TextDecoration.underline),),
                                SizedBox(height: 10,),
                                Text(parentNoticeBoardListModel.data![i].noticeBoardContents??"",style: CommonDecoration.smallLabel,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                  ),
                );
              }))
        ],
      )),
    );
  }
}
