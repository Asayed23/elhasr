import 'package:badges/badges.dart';
import 'package:elhasr/pages/Auth/register/register_page.dart';

import 'package:elhasr/pages/order/view/order_page.dart';
import 'package:elhasr/pages/sub_category/control/cart_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Auth/controller/currentUser_controller.dart';
import '../../Auth/profile/profile_page.dart';
import '../../category/view/category.dart';
import 'bottom_bar_controller.dart';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';

final MyBottomBarCtrl myBottomBarCtrl = Get.put(MyBottomBarCtrl());
final CurrentUserController userctrl = Get.put(CurrentUserController());
final CartController cartController = Get.put(CartController());

mybottomBarWidget() {
  return Obx(() => ConvexAppBar.badge(
        {
          1: cartController.cartIDList.length > 0
              ? cartController.cartIDList.length.toString()
              : ''
        },
        backgroundColor: Colors.white,
        items: [
          TabItem(
            icon: Icon(Icons.home),
            title: 'Home'.tr,
          ),

          TabItem(
            icon:

                // Badge(
                //     showBadge: cartController.cartIDList.length > 0,
                //     badgeContent: Text(cartController.cartIDList.length.toString()),
                //     child:

                Icon(Icons.chat_rounded),

            //  ),
            title: 'Request'.tr,
          ),

          TabItem(
            icon: Icon(Icons.settings),
            title: 'Profile'.tr,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.chat),
          //   label: 'Chats',
          // ),
        ],
        initialActiveIndex: myBottomBarCtrl.selectedIndBottomBar.value,
        onTap: (index) {
          myBottomBarCtrl.selectedIndBottomBar.value = index;
          if (index == 0) {
            Get.to(const CategoryPage());
          } else if (index == 1) {
            Get.to(const OrderPage());
          } else if (index == 2) {
            Get.to(UserProfilePage(showbottombar: true));
          }
        },
      ));
}

mybottomBarWidget2() {
  return Obx(() => BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'.tr,
          ),

          BottomNavigationBarItem(
            icon: Badge(
                showBadge: cartController.cartIDList.length > 0,
                badgeContent: Text(cartController.cartIDList.length.toString()),
                child: Icon(Icons.remove_from_queue)),
            label: 'Requst'.tr,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Profile'.tr,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.chat),
          //   label: 'Chats',
          // ),
        ],
        currentIndex: myBottomBarCtrl.selectedIndBottomBar.value,
        onTap: (index) {
          myBottomBarCtrl.selectedIndBottomBar.value = index;
          if (index == 0) {
            Get.to(const CategoryPage());
          } else if (index == 1) {
            Get.to(const OrderPage());
          } else if (index == 2) {
            Get.to(UserProfilePage(showbottombar: true));
          }
        },
      ));
}
