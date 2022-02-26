import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:loading_animations/loading_animations.dart';

import 'package:elhasr/pages/common_widget/local_colors.dart';

import 'package:elhasr/core/size_config.dart';
import 'package:elhasr/pages/Auth/controller/currentUser_controller.dart';
import 'package:elhasr/pages/Auth/controller/login_controller.dart';
import 'package:elhasr/pages/Auth/login/forget_password.dart';
import 'package:elhasr/pages/Auth/register/ploicy.dart';
import 'package:elhasr/pages/Auth/register/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = Get.put(LoginController());

  final _formKey = GlobalKey<FormState>();
  bool _isobscureText = true;
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'SA';

  final CurrentUserController currentUserController =
      Get.put(CurrentUserController());

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
    return Scaffold(
      ///=======================================================================
      ///==================== Body ========================================
      ///=======================================================================
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: sp(40), right: sp(20), left: sp(20)),
          child: Form(
            key: _formKey,
            child: Column(
              ///=======================================================================
              ///==================== Logo  ========================================
              ///=======================================================================
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/app_logo.jpg",
                  width: sp(80),
                  height: sp(80),
                  //color: Colors.red,
                ),
                // SvgPicture.asset(
                //   "assets/images/sportive1.svg",
                //   width: sp(50),
                //   height: sp(50),
                // ),
                // SizedBox(height: h(1)),

                SizedBox(height: sp(10)),

                ///=======================================================================
                ///==================== Phone Number ========================================
                ///=======================================================================
                ///
                IntlPhoneField(
                  decoration: const InputDecoration(
                    labelText: 'Phone_Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'SA',
                  onChanged: (phone) {
                    loginController.phone.value =
                        phone.completeNumber.toString();
                    // print(phone.completeNumber);
                  },
                ),
                // InternationalPhoneNumberInput(
                //   hintText: "Phone_Number".tr,
                //   onInputChanged: (PhoneNumber number) {
                //     print(number.phoneNumber);
                //     print(number.isoCode);
                //     loginController.phone.value =
                //         number.phoneNumber.toString();
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
                //   textStyle: TextStyle(fontSize: sp(10)),
                //   autoValidateMode: AutovalidateMode.disabled,
                //   selectorTextStyle: TextStyle(fontSize: sp(10)),
                //   initialValue: number,
                //   textFieldController: controller,
                //   formatInput: false,
                //   keyboardType: TextInputType.numberWithOptions(
                //       signed: true, decimal: true),
                //   inputBorder: OutlineInputBorder(),
                //   onSaved: (PhoneNumber number) {
                //     print('On Saved: $number');
                //     loginController.phone.value =
                //         number.phoneNumber.toString();
                //   },
                // ),

                SizedBox(height: sp(10)),

                ///=======================================================================
                ///==================== Password ========================================
                ///=======================================================================

                /// Password
                TextFormField(
                  style: TextStyle(
                    fontSize: sp(12),
                  ),
                  onSaved: (val) => loginController.password.value = val!,

                  validator: (val) =>
                      val!.length < 2 ? 'Password_too_short'.tr : null,
                  obscureText: _isobscureText, // to show stars for password
                  autofocus: false,

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password'.tr,
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
                          color: Colors.white60,
                        )),
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 6.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      //borderSide: BorderSide(color: lgreen),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: sp(12)),

                ///=======================================================================
                ///==================== Forget Password ========================================
                ///=======================================================================
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  TextButton(
                      onPressed: () {
                        Get.to(() => ForgetPassword());
                      },
                      child: Text('forget_password'.tr,
                          style: TextStyle(fontSize: sp(10)))),
                ]),

                ///=======================================================================
                ///==================== Login ========================================
                ///=======================================================================
                SizedBox(height: sp(12)),
                Obx(() => loginController.isLoading.isTrue
                    ? LoadingFlipping.circle(
                        borderColor: lgreen,
                        borderSize: 3.0,
                        size: sp(20),
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

                            final form = _formKey.currentState;
                            if (form!.validate()) {
                              form.save();
                              await loginController.checkuser();
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
                        Get.to(() => PloicyPage());
                      },
                      child: Text('No_account_register'.tr,
                          style: TextStyle(fontSize: sp(10)))),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
