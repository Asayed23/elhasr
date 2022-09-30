import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:elhasr/pages/category/view/category.dart';
import 'package:elhasr/translation/translation_page.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/size_config.dart';
import '../Auth/controller/currentUser_controller.dart';
import '../Auth/controller/sharedpref_function.dart';
import '../category/control/category_controller.dart';
import '../sub_category/control/cart_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final CurrentUserController currentUserController =
      Get.put(CurrentUserController());

  final CategoryController categoryController = Get.put(CategoryController());
  final CartController cartController = Get.put(CartController());
  String? mytoken;
  @override
  void initState() {
    getToken();
    super.initState();
  }

  getToken() async {
    mytoken = await FirebaseMessaging.instance.getToken();
    setState(() {
      currentUserController.currentUser.value.accountToken = mytoken!;
      mytoken = mytoken;
    });
    print('==================================');
    print(currentUserController.currentUser.value.accountToken);
  }

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedSplashScreen.withScreenFunction(
        animationDuration: const Duration(milliseconds: 1500),
        splashIconSize: sp(150),
        //duration: 2,

        splash: Container(
          width: w(45),
          height: h(70),
          child: Image.asset(
            "assets/images/hasr_logolarge.png",

            fit: BoxFit.cover,
            // width: w(30),
            // height: h(70),
            //color: Colors.red,
          ),
        ),
        screenFunction: () async {
          // bool isOnline = await hasNetwork();
          // if (isOnline) {
          // unlockController.getlist();
          categoryController.getdata();
          SharedPreferences prefs = await SharedPreferences.getInstance();

          var _lang = prefs.getString('lang');
          try {
            currentUserController.currentUser.value =
                await loadUserData('user');
            cartController.getcartList();

            var locale = Locale(_lang!, _lang);
            Get.updateLocale(locale);
          } catch (e) {
            print(e);
            // removeUserData('user');
          }
          return _lang == "ar" || _lang == "en"
              ? CategoryPage()
              : TrnaslationPage();
          // } else {
          //   return NoConnectionPage();
          // }
        },
        splashTransition: SplashTransition.scaleTransition,
        //pageTransitionType: ,
        // backgroundColor: Colors.black,
      ),
    );
  }
}
