import 'package:elhasr/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:loading_animations/loading_animations.dart';
import 'package:elhasr/pages/common_widget/local_colors.dart';
import 'package:elhasr/core/size_config.dart';
import 'package:elhasr/pages/Auth/Model/users.dart';
import 'package:elhasr/pages/Auth/controller/forgetPassword_controller.dart';
import 'package:elhasr/pages/Auth/controller/phone_controller.dart';
import 'package:elhasr/pages/Auth/controller/register_controller.dart';
import 'package:elhasr/pages/Auth/login/login_page.dart';

import 'package:elhasr/translation/translate_ctrl.dart';

import 'otp_forgetpassword.dart';
//import 'package:awesome_dialog/awesome_dialog.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final Translatectrl translatectrl = Get.put(Translatectrl());
  final RegisterController registerController = Get.put(RegisterController());
  final PhoneController phoneController = Get.put(PhoneController());

  final ForgerPassController forgerPassController =
      Get.put(ForgerPassController());

  final _formKey = GlobalKey<FormState>();
  final _formKeyotp = GlobalKey<FormState>();
  bool _isobscureText1 = true, _isobscureText2 = true;
  User _user = User();
  String _password = "";
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'SA';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      ///=======================================================================
      ///==================== Body ========================================
      ///=======================================================================
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(top: h(10), right: sp(20), left: sp(20)),
            // form
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/hasr_logo.png",
                    width: sp(60),
                    height: sp(60),
                    fit: BoxFit.cover,
                    //color: Colors.red,
                  ),

                  SizedBox(height: h(1)),

                  SizedBox(height: sp(10)),

                  ///=======================================================================
                  ///==================== Phone Number ========================================
                  ///=======================================================================
                  ///
                  IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'SA',
                    onChanged: (phone) {
                      _user.phoneNumber = phone.completeNumber.toString();
                    },
                  ),

                  SizedBox(height: sp(10)),

                  ///=======================================================================
                  ///==================== Password ========================================
                  ///=======================================================================

                  /// Password
                  TextFormField(
                    style: TextStyle(fontSize: sp(10)),
                    onSaved: (val) => _password = val!,

                    validator: (val) {
                      val!.length < 2
                          ? 'Password_too_short'.tr
                          : setState(() {
                              _password = val;
                            });
                    },
                    obscureText: _isobscureText1, // to show stars for password
                    autofocus: false,

                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'new_password'.tr,
                      filled: false,
                      fillColor: lblue,
                      prefixIcon: Icon(
                        Icons.security,
                        //color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isobscureText1 = !_isobscureText1;
                            });
                          },
                          icon: Icon(
                            _isobscureText1
                                ? Icons.visibility
                                : Icons.visibility_off,
                            //         color: Colors.white60,
                          )),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 6.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        //      borderSide: BorderSide(color: lgreen),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        //           borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),

                  ///=======================================================================
                  ///==================== Password Confirm ========================================
                  ///=======================================================================
                  SizedBox(height: sp(3)),

                  /// Password
                  TextFormField(
                    style: TextStyle(fontSize: sp(10)),
                    onSaved: (val) =>
                        forgerPassController.newPassword.value = val!,

                    validator: (val) => val!.length < 2 || val != _password
                        ? 'password_are_not_matching'.tr
                        : null,
                    obscureText: _isobscureText2, // to show stars for password
                    autofocus: false,

                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 're_enter_new_password'.tr,
                      filled: false,
                      fillColor: lblue,
                      prefixIcon: Icon(
                        Icons.security,
                        //color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isobscureText2 = !_isobscureText2;
                            });
                          },
                          icon: Icon(
                            _isobscureText2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            //             color: Colors.white60,
                          )),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 6.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        //borderSide: BorderSide(color: lgreen),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        //              borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),

                  ///=======================================================================
                  ///==================== Register button========================================
                  ///=======================================================================
                  SizedBox(height: sp(12)),
                  Obx(() => registerController.isLoading.isTrue
                      ? LoadingFlipping.circle(
                          borderColor: clickIconColor,
                          borderSize: 3.0,
                          size: sp(40),
                          //backgroundColor: Color(0xff112A04),
                          duration: Duration(milliseconds: 500),
                        )
                      : Container(
                          width: w(70),
                          child:
                              // our local Elvated Button (text , color , onpress:(){})
                              ElevatedButton(
                            child: Text('change_password'.tr,
                                style: TextStyle(fontSize: sp(20))),
                            onPressed: () async {
                              ///=====================
                              /// OTP Check ===================
                              // =======================

                              final form = _formKey.currentState;
                              if (form!.validate()) {
                                form.save();

                                // =======================
                                /// check Phonenumber and send OTP===================
                                // =======================
                                phoneController.usernum.value =
                                    _user.phoneNumber;
                                forgerPassController.resetPassword.value =
                                    _password;
                                forgerPassController
                                    .chdeck_number(_user.phoneNumber);
                                // var resp = await phoneController
                                //     .verifyPhone(_user.phoneNumber);

                                // Get.to(OtpForgetPassPage());
                              }
                            },
                          ),
                        )),
                  SizedBox(height: sp(5)),

                  ///=======================================================================
                  ///==================== Go to Signup ========================================
                  ///=======================================================================
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    TextButton(
                        onPressed: () {
                          Get.to(() => LoginPage());
                        },
                        child: Text('Go_To_sign_in_Page'.tr,
                            style: TextStyle(fontSize: sp(10)))),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
