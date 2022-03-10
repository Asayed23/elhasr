import 'package:elhasr/pages/category/model/category_model.dart';
import 'package:elhasr/pages/common_widget/error_snackbar.dart';
import 'package:elhasr/pages/sub_category/model/cart_item_model.dart';
import 'package:elhasr/pages/sub_category/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:elhasr/core/db_links/db_links.dart';

import '../../Auth/controller/currentUser_controller.dart';
import '../model/subCategory_model.dart';

class CartController extends GetxController {
  var cart = CartModel().obs;
  var isLoading = false.obs;
  var cartIDList = [].obs;
  final CurrentUserController currentUserController =
      Get.put(CurrentUserController());

  @override
  void onInit() {
    super.onInit();
  }

  Future getcartList() async {
    if (currentUserController.currentUser.value.id != -1) {
      try {
        isLoading(true);
        var dio = Dio();
        cart.value = CartModel();
        var response = await dio.post(
          cartListUrl,
          data: {
            'user_id': currentUserController.currentUser.value.id.toString(),
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
          // Read Cart
          cart.value = CartModel.fromJson(response.data['cart']);
          cart.value.cartItems =
              fillCartItemFromjson(response.data['cart items']);
          List<CartItemModel> _listitems = [];
          cartIDList.value = [];
          response.data['cart items'].forEach((_itemdata) {
            final CartItemModel _item = CartItemModel.fromJson(_itemdata);
            _listitems.add(_item);
            cartIDList.add(_item.item);
          });

          cart.value.cartItems = _listitems;
        } else {
          mySnackbar('Sorry', 'No List cant be updated', false);
        }
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future addtoCart(int service_id) async {
    try {
      isLoading(true);
      var dio = Dio();
      cart.value = CartModel();
      var response = await dio.post(
        cartAddUrl,
        data: {
          'user_id': currentUserController.currentUser.value.id.toString(),
          'service_id': service_id.toString(),
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
        if (!response.data?.containsKey('message')) {
          // Read Cart
          cart.value = CartModel.fromJson(response.data['cart']);
          cart.value.cartItems =
              fillCartItemFromjson(response.data['cart items']);
          List<CartItemModel> _listitems = [];
          cartIDList.value = [];
          response.data['cart items'].forEach((_itemdata) {
            final CartItemModel _item = CartItemModel.fromJson(_itemdata);
            _listitems.add(_item);
            cartIDList.add(_item.item);
          });
          mySnackbar('Item', 'added', true);
        }
      } else {
        mySnackbar('Sorry', 'No List cant be updated', false);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future delFromCart(int service_id) async {
    try {
      isLoading(true);
      var dio = Dio();
      cart.value = CartModel();
      var response = await dio.post(
        cartDelUrl,
        data: {
          'user_id': currentUserController.currentUser.value.id.toString(),
          'service_id': service_id.toString(),
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
        getcartList();
        // // Read Cart
        // cart.value = CartModel.fromJson(response.data['cart']);
        // cart.value.cartItems =
        //     fillCartItemFromjson(response.data['cart items']);
        // List<CartItemModel> _listitems = [];
        // cartIDList.value = [];
        // response.data['cart items'].forEach((_itemdata) {
        //   final CartItemModel _item = CartItemModel.fromJson(_itemdata);
        //   _listitems.add(_item);
        //   cartIDList.add(_item.item);
        // });

        // cart.value.cartItems = _listitems;
        mySnackbar('Item', 'removed', true);
      } else {
        mySnackbar('Sorry', 'No item cannot deleted', false);
      }
    } finally {
      isLoading.value = false;
    }
  }
}
