import 'package:elhasr/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:elhasr/core/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

simplAppbar() {
  return AppBar(
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
