import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  bool _isobscureText = true;
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
                  SvgPicture.asset(
                    "assets/images/mylogo.svg",
                    width: sp(60),
                    height: sp(60),
                    //color: Colors.red,
                  ),
                  SvgPicture.asset(
                    "assets/images/sportive1.svg",
                    width: sp(30),
                    height: sp(30),
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
                      print(phone.completeNumber);
                    },
                  ),
                  // InternationalPhoneNumberInput(
                  //   onInputChanged: (PhoneNumber number) {
                  //     print(number.phoneNumber);
                  //     print(number.isoCode);
                  //     _user.phoneNumber = number.phoneNumber.toString();
                  //   },
                  //   onInputValidated: (bool value) {
                  //     print(value);
                  //   },
                  //   selectorConfig: SelectorConfig(
                  //     selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  //     showFlags: true,
                  //     useEmoji: false,
                  //     setSelectorButtonAsPrefixIcon: false,
                  //   ),
                  //   ignoreBlank: false,
                  //   autoValidateMode: AutovalidateMode.disabled,
                  //   selectorTextStyle: TextStyle(fontSize: sp(10)),
                  //   textStyle: TextStyle(fontSize: sp(10)),
                  //   initialValue: number,
                  //   textFieldController: controller,
                  //   formatInput: false,
                  //   keyboardType: TextInputType.numberWithOptions(
                  //       signed: true, decimal: true),
                  //   inputBorder: OutlineInputBorder(),
                  //   onSaved: (PhoneNumber number) {
                  //     print('On Saved: $number');
                  //     _user.phoneNumber = number.phoneNumber.toString();
                  //   },
                  // ),

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
                    obscureText: _isobscureText, // to show stars for password
                    autofocus: false,

                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'New_password'.tr,
                      filled: false,
                      fillColor: lblue,
                      prefixIcon: Icon(
                        Icons.security,
                        //color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isobscureText = !_isobscureText;
                            });
                          },
                          icon: Icon(
                            _isobscureText
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
                    obscureText: _isobscureText, // to show stars for password
                    autofocus: false,

                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'reEnter_New_password'.tr,
                      filled: false,
                      fillColor: lblue,
                      prefixIcon: Icon(
                        Icons.security,
                        //color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isobscureText = !_isobscureText;
                            });
                          },
                          icon: Icon(
                            _isobscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            //             color: Colors.white60,
                          )),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 6.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: lgreen),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        //              borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
////////
                  ///
                  ///
                  // AnimatedButton(
                  //   text: 'Info Dialog fixed width and sqare buttons',
                  //   pressEvent: () {
                  //     AwesomeDialog(
                  //       context: context,
                  //       dialogType: DialogType.INFO_REVERSED,
                  //       borderSide: BorderSide(color: Colors.green, width: 2),
                  //       width: 280,
                  //       buttonsBorderRadius:
                  //           BorderRadius.all(Radius.circular(2)),
                  //       headerAnimationLoop: false,
                  //       animType: AnimType.BOTTOMSLIDE,
                  //       title: 'INFO',
                  //       desc: 'Dialog description here...',
                  //       showCloseIcon: true,
                  //       btnCancelOnPress: () {},
                  //       btnOkOnPress: () {},
                  //     )..show();
                  //   },
                  // ),

                  ///=======================================================================
                  ///==================== Register button========================================
                  ///=======================================================================
                  ///=======================================================================
                  ///==================== Register button========================================
                  ///=======================================================================
                  SizedBox(height: sp(12)),
                  Obx(() => registerController.isLoading.isTrue
                      ? LoadingFlipping.circle(
                          borderColor: lgreen,
                          borderSize: 3.0,
                          size: sp(40),
                          backgroundColor: Color(0xff112A04),
                          duration: Duration(milliseconds: 500),
                        )
                      : Container(
                          width: w(70),
                          child:
                              // our local Elvated Button (text , color , onpress:(){})
                              ElevatedButton(
                            child: Text('Change_password'.tr,
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

                                var resp = await phoneController
                                    .verifyPhone(_user.phoneNumber);

                                Get.to(OtpForgetPassPage());
                                // =======================
                                /// check OTP===================
                                // =======================

                                // Get.defaultDialog(
                                //   barrierDismissible: false,
                                //   onCancel: () {},
                                //   title: "code_check",
                                //   content: Form(
                                //     key: _formKeyotp,
                                //     child: Column(
                                //       children: [
                                //         TextFormField(
                                //             validator: (value) {
                                //               if (value == null ||
                                //                   value.isEmpty ||
                                //                   value.length < 1) {
                                //                 return 'Enter_OTP'.tr;
                                //               }
                                //               return null;
                                //             },
                                //             onSaved: (val) => phoneController
                                //                 .userotp.value = val!,
                                //             decoration: InputDecoration(
                                //               prefixIcon: Icon(
                                //                 Icons.sms,
                                //                 //color: Colors.white,
                                //               ),
                                //               border: InputBorder.none,
                                //               hintText: 'Enter_OTP'.tr,
                                //             )),
                                //         Obx(() => (phoneController
                                //                     .authStatus.value) !=
                                //                 'OTP_Sent'
                                //             ? Text(phoneController
                                //                 .authStatus.value)
                                //             : ElevatedButton(
                                //                 child: Text(
                                //                   'code_check'.tr,
                                //                 ),
                                //                 onPressed: () async {
                                //                   Navigator.of(context).pop();

                                //                   final form2 =
                                //                       _formKeyotp.currentState;
                                //                   if (form2!.validate()) {
                                //                     form2.save();
                                //                     // phoneController.verifyPhone("+201022645564");
                                //                     var otpcorrect =
                                //                         await phoneController
                                //                             .otpVerify(
                                //                                 phoneController
                                //                                     .userotp
                                //                                     .value);

                                //                     if (otpcorrect) {
                                //                       phoneController
                                //                           .otpcorrect(false);
                                //                       await forgerPassController
                                //                           .resetpassword(
                                //                               _password,
                                //                               phoneController
                                //                                   .usernum
                                //                                   .value);
                                //                     } else {
                                //                       Get.snackbar("Invalid",
                                //                           'user error');
                                //                     }
                                //                   }
                                //                 },
                                //               )),
                                //       ],
                                //     ),
                                //   ),
                                // );
                                // =======================
                                /// Save User in DB===================
                                // =======================

                                // if (otpcorrect) {
                                //   phoneController.otpcorrect(false);
                                //   await registerController
                                //       .registeruser(_user);
                                // }

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
