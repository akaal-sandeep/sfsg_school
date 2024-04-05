import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/controller/drawer_controller.dart';
import 'package:web_school_manager/controller/reception_controller.dart';
import 'package:web_school_manager/controller/user_controller.dart';
import 'package:web_school_manager/drawer/parent_drawer.dart';
import 'package:web_school_manager/generated/assets.dart';
import 'package:web_school_manager/reception/screen/create_inward_gate_pass.dart';
import 'package:web_school_manager/reception/screen/gate_pass_list_screen.dart';
import 'package:web_school_manager/reception/screen/student_search_screen.dart';
import 'package:web_school_manager/reception_model/get_pass_list_model.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';

class ReceptionDashboardScreen extends StatelessWidget {
   ReceptionDashboardScreen({super.key});

  Future<bool> checkExit() async {
    bool myExit = false;
    var exit = await switchDialog(exit: myExit).then((value) {
      return value;
    });
    return exit;
  }

  List iconList = [
    Assets.iconsSecurityGate,
    Assets.iconsCard,
    Assets.iconsInwardPass,
    Assets.iconsInwardPassList,

  ];
  List name = [

    "Outward Gate Pass List",
    "Create Outward Gate Pass",
    "Create Inward Gate Pass",
    "Inward Gate Pass List",
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exit = await checkExit();
        myLog(label: "exit", value: exit);
        return Future.value(exit);
      },
      child: Scaffold(
        key: UserController.drawerState,
        drawer: ParentDrawer(),
        body: myPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonHeader(
                title: "Reception",
                showDrawer: true,
                hideStudentName: true,
              ),
              largeSpace(),
              InkWell(
                onTap: (){
                  ParentDrawerController().getNotificationList();
                  // Get.to(TimelineScreen());
                },

                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  decoration: BoxDecoration(
                      boxShadow: myShadow,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          height: 30,
                          child: Image.asset("assets/icons/timeline.png")),
                      SizedBox(width: 10,),
                      Text("Notifications")
                    ],
                  ),
                ),
              ),
          Expanded(
            child: AnimationLimiter(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 20),
                itemCount:iconList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 120,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0),
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 1000),
                    columnCount: 3,
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: InkWell(
                          onTap: ()async {
                            switch(index){
                              case 0:
                             GetPassListModel model = await ReceptionController().getOutwardGatePassList();
                             Get.to(()=>GatePassListScreen(getPassListModel: model,outward: true,));
                                break;
                              case 1:
                                Get.to(()=>StudentSearchScreen());
                                break;
                              case 2:
                                Get.to(()=>CreateInwawrdGatePass());
                                break;
                              case 3:
                                GetPassListModel model = await ReceptionController().getInwardGatePassList();
                                Get.to(()=>GatePassListScreen(getPassListModel: model,outward: false,));
                                break;
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 9),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: myShadow),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  iconList[index],
                                  height: 60,
                                ),
                                Spacer(),
                                Text(
                                  name[index],
                                  textAlign: TextAlign.center,
                                  style: CommonDecoration.dashBoardList,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ) ],
          ),
        ),
      ),
    );
  }
}
