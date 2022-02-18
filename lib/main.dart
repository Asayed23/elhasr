import 'package:elhasr/pages/Auth/register/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:elhasr/core/theme.dart';

import 'package:elhasr/translation/translation.dart';

import 'pages/home_page/view/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ElHasr',
      theme: LocalThemes.lightTheme,
      debugShowCheckedModeBanner: false,
      // our home page is the splash
      //home: Application(),
      home: HomePage(),
      // all the below for translating using getx
      translations: Translate(),
      // Main language ( ar & en are dictionary contains all arabic & text english )
      locale: Get.deviceLocale,
      // if there any erroe will go back to english
      fallbackLocale: const Locale('en'),
    );
  }
}
