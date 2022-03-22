import 'package:elhasr/pages/category/model/category_model.dart';
import 'package:elhasr/pages/common_widget/error_snackbar.dart';
import 'package:elhasr/pages/sub_category/view/sub_category_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:elhasr/core/db_links/db_links.dart';

import '../../Auth/controller/currentUser_controller.dart';
import '../model/subCategory_model.dart';

class SubCategoryController extends GetxController {
  ///===============================================================
  /// variableds (from , to , showitems "PlayerProfile" , isloading)
  /// functions getdata () , update  showitems "PlayerProfile"  it uess unifyfunction
  ///
  ///===============================================

  var selecteditem = -1.obs;
  var categoryimage = "".obs;
  var from = 0.obs;
  int _step = 30;
  var shownsubCatgeroy = [SubCategoryModel()].obs;
  var selectsubCategory = SubCategoryModel().obs;
  var isLoading = false.obs;
  final CurrentUserController currentUserController =
      Get.put(CurrentUserController());

  @override
  void onInit() {
    super.onInit();
  }

  Future getdatarefresh() async {
    shownsubCatgeroy.value = [SubCategoryModel()];
    from.value = 0;
    // unlockController.getlist();
    getsubcategorydata(selecteditem);
  }

  Future getsubcategorydata(int id) async {
    try {
      isLoading(true);
      Get.to(() => const SubCategoryPage());
      var dio = Dio();
      shownsubCatgeroy.value = [SubCategoryModel()];
      var response = await dio.post(
        subcategoryUrl,
        data: {
          'category_id': id.toString(),
          'size': currentUserController.currentUser.value.villaArea.toString(),
          // 'from': from.value.toString(),
          // 'to': (from.value + _step).toString()

          // 'from': 0,
          // 'to': 100000000,
        },
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 800;
          },
          //headers: {},
        ),
      );
      // var _list = unlockController.unlocklists.value;
      if (response.statusCode == 200) {
        // from.value = from.value + _step;
        // print(response.data["length"].toString());
        //totalListLen.value = response.data['length'];

        for (var dic in response.data)
        // item.forEach((k, v) {
        //   if (k == "playerId") {
        //     shownCatgeroy.add(v);
        //   }
        // }
        {
          // list.contains(x);
          // dic['unlock'] = _list[dic['accountType']].contains(dic['accountId']);
          shownsubCatgeroy.add(SubCategoryModel.fromJson(dic));
        }
      } else {
        mySnackbar('error', 'canot_upload_subcategory', false);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
