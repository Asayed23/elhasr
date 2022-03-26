import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:elhasr/pages/category/view/category.dart';

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
        animationDuration: const Duration(seconds: 3),

        splash: Image.asset(
          "assets/images/hasr_logo.png",
          width: w(30),
          height: h(30),
          fit: BoxFit.cover,
          //color: Colors.red,
        ),
        screenFunction: () async {
          // bool isOnline = await hasNetwork();
          // if (isOnline) {
          // unlockController.getlist();
          categoryController.getdata();

          try {
            currentUserController.currentUser.value =
                await loadUserData('user');
            cartController.getcartList();

            SharedPreferences prefs = await SharedPreferences.getInstance();

            var _lang = prefs.getString('lang');
            var locale = Locale(_lang!, _lang);
            Get.updateLocale(locale);
          } catch (e) {
            print(e);
            // removeUserData('user');
          }
          return CategoryPage();
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
