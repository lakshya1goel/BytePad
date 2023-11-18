import 'dart:async';
import 'package:bytepad/Views/Pages/Dashboards/student_dashboard.dart';
import 'package:bytepad/Views/Pages/Home/StudentSide.dart';
import 'package:bytepad/Views/Pages/OnboardingScreens/first_onboarding_screen.dart';
import 'package:flutter/material.dart';

import '../../../Services/authentication/storage.dart';

String? accessToken;
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SecureStorage secureStorage = SecureStorage();

  @override
  void initState() {
    secureStorage.readSecureData('accessToken').then((value) {
      accessToken = value;
    });
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(
          builder: (context) => accessToken == null ? FirstOnboardingScreen() : StudentSide()));

    });
  }
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/BytePadLogo.png",
                height: size.height*0.2,
              ),
              Text("BytePad",style: TextStyle(
                fontSize: size.height*0.05,
                fontWeight: FontWeight.bold,
              ),),
            ],
          ),
        )
    );
  }
}