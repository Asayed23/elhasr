// import 'dart:async';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:elhasr/core/local_colors.dart';
// import 'package:elhasr/core/size_config.dart';
// import 'package:elhasr/pages/Auth/controller/currentUser_controller.dart';
// import 'package:elhasr/pages/Auth/controller/sharedpref_function.dart';
// import 'package:elhasr/pages/home/controller/home_controller.dart';
// import 'package:elhasr/pages/home/home.dart';

// class TrnaslationPage extends StatefulWidget {
//   @override
//   _TrnaslationPageState createState() => new _TrnaslationPageState();
// }

// class _TrnaslationPageState extends State {
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Container(
//       decoration: ldecoration,
//       child: Scaffold(
//           backgroundColor: Colors.transparent,
//           appBar: AppBar(),
//           body: Center(
//               child: ListView(
//             children: [
//               SvgPicture.asset(
//                 "assets/images/mylogo.svg",
//                 width: sp(60),
//                 height: sp(60),
//                 //color: Colors.red,
//               ),
//               SvgPicture.asset(
//                 "assets/images/elhasr1.svg",
//                 width: sp(30),
//                 height: sp(30),
//               ),
//               SizedBox(height: h(20)),
//               Padding(
//                 padding: EdgeInsets.only(right: w(40), left: w(1)),
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.black,
//                       side: BorderSide(color: Colors.white10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ), // text color

//                     onPressed: () async {
//                       var locale = Locale('en', 'en');
//                       Get.updateLocale(locale);
//                       SharedPreferences prefs =
//                           await SharedPreferences.getInstance();
//                       bool reult = await prefs.setBool('isArabic', false);
//                       Get.to(HomePage());
//                     },
//                     child: Text(
//                       'English',
//                       style: TextStyle(fontSize: sp(20), color: Colors.white),
//                     )),
//               ),
//               SizedBox(
//                 height: h(2),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: w(40), right: w(1)),
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.black,
//                       side: BorderSide(color: Colors.white10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ), // text color
//                     onPressed: () async {
//                       var locale = Locale('ar', 'ar');
//                       Get.updateLocale(locale);
//                       SharedPreferences prefs =
//                           await SharedPreferences.getInstance();
//                       bool reult = await prefs.setBool('isArabic', true);
//                       print(reult);

//                       Get.to(HomePage());
//                     },
//                     child: Text(
//                       'عربى',
//                       style: TextStyle(fontSize: sp(20), color: Colors.white),
//                     )),
//               ),
//             ],
//           ))),
//     );
//   }
// }
