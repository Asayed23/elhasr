// import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:elhasr/pages/common_widget/local_colors.dart';
// import 'package:elhasr/core/size_config.dart';
// import 'package:elhasr/pages/Auth/controller/register_controller.dart';

// class PhoneSMSHandler extends StatelessWidget {
//   final RegisterController registerController = Get.put(RegisterController());
//   String? _enteredOTP;
//   String _phoneNumber = "";

//   @override
//   Widget build(BuildContext context) {
//     _phoneNumber = registerController.registeruserdata.value.phoneNumber;
//     return SafeArea(
//       child: FirebasePhoneAuthHandler(
//         phoneNumber: _phoneNumber,
//         timeOutDuration: const Duration(seconds: 60),
//         onLoginSuccess: (userCredential, autoVerified) async {
//           print(autoVerified
//               ? "OTP was fetched automatically"
//               : "OTP was verified manually");

//           print("Login Success UID: ${userCredential.user?.uid}");
//           await registerController.registeruser();
//         },
//         onLoginFailed: (authException) {
//           print("An error occurred: ${authException.message}");

//           // handle error further if needed
//         },
//         builder: (context, controller) {
//           return Container(
//             decoration: ldecoration,
//             child: Scaffold(
//               backgroundColor: Colors.transparent,
//               appBar: AppBar(
//                 title: Text("Verification Code"),
//                 backgroundColor: Colors.black,
//                 actions: controller.codeSent
//                     ? [
//                         TextButton(
//                           child: Text(
//                             controller.timerIsActive
//                                 ? "${controller.timerCount.inSeconds}s"
//                                 : "RESEND",
//                             style: TextStyle(color: lgreen, fontSize: sp(15)),
//                           ),
//                           onPressed: controller.timerIsActive
//                               ? null
//                               : () async {
//                                   await controller.sendOTP();
//                                 },
//                         ),
//                         SizedBox(width: 5),
//                       ]
//                     : null,
//               ),
//               body: controller.codeSent
//                   ? ListView(
//                       padding: EdgeInsets.all(20),
//                       children: [
//                         Text(
//                           "We've sent an SMS with a verification code to $_phoneNumber",
//                           style: TextStyle(
//                             fontSize: sp(12),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Divider(),
//                         // AnimatedContainer(
//                         //   duration: Duration(seconds: 1),
//                         //   height: controller.timerIsActive ? null : 0,
//                         //   child: Column(
//                         //     children: [
//                         //       CircularProgressIndicator(),
//                         //       SizedBox(height: 50),
//                         //       Text(
//                         //         "Listening for OTP",
//                         //         textAlign: TextAlign.center,
//                         //         style: TextStyle(
//                         //           fontSize: 25,
//                         //           fontWeight: FontWeight.w600,
//                         //         ),
//                         //       ),
//                         //       Divider(),
//                         //       Text("OR", textAlign: TextAlign.center),
//                         //       Divider(),
//                         //     ],
//                         //   ),
//                         // ),
//                         Text(
//                           "Enter Code",
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         TextField(
//                           maxLength: 6,
//                           keyboardType: TextInputType.number,
//                           onChanged: (String v) async {
//                             _enteredOTP = v;
//                             if (this._enteredOTP?.length == 6) {
//                               final res =
//                                   await controller.verifyOTP(otp: _enteredOTP!);
//                               // Incorrect OTP
//                               if (!res)
//                                 print(
//                                   "Please enter the correct OTP sent to $_phoneNumber",
//                                 );
//                             }
//                           },
//                         ),
//                       ],
//                     )
//                   : Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         CircularProgressIndicator(),
//                         SizedBox(height: 50),
//                         Center(
//                           child: Text(
//                             "Sending OTP",
//                             style: TextStyle(fontSize: 25),
//                           ),
//                         ),
//                       ],
//                     ),
//               floatingActionButton: controller.codeSent
//                   ? FloatingActionButton(
//                       backgroundColor: lgreen,
//                       child: Icon(Icons.check),
//                       onPressed: () async {
//                         if (_enteredOTP == null || _enteredOTP?.length != 6) {
//                           print("Please enter a valid 6 digit OTP");
//                         } else {
//                           final res =
//                               await controller.verifyOTP(otp: _enteredOTP!);
//                           // Incorrect OTP
//                           if (!res) {
//                             print(
//                                 "Please enter the correct OTP sent to $_phoneNumber");
//                           } else {
//                             await registerController.registeruser();
//                           }
//                         }
//                       },
//                     )
//                   : null,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
