import 'dart:io';

import 'package:elhasr/pages/common_widget/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

sendtowhatsapp(String textdata) async {
  var whatsapp = "+201012993024";
  // var whatsappURl_android =
  //     "whatsapp://send?phone=" + whatsapp + "&text=$textdata";
  var whatsappURl_android = "https://wa.me/$whatsapp?text=$textdata";
  var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("$textdata")}";

  whatsappURl_android = whatsappURl_android.replaceAll(" ", "%20");
  if (Platform.isIOS) {
    // for iOS phone only
    if (await canLaunch(whatappURL_ios)) {
      await launch(whatappURL_ios, forceSafariVC: false);
    } else {
      mySnackbar('error', 'whats_not_intsalled', false);
    }
  } else {
    // android , web
    if (await canLaunch(whatsappURl_android)) {
      await launch(whatsappURl_android);
    } else {
      mySnackbar('error'.tr, 'whats_not_intsalled'.tr, false);
    }
  }
}
