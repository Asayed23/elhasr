import 'package:elhasr/pages/category/model/category_model.dart';
import 'package:elhasr/pages/common_widget/error_snackbar.dart';
import 'package:elhasr/pages/order/model/order_history_model.dart';
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

  // final CartController cartController = Get.put(CartController());

  var isLoading = false.obs;
  var orderList = [OrderHistoryModel()].obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future getOrderList() async {
    if (currentUserController.currentUser.value.id != -1) {
      try {
        isLoading(true);
        var dio = Dio();

        var response = await dio.post(
          listordersUrl,
          data: {
            'user_id': currentUserController.currentUser.value.id,
            // 'user_id': '1',
          },
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 800;
            },
            //headers: {},
          ),
        );
        if (response.statusCode == 200) {
          orderList = [OrderHistoryModel()].obs;

          response.data['orders'].forEach((_itemdata) {
            orderList.add(OrderHistoryModel.fromJson(_itemdata));
          });
        } else {
          mySnackbar('Sorry'.tr, 'cannot_load_order'.tr, false);
        }
      } finally {
        isLoading.value = false;
      }
    }
  }
}
