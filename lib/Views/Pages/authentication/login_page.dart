import 'package:bytepad/Views/Pages/authentication/forgot_password_page.dart';
import 'package:bytepad/Views/Pages/home_page.dart';
import 'package:bytepad/Views/Widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import '../../../Contollers/validation.dart';
import '../../../Models/error_message_dialog_box.dart';
import '../../../Services/token_generation.dart';
import '../../../theme_data.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  // void handleSubmit() {
  //   String email = emailController.text;
  //   String password = passwordController.text;
  //   loginUser(email, password, context);
  // }

  @override

  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset("assets/images/BytePadLogo.png",
                    height: size.width*0.35,
                    width: size.width*0.35,
                  ),
                ),
                SizedBox(height: size.height*0.05),
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
                  child: CustomInputField(labelText: "Email", icon: Icons.email, controller: emailController,),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                  child: CustomInputField(labelText: "Password", icon: Icons.key, controller: passwordController,),
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
                        String? emailError = Validator.isValidEmail(emailController.text);
                        if (emailError != null) {
                          ErrorMessage.showAlertDialog(context, "Error", emailError);
                          return;
                        }
                        String? passwordError = Validator.isValidPassword(passwordController.text);
                        if (passwordError != null) {
                          ErrorMessage.showAlertDialog(context, "Error", passwordError);
                          return;
                        }

                        setState(() {
                          isLoading = true;
                        });

                        try {
                          String? errorMessage = await loginUser(emailController.text, passwordController.text);

                          setState(() {
                            isLoading = false;
                          });

                          if (errorMessage != null) {
                            ErrorMessage.showAlertDialog(context, "Error", errorMessage);
                            return; // Don't proceed further if there's an error
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );

                        } catch (error) {
                          setState(() {
                            isLoading = false;
                          });
                          ErrorMessage.showAlertDialog(context, "Error", "Error requesting OTP. Please try again later.");
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
