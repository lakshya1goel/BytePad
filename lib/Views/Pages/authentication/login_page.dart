import 'dart:io';

import 'package:bytepad/Views/Pages/Dashboards/student_dashboard.dart';
import 'package:bytepad/Views/Pages/Home/StudentSide.dart';
import 'package:bytepad/Views/Pages/authentication/forgot_password_page.dart';
import 'package:bytepad/Views/Widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import '../../../Contollers/validation.dart';
import '../../../Services/authentication/storage.dart';
import '../../../Services/authentication/token_generation.dart';
import '../../../Utils/Constants/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool _obscureText=true;
  final _emailformKey = GlobalKey<FormState>();
  final _passwordformKey = GlobalKey<FormState>();
  final SecureStorage secureStorage = SecureStorage();
  String? errorMsgText;

  @override

  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height*0.05),
                Center(
                  child: Image.asset("assets/images/BytePadLogo.png",
                    height: size.width*0.35,
                    width: size.width*0.35,
                  ),
                ),
                SizedBox(height: size.height*0.03),
                Padding(
                  padding: EdgeInsets.all(size.width*0.05),
                  child: Text("Login",
                    style: TextStyle(
                      fontSize: size.width*0.15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                  child: Text("Hi! Tell us more about yourself by signing in.",
                    style: TextStyle(
                      fontSize: size.width*0.04,
                      color: greyColor
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(size.width*0.05),
                  child: CustomInputField(labelText: "Email", icon: Icons.email, controller: emailController, emailController: emailController, formKey: _emailformKey, errorMsgText: errorMsgText,),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _passwordformKey,
                      child: TextFormField(
                        obscureText: _obscureText,
                        obscuringCharacter: '*',
                        controller: passwordController,
                        cursorColor: blueColor,
                        validator: (value) {
                          String? passwordError = passwordController?.text != null
                              ? Validator.isValidPassword(passwordController!.text)
                              : null;

                          if (passwordError != null) {
                            return passwordError;
                          }
                        },
                        decoration: InputDecoration(
                          errorText: errorMsgText,
                          suffixIcon: GestureDetector(
                            onTap: (){
                              setState(() {
                                _obscureText= !_obscureText;
                              }
                              );
                            },
                            child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                          ),
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: blueColor),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          prefixIcon: Container(
                              margin: EdgeInsets.only(right: size.width*0.08),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: blueColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(17.0),
                                child: Icon(Icons.key,
                                  color: Colors.white,
                                ),
                              )
                          ),
                        ),
                      ),
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: size.width*0.05, right: size.width*0.05 ),
                  child: TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: const Text("Forgot Password?",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: blueColor
                          ),
                        ),
                      ),
                  ),
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
                            if (_emailformKey.currentState!.validate() && _passwordformKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                                // errorMsgText = null;
                              });

                              try {
                                String? errorMessage = await loginUser(emailController.text, passwordController.text, context);

                                setState(() {
                                  isLoading = false;
                                  errorMsgText = "";
                                });

                                if (errorMessage != null) {
                                  setState(() {
                                    errorMsgText = errorMessage;
                                  });
                                  return;
                                }
                              } catch (error) {
                                setState(() {
                                  isLoading = false;
                                  errorMsgText = "Unexpected error occurred. Please try again later.";
                                });
                              }
                            }
                          } else {
                            // No internet connection
                            setState(() {
                              errorMsgText = "No Internet Connection";
                            });
                          }
                        } on SocketException catch (_) {
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
                                : Text("VERIFY",
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
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(size.width * 0.05),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "By Clicking 'Verify', you agree to our ",
                                style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                    fontSize: size.width*0.04,
                                ),
                              ),
                              TextSpan(
                                text: "Terms of Services",
                                style: TextStyle(
                                    color: blueColor,
                                    decoration: TextDecoration.none,
                                    fontSize: size.width*0.04
                                ),
                              ),
                              TextSpan(
                                text: " and ",
                                style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                    fontSize: size.width*0.04
                                ),
                              ),
                              TextSpan(
                                text: "Privacy Policy",
                                style: TextStyle(
                                    color: blueColor,
                                    decoration: TextDecoration.none,
                                    fontSize: size.width*0.04
                                ),
                              ),
                              TextSpan(
                                text: ".",
                                style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                    fontSize: size.width*0.04
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
