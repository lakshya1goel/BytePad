import 'package:bytepad/Views/Widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import '../../theme_data.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override

  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    bool rememberMe = false;

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
                  child: Text("Hi! Please sign in to continue.",
                    style: TextStyle(
                      fontSize: size.width*0.04,
                      color: greyColor
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(size.width*0.05),
                  child: const CustomInputField(labelText: "Email", icon: Icons.email,),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                  child: const CustomInputField(labelText: "Password", icon: Icons.key,),
                ),
                Padding(
                  padding: EdgeInsets.all(size.width*0.05),
                  child: Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                      ),
                      const Text("Remember Me"),
                      SizedBox( width: size.width*0.15,),
                      TextButton(
                          onPressed: (){},
                          child: const Text("Forgot Password?",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: blueColor
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    width: size.width*0.9,
                    child: ElevatedButton(
                        onPressed: (){},
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                            child: Text("VERIFY",
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
