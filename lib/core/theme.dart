import 'package:flutter/material.dart';

import 'package:elhasr/pages/common_widget/local_colors.dart';

//https://api.flutter.dev/flutter/material/ThemeData-class.html

var clickIconColor = Color.fromARGB(255, 18, 74, 117);

class LocalThemes {
  static final darkTheme = ThemeData(
      // background color
      //scaffoldBackgroundColor: Colors.grey.shade900,
      // accentColor: lgreen,
      // appbar color
      // primaryColor: Colors.black,
      colorScheme: ColorScheme.light(),
      iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
// Text Styles

      textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        subtitle1: TextStyle(
          color: Colors.white,
        ),
      ),

// text button theme
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: lgreen,
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      )),
      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              primary: lgreen, // background color
              textStyle: TextStyle(
                color: Colors.white,
                // fontStyle: FontStyle.italic,
              ))),
      // outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(15),
        textStyle: TextStyle(),
      )));

  static final lightTheme = ThemeData(
    colorScheme:
        const ColorScheme.light(primary: Color.fromARGB(255, 230, 159, 52)),
    iconTheme: const IconThemeData(color: Color.fromARGB(255, 230, 159, 52)),
    primaryIconTheme:
        const IconThemeData(color: Color.fromARGB(255, 230, 159, 52)),

    primarySwatch: Colors.indigo,
    //ElvatedButton theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            primary: clickIconColor, // background color
            textStyle: const TextStyle(
              color: Colors.white,
              // fontStyle: FontStyle.italic,
            ))),

// Text in body

    textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.black)),

    // text button theme
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      primary: Color.fromARGB(255, 230, 159, 52),
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
    )),
  );
}
