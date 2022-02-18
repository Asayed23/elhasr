import 'package:elhasr/pages/common_widget/mybottom_bar/my_bottom_bar.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('Category')),
      bottomNavigationBar: mybottomBarWidget(),
    );
  }
}
