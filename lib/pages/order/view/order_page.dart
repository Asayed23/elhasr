import 'package:elhasr/core/theme.dart';
import 'package:elhasr/pages/common_widget/mybottom_bar/my_bottom_bar.dart';
import 'package:elhasr/pages/sub_category/control/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../../core/size_config.dart';
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
  String _number = "+201022645564";
  final CartController cartController = Get.put(CartController());
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
                : cartController.cart.value.cartItems.isEmpty
                    ? Center(
                        child: Text(
                        'No_selected_items',
                        style: TextStyle(fontSize: sp(15)),
                      ))
                    : Column(children: [
                        SizedBox(
                          height: h(5),
                        ),
                        SizedBox(
                            height: h(10),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await launch(
                                        "https://wa.me/${_number}?text=Please go processed with my order number *xxxx*");
                                  },
                                  child: const Text('Submit')),
                            )),
                        Expanded(
                          child: ListView.builder(
                              controller: scrollController,
                              itemCount:
                                  cartController.cart.value.cartItems.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return showcartItemOrder(
                                    cartController.cart.value.cartItems[index]);
                              }),
                        ),
                      ]),
          )),
      bottomNavigationBar: mybottomBarWidget(),
    );
  }
}
