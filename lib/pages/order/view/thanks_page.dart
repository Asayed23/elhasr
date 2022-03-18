import 'dart:ui';

import 'package:elhasr/core/theme.dart';
import 'package:elhasr/pages/common_widget/mybottom_bar/my_bottom_bar.dart';
import 'package:elhasr/pages/sub_category/control/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/size_config.dart';
import '../../common_widget/local_colors.dart';
import '../../sub_category/control/subCategory_control.dart';
import '../control/send_data_whatsapp.dart';
import 'order_cart_item.dart';

class ThanksPage extends StatefulWidget {
  const ThanksPage({Key? key}) : super(key: key);

  @override
  _ThanksPageState createState() => _ThanksPageState();
}

class _ThanksPageState extends State<ThanksPage> {
  final scrollController = ScrollController();
  //final SearchController searchController = Get.put(SearchController());
  String _number = "+201022645564", _offer = "";

  final CartController cartController = Get.put(CartController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      cartController.getcartList();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      //appBar: AppBar(),
      body: Center(child: Text('Thanks'.tr)),
      bottomNavigationBar: mybottomBarWidget(),
    );
  }
}
