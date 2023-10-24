import 'package:bytepad/Views/Pages/OnboardingScreens/first_onboarding_screen.dart';
import 'package:bytepad/theme_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BytePad',
      theme: ThemeData(
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Montserrat',
          ),
        ),
        scaffoldBackgroundColor: bgColor,
      ),
      home: const FirstOnboardingScreen(),
    );
  }
}