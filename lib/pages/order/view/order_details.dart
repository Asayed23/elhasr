import 'dart:ui';

import 'package:elhasr/core/theme.dart';
import 'package:elhasr/pages/common_widget/mybottom_bar/my_bottom_bar.dart';
import 'package:elhasr/pages/common_widget/simple_appbar.dart';
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

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final scrollController = ScrollController();
  //final SearchController searchController = Get.put(SearchController());

  bool _showEmpty = true;

  final CartController cartController = Get.put(CartController());
  final OrderController orderController = Get.put(OrderController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      cartController.getcartHistoryList();
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
      appBar: simplAppbar(true),
      body: Obx(() => RefreshIndicator(
            onRefresh: cartController.getcartList,
            child: cartController.isLoading.value
                ? Center(
                    child: LoadingBouncingGrid.circle(
                    backgroundColor: clickIconColor,
                  ))
                : cartController.cart.value.cartItems.isEmpty & _showEmpty
                    ? Center(
                        child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'No_selected_items'.tr,
                          style: TextStyle(fontSize: sp(15)),
                        ),
                      ))
                    : Column(children: [
                        SizedBox(
                          height: h(3),
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
                          Expanded(
                            child: Center(
                              child: Text(
                                cartController.cart.value.requested_date,
                                style: TextStyle(fontSize: sp(10)),
                              ),
                            ),
                          ),
                        ]),
                        Expanded(
                          flex: 3,
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
                        Divider(thickness: sp(2)),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: sp(17),
                                  overflow: TextOverflow.fade),
                              text: 'total_items_cost'.tr,
                              children: [
                                TextSpan(
                                  text:
                                      '${cartController.cart.value.final_price.toString()}'
                                      ' SR',
                                  style: TextStyle(fontSize: sp(20)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
          )),
      bottomNavigationBar: mybottomBarWidget(),
    );
  }
}
