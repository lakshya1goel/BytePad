import 'package:bytepad/Views/Pages/authentication/login_page.dart';
import 'package:flutter/material.dart';

import '../../../theme_data.dart';
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
                child: Text("Success!",
                  style: TextStyle(
                    fontSize: size.width*0.1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: size.height*0.02,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
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
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
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
              SizedBox(height: size.height*0.1,),
              Align(
                alignment: Alignment.center,
                  child: Image.asset("assets/images/SuccessImg.png")
              ),
            ],
          ),
        ),
      ),
    );
  }
}
