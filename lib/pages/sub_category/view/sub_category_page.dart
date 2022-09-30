import 'package:elhasr/pages/common_widget/mybottom_bar/my_bottom_bar.dart';
import 'package:elhasr/pages/common_widget/simple_appbar.dart';
import 'package:elhasr/pages/sub_category/control/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';

import '../../../core/size_config.dart';
import '../../../core/theme.dart';
import '../control/subCategory_control.dart';
import 'show_subcategory_item.dart';

class SubCategoryPage extends StatefulWidget {
  const SubCategoryPage({Key? key}) : super(key: key);

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  final scrollController = ScrollController();
  //final SearchController searchController = Get.put(SearchController());

  final SubCategoryController subcategoryController =
      Get.put(SubCategoryController());
  String _size = '100';
  final _formKey = GlobalKey<FormState>();

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
      appBar: simplAppbar(true),
      //backgroundColor: Color.fromARGB(236, 236, 239, 239),
      body: Obx(() => RefreshIndicator(
            onRefresh: subcategoryController.getdatarefresh,
            child: subcategoryController.isLoading.value
                ? Center(
                    child: LoadingBouncingGrid.circle(
                    backgroundColor: clickIconColor,
                  ))
                : Column(children: [
                    // Row(children: [
                    //   Expanded(
                    //     flex: 6,
                    //     child: TextField(
                    //       textInputAction: TextInputAction.search,
                    //       onSubmitted: (value) {
                    //         searchController.searchWords.value.searchWord = value;
                    //         searchController.from.value = 0;
                    //         searchController.shownItems.value = [
                    //           GlobalProfileModel()
                    //         ];
                    //         searchController.getdata(false);
                    //         Get.to(() => SearchPage());
                    //       },
                    //       style: TextStyle(color: Colors.white70),
                    //       decoration: InputDecoration(
                    //           enabledBorder: OutlineInputBorder(
                    //             borderRadius:
                    //                 BorderRadius.all(Radius.circular(sp(7))),
                    //             borderSide:
                    //                 BorderSide(width: 1, color: Colors.grey.shade700),
                    //           ),
                    //           prefixIcon: Icon(
                    //             Icons.search,
                    //             color: lgreen,
                    //           ),
                    //           fillColor: Colors.black,
                    //           filled: true,
                    //           hintText:
                    //               searchController.searchWords.value.searchWord != ""
                    //                   ? searchController.searchWords.value.searchWord
                    //                   : "Search.....",
                    //           hintStyle: TextStyle(color: Colors.white),
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(sp(3)),
                    //             borderSide: BorderSide(
                    //               width: 0,
                    //               style: BorderStyle.none,
                    //             ),
                    //           )),
                    //     ),
                    //   ),
                    //   Expanded(
                    //     flex: 1,
                    //     child: IconButton(
                    //       onPressed: () {
                    //         //   Get.to(() => FilterSearch());
                    //       },
                    //       icon: FaIcon(
                    //         FontAwesomeIcons.filter,
                    //         color: Colors.white,
                    //         //size: 100,
                    //       ),
                    //     ),
                    //   ),
                    // ]),
                    SizedBox(
                      height: h(8),
                      child: ListTile(
                          trailing: Text(
                            'edit'.tr,
                            style: TextStyle(color: textbuttonColor),
                          ),
                          leading: FaIcon(FontAwesomeIcons.houseUser),
                          title: Text('myarea_size_price'.tr +
                              ' ${currentUserController.currentUser.value.villaArea.toString()} (m2)'),
                          onTap: () async {
                            Get.defaultDialog(
                                backgroundColor: Colors.white.withOpacity(0.9),
                                title: '',
                                content: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty ||
                                              int.parse(value) < 20) {
                                            return 'less_size_100'.tr;
                                          }
                                          return null;
                                        },
                                        initialValue: currentUserController
                                            .currentUser.value.villaArea
                                            .toString(),
                                        onChanged: ((value) {
                                          setState(() {
                                            _size = value;
                                          });
                                        }),
                                        keyboardType: TextInputType.number,
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                            labelText:
                                                'enter_size'.tr + ' (m2)',
                                            hintMaxLines: 1,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green,
                                                    width: 4.0))),
                                      ),
                                      SizedBox(
                                        height: h(2),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          final form = _formKey.currentState;
                                          if (form!.validate()) {
                                            form.save();

                                            if (_size != "") {
                                              currentUserController
                                                  .currentUser
                                                  .value
                                                  .villaArea = int.parse(_size);

                                              currentUserController
                                                  .updateUserData(
                                                      currentUserController
                                                          .currentUser.value);
                                              subCategoryController
                                                  .getsubcategorydata(
                                                      subCategoryController
                                                          .selecteditem);
                                              Navigator.of(context).pop();
                                              // Get.to(() => const UserProfilePage());

                                              setState(() {
                                                currentUserController
                                                        .currentUser
                                                        .value
                                                        .villaArea =
                                                    int.parse(_size);
                                              });

                                              //Get.back();
                                            }
                                          }
                                        },
                                        child: Text('update_size'.tr),
                                      )
                                    ],
                                  ),
                                ),
                                radius: 10.0);
                          }),
                    ),
                    Divider(),
                    SizedBox(
                        height: h(4),
                        child: Text(
                          'select'.tr,
                          style: TextStyle(fontSize: sp(12)),
                        )),
                    Expanded(
                      child: GridView.builder(
                          controller: scrollController,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 2.2 / 1,

                            // maxCrossAxisExtent: sp(200),
                            //  childAspectRatio: 1 / 2,
                            // crossAxisSpacing: sp(0.5),
                            // mainAxisSpacing: sp(0.5)),
                          ),
                          itemCount:
                              subcategoryController.shownsubCatgeroy.length - 1,
                          itemBuilder: (BuildContext ctx, index) {
                            return showSubCategoryItem(
                                subcategoryController
                                    .shownsubCatgeroy[index + 1],
                                index + 1);
                          }),
                    ),
                    SizedBox(height: h(4))
                  ]),
          )),
      bottomNavigationBar: mybottomBarWidget(),
    );
  }
}
