import 'package:bytepad/Views/Pages/authentication/otp_verification_page.dart';
import 'package:bytepad/Views/Pages/authentication/reset_password_page.dart';
import 'package:flutter/material.dart';

import '../../../Services/get_otp.dart';
import '../../../theme_data.dart';
import '../../Widgets/custom_input_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  TextEditingController emailController = TextEditingController();

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                child: Text("Forgot Password?",
                  style: TextStyle(
                    fontSize: size.width*0.09,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                child: Text("Provide your email address to receive a password reset link.",
                  style: TextStyle(
                    fontSize: size.width*0.05,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(size.width*0.05),
                child: CustomInputField(labelText: "Enter registered e-mail", icon: Icons.email, controller: emailController,),
              ),
              SizedBox(height: size.height*0.05,),
              Center(
                child: Container(
                  width: size.width*0.9,
                  child: ElevatedButton(
                    onPressed: (){
                      requestResetPasswordOTP(emailController.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OTPVerificationScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("SEND",
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
              SizedBox(height: size.height*0.05,),
              Image.asset("assets/images/ForgotPasswordImg.png"),
            ],
          ),
        ),
      ),
    );
  }
}
