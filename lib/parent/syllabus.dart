import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

import '../teacher_model/get_syllabus_list_by_class_section_subject_model.dart';

class Syllabus extends StatelessWidget {
  GetSyllabusListByClassSectionSubjectModel getSyllabusListByClassSectionSubjectModel;
   Syllabus({Key? key,required this.getSyllabusListByClassSectionSubjectModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(child: Column(
        children: [
          CommonHeader(title: "Syllabus",),
          smallSpace(),

          Expanded(child:getSyllabusListByClassSectionSubjectModel.data!.length.isEqual(0)?myImage(isNetwork: false, source: "assets/icons/empty.png") :ListView.builder(
              itemCount: getSyllabusListByClassSectionSubjectModel.data!.length,
              itemBuilder: (context,i){
                return InkWell(
                    onTap: (){
                      viewDocument(fileSource: getSyllabusListByClassSectionSubjectModel.data![i].absoluteImagePath??"",fromUrl: true);
                    },
                    child: subjectCard(subjectName: getSyllabusListByClassSectionSubjectModel.data![i].title??""));
          }))
        ],
      )),
    );
  }
}
