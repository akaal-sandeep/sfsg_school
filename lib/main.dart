// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.cyan,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: const OverlayDemo(),
//     );
//   }
// }
//
// class OverlayDemo extends StatefulWidget {
//   const OverlayDemo({Key? key}) : super(key: key);
//
//   @override
//   _OverlayDemoState createState() => _OverlayDemoState();
// }
//
// class _OverlayDemoState extends State<OverlayDemo> {

//   void _showOverlay(BuildContext context) async {
//     OverlayState? overlayState = Overlay.of(context);
//     OverlayEntry overlay1;
//     OverlayEntry overlay2;
//     OverlayEntry overlay3;
//     overlay1 = OverlayEntry(builder: (context) {
//       return Positioned(
//         left: MediaQuery.of(context).size.width * 0.1,
//         top: MediaQuery.of(context).size.height * 0.3,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: Container(
//             padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
//             width: MediaQuery.of(context).size.width * 0.8,
//             height: MediaQuery.of(context).size.height * 0.11,
//             color: Colors.orange.withOpacity(0.5),
//             child: Material(
//               color: Colors.transparent,
//               child: Text('The Flutter app developers at FlutterDevs have',
//                   style: TextStyle(
//                       fontSize: MediaQuery.of(context).size.height * 0.03,
//                       //fontWeight: FontWeight.bold,
//                       color: Colors.white)),
//             ),
//           ),
//         ),
//       );
//     });
//     overlay2 = OverlayEntry(builder: (context) {
//       return Positioned(
//         left: MediaQuery.of(context).size.width * 0.1,
//         top: MediaQuery.of(context).size.height * 0.5,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: Container(
//             padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
//             width: MediaQuery.of(context).size.width * 0.8,
//             height: MediaQuery.of(context).size.height * 0.11,
//             color: Colors.pink.withOpacity(0.5),
//             child: Material(
//               color: Colors.transparent,
//               child: Text('decades of industry experience under a single roof,',
//                   style: TextStyle(
//                       fontSize: MediaQuery.of(context).size.height * 0.03,
//                       //fontWeight: FontWeight.bold,
//                       color: Colors.white)),
//             ),
//           ),
//         ),
//       );
//     });
//     overlay3 = OverlayEntry(builder: (context) {
//       return Positioned(
//         left: MediaQuery.of(context).size.width * 0.1,
//         top: MediaQuery.of(context).size.height * 0.7,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: Container(
//             padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
//             width: MediaQuery.of(context).size.width * 0.8,
//             height: MediaQuery.of(context).size.height * 0.11,
//             color: Colors.blue.withOpacity(0.5),
//             child: Material(
//               color: Colors.transparent,
//               child: Text('and this empowers us to serve you with excellence.',
//                   style: TextStyle(
//                       fontSize: MediaQuery.of(context).size.height * 0.03,
//                       //fontWeight: FontWeight.bold,
//                       color: Colors.white)),
//             ),
//           ),
//         ),
//       );
//     });
//
//     overlayState?.insertAll([overlay1, overlay2, overlay3]);
//
//     await Future.delayed(const Duration(seconds: 2));
//
//     overlay1.remove();
//
//     await Future.delayed(const Duration(seconds: 1));
//
//     overlay2.remove();
//
//     await Future.delayed(const Duration(seconds: 1));
//
//     overlay3.remove();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[50],
//       appBar: AppBar(
//         title: const Text(
//           'Flutter Overlay Demo',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//       ),
//       body: SafeArea(
//           child: Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/logo.png',
//                     height: 300,
//                     width: 350,
//                   ),
//                   const SizedBox(
//                     height: 50,
//                   ),
//                   MaterialButton(
//                     color: Colors.pink[300],
//                     minWidth: MediaQuery.of(context).size.width * 0.4,
//                     height: MediaQuery.of(context).size.height * 0.06,
//                     child: const Text(
//                       'show Overlay',
//                       style: TextStyle(color: Colors.white, fontSize: 17),
//                     ),
//                     onPressed: () {
//                       _showOverlay(context);
//                     },
//                   ),
//                 ],
//               ))),
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_school_manager/common_view/splash.dart';

import 'fcm/fcm_service.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
 // await Firebase.initializeApp();
  //await PushNotificationService().setupInteractedMessage();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarBrightness: Brightness.light));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);


  final Map<int, Color> shades = {
    50: Color(0xff224e7f).withOpacity(.1),
    100: Color(0xff224e7f).withOpacity(.2),
    200: Color(0xff224e7f).withOpacity(.3),
    300: Color(0xff224e7f).withOpacity(.4),
    400: Color(0xff224e7f).withOpacity(.5),
    500: Color(0xff224e7f).withOpacity(.6),
    600: Color(0xff224e7f).withOpacity(.7),
    700: Color(0xff224e7f).withOpacity(.8),
    800: Color(0xff224e7f).withOpacity(.9),
    900: Color(0xff224e7f),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SFSJ School',
      theme: ThemeData(
        useMaterial3:false,
        fontFamily: "poppins",
        primarySwatch: MaterialColor(0xff224e7f, shades),
      ),
      home: Splash(),
    );
  }
}
