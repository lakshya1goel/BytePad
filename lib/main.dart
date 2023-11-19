import 'package:bytepad/Views/Pages/DocumentUploadingScreens/document_selction_screen.dart';
import 'package:bytepad/Views/Pages/Dashboards/faculty_dashboard.dart';
import 'package:bytepad/Views/Pages/Home/StudentSide.dart';
import 'package:bytepad/Views/Pages/OnboardingScreens/splash_screen.dart';
import 'package:bytepad/Utils/Constants/colors.dart';
import 'package:bytepad/Views/Pages/ProfilePages/student_profile_page.dart';
import 'package:bytepad/Views/Pages/authentication/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'Views/Pages/Attendance/student_attendance.dart';
import 'Views/Pages/DocumentUploadingScreens/document_listing_page_faculty.dart';
import 'Views/Pages/DocumentViewScreens/documents_listing_screen.dart';
import 'Views/Pages/Dashboards/hod_dashboard.dart';
import 'Views/Pages/Dashboards/student_dashboard.dart';
import 'Views/Pages/DocumentViewScreens/filters.dart';
import 'Views/Pages/Home/FacultySide.dart';
import 'Views/Pages/Home/HodSide.dart';
import 'Views/Pages/ProfilePages/hod_faculty_profile_page.dart';
import 'Views/Pages/ProfilePages/profile_setting_page.dart';
import 'Views/Pages/DocumentViewScreens/learning_section.dart';
import 'Views/Pages/DocumentViewScreens/papers_collection.dart';


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
      home: StudentAttendance(),
      routes: {
        '/Login' : (context) => const LoginPage()
      },
    );
  }
}