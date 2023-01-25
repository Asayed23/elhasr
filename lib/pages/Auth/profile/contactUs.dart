import 'package:elhasr/pages/common_widget/simple_appbar.dart';
import 'package:elhasr/pages/order/control/send_data_whatsapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widget/mybottom_bar/my_bottom_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simplAppbar(true),
      body: Center(
          child: TextButton(
        onPressed: () {
          sendtowhatsapp('hi');
        },
        child: Text('contact us'),
      )),
      bottomNavigationBar: mybottomBarWidget(),
    );
  }
}
