import 'package:elhasr/pages/common_widget/mybottom_bar/my_bottom_bar.dart';
import 'package:elhasr/pages/common_widget/simple_appbar.dart';
import 'package:elhasr/pages/sub_category/control/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';

import '../../../core/size_config.dart';
import '../../../core/theme.dart';
import '../control/order_controller.dart';
import 'order_cart_item.dart';
import 'order_histrory_item.dart';

class OrderHistroyPage extends StatefulWidget {
  const OrderHistroyPage({Key? key}) : super(key: key);

  @override
  _OrderHistroyPageState createState() => _OrderHistroyPageState();
}

class _OrderHistroyPageState extends State<OrderHistroyPage> {
  final scrollController = ScrollController();
  //final SearchController searchController = Get.put(SearchController());

  final OrderController orderController = Get.put(OrderController());
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      orderController.getOrderList();
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
            onRefresh: orderController.getOrderList,
            child: orderController.isLoading.value
                ? Center(
                    child: LoadingBouncingGrid.circle(
                    backgroundColor: clickIconColor,
                  ))
                : Column(children: [
                    SizedBox(
                      height: h(2),
                    ),
                    Center(child: Text('Order_list'.tr)),
                    Expanded(
                      child: ListView.builder(
                          controller: scrollController,
                          itemCount: orderController.orderList.length - 1,
                          itemBuilder: (BuildContext ctx, index) {
                            return showHistoryOrderItem(
                                orderController.orderList[index + 1]);
                          }),
                    ),
                  ]),
          )),
      bottomNavigationBar: mybottomBarWidget(),
    );
  }
}
