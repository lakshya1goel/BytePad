import 'package:bytepad/Views/Pages/DocumentUploadingScreens/document_selction_screen.dart';
import 'package:bytepad/Views/Pages/OnboardingScreens/splash_screen.dart';
import 'package:bytepad/Utils/Constants/colors.dart';
import 'package:bytepad/Views/Pages/authentication/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  await dotenv.load(fileName: ".env");
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
      home: const DocumentSelectionScren(),
      routes: {
        '/Login' : (context) => LoginPage()
      },
    );
  }
}