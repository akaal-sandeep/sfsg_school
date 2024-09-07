import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:web_school_manager/local_storage/local_storage.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/dialog.dart';

class BioMetric{

  static final BioMetric _singleton = BioMetric._internal();

  factory BioMetric() {
    return _singleton;
  }

  BioMetric._internal();

  final LocalAuthentication auth = LocalAuthentication();
  bool? canAuthenticateWithBiometric;
  bool? canAuthenticate;

  init()async{
    canAuthenticateWithBiometric = await auth.canCheckBiometrics;
   canAuthenticate =
        canAuthenticateWithBiometric! || await auth.isDeviceSupported();
  }



  authenticateUserWithBioMetric()async{
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to show account balance');
      LocalStorage().saveBioMetricStatus(didAuthenticate);
      // ···
    } on PlatformException catch(e) {
      myLog(label: 'Ad', value: 'platform ${e.toString()}');
    }catch(e){
      myLog(label: 'Ad', value: e.toString());
    }
  }

 Future <bool> factorTwoAuth()async{
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to show account balance');
      return didAuthenticate;
      // ···
    } on PlatformException catch(e) {
      myLog(label: 'Ad', value: 'platform ${e.toString()}');
      return false;
    }catch(e){
      return false;
    }
  }

  Future<dynamic> bioMetricDialog() {
    if(canAuthenticate==false){
     return Future.delayed(Duration(microseconds: 1));
    }
    return showDialog(
        context: Get.context!,
        builder: (context) => AlertDialogCustom(
          image: "assets/icons/fingerprint.gif",
          iconColor: Colors.red,
          showNegative: true,
          description: "Do you want to enable biometric login?",
          positiveCall: () {
            Get.back();
            authenticateUserWithBioMetric();
            // UserController().logout();
          },
          negativeCall: () {
            Get.back();
          },
        ));
  }

}