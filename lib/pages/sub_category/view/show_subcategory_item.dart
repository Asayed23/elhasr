import 'package:elhasr/pages/detail/view/detail_page.dart';
import 'package:elhasr/pages/sub_category/control/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/db_links/db_links.dart';
import '../../../core/size_config.dart';
import '../../sub_category/control/subCategory_control.dart';
import '../../sub_category/view/sub_category_page.dart';

import '../model/subCategory_model.dart';

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
Widget showSubCategoryItem(SubCategoryModel shownItem, int _selecteditem) {
  return GestureDetector(
    onTap: () async {
      // subCategoryController.getsubcategorydata(shownItem.id);
      // print(dbImageurl + shownItem.image);
      // subCategoryController.selecteditem = _selecteditem;
      // subCategoryController.categoryimage.value = shownItem.image;
      // Get.to(const SubCategoryPage());
      Get.to(() => DetailPage());
      // _paymentCheckController
      //     .showProfileCheking(currentProfileController.profile.value);
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(15)),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: w(22),
              height: h(12),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(sp(8)),
                border: Border.all(
                  color: Colors.grey.shade800,
                  width: sp(1),
                ),
              ),
              child: Padding(
                  padding: EdgeInsets.all(sp(0)),
                  child: Hero(
                    tag: shownItem.image,
                    child: Image.network(
                      dbImageurl + shownItem.image,
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  )
                  //  fit: BoxFit.contain,
                  //   imageUrl: dbImageurl + shownItem.image,
                  //   progressIndicatorBuilder: (context, url, downloadProgress) =>
                  //       CircularProgressIndicator(value: downloadProgress.progress),
                  //   errorWidget: (context, url, error) => Icon(Icons.error),
                  // ),
                  ),
            ),
            Text(
              shownItem.name,
              style: TextStyle(
                  overflow: TextOverflow.fade,
                  //  color: lgreen,
                  //  fontSize: h(2),
                  fontSize: sp(10)),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text(
                shownItem.price.toString() + ' SR',
                style: TextStyle(
                    //  color: lgreen,
                    //  fontSize: h(2),
                    fontSize: sp(10)),
              ),
              Obx(() => IconButton(
                  onPressed: () {
                    cartController.cartIDList.contains(shownItem.service_id)
                        ? cartController.delFromCart(shownItem.service_id)
                        : cartController.addtoCart(shownItem.service_id);
                  },
                  icon: Icon(
                    Icons.add_chart,
                    color:
                        cartController.cartIDList.contains(shownItem.service_id)
                            ? Colors.red
                            : Colors.white,
                  )))
            ]),
          ],
        ),
      ),
    ),
  );
}
