import 'package:elhasr/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:elhasr/core/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

simplAppbar(bool showbackbutton) {
  return AppBar(
    automaticallyImplyLeading: showbackbutton,

    iconTheme: IconThemeData(
      color: Colors.black, //change your color here
    ),
    backgroundColor: backgroundColor, // 1
    //elevation: 0, // 2
    title: Image.asset(
      "assets/images/hasr_logo.png",
      width: sp(40),
      height: sp(40),
      //color: Colors.red,
    ),
    centerTitle: true,
  );
}
