import 'dart:async';
import 'package:bytepad/Views/Pages/Dashboards/student_dashboard.dart';
import 'package:bytepad/Views/Pages/Home/StudentSide.dart';
import 'package:bytepad/Views/Pages/OnboardingScreens/first_onboarding_screen.dart';
import 'package:flutter/material.dart';

import '../../../Models/Details/hod_faculty_details_model.dart';
import '../../../Models/Details/student_details_model.dart';
import '../../../Services/Details/hod_faculty_details.dart';
import '../../../Services/Details/student_details.dart';
import '../../../Services/authentication/storage.dart';
import '../Home/FacultySide.dart';
import '../Home/HodSide.dart';

String? accessToken;
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SecureStorage secureStorage = SecureStorage();
  StudentDetailsModel? studentDetails;
  HodFacultyDetailsModel? hodFacultyDetailsModel;

  @override
  void initState() {
    super.initState();
    secureStorage.readSecureData('accessToken').then((value) {
      accessToken = value;
      getStudentDetails(accessToken).then((data) {
        setState(() {
          studentDetails = data;
        });
      });
      getHodFacultyDetails(accessToken).then((data) {
        setState(() {
          hodFacultyDetailsModel = data;
        });
      });
    });
    // TODO: implement initState
    Timer(Duration(seconds: 4), () {
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(
      //     builder: (context) => accessToken == null ? FirstOnboardingScreen() : StudentSide()));
      if (accessToken == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FirstOnboardingScreen()),
        );
      }
      else if (studentDetails != null && studentDetails!.isStudent == true && studentDetails!.isFaculty == false && studentDetails!.isDepartmentHead == false) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StudentSide(studentDetails: studentDetails,)),
        );
      }
      else if (studentDetails != null && studentDetails!.isStudent == false && studentDetails!.isFaculty == true && studentDetails!.isDepartmentHead == false) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FacultySide(studentDetails: studentDetails, hodFacultyDetailsModel: hodFacultyDetailsModel,)),
        );
      }
      else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HodSide(studentDetails: studentDetails, hodFacultyDetailsModel: hodFacultyDetailsModel,)),
        );
      }
      // else {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => FirstOnboardingScreen()),
      //   );
      // }

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