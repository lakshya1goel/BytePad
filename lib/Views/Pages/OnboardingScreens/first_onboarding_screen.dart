import 'package:bytepad/Views/Pages/OnboardingScreens/second_onboarding_screen.dart';
import 'package:bytepad/Views/Pages/authentication/login_page.dart';
import 'package:bytepad/theme_data.dart';
import 'package:flutter/material.dart';

class FirstOnboardingScreen extends StatelessWidget {
  const FirstOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Text("Skip",
                      style: TextStyle(
                          color: blueColor
                      ),
                    ),
                  )
              ),
              Image.asset("assets/images/FirstOnboardImage.jpeg"),
              SizedBox(height: size.height*0.05),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                child: Text("Unlock the Past",
                  style: TextStyle(
                    fontSize: size.width*0.08,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(size.width*0.05),
                child: Text("Dive into a treasure trove of past exam papers and study materials, making exam preparation a breeze.",
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
                    backgroundColor: blueColor,
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
                    backgroundColor: Colors.grey,
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
                          builder: (context) => const SecondOnboardingScreen(),
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
