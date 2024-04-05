import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/constants/color_constants.dart';
import 'package:web_school_manager/controller/principal_controller.dart';
import 'package:web_school_manager/principal_model/teacher_list_model.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';
import 'package:web_school_manager/widget/mytextfield.dart';

class TeacherAttendanceScreen extends StatefulWidget {
  TeacherListModel teacherListModel;
   TeacherAttendanceScreen({Key? key,required this.teacherListModel}) : super(key: key);

  @override
  State<TeacherAttendanceScreen> createState() => _TeacherAttendanceScreenState();
}

class _TeacherAttendanceScreenState extends State<TeacherAttendanceScreen> {
  final controller=Get.put(PrincipalController());

  List<TeacherListData> _searchList=[];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.searchController!.clear();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.searchController!.addListener(() {
      _searchList=[];
      for(var element in widget.teacherListModel.data!){

        if(element.displayName!.toUpperCase().contains(controller.searchController!.value.text.toUpperCase())){
          _searchList.add(element);
        }
      }
      setState(() {

      });


    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPadding(child: Column(
        children: [
          CommonHeader(title: "Teacher Attendance",

          ),
          smallSpace(),
          _searchField(),
          smallSpace(),
          controller.searchController!.value.text.length.isEqual(0)?
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  largeSpace(),
                  widget.teacherListModel.data!.length.isEqual(0)?

                      myImage(isNetwork: false, source: "assets/icons/empty.png"):
                  ListView.separated(
                    padding: EdgeInsets.only(bottom: 50),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        _bigContainer(index:index,theList: widget.teacherListModel.data),
                        _profileImage(index: index,theList: widget.teacherListModel.data),
                      ],
                    );
                  }, separatorBuilder: (BuildContext context, int index) {
                    return smallSpace();
                  }, itemCount: widget.teacherListModel.data!.length,),




                ],
              ),
            ),
          ):
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  largeSpace(),
                  
                  _searchList.length.isEqual(0)?
                  myImage(isNetwork: false, source: "assets/icons/empty.png"):

                  ListView.separated(
                    padding: EdgeInsets.only(bottom: 50),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          _bigContainer(index: index,theList: _searchList),
                          _profileImage(index: index,theList: _searchList),
                        ],
                      );
                    }, separatorBuilder: (BuildContext context, int index) {
                    return smallSpace();
                  }, itemCount: _searchList.length,),




                ],
              ),
            ),
          ),

        ],
      )),
    );
  }
  Widget _bigContainer({index,theList}){
    return Container(
      padding: EdgeInsets.only(top: 40),
      margin: EdgeInsets.only(top: 70,left: 10,right: 10),
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
          color: Colors.grey.withOpacity(0.4),
          spreadRadius: 3.0,
          blurRadius: 5.0
        )],
      ),
      child:   Column(
        children: [
          myPadding(

            child: Column(
              children: [
                smallSpace(),

                Text("${theList[index].displayName??""}",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black
                  ),),
                Text("Employee Id : "+"${theList![index].employeeId??""}",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey
                  ),),
                Text("Attendance Status : "+"${theList![index].attendanceStatus!.isEmpty?"Pending":
                "${theList![index].attendanceStatus??""}"
                }",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey
                  ),),



              ],
            ),
          ),
          Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),

            child: ExpansionTile(
              childrenPadding: EdgeInsets.symmetric(horizontal: 10),
              title: Text(
                "More Details",
                style: CommonDecoration.expensionStyle,
              ),
              children: <Widget>[
                detailsWithIcon(asseturl: "assets/icons/teacher-icon.png", text: "${theList[index].employeeCategoryName??""}"),
                detailsWithIcon(asseturl:  "assets/icons/employee-id.png", text: "${theList![index].employeeId??""}",),
                detailsWithIcon(asseturl:  "assets/icons/DOB.png", text: getTimeFormat(DateTime.parse("${theList![index].dateOfJoining??""}"))),
                _divider(),
                detailsWithIcon(asseturl: "assets/icons/phone-number.png", text:  "${theList![index].mobileNo??""}",),
                detailsWithIcon(asseturl: "assets/icons/DOB.png", text: getTimeFormat(DateTime.parse("${theList![index].dateOfBirth??""}"))),
                detailsWithIcon(asseturl: "assets/icons/gender.png", text:  "${theList![index].gender??""}",),
                smallSpace(),

              ],
            ),
          ),
        ],
      ),

    );
  }
  Widget _divider(){
    return  Divider(
      thickness: 2,
      color: Colors.grey.withOpacity(0.3),
    );
  }
  Widget _profileImage({index,theList}){
    return Container(
      height: 130,
      width: 130,
      decoration: BoxDecoration(
        color: Colors.white,
          shape: BoxShape.circle,
        boxShadow: myShadow,
      ),
      child:   ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: myImage(isNetwork: true, source:"${theList![index].employeeProfilePicturePath}"
        ),
      ),

    );
  }

  Widget _searchField(){
    return MyTextFieldWithWidget(

        hint: "Search", inputType: TextInputType.emailAddress,
        textEditingController: controller.searchController!,
        focusNode: controller.searchNode!,
        borderColor: ColorConstants.themeColor,
        borderRadius: 10,
        filled: false,
        prefixWidget: Icon(Icons.search),
        isValidate: false);
  }
}
