import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:elhasr/pages/common_widget/local_colors.dart';
import 'package:elhasr/core/size_config.dart';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';

import 'package:elhasr/pages/Auth/controller/login_controller.dart';
import 'package:elhasr/pages/Auth/controller/phone_controller.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _formKey = GlobalKey<FormState>();
  final LoginController loginController = Get.put(LoginController());
  final PhoneController phoneController = Get.put(PhoneController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.transparent,

      ///=======================================================================
      ///==================== Appbar ========================================
      ///=======================================================================
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   //backgroundColor: Color(0x44000000),
      //   elevation: 0,
      //   //  title: Text("Title"),
      // ),

      ///=======================================================================
      ///==================== Body ========================================
      ///=======================================================================

      body: Container(
        height: h(110),
        decoration: ldecoration,
        child: Padding(
          padding: EdgeInsets.only(top: sp(40), right: sp(20), left: sp(20)),
          // form
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/mylogo.svg",
                    width: sp(100),
                    height: sp(100),
                    //color: Colors.red,
                  ),
                  SvgPicture.asset(
                    "assets/images/sportive1.svg",
                    width: sp(60),
                    height: sp(70),
                  ),
                  SizedBox(height: h(1)),
                  Text(loginController.userctrl.currentUser.value.phoneNumber),

                  SizedBox(height: sp(10)),

                  ///=======================================================================
                  ///==================== OTP ========================================
                  ///=======================================================================
                  // Name
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 1) {
                        return 'Enter_OTP'.tr;
                      }
                      return null;
                    },
                    onSaved: (val) => phoneController.userotp.value = val!,

                    //autofocus: false,
                    // Text Style
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.,+]+'))
                    ],

                    /// decoration
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.call,
                        //color: Colors.white,
                      ),
                      border: InputBorder.none,
                      hintText: 'Enter_OTP'.tr,
                      filled: false,
                      fillColor: lblue,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 6.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: lgreen),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),

                    /// end of decoration
                  ),

                  SizedBox(height: sp(10)),

                  ElevatedButton(
                    child:
                        Text('send OTP'.tr, style: TextStyle(fontSize: sp(20))),
                    onPressed: () async {
                      //Get.to(()=>MainProfilePage());
                      // phoneController.verifyPhone(loginController
                      //     .userctrl.currentUser.value.phoneNumber);

                      phoneController.verifyPhone("+201022645564");
                    },
                  ),

                  ///=======================================================================
                  ///==================== Login ========================================
                  ///=======================================================================
                  SizedBox(height: sp(12)),
                  Obx(() => loginController.isLoading.isTrue
                      ? LoadingFlipping.circle(
                          borderColor: lgreen,
                          borderSize: 3.0,
                          size: sp(40),
                          backgroundColor: Color(0xff112A04),
                          duration: Duration(milliseconds: 500),
                        )
                      : Container(
                          width: w(40),
                          child:
                              // our local Elvated Button (text , color , onpress:(){})
                              ElevatedButton(
                            child: Text('Login'.tr,
                                style: TextStyle(fontSize: sp(20))),
                            onPressed: () async {
                              //Get.to(()=>MainProfilePage());
                              // phoneController.verifyPhone(loginController
                              //     .userctrl.currentUser.value.phoneNumber);
                              final form = _formKey.currentState;
                              if (form!.validate()) {
                                form.save();
                                // phoneController.verifyPhone("+201022645564");
                                phoneController
                                    .otpVerify(phoneController.userotp.value);
                              }
                            },
                          ),
                        )),
                  SizedBox(height: sp(5)),

                  ///=======================================================================
                  ///==================== Go to Signup ========================================
                  ///=======================================================================
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
