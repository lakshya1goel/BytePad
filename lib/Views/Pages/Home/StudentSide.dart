import 'package:bytepad/Views/Pages/Dashboards/student_dashboard.dart';
import 'package:bytepad/Views/Pages/ProfilePages/profile_setting_page.dart';
import 'package:flutter/material.dart';
import '../../../Models/Details/student_details_model.dart';
import '../../../Utils/Constants/colors.dart';
import '../Attendance/student_attendance.dart';
import '../DocumentViewScreens/learning_section.dart';

class StudentSide extends StatefulWidget {
  final StudentDetailsModel? studentDetails;
  const StudentSide({super.key, required this.studentDetails});

  @override
  State<StudentSide> createState() => _StudentSideState();
}

class _StudentSideState extends State<StudentSide> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [StudentDashboard(studentDetails: widget.studentDetails,), LearningSection(), StudentAttendance(), ProfileSettingPage(studentDetails: widget.studentDetails,)];
    return Scaffold(
      body: widgets.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Learning',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outline,),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: blueColor,
      ),
    );
  }
}