import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../Utils/Constants/colors.dart';

class StudentAttendance extends StatefulWidget {
  const StudentAttendance({super.key});

  @override
  State<StudentAttendance> createState() => _StudentAttendanceState();
}

class _StudentAttendanceState extends State<StudentAttendance> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
          child: IconButton(
            icon: Icon(Icons.arrow_back,
              color: Colors.black,
              size: size.width*0.1,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.07,),
                child: Text('Attendance',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width*0.09,
                  ),
                ),
              ),
              SizedBox(height: size.height*0.02,),
              Center(
                child: Container(
                  width: size.width*0.9,
                  height: size.height*0.2,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFF1246AC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width*0.05, top: size.height*0.02),
                        child: Column(
                          children: [
                            Text("Overall Attendance",
                              style: TextStyle(
                                  color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: size.width*0.035
                              ),
                            ),
                            Text("All Subjects (incl. Labs)",
                              style: TextStyle(
                                color: Colors.white,
                                  fontSize: size.width*0.035
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right:size.width*0.05),
                        child: CircularPercentIndicator(
                          radius: size.width*0.15,
                          percent: 0.5,
                          center: Text("50%",
                            style: TextStyle(
                                color: Color(0xFF0BAC00),
                              fontSize: size.width*0.07,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          circularStrokeCap: CircularStrokeCap.butt,
                          backgroundColor: Colors.white,
                          progressColor: Color(0xFF0BAC00),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(size.width*0.07),
                child: Text("All Subjects",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: size.width*0.05,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: size.width*0.9,
                  height: size.height*0.1,
                  decoration: ShapeDecoration(
                    color: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width*0.05, top: size.height*0.03),
                        child: Column(
                          children: [
                            Text("Overall Attendance",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: size.width*0.035
                              ),
                            ),
                            Text("All Subjects (incl. Labs)",
                              style: TextStyle(
                                  fontSize: size.width*0.035
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right:size.width*0.05),
                        child: CircularPercentIndicator(
                          radius: size.width*0.07,
                          percent: 0.5,
                          center: Text("50%",
                            style: TextStyle(
                                color: Color(0xFF0BAC00),
                                fontSize: size.width*0.04,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          circularStrokeCap: CircularStrokeCap.butt,
                          backgroundColor: Colors.white,
                          progressColor: Color(0xFF0BAC00),
                        ),
                      )
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
