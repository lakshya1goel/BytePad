import 'package:bytepad/Views/Pages/FacultyScreens/my_classes.dart';
import 'package:bytepad/Views/Pages/ProfilePages/hod_faculty_profile_page.dart';
import 'package:bytepad/Views/Pages/ProfilePages/profile_setting_page.dart';
import 'package:flutter/material.dart';
import '../../../Utils/Constants/colors.dart';
import '../Dashboards/hod_dashboard.dart';
import '../DocumentUploadingScreens/document_selction_screen.dart';
import '../Management/hod_announcement.dart';

class HodSide extends StatefulWidget {
  const HodSide({super.key});

  @override
  State<HodSide> createState() => _HodSideState();
}

class _HodSideState extends State<HodSide> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [HodDashboard(), MyClasses(), Management(), ProfileSettingPage()];
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
            icon: Transform.rotate(
              angle: 135 * 3.14 / 180,
              child: Icon(Icons.edit),
            ),
            label: 'Manage',
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
