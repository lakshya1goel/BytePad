import 'dart:io';

import 'package:bytepad/Views/Pages/authentication/otp_verification_page.dart';
import 'package:flutter/material.dart';
import '../../../Contollers/validation.dart';
import '../../../Services/authentication/get_otp.dart';
import '../../../Utils/Constants/colors.dart';
import '../../Widgets/custom_input_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  final _emailformKey = GlobalKey<FormState>();
  String? errorMsgText;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                width: size.width,
                color: blueColor,
                height: size.height*0.28,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
                    child: Text("Forgot Password?",
                      style: TextStyle(
                        fontSize: size.width*0.09,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height*0.02,),
                  Image.asset("assets/images/forgotPasswordImage.png"),
                  SizedBox(height: size.height*0.02,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
                    child: Text("Provide your email address to receive a password reset link.",
                      style: TextStyle(
                        fontSize: size.width*0.05,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height*0.02,),
                  Padding(
                    padding: EdgeInsets.all(size.width*0.05),
                    child: CustomInputField(labelText: "Enter registered e-mail", icon: Icons.email, controller: emailController,  emailController: emailController, formKey: _emailformKey, errorMsgText: errorMsgText,),
                  ),
                  SizedBox(height: size.height*0.05,),
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: size.width*0.9,
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                final result = await InternetAddress.lookup('example.com');
                                if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                                  // Internet connection is available
                                  if (_emailformKey.currentState!.validate()) {
                                    setState(() {
                                      // errorMsgText = null;
                                      isLoading = true;
                                    });

                                    try {
                                      String? errorMessage = await requestResetPasswordOTP(emailController.text);

                                      setState(() {
                                        isLoading = false;
                                        errorMsgText = "";
                                      });

                                      if (errorMessage != null) {
                                        setState(() {
                                          errorMsgText = errorMessage;
                                        });
                                        return; // Don't proceed further if there's an error
                                      }

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => OTPVerificationScreen(
                                            email: emailController.text,
                                          ),
                                        ),
                                      );

                                    } catch (error) {
                                      setState(() {
                                        isLoading = false;
                                        errorMsgText = "Error requesting OTP. Please try again later.";
                                      });
                                    }
                                  }
                                } else {
                                  // No internet connection
                                  setState(() {
                                    isLoading = false;
                                    errorMsgText = "No Internet Connection";
                                  });
                                }
                              } on SocketException catch (_) {
                                // Unable to lookup host, likely no internet connection
                                setState(() {
                                  isLoading = false;
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
                                  : Text("SEND",
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
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}