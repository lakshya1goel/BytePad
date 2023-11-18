import 'package:bytepad/Views/Pages/Attendance/student_attendance.dart';
import 'package:bytepad/Views/Pages/Dashboards/student_dashboard.dart';
import 'package:bytepad/Views/Pages/DocumentViewScreens/learning_section.dart';
import 'package:bytepad/Views/Pages/ProfilePages/profile_setting_page.dart';
import 'package:bytepad/Views/Widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class StudentSideScreens extends StatefulWidget {
  const StudentSideScreens({super.key});

  @override
  State<StudentSideScreens> createState() => _StudentSideScreensState();
}

class _StudentSideScreensState extends State<StudentSideScreens> {
  final PageController _pageController = PageController();
  int currPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        children: [
          StudentDashboard(pageController: _pageController,),
          LearningSection(pageController: _pageController,),
          StudentAttendance(pageController: _pageController,),
          ProfileSettingPage(pageController: _pageController,),
        ],
        onPageChanged: (index) {
          setState(() {
            currPage = index;
          });
        },
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currPage: currPage,
        pageController: _pageController,
        onTap: (ind) {
          setState(() {
            _pageController.jumpToPage(ind);
          });
        }
      ),
    );
  }
}
