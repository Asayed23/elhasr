import 'package:elhasr/pages/common_widget/mybottom_bar/my_bottom_bar.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('Order')),
      bottomNavigationBar: mybottomBarWidget(),
    );
  }
}
