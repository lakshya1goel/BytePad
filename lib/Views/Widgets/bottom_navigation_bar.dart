import 'package:bytepad/Utils/Constants/colors.dart';
import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currPage;
  final PageController pageController;
  final void Function(int)? onTap;
  const MyBottomNavigationBar({super.key, required this.currPage, required this.pageController, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currPage,
      onTap: onTap,
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
