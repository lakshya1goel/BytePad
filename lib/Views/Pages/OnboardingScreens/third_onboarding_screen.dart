import 'package:bytepad/Views/Pages/login_page.dart';
import 'package:bytepad/theme_data.dart';
import 'package:flutter/material.dart';

class ThirdOnboardingScreen extends StatelessWidget {
  const ThirdOnboardingScreen({super.key});

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
              Image.asset("assets/images/ThirdOnboardImage.jpeg"),
              SizedBox(height: size.height*0.05),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                child: Text("Empowering Educators",
                  style: TextStyle(
                    fontSize: size.width*0.08,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(size.width*0.05),
                child: Text("Stay updated with the latest course materials, announcements, and resources shared by your teachers.",
                  style: TextStyle(
                    fontSize: size.width*0.05,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: size.width*0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.width*0.01),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: size.width*0.01,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: blueColor,
                    radius: size.width*0.01,
                  ),
                ],
              ),
              SizedBox(height: size.height*0.02,),
              Center(
                child: Container(
                  width: size.width*0.9,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("NEXT",
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
