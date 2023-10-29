import 'package:bytepad/Views/Pages/authentication/success_screen.dart';
import 'package:flutter/material.dart';
import '../../../Contollers/validation.dart';
import '../../../Models/error_message_dialog_box.dart';
import '../../../Services/reset_password.dart';
import '../../../Utils/Constants/colors.dart';

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
  final _passwordformKey = GlobalKey<FormState>();
  final _confirmPasswordformKey = GlobalKey<FormState>();
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  String password = "";

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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Form(
                    key: _passwordformKey,
                    child: TextFormField(
                      obscureText: _obscureTextPassword,
                      obscuringCharacter: '*',
                      controller: passwordController,
                      cursorColor: blueColor,
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (value) {
                        String? passwordError = passwordController?.text != null
                            ? Validator.isStrongPassword(passwordController!.text)
                            : null;

                        if (passwordError != null) {
                          return passwordError;
                        }
                      },
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: (){
                            setState(() {
                              _obscureTextPassword =! _obscureTextPassword;
                            }
                            );
                          },
                          child: Icon(_obscureTextPassword ? Icons.visibility_off : Icons.visibility,
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
                              child: Icon(Icons.mail,
                                color: Colors.white,
                              ),
                            )
                        ),
                      ),
                    ),
                  ),
                )
              ),
              SizedBox(height: size.height*0.04,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Form(
                    key: _confirmPasswordformKey,
                    child: TextFormField(
                      obscureText: _obscureTextConfirmPassword,
                      obscuringCharacter: '*',
                      controller: confirmPasswordController,
                      cursorColor: blueColor,
                      validator: (value) {
                        if(confirmPasswordController.text.isEmpty) {
                          return "Cannot be empty";
                        }
                        if(password != confirmPasswordController.text) {
                          return "Password Mismatch";
                        }
                      },
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: (){
                            setState(() {
                              _obscureTextConfirmPassword =! _obscureTextConfirmPassword;
                            }
                            );
                          },
                          child: Icon(_obscureTextConfirmPassword ? Icons.visibility_off : Icons.visibility,
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
                              child: Icon(Icons.mail,
                                color: Colors.white,
                              ),
                            )
                        ),
                      ),
                    ),
                  ),
                )
              ),
              SizedBox(height: size.height*0.05,),
              Center(
                child: Container(
                  width: size.width*0.9,
                  child: ElevatedButton(
                    onPressed: () async {

                        if( _passwordformKey.currentState!.validate() && _confirmPasswordformKey.currentState!.validate()){

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
                          } catch (error) {
                            setState(() {
                              isLoading = false;
                            });
                            print(error);
                            ErrorMessage.showAlertDialog(context, "Error", "Unexpected error occurred. Please try again later.");
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SuccessScreen(),
                            ),
                          );
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
