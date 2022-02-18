import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:elhasr/pages/Auth/register/register_page.dart';
import 'package:elhasr/pages/home_page/view/home_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../core/size_config.dart';
import '../Auth/controller/currentUser_controller.dart';
import '../Auth/controller/sharedpref_function.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final CurrentUserController currentUserController =
      Get.put(CurrentUserController());

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
        animationDuration: Duration(seconds: 2),

        splash: Container(
          height: h(50),
          child: ListView(children: const [
            // "assets/images/logigif.gif",

            // SvgPicture.asset("assets/images/mylogo.svg",
            //     width: sp(80), height: sp(90)),
            Text('Hello'),
          ]),
        ),
        screenFunction: () async {
          // bool isOnline = await hasNetwork();
          // if (isOnline) {
          // unlockController.getlist();
          // favController.getdata();
          // homeController.getdata();

          try {
            currentUserController.currentUser.value =
                await loadUserData('user');
          } catch (e) {
            removeUserData('user');
          }
          return RegisterPage();
          // } else {
          //   return NoConnectionPage();
          // }
        },
        splashTransition: SplashTransition.rotationTransition,
        //pageTransitionType: PageTransitionType.scale,
        backgroundColor: Colors.black,
      ),
    );
  }
}
