import 'dart:developer';

import 'package:elhasr/pages/category/view/category.dart';
import 'package:elhasr/pages/home_page/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/size_config.dart';
import '../common_widget/mybottom_bar/bottom_bar_controller.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  List<Slide> slides = [];
  final MyBottomBarCtrl myBottomBarCtrl = Get.put(MyBottomBarCtrl());

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        styleTitle: TextStyle(color: const Color(0xff203152), fontSize: sp(20)),
        styleDescription:
            TextStyle(color: const Color(0xff203152), fontSize: sp(15)),
        title: "الحصر",
        description: "شركة الحصر متخصصه فى مواد البناء",
        pathImage: "assets/images/hasr_logolarge.png",
        backgroundColor: Color.fromARGB(255, 220, 220, 211),
      ),
    );

    slides.add(
      Slide(
        title: "مدنى",
        description: "تقديم خدمات البناء المميزه بافضل اسعار واعلى جوده",
        pathImage: "assets/images/civil.jpg",
        backgroundColor: const Color(0xff203152),
      ),
    );
    slides.add(
      Slide(
        title: "معمارى",
        description: "تقديم خدمات البناء المميزه بافضل اسعار واعلى جوده",
        pathImage: "assets/images/arch.jpg",
        backgroundColor: const Color(0xff203152),
      ),
    );
    slides.add(
      Slide(
        title: "كهرباء",
        description: "تقديم خدمات البناء المميزه بافضل اسعار واعلى جوده",
        pathImage: "assets/images/electric.jpg",
        backgroundColor: const Color(0xff203152),
      ),
    );

    slides.add(
      Slide(
        title: "سباكه",
        description: "تقديم خدمات البناء المميزه بافضل اسعار واعلى جوده",
        pathImage: "assets/images/plumb.jpg",
        backgroundColor: const Color(0xff203152),
      ),
    );
  }

  void onDonePress() {
    // Do what you want
    Get.to(CategoryPage());
  }

  Future<void> onSkipPress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('skip', 'yes');
    myBottomBarCtrl.selectedIndBottomBar.value = 0;
    Get.to(CategoryPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroSlider(
        slides: slides,
        // isScrollable: false,
        onSkipPress: onSkipPress,
        onDonePress: onDonePress,
        showDotIndicator: false,
      ),
    );
  }
}
