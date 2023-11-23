import 'dart:async';
import 'dart:io';

import 'package:bytepad/Views/Pages/authentication/reset_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../Models/authentication/error_message_dialog_box.dart';
import '../../../Models/authentication/verify_response.dart';
import '../../../Services/authentication/get_otp.dart';
import '../../../Services/authentication/verify_otp.dart';
import '../../../Utils/Constants/colors.dart';
import 'package:pinput/pinput.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;
  OTPVerificationScreen({required this.email, Key? key}) : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {

  bool isLoading = false;
  final TextEditingController _otpController = TextEditingController();

  final focusNode = FocusNode();

  int _secondsRemaining = 300; // Initial value for OTP timer (5 minutes)
  late Timer _timer;
  String? errorMsgText;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                child: Text("Verification Code",
                  style: TextStyle(
                    fontSize: size.width*0.09,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.1),
                child: Text("We have sent the verification code to your email address.",
                  style: TextStyle(
                    fontSize: size.width*0.05,
                  ),
                ),
              ),
              SizedBox(height: size.height*0.02,),
              Image.asset("assets/images/OTPVerificationImg.png"),
              SizedBox(height: size.height*0.05,),
              Form(
                child: Pinput(
                  // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  // forceErrorState: (errorMsgText != null && errorMsgText == ''),
                  controller: _otpController,
                  defaultPinTheme: PinTheme(
                    textStyle: TextStyle(
                      fontSize: size.width*0.05,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: blueColor),
                        borderRadius: BorderRadius.circular(5)),
                    height: size.height * 0.05,
                    width: size.width * 0.1,
                  ),
                  focusNode: focusNode,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  length: 4,
                  validator: (value) {
                    if (value!.length != 4) {
                      return "Enter the OTP";
                    }
                    return null;
                  },
                  errorText: errorMsgText,
                  errorPinTheme: PinTheme(
                    textStyle: TextStyle(
                        color: Colors.red,
                        fontSize: size.width*0.05,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(8)),
                    height: size.height * 0.05,
                    width: size.width * 0.1,
                  ),
                ),
              ),
              SizedBox(height: size.height*0.025,),
              Text(
                '${(_secondsRemaining ~/ 60).toString().padLeft(2, '0')} : ${(_secondsRemaining % 60).toString().padLeft(2, '0')} ',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              SizedBox(height: size.height*0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Did not recieve OTP?"),
                  TextButton(
                      onPressed: () {
                        requestResetPasswordOTP(widget.email);
                      } ,
                      child: Text("Resend OTP",
                        style: TextStyle(
                          color: blueColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                  )
                ],
              ),
              Center(
                child: Container(
                  width: size.width*0.9,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final result = await InternetAddress.lookup('example.com');
                        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                          // Internet connection is available
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            VerifyResponse result = await verifyResetPasswordOTP(widget.email, _otpController.text, context);

                            setState(() {
                              isLoading = false;
                              errorMsgText = "";
                            });

                            if (result.token != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResetPasswordScreen(
                                    token: result.token,
                                  ),
                                ),
                              );
                            } else {
                              setState(() {
                                errorMsgText = "Can't be empty!";
                              });
                            }

                          } catch (error) {
                            setState(() {
                              isLoading = false;
                            });

                            print('Error requesting OTP: $error');
                            setState(() {
                              errorMsgText = "Error requesting OTP. Please try again later.";
                            });

                          }
                        } else {
                          // No internet connection
                          setState(() {
                            errorMsgText = "No Internet Connection";
                          });
                        }
                      } on SocketException catch (_) {
                        // Unable to lookup host, likely no internet connection
                        setState(() {
                          errorMsgText = "No Internet Connection";
                        });
                      }
                    },

                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: isLoading ?
                      SizedBox(
                        width: size.width*0.052,
                        height: size.height*0.028,
                        child: CircularProgressIndicator(),
                      )
                          : Text("SUBMIT",
                        style: TextStyle(
                          fontSize: size.width*0.05,
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(blueColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// void showErrorDialog(BuildContext context, String errorMessage) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Error'),
//         content: Text(errorMessage),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//             },
//             child: Text('OK'),
//           ),
//         ],
//       );
//     },
//   );
// }