import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:elhasr/pages/category/view/category.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../core/size_config.dart';
import '../Auth/controller/currentUser_controller.dart';
import '../Auth/controller/sharedpref_function.dart';
import '../category/control/category_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final CurrentUserController currentUserController =
      Get.put(CurrentUserController());

  final CategoryController categoryController = Get.put(CategoryController());

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
        animationDuration: const Duration(seconds: 2),

        splash: SizedBox(
          height: h(50),
          child: ListView(children: [
            // "assets/images/logigif.gif",

            Image.asset(
              "assets/images/app_logo.jpg",
              width: sp(120),
              height: sp(120),
              //color: Colors.red,
            ),
            // SvgPicture.asset("assets/images/mylogo.svg",
            //     width: sp(80), height: sp(90)),
            const Text('Elhasr'),
          ]),
        ),
        screenFunction: () async {
          // bool isOnline = await hasNetwork();
          // if (isOnline) {
          // unlockController.getlist();
          categoryController.getdata();
          // homeController.getdata();

          try {
            currentUserController.currentUser.value =
                await loadUserData('user');
          } catch (e) {
            removeUserData('user');
          }
          return CategoryPage();
          // } else {
          //   return NoConnectionPage();
          // }
        },
        splashTransition: SplashTransition.rotationTransition,
        //pageTransitionType: PageTransitionType.scale,
        // backgroundColor: Colors.black,
      ),
    );
  }
}
