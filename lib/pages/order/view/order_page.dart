import 'package:elhasr/pages/common_widget/mybottom_bar/my_bottom_bar.dart';
import 'package:elhasr/pages/sub_category/control/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/size_config.dart';
import '../../sub_category/control/subCategory_control.dart';
import 'order_cart_item.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final scrollController = ScrollController();
  //final SearchController searchController = Get.put(SearchController());

  final CartController cartController = Get.put(CartController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      //  cartController.getcartList();
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
      appBar: AppBar(),
      body: Obx(() => RefreshIndicator(
            onRefresh: cartController.getcartList,
            child: Column(children: [
              SizedBox(
                height: h(2),
              ),
              Expanded(
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: cartController.cart.value.cartItems.length,
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
