import 'package:elhasr/pages/common_widget/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:elhasr/pages/common_widget/local_colors.dart';
import 'package:elhasr/core/size_config.dart';
import 'package:elhasr/pages/common_widget//simple_appbar.dart';
import 'package:elhasr/pages/Auth/controller/phone_controller.dart';
import 'package:elhasr/pages/Auth/controller/register_controller.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpDialogue extends StatefulWidget {
  const OtpDialogue({Key? key}) : super(key: key);

  @override
  _OtpDialogueState createState() => _OtpDialogueState();
}

class _OtpDialogueState extends State<OtpDialogue> {
  final _formKey = GlobalKey<FormState>();
  final PhoneController phoneController = Get.put(PhoneController());
  final RegisterController registerController = Get.put(RegisterController());
  final _formKeyotp = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _listeOTP();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: simplAppbar(),
      // backgroundColor: Colors.transparent,
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.,
            children: [
              ///=======================================================================
              ///==================== OTP ========================================
              ///=======================================================================
              // Name
              SizedBox(height: h(20)),
              Obx(() => Visibility(
                  visible: phoneController.authStatus.value ==
                      'Please Wait. Sending SMS..',
                  child: Center(
                      child: LoadingBouncingGrid.circle(
                    backgroundColor: lgreen,
                  )))),
              SizedBox(height: h(8)),

              Obx(() => Visibility(
                  visible: phoneController.authStatus.value == 'OTP_Sent',
                  child: const Text('Enter Code'))),

              Obx(() => Visibility(
                  visible: phoneController.authStatus.value == 'OTP_Sent',
                  child: const Divider())),
              Obx(() => Visibility(
                    visible: phoneController.authStatus.value == 'OTP_Sent',
                    child:
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(9),
                        //       color: lgreen2,
                        //       boxShadow: [
                        //         BoxShadow(color: lgreen, spreadRadius: 1),
                        //       ],
                        //     ),
                        //     child: TextFormField(
                        //         validator: (value) {
                        //           if (value == null ||
                        //               value.isEmpty ||
                        //               value.length < 1) {
                        //             return 'Enter_OTP'.tr;
                        //           }
                        //           return null;
                        //         },
                        //         onChanged: (val) =>
                        //             phoneController.userotp.value = val,
                        //         onSaved: (val) =>
                        //             phoneController.userotp.value = val!,
                        //         decoration: InputDecoration(
                        //           prefixIcon: Icon(
                        //             Icons.sms,
                        //             //color: Colors.white,
                        //           ),
                        //           // border: InputBorder,
                        //           hintText: 'Enter_OTP'.tr,
                        //         )),
                        //   ),
                        // ),
                        Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: PinFieldAutoFill(
                        codeLength: 6,
                        onCodeSubmitted: (value) async {
                          mySnackbar("thanks", value, false);
                          phoneController.userotp.value = value;
                          var otpcorrect = await phoneController
                              .otpVerify(phoneController.userotp.value);

                          if (otpcorrect) {
                            phoneController.otpcorrect(false);
                            await registerController.registeruser();
                          } else {
                            Get.snackbar("Invalid", 'user error');
                          }
                        },
                        onCodeChanged: (value) async {
                          if (value!.length == 6) {
                            phoneController.userotp.value = value;
                            var otpcorrect = await phoneController
                                .otpVerify(phoneController.userotp.value);

                            if (otpcorrect) {
                              phoneController.otpcorrect(false);
                              await registerController.registeruser();
                            } else {
                              Get.snackbar("Invalid", 'user error');
                            }
                          }
                          //  print(value);
                        },
                      ),
                    ),
                  )),
              // ElevatedButton(
              //   child: Text(
              //     'check_code'.tr,
              //   ),
              //   onPressed: () async {
              //     // final form2 = _formKeyotp.currentState;
              //     // if (form2!.validate()) {
              //     //   form2.save();
              //     // phoneController.verifyPhone("+201022645564");

              //     var otpcorrect = await phoneController
              //         .otpVerify(phoneController.userotp.value);

              //     if (otpcorrect) {
              //       phoneController.otpcorrect(false);
              //       await registerController.registeruser();
              //     } else {
              //       Get.snackbar("Invalid", 'user error');
              //     }
              //     // }
              //   },
              // ),

              Obx(() => (phoneController.authStatus.value) != 'OTP_Sent'
                  ? Center(
                      child: Text(phoneController.authStatus.value,
                          style: TextStyle(fontSize: sp(12), color: lgreen)))
                  : Text('')),

              ///=======================================================================
              ///==================== Go to Signup ========================================
              ///=======================================================================
            ],
          ),
        ),
      ),
    );
  }

  _listeOTP() async {
    await SmsAutoFill().listenForCode;
  }
}
