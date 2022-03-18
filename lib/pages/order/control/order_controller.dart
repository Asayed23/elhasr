import 'package:elhasr/pages/category/model/category_model.dart';
import 'package:elhasr/pages/common_widget/error_snackbar.dart';
import 'package:elhasr/pages/sub_category/model/cart_item_model.dart';
import 'package:elhasr/pages/sub_category/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:elhasr/core/db_links/db_links.dart';

import '../../Auth/controller/currentUser_controller.dart';
import '../../sub_category/control/cart_controller.dart';

class OrderController extends GetxController {
  final CurrentUserController currentUserController =
      Get.put(CurrentUserController());

  final CartController cartController = Get.put(CartController());

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }
}
