import 'package:flutter/material.dart';
import 'package:elhasr/core/size_config.dart';

simplAppbar() {
  return AppBar(
    backgroundColor: Colors.black, // 1
    //elevation: 0, // 2
    title: Image.asset(
      "assets/images/logo_photo.png",
      width: sp(80),
      height: sp(80),
      //color: Colors.red,
    ),
    centerTitle: true,
  );
}
