import 'package:elhasr/pages/category/model/category_model.dart';
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

      var response = await dio.post(
        homepage_Url,
        data: {
          'from': from.value.toString(),
          'to': (from.value + _step).toString()

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
      // var _list = unlockController.unlocklists.value;
      if (response.statusCode == 200) {
        from.value = from.value + _step;
        print(response.data["length"].toString());
        totalListLen.value = response.data['length'];

        for (var dic in response.data['data'])
        // item.forEach((k, v) {
        //   if (k == "playerId") {
        //     shownCatgeroy.add(v);
        //   }
        // }
        {
          // list.contains(x);
          // dic['unlock'] = _list[dic['accountType']].contains(dic['accountId']);
          shownCatgeroy.add(CategoryModel.fromJson(dic));
        }

        // print(shownCatgeroy);
        // print(shownCatgeroy);
        //);

        // Get.snackbar('Thanks'.tr, 'fetch_Successfuly'.tr,
        //     snackPosition: SnackPosition.BOTTOM,
        //     backgroundColor: Colors.greenAccent);
        // _redirectUser();

      } else {
        _failmessage(response);
      }
    } finally {
      isLoading.value = false;
    }
  }

  _failmessage(response) async {
    isLoading(false);
    Get.snackbar('${response.data['errorCode']}', 'fetch_failed'.tr,
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
  }

  // Future getplayeridlist(_userid) async {
  //   var dio = Dio();
  //   var response = await dio.get(
  //     "$playerlist_Url${_userid.toString()}/",
  //     options: Options(
  //       followRedirects: false,
  //       validateStatus: (status) {
  //         return status! < 505;
  //       },
  //       //headers: {},
  //     ),
  //   );
  //   var playeridlist = [];
  //   if (response.statusCode == 200) {
  //     //playerId

  //     for (var item in response.data)
  //       item.forEach((k, v) {
  //         if (k == "playerId") {
  //           playeridlist.add(v);
  //         }
  //       });

  //     //_regiuser.playerId = response.data[0]['playerId'];
  //   } else {
  //     _failmessage(response);
  //   }
  //   return playeridlist;
  // }
}
