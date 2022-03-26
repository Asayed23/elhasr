import 'dart:async';
import 'package:elhasr/pages/category/view/category.dart';
import 'package:elhasr/pages/common_widget/simple_appbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:elhasr/pages/common_widget/local_colors.dart';
import 'package:elhasr/core/size_config.dart';
import 'package:elhasr/pages/Auth/controller/currentUser_controller.dart';
import 'package:elhasr/pages/Auth/controller/sharedpref_function.dart';
import 'package:elhasr/pages/home_page/view/home_page.dart';

import '../pages/common_widget/mybottom_bar/bottom_bar_controller.dart';

class TrnaslationPage extends StatefulWidget {
  @override
  _TrnaslationPageState createState() => new _TrnaslationPageState();
}

final MyBottomBarCtrl myBottomBarCtrl = Get.put(MyBottomBarCtrl());

class _TrnaslationPageState extends State {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        // appBar: simplAppbar(true),
        body: Center(
            child: ListView(
      children: [
        Image.asset(
          "assets/images/hasr_logo.png",
          width: w(40),
          height: h(20),
          //color: Colors.red,
        ),
        SizedBox(height: h(20)),
        Padding(
          padding: EdgeInsets.only(right: w(40), left: w(1)),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                side: BorderSide(color: Colors.white10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ), // text color

              onPressed: () async {
                var locale = Locale('en', 'en');
                Get.updateLocale(locale);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('lang', 'en');
                myBottomBarCtrl.selectedIndBottomBar.value = 0;
                Get.to(CategoryPage());
              },
              child: Text(
                'English',
                style: TextStyle(fontSize: sp(20), color: Colors.white),
              )),
        ),
        SizedBox(
          height: h(2),
        ),
        Padding(
          padding: EdgeInsets.only(left: w(40), right: w(1)),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                side: BorderSide(color: Colors.white10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ), // text color
              onPressed: () async {
                var locale = Locale('ar', 'ar');
                Get.updateLocale(locale);
                SharedPreferences prefs = await SharedPreferences.getInstance();

                await prefs.setString('lang', 'ar');
                myBottomBarCtrl.selectedIndBottomBar.value = 0;

                Get.to(CategoryPage());
              },
              child: Text(
                'عربى',
                style: TextStyle(fontSize: sp(20), color: Colors.white),
              )),
        ),
      ],
    )));
  }
}
