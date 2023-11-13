import 'package:bytepad/Utils/Constants/colors.dart';
import 'package:flutter/material.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            radius: 17,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Greetings!",
              style: TextStyle(color: Colors.black, fontSize: size.width*0.05),
            ),
            Text("Student",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.notifications,
                color: blueColor,
              )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(size.width*0.05),
                child: Text("Quick Links",
                  style: TextStyle(
                    fontSize: size.width*0.05,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: size.width*0.05),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: (){},
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF28C2A0).withOpacity(0.1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Image.asset("assets/images/Folder.png",
                                  // color: blueColor,
                                ),
                              ),
                            ),
                            Text("Collections"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: size.width*0.05),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: (){},
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF28C2A0).withOpacity(0.1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Image.asset("assets/images/pastPapers.png",
                                  // color: blueColor,
                                ),
                              ),
                            ),
                            Text("Past Papers"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: size.width*0.05),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: (){},
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF28C2A0).withOpacity(0.1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Image.asset("assets/images/notice.png",
                                ),
                              ),
                            ),
                            Text("Notice"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
