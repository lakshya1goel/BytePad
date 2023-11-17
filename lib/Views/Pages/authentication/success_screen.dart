import 'dart:io';

import 'package:bytepad/Views/Pages/authentication/login_page.dart';
import 'package:flutter/material.dart';

import '../../../Models/authentication/error_message_dialog_box.dart';
import '../../../Utils/Constants/colors.dart';
import '../../Widgets/custom_input_field.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
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
                    child: Text("Success!",
                      style: TextStyle(
                        fontSize: size.width*0.1,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height*0.07,),
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset("assets/images/successImage.png")
                  ),
                  SizedBox(height: size.height*0.04,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
                    child: Text("Your password has been successfully reset. You can now log in with your new password.",
                      style: TextStyle(
                        fontSize: size.width*0.05,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height*0.05,),
                  Center(
                    child: Container(
                      width: size.width*0.9,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            final result = await InternetAddress.lookup('example.com');
                            if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                              // Internet connection is available
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                                ModalRoute.withName('/Login'),
                              );
                            } else {
                              // No internet connection
                              ErrorMessage.showAlertDialog(context, "Error", "No Internet Connection");
                            }
                          } on SocketException catch (_) {
                            // Unable to lookup host, likely no internet connection
                            ErrorMessage.showAlertDialog(context, "Error", "No Internet Connection");
                          }
                        },

                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("LOGIN",
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
            ],
          ),
        ),
      ),
    );
  }
}
