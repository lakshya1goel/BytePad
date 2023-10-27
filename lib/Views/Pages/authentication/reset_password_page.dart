import 'package:bytepad/Views/Pages/authentication/success_screen.dart';
import 'package:flutter/material.dart';

import '../../../Contollers/validation.dart';
import '../../../Models/error_message_dialog_box.dart';
import '../../../Services/reset_password.dart';
import '../../../theme_data.dart';
import '../../Widgets/custom_input_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String? token;
  ResetPasswordScreen({required this.token, Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  TextEditingController  passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isLoading = false;

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
                child: Text("Reset Password",
                  style: TextStyle(
                    fontSize: size.width*0.1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: size.height*0.02,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                child: Text("You can create a new password for your account.",
                  style: TextStyle(
                    fontSize: size.width*0.05,
                  ),
                ),
              ),
              SizedBox(height: size.height*0.05,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                child: CustomInputField(labelText: "New Password", icon: Icons.key, controller: passwordController,),
              ),
              SizedBox(height: size.height*0.04,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                child: CustomInputField(labelText: "Confirm New Password", icon: Icons.access_time_filled, controller: confirmPasswordController,),
              ),
              SizedBox(height: size.height*0.05,),
              Center(
                child: Container(
                  width: size.width*0.9,
                  child: ElevatedButton(
                    onPressed: () async {
                      String? passwordError = Validator.isResetPassword(passwordController.text, confirmPasswordController.text);
                      if (passwordError != null) {
                        ErrorMessage.showAlertDialog(context, "Error", passwordError);
                        return;
                      }


                      setState(() {
                        isLoading = true;
                      });

                      try {
                        String? errorMessage = await resetPassword(widget.token, passwordController.text, context);

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
                            builder: (context) => SuccessScreen(),
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
