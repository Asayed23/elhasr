import 'package:elhasr/pages/Auth/controller/currentUser_controller.dart';
import 'package:elhasr/pages/Auth/register/register_page.dart';
import 'package:elhasr/pages/detail/view/detail_page.dart';
import 'package:elhasr/pages/sub_category/control/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
final CurrentUserController currentUserController =
    Get.put(CurrentUserController());
final CartController cartController = Get.put(CartController());
Widget showSubCategoryItem(SubCategoryModel shownItem, int _selecteditem) {
  return GestureDetector(
    onTap: () async {
      // subCategoryController.getsubcategorydata(shownItem.id);
      // print(dbImageurl + shownItem.image);
      // subCategoryController.selecteditem = _selecteditem;
      // subCategoryController.categoryimage.value = shownItem.image;
      // Get.to(const SubCategoryPage());
      subCategoryController.selectsubCategory.value = shownItem;
      Get.to(() => DetailPage());
      // _paymentCheckController
      //     .showProfileCheking(currentProfileController.profile.value);
    },
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        // decoration: BoxDecoration(
        //     border: Border.all(
        //         width: sp(2), color: Color.fromARGB(155, 204, 229, 242)),
        //     color: Color.fromARGB(255, 223, 234, 216),
        //     borderRadius: BorderRadius.circular(10)),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20), //border corner radius
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), //color of shadow
              spreadRadius: sp(1), //spread radius
              blurRadius: sp(1), // blur radius
              offset: Offset(0, 1.4), // changes position of shadow
              //first paramerter of offset is left-right
              //second parameter is top to down
            ),
            //you can set more BoxShadow() here
          ],
        ),
        //alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: w(30),
                height: h(20),
                decoration: BoxDecoration(
                  // color: Colors.grey,
                  borderRadius: BorderRadius.circular(sp(15)),
                  // border: Border.all(
                  //   //   color: Colors.grey.shade800,
                  //   width: sp(1),
                  // ),
                ),
                child: Hero(
                  tag: shownItem.image,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      dbImageurl + shownItem.image,
                      fit: BoxFit.cover,
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
                  ),
                ),
              ),
            ),
            Container(
              width: w(50),
              height: h(20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      shownItem.name,
                      style: GoogleFonts.tajawal(
                        textStyle: TextStyle(
                            overflow: TextOverflow.fade,
                            color: Colors.blue,
                            fontSize: sp(12),
                            letterSpacing: .5),
                      ),
                    ),
                    Text(
                      shownItem.price.toString() + ' SR',
                      style: TextStyle(
                          //  color: lgreen,
                          //  fontSize: h(2),
                          fontSize: sp(10)),
                    ),
                    Obx(() => currentUserController.currentUser.value.id == -1
                        ? IconButton(
                            onPressed: () {
                              Get.to(RegisterPage());
                            },
                            icon: Icon(Icons.login))
                        : IconButton(
                            onPressed: () {
                              cartController.cartIDList
                                      .contains(shownItem.service_id)
                                  ? cartController
                                      .delFromCart(shownItem.service_id)
                                  : cartController
                                      .addtoCart(shownItem.service_id);
                            },
                            icon: cartController.cartIDList
                                    .contains(shownItem.service_id)
                                ? Icon(Icons.delete, color: Colors.red)
                                : Icon(
                                    Icons.add_chart,
                                    color: Colors.grey,
                                  )))
                  ]),
            ),
          ],
        ),
      ),
    ),
  );
}
