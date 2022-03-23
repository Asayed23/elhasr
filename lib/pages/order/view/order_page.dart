import 'dart:ui';

import 'package:elhasr/core/theme.dart';
import 'package:elhasr/pages/common_widget/mybottom_bar/my_bottom_bar.dart';
import 'package:elhasr/pages/order/control/order_controller.dart';
import 'package:elhasr/pages/order/view/thanks_page.dart';
import 'package:elhasr/pages/sub_category/control/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/size_config.dart';
import '../../common_widget/local_colors.dart';
import '../../sub_category/control/subCategory_control.dart';
import '../control/send_data_whatsapp.dart';
import 'order_cart_item.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final scrollController = ScrollController();
  //final SearchController searchController = Get.put(SearchController());
  String _number = "+201022645564", _offer = "";
  bool _showEmpty = true;

  final CartController cartController = Get.put(CartController());
  final OrderController orderController = Get.put(OrderController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      cartController.getcartList();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      //appBar: AppBar(),
      body: Obx(() => RefreshIndicator(
            onRefresh: cartController.getcartList,
            child: cartController.isLoading.value
                ? Center(
                    child: LoadingBouncingGrid.circle(
                    backgroundColor: clickIconColor,
                  ))
                : cartController.cart.value.cartItems.isEmpty & _showEmpty
                    ? Center(
                        child: Text(
                        'No_selected_items',
                        style: TextStyle(fontSize: sp(15)),
                      ))
                    : Column(children: [
                        SizedBox(
                          height: h(8),
                        ),
                        Row(children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                'request_summary'.tr,
                                style: TextStyle(fontSize: sp(15)),
                              ),
                            ),
                          ),
                        ]),
                        Expanded(
                          flex: 2,
                          child: ListView.builder(
                              shrinkWrap: true,
                              controller: scrollController,
                              itemCount:
                                  cartController.cart.value.cartItems.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return showcartItemOrder(
                                    cartController.cart.value.cartItems[index]);
                              }),
                        ),
                        Divider(thickness: sp(5)),
                        Obx(() => cartController.cart.value.discount_percent > 0
                            ? RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: sp(17),
                                      overflow: TextOverflow.fade),
                                  text: 'This item costs ',
                                  children: [
                                    TextSpan(
                                      text:
                                          '${cartController.cart.value.total_price.toString()}'
                                          ' SR',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          ' ${cartController.cart.value.total_price - (cartController.cart.value.total_price * cartController.cart.value.discount_percent / 100)}',
                                    ),
                                  ],
                                ),
                              )
                            : RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: sp(17),
                                      overflow: TextOverflow.fade),
                                  text: 'This item costs ',
                                  children: [
                                    TextSpan(
                                      text:
                                          '${cartController.cart.value.total_price.toString()}'
                                          ' SR',
                                      style: TextStyle(
                                        color: textinBodyColor,
                                        // decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        Expanded(
                            child: ListView(shrinkWrap: true, children: [
                          Row(children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TextFormField(
                                  enabled:
                                      !(cartController.cart.value.coupon_code !=
                                              "" &&
                                          cartController
                                                  .cart.value.discount_percent >
                                              0),
                                  initialValue: cartController
                                              .cart.value.coupon_code !=
                                          ""
                                      ? cartController.cart.value.coupon_code
                                      : null,
                                  onSaved: (val) => cartController
                                      .cart.value.coupon_code = val!,
                                  onChanged: (val) => cartController
                                      .cart.value.coupon_code = val,

                                  //autofocus: false,
                                  // Text Style
                                  style: TextStyle(
                                      fontSize: sp(10), color: Colors.black),
                                  // keyboardType: TextInputType.phone,
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.allow(RegExp('[0-9.,+]+'))
                                  // ],

                                  /// decoration
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.discount
                                        //color: Colors.white,
                                        ),
                                    border: InputBorder.none,
                                    hintText: 'enter_promo_code'.tr,
                                    filled: false,
                                    fillColor: lblue,
                                    contentPadding: const EdgeInsets.only(
                                        left: 4, bottom: 6.0, top: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      //  borderSide: BorderSide(color: lgreen),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      //  borderSide: const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),

                                  /// end of decoration
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Visibility(
                                  visible:
                                      !(cartController.cart.value.coupon_code !=
                                              "" &&
                                          cartController
                                                  .cart.value.discount_percent >
                                              0),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: textbuttonColor,
                                      ),
                                      onPressed: () async {
                                        cartController.Checkcubon();
                                      },
                                      child: const Text('Code_check')),
                                ),
                              ),
                            )
                          ]),
                          Padding(
                            padding: EdgeInsets.only(
                                top: h(1),
                                bottom: h(4),
                                right: sp(8),
                                left: sp(8)),
                            child: ElevatedButton(
                                onPressed: () async {
                                  cartController.createOrder();

                                  // String _textMsg =
                                  //     "Please go processed with my order number *xxxx* , total price  ${cartController.cart.value.total_price.toString()}";
                                  // if (cartController.cart.value.coupon_code !=
                                  //     "") {
                                  //   _textMsg = _textMsg +
                                  //       " with offer_code " +
                                  //       cartController.cart.value.coupon_code;
                                  // }

                                  // await launch(
                                  //     "https://wa.me/${_number}?text=Please go processed with my order number *xxxx*");

                                  // Get.off(ThanksPage());
                                },
                                child: const Text('Submit')),
                          ),
                        ]))
                      ]),
          )),
      bottomNavigationBar: mybottomBarWidget(),
    );
  }
}
