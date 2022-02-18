// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class PhoneAuthForm extends StatefulWidget {
//   PhoneAuthForm({Key? key}) : super(key: key);

//   @override
//   _PhoneAuthFormState createState() => _PhoneAuthFormState();
// }

// class _PhoneAuthFormState extends State<PhoneAuthForm> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController phoneNumber = TextEditingController();
//   TextEditingController otpCode = TextEditingController();

//   OutlineInputBorder border =
//       OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 3.0));

//   bool isLoading = false;

//   String? verificationId;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         body: Center(
//       child: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: size.width * 0.8,
//               child: TextFormField(
//                   keyboardType: TextInputType.phone,
//                   controller: phoneNumber,
//                   decoration: InputDecoration(
//                     labelText: "Enter Phone",
//                     contentPadding:
//                         EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
//                     border: border,
//                   )),
//             ),
//             SizedBox(
//               height: size.height * 0.01,
//             ),
//             SizedBox(
//               width: size.width * 0.8,
//               child: TextFormField(
//                 keyboardType: TextInputType.number,
//                 controller: otpCode,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: "Enter Otp",
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
//                   border: border,
//                 ),
//               ),
//             ),
//             Padding(padding: EdgeInsets.only(bottom: size.height * 0.05)),
//             !isLoading
//                 ? SizedBox(
//                     width: size.width * 0.8,
//                     child: OutlinedButton(
//                       onPressed: () async {
//                         //FirebaseService service = new FirebaseService();
//                         if (_formKey.currentState!.validate()) {
//                           setState(() {
//                             isLoading = true;
//                           });
//                           await phoneSignIn(phoneNumber: phoneNumber.text);
//                         }
//                       },
//                       child: Text('Sign'),
//                     ),
//                   )
//                 : CircularProgressIndicator(),
//           ],
//         ),
//       ),
//     ));
//   }

//   Future<void> phoneSignIn({required String phoneNumber}) async {
//     await _auth.verifyPhoneNumber(
//         timeout: Duration(seconds: 50),
//         phoneNumber: phoneNumber,
//         verificationCompleted: _onVerificationCompleted,
//         verificationFailed: _onVerificationFailed,
//         codeSent: _onCodeSent,
//         codeAutoRetrievalTimeout: _onCodeTimeout);
//   }

//   _onVerificationCompleted(AuthCredential authCredential) {
//     var auth = FirebaseAuth.instance;
//     if (auth.currentUser != null) {
//       setState(() {
//         isLoading = false;
//       });
//       print("login successfully");
//     }
//   }
//   // _onVerificationCompleted(PhoneAuthCredential authCredential) async {
//   //   print("verification completed ${authCredential.smsCode}");
//   //   User? user = FirebaseAuth.instance.currentUser;
//   //   setState(() {
//   //     this.otpCode.text = authCredential.smsCode!;
//   //   });
//   //   if (authCredential.smsCode != null) {
//   //     try {
//   //       UserCredential credential =
//   //           await user!.linkWithCredential(authCredential);
//   //     } on FirebaseAuthException catch (e) {
//   //       if (e.code == 'provider-already-linked') {
//   //         await _auth.signInWithCredential(authCredential);
//   //       }
//   //     }
//   //     setState(() {
//   //       isLoading = false;
//   //     });
//   //   }
//   // }

//   _onVerificationFailed(FirebaseAuthException exception) {
//     if (exception.code == 'invalid-phone-number') {
//       showMessage("The phone number entered is invalid!");
//     }
//   }

//   _onCodeSent(String verificationId, int? forceResendingToken) {
//     this.verificationId = verificationId;
//     print(forceResendingToken);
//     print("code sent");
//   }

//   _onCodeTimeout(String timeout) {
//     showMessage('Time out');
//     return null;
//   }

//   void showMessage(String errorMessage) {
//     showDialog(
//         context: context,
//         builder: (BuildContext builderContext) {
//           return AlertDialog(
//             title: Text("Error"),
//             content: Text(errorMessage),
//             actions: [
//               TextButton(
//                 child: Text("Ok"),
//                 onPressed: () async {
//                   Navigator.of(builderContext).pop();
//                 },
//               )
//             ],
//           );
//         }).then((value) {
//       setState(() {
//         isLoading = false;
//       });
//     });
//   }
// }
