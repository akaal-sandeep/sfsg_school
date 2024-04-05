
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/api/api_client.dart';
import 'package:web_school_manager/api/api_url.dart';
import 'package:web_school_manager/constants/string_constants.dart';
import 'package:web_school_manager/drawer/module/gallery.dart';
import 'package:web_school_manager/drawer/module/holidays.dart';
import 'package:web_school_manager/drawer/module/notice_board.dart';
import 'package:web_school_manager/drawer/module/press_release.dart';
import 'package:web_school_manager/drawer/module/sports_schedule.dart';
import 'package:web_school_manager/model/get_gallary_data_model.dart';
import 'package:web_school_manager/model/get_holidays_list_model.dart';
import 'package:web_school_manager/model/get_notification_list_model.dart';
import 'package:web_school_manager/model/get_sports_schedule_list_model.dart';
import 'package:web_school_manager/model/parent_notice_board_list_model.dart';
import 'package:web_school_manager/model/parent_press_release_images_model.dart';
import 'package:web_school_manager/model/parent_press_release_model.dart';
import 'package:web_school_manager/utility/helper_widget.dart';

import '../drawer/module/contact_us.dart';
import '../drawer/module/notifications.dart';
import '../drawer/module/press_images.dart';

class ParentDrawerController {

  Future getParentNoticeBoardList() async {
    showLoader();
    var response =
        await ApiClient().postWithToken(ApiUrls.ParentNoticeBoardList, {});
    hideLoader();
    ParentNoticeBoardListModel parentNoticeBoardListModel =
        ParentNoticeBoardListModel.fromJson(response);
    classNavigate(NoticeBoard(
      parentNoticeBoardListModel: parentNoticeBoardListModel,
    ));
  }

  Future getHolidaysList() async {
    showLoader();
    var response = await ApiClient().postWithToken(ApiUrls.GetHolidaysList, {});
    hideLoader();
    GetHolidaysListModel getHolidaysListModel =
        GetHolidaysListModel.fromJson(response);
    classNavigate(Holidays(
      getHolidaysListModel: getHolidaysListModel,
    ));
  }

  Future getGalleryData() async {
    showLoader();
    var response = await ApiClient().postWithToken(ApiUrls.GetGalleryData, {});
    hideLoader();
    GetGalleryDataModel getGalleryDataModel =
        GetGalleryDataModel.fromJson(response);
    classNavigate(Gallery(getGalleryDataModel: getGalleryDataModel));
  }

  Future getParentPressRelease() async {
    showLoader();
    var response =
        await ApiClient().postWithToken(ApiUrls.ParentPressRelease, {});
    hideLoader();
    ParentPressReleaseModel parentPressReleaseModel =
        ParentPressReleaseModel.fromJson(response);
    classNavigate(
        PressRelease(parentPressReleaseModel: parentPressReleaseModel));
  }

  Future getParentPressReleaseImages({required String id}) async {
    showLoader();
    var raw = {"Id": id};
    var response =
        await ApiClient().postWithToken(ApiUrls.ParentPressReleaseImages, raw);
    hideLoader();
    ParentPressReleaseImagesModel parentPressReleaseImagesModel =
        ParentPressReleaseImagesModel.fromJson(response);
    Get.to(
        () => PressImages(
            parentPressReleaseImagesModel: parentPressReleaseImagesModel),
        transition: Transition.leftToRightWithFade);
  }

  Future getNotificationList() async {
    showLoader();
    var response =
        await ApiClient().postWithToken(ApiUrls.GetNotificationList,{});
    hideLoader();
    GetNotificationListModel getNotificationListModel = GetNotificationListModel.fromJson(response);
    classNavigate(UserNotification(getNotificationListModel: getNotificationListModel,));
  }

  Future getSportsScheduleList()async{
    showLoader();
    var response = await ApiClient().postWithToken(ApiUrls.GetSportsScheduleList, {});
    GetSportsScheduleListModel getSportsScheduleListModel = GetSportsScheduleListModel.fromJson(response);
    hideLoader();
    classNavigate(SportsSchedule(getSportsScheduleListModel: getSportsScheduleListModel));
  }

  Future contactUs()async{
    // showLoader();
    // var response = await ApiClient().postWithToken(ApiUrls.ContactUs, {});
    // hideLoader();
    // if(response['statuscode']==StringConstants.success){

      classNavigate(ContactUsStatic());
    // }else{
    //   showMessage(msg: response['message']);
    // }
  }

  void classNavigate(Widget navigateClass) {
    myLog(label: "ss", value: "ss ");
    Get.to(() => navigateClass, transition: Transition.leftToRightWithFade);
  }

}
