import 'package:bytepad/Views/Pages/Dashboards/faculty_dashboard.dart';
import 'package:bytepad/Views/Pages/DocumentUploadingScreens/document_listing_page_faculty.dart';
import 'package:bytepad/Views/Pages/FacultyScreens/my_classes.dart';
import 'package:bytepad/Views/Pages/ProfilePages/hod_faculty_profile_page.dart';
import 'package:bytepad/Views/Pages/ProfilePages/profile_setting_page.dart';
import 'package:flutter/material.dart';
import '../../../Utils/Constants/colors.dart';
import '../Attendance/faculty_side_attendance.dart';

class FacultySide extends StatefulWidget {
  const FacultySide({super.key});

  @override
  State<FacultySide> createState() => _FacultySideState();
}

class _FacultySideState extends State<FacultySide> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [FacultyDashboard(), MyClasses(), FacultySideAttendance(), ProfileSettingPage()];
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
