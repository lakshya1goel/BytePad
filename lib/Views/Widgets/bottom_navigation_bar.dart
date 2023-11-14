import 'package:bytepad/Utils/Constants/colors.dart';
import 'package:bytepad/Views/Pages/Dashboards/student_dashboard.dart';
import 'package:bytepad/Views/Pages/DocumentViewScreens/documents_listing_screen.dart';
import 'package:bytepad/Views/Pages/DocumentViewScreens/learning_section.dart';
import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  const MyBottomNavigationBar({required this.currentIndex, Key? key}) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {

  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: (index) {
        if(index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => StudentDashboard(),
            ),
          );
          setState(() {
            _currentIndex = index;
          });
        }
        if(index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LearningSection(),
            ),
          );
          setState(() {
            _currentIndex = index;
          });
        }
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
    );
  }
}
