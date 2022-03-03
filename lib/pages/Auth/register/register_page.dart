import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:loading_animations/loading_animations.dart';
import 'package:elhasr/pages/common_widget/local_colors.dart';
import 'package:elhasr/core/size_config.dart';
import 'package:elhasr/pages/Auth/Model/users.dart';
import 'package:elhasr/pages/Auth/controller/currentUser_controller.dart';
import 'package:elhasr/pages/Auth/controller/phone_controller.dart';
import 'package:elhasr/pages/Auth/controller/register_controller.dart';
import 'package:elhasr/pages/Auth/login/login_page.dart';
import 'package:elhasr/pages/Auth/register/otp_dialogue.dart';
import 'package:elhasr/pages/Auth/register/phone_handler.dart';
import 'package:elhasr/translation/translate_ctrl.dart';
import 'package:sms_autofill/sms_autofill.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Translatectrl translatectrl = Get.put(Translatectrl());
  final RegisterController registerController = Get.put(RegisterController());
  final PhoneController phoneController = Get.put(PhoneController());
  final CurrentUserController currentUserController =
      Get.put(CurrentUserController());
  final _formKey = GlobalKey<FormState>();
  final _formKeyotp = GlobalKey<FormState>();
  bool _isobscureText = true;

  String _password = "";
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'SA';

  String? mytoken;

  getToken() async {
    mytoken = await FirebaseMessaging.instance.getToken();
    setState(() {
      currentUserController.currentUser.value.accountToken = mytoken!;
      mytoken = mytoken;
    });
    print('==================================');
    print(currentUserController.currentUser.value.accountToken);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getToken();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        //decoration: ldecoration,
        child: Scaffold(
      // backgroundColor: Colors.transparent,

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
                    "assets/images/app_logo.jpg",
                    width: sp(60),
                    height: sp(60),
                    //color: Colors.red,
                  ),
                  // SvgPicture.asset(
                  //   "assets/images/sportive1.svg",
                  //   width: sp(30),
                  //   height: sp(30),
                  // ),
                  // SizedBox(height: h(1)),

                  SizedBox(height: sp(10)),

                  ///=======================================================================
                  ///==================== Name ========================================
                  ///=======================================================================
                  // Name
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 1) {
                        return 'Please_Enter_The_Name'.tr;
                      }
                      return null;
                    },
                    onSaved: (val) => registerController
                        .registeruserdata.value.fullName = val!,

                    //autofocus: false,
                    // Text Style
                    style: TextStyle(
                        fontSize: sp(10),
                        color: Color.fromARGB(255, 180, 56, 56)),
                    // keyboardType: TextInputType.phone,
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.allow(RegExp('[0-9.,+]+'))
                    // ],

                    /// decoration
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person
                          //color: Colors.white,
                          ),
                      border: InputBorder.none,
                      hintText: 'Enter_yourName'.tr,
                      filled: false,
                      fillColor: lblue,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 6.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        //  borderSide: BorderSide(color: lgreen),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        //  borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),

                    /// end of decoration
                  ),
                  SizedBox(height: sp(10)),

                  ///=======================================================================
                  ///==================== Villa Size ========================================
                  ///=======================================================================
                  // Name
                  TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.parse(value) < 80) {
                        return 'Less Size is 100 m'.tr;
                      }
                      return null;
                    },
                    onSaved: (val) => registerController.registeruserdata.value
                        .villaArea = val.toString() as int,

                    //autofocus: false,
                    // Text Style
                    style: TextStyle(
                        fontSize: sp(10),
                        color: Color.fromARGB(255, 180, 56, 56)),
                    keyboardType: TextInputType.number,
                    // inputFormatters: [
                    //   FilteringTextInputFormatter.allow(RegExp('[0-9.,+]+'))
                    // ],

                    /// decoration
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const FaIcon(FontAwesomeIcons.rulerVertical),
                      ),
                      border: InputBorder.none,
                      hintText: 'Enter Size in metere'.tr,
                      filled: false,
                      fillColor: lblue,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 6.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        //  borderSide: BorderSide(color: lgreen),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        //  borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),

                    /// end of decoration
                  ),
                  SizedBox(height: sp(10)),

                  ///=======================================================================
                  ///==================== Phone Number ========================================
                  ///=======================================================================
                  // InternationalPhoneNumberInput(
                  //   onInputChanged: (PhoneNumber number) {
                  //     print(number.phoneNumber);
                  //     print(number.isoCode);
                  //     registerController.registeruserdata.value.phoneNumber = number.phoneNumber.toString();
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
                  //     registerController.registeruserdata.value.phoneNumber = number.phoneNumber.toString();
                  //   },
                  // ),

                  IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: 'Phone_Number'.tr,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'SA',
                    onChanged: (phone) {
                      registerController.registeruserdata.value.phoneNumber =
                          phone.completeNumber.toString();
                      print(phone.completeNumber);
                    },
                  ),

                  SizedBox(height: sp(10)),

                  ///=======================================================================
                  ///==================== Email/ SocialLink ========================================
                  ///=======================================================================
                  // Name

                  ///=======================================================================
                  ///==================== Password ========================================
                  ///=======================================================================

                  /// Password
                  TextFormField(
                    style: TextStyle(
                        fontSize: sp(10),
                        color: Color.fromARGB(255, 180, 56, 56)),
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
                      hintText: 'password'.tr,
                      filled: false,
                      // fillColor: lblue,
                      prefixIcon: const Icon(
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
                            //   color: Colors.white60,
                          )),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 6.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        //borderSide: BorderSide(color: lgreen),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        //  borderSide: const BorderSide(color: Colors.grey),
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
                    style: TextStyle(
                        fontSize: sp(10),
                        color: Color.fromARGB(255, 180, 56, 56)),
                    onSaved: (val) => registerController
                        .registeruserdata.value.password = val!,

                    validator: (val) => val!.length < 2 || val != _password
                        ? 'password_are_not_matching'.tr
                        : null,
                    obscureText: _isobscureText, // to show stars for password
                    autofocus: false,

                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'reenter_password'.tr,
                      filled: false,
                      fillColor: lblue,
                      prefixIcon: const Icon(
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
                            // color: Colors.white60,
                          )),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 6.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        // borderSide: BorderSide(color: lgreen),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        //  borderSide: const BorderSide(color: Colors.grey),
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
                          borderColor: lgreen,
                          borderSize: 3.0,
                          size: sp(40),
                          backgroundColor: const Color(0xff112A04),
                          duration: const Duration(milliseconds: 500),
                        )
                      : SizedBox(
                          width: w(60),
                          child:
                              // our local Elvated Button (text , color , onpress:(){})
                              ElevatedButton(
                            child: Text('Sign_up'.tr,
                                style: TextStyle(fontSize: sp(20))),
                            onPressed: () async {
                              ///=====================
                              /// OTP Check ===================
                              // =======================

                              final form = _formKey.currentState;
                              if (form!.validate()) {
                                form.save();
                                // await registerController.registeruser();
                                // Get.to(() => PhoneSMSHandler());

                                // =======================
                                /// check Phonenumber and send OTP===================
                                // =======================

                                // phoneController.usernum.value =
                                //     registerController
                                //         .registeruserdata.value.phoneNumber;
                                var resp = await phoneController.verifyPhone(
                                    registerController
                                        .registeruserdata.value.phoneNumber);
                                await SmsAutoFill().listenForCode;
                                Get.to(const OtpDialogue());

                                // =======================
                                /// check OTP===================
                                // =======================

                                // Get.defaultDialog(
                                //   barrierDismissible: false,
                                //   onCancel: () {},
                                //   title: "OTP_Check",
                                //   content: Form(
                                //     key: _formKeyotp,
                                //     child: Column(
                                //       children: [
                                //         TextFormField(
                                //             validator: (value) {
                                //               if (value == null ||
                                //                   value.isEmpty ||
                                //                   value.length < 2) {
                                //                 return 'Enter_OTP'.tr;
                                //               }
                                //               return null;
                                //             },
                                //             onSaved: (val) => phoneController
                                //                 .userotp.value = val!,
                                //             decoration: InputDecoration(
                                //               prefixIcon: const Icon(
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
                                //                   'OTP_Check'.tr,
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
                                //                       await registerController
                                //                           .registeruser();
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
                                // / Save User in DB===================
                                // =======================

                                // if (otpcorrect) {
                                //   phoneController.otpcorrect(false);
                                //   await registerController
                                //       .registeruser(registerController.registeruserdata.value);
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
                        child: Text('Already_have_an_account_sign_in'.tr,
                            style: TextStyle(fontSize: sp(10)))),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
