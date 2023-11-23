import 'package:bytepad/Views/Pages/FacultyScreens/my_classes.dart';
import 'package:bytepad/Views/Pages/ProfilePages/profile_setting_page.dart';
import 'package:flutter/material.dart';
import '../../../Models/Details/hod_faculty_details_model.dart';
import '../../../Models/Details/student_details_model.dart';
import '../../../Utils/Constants/colors.dart';
import '../Dashboards/hod_dashboard.dart';
import '../Management/hod_announcement.dart';

class HodSide extends StatefulWidget {
  final StudentDetailsModel? studentDetails;
  final HodFacultyDetailsModel? hodFacultyDetailsModel;
  const HodSide({super.key, this.studentDetails, this.hodFacultyDetailsModel});

  @override
  State<HodSide> createState() => _HodSideState();
}

class _HodSideState extends State<HodSide> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [HodDashboard(studentDetails: widget.studentDetails,), MyClasses(), Management(), ProfileSettingPage(studentDetails: widget.studentDetails, hodFacultyDetailsModel: widget.hodFacultyDetailsModel,)];
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
            icon: Image.asset('assets/images/manage.png',
              color: (_selectedIndex == 2 )? blueColor: Colors.black54,
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
