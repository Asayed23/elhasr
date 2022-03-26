import 'package:elhasr/pages/category/model/category_model.dart';
import 'package:elhasr/pages/common_widget/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:elhasr/core/db_links/db_links.dart';

class CategoryController extends GetxController {
  ///===============================================================
  /// variableds (from , to , showitems "PlayerProfile" , isloading)
  /// functions getdata () , update  showitems "PlayerProfile"  it uess unifyfunction
  ///
  ///===============================================
  var totalListLen = 1.obs;
  var currentListLen = 0.obs;
  var selecteditem = -1.obs;
  var from = 0.obs;
  int _step = 30;
  var shownCatgeroy = [CategoryModel()].obs;
  var isLoading = false.obs;
  // final UnlockController unlockController = Get.put(UnlockController());

  @override
  void onInit() {
    super.onInit();
  }

  Future getdatarefresh() async {
    shownCatgeroy.value = [CategoryModel()];
    from.value = 0;
    // unlockController.getlist();
    getdata();
  }

  Future getdata() async {
    try {
      isLoading(true);
      var dio = Dio();
      shownCatgeroy.value = [CategoryModel()];
      var response = await dio.post(
        categoryUrl,
        data: {
          // 'from': from.value.toString(),
          // 'to': (from.value + _step).toString()

          // 'from': 0,
          // 'to': 100000000,
        },
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
          //headers: {},
        ),
      );

      if (response.statusCode == 200) {
        for (var dic in response.data) {
          shownCatgeroy.add(CategoryModel.fromJson(dic));
        }
      } else {
        mySnackbar('Failed'.tr, 'ensure_internet_is_working'.tr, false);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
