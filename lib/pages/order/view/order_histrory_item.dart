import 'package:elhasr/pages/detail/view/detail_page.dart';
import 'package:elhasr/pages/sub_category/control/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/db_links/db_links.dart';
import '../../../core/size_config.dart';
import '../../sub_category/control/subCategory_control.dart';
import '../../sub_category/model/cart_item_model.dart';
import '../../sub_category/view/sub_category_page.dart';
import '../model/order_history_model.dart';

//  String playerFirstName;
//   String playerLastName;
//   String nationality;
//   String birthday;
//   double height;
//   double weight;
//   String currentCountry;
//   String currentCity;
//   String game;
//   String image;
//   String gender;
final SubCategoryController subCategoryController =
    Get.put(SubCategoryController());

final CartController cartController = Get.put(CartController());
Widget showHistoryOrderItem(OrderHistoryModel shownItem) {
  return GestureDetector(
    onTap: () async {
      // Get.to(() => DetailPage());
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: w(30),
        height: h(12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(sp(8)),
          border: Border.all(
            color: Colors.grey.shade800,
            width: sp(1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('reuest_no'.tr + ' ' + shownItem.id.toString(),
                    style: TextStyle(overflow: TextOverflow.fade)),
                Text('date'.tr + ' ' + shownItem.requested_date.toString(),
                    style: TextStyle(overflow: TextOverflow.fade)),
              ],
            ),
            Text('total_price'.tr + ' ' + shownItem.final_price.toString(),
                style: TextStyle(overflow: TextOverflow.fade)),
          ],
        ),
      ),
    ),
  );
}
