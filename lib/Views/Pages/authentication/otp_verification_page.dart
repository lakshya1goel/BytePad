import 'package:bytepad/Views/Pages/authentication/reset_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../Models/error_message_dialog_box.dart';
import '../../../Models/verify_response.dart';
import '../../../Services/get_otp.dart';
import '../../../Services/verify_otp.dart';
import '../../../theme_data.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;
  OTPVerificationScreen({required this.email, Key? key}) : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {

  List<TextEditingController> controllers = List.generate(4, (index) => TextEditingController());
  bool isLoading = false;

  String getOtp() {
    String otp = '';
    for (var controller in controllers) {
      otp += controller.text;
    }
    return otp;
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
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.1,
                        height: size.height * 0.05,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextField(
                            controller: controllers[index],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: size.width*0.03,),
                    ],
                  );
                }),
                ),
              ),
              SizedBox(height: size.height*0.05,),
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
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        VerifyResponse result = await verifyResetPasswordOTP(widget.email, getOtp(), context);

                        setState(() {
                          isLoading = false;
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
                          ErrorMessage.showAlertDialog(context, "Error", result.error ?? "Can't be empty");
                        }

                      } catch (error) {
                        setState(() {
                          isLoading = false;
                        });

                        print('Error requesting OTP: $error');
                        ErrorMessage.showAlertDialog(context, "Error", "Error requesting OTP. Please try again later.");
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: isLoading ? CircularProgressIndicator() : Text("SUBMIT",
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
