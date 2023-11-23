import 'package:bytepad/Views/Pages/Attendance/student_subject_detailed_attendance.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../Models/Attendance/student_attendance_model.dart';
import '../../../Services/Attendance/student_attendance_data.dart';
import '../../../Services/authentication/storage.dart';
import '../../../Utils/Constants/colors.dart';
String? accessToken;
Size? size;
class StudentAttendance extends StatefulWidget {
  const StudentAttendance({super.key});

  @override
  State<StudentAttendance> createState() => _StudentAttendanceState();
}

class _StudentAttendanceState extends State<StudentAttendance> {

  Future<StudentAttendanceDataModel?>? attendanceData;
  final SecureStorage secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    secureStorage.readSecureData('accessToken').then((value) {
      accessToken = value;
      print(accessToken);
      setState(() {
        attendanceData = fetchAttendanceData(accessToken);
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size!.height*0.02,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size!.width*0.07,),
              child: Text('Attendance',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size!.width*0.09,
                ),
              ),
            ),
            SizedBox(height: size!.height*0.02,),
            Center(
              child: Container(
                width: size!.width*0.9,
                height: size!.height*0.2,
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
                      padding: EdgeInsets.only(left: size!.width*0.05, top: size!.height*0.02),
                      child: Column(
                        children: [
                          Text("Overall Attendance",
                            style: TextStyle(
                                color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: size!.width*0.035
                            ),
                          ),
                          Text("All Subjects (incl. Labs)",
                            style: TextStyle(
                              color: Colors.white,
                                fontSize: size!.width*0.035
                            ),
                          )
                        ],
                      ),
                    ),
                    FutureBuilder<StudentAttendanceDataModel?>(
                      future: attendanceData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Padding(
                            padding: EdgeInsets.only(right:size!.width*0.05),
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData) {
                          return Center(child: Text('No data available'));
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(right:size!.width*0.05),
                            child: CircularPercentIndicator(
                              radius: size!.width*0.15,
                              percent: (snapshot.data!.totalAttendance ?? 0).toDouble() / 100.0,
                              center: Text("${snapshot.data!.totalAttendance ?? 0}%",
                                style: TextStyle(
                                    color: Color(0xFF0BAC00),
                                    fontSize: size!.width*0.04,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              circularStrokeCap: CircularStrokeCap.butt,
                              backgroundColor: Colors.white,
                              progressColor: Color(0xFF0BAC00),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size!.width*0.07),
              child: Text("All Subjects",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: size!.width*0.05,
                ),
              ),
            ),
            FutureBuilder<StudentAttendanceDataModel?>(
              future: attendanceData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return Center(child: Text('No data available'));
                } else {
                  return CourseWiseDetails(data: snapshot.data!);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CourseWiseDetails extends StatelessWidget {
  final StudentAttendanceDataModel data;

  CourseWiseDetails({required this.data});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: data.courseWise?.length ?? 0,
        itemBuilder: (context, index) {
          CourseWise course = data.courseWise![index];

          return Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentDetailedSubjectAttendance(),
                    ),
                  );
                },
                child: Container(
                  width: size!.width*0.9,
                  height: size!.height*0.1,
                  decoration: ShapeDecoration(
                    color: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: ListTile(
                    title: Text('${course.subject ?? ""}',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: size!.width*0.035
                      ),
                    ),
                    subtitle: Text('Attendance: ${course.present?? 0}/${course.present! + (course.absent ?? 0)}',
                      style: TextStyle(
                          fontSize: size!.width*0.035
                      ),
                    ),
                    trailing: Padding(
                      padding: EdgeInsets.only(right:size!.width*0.05),
                      child: CircularPercentIndicator(
                        radius: size!.width*0.07,
                        percent: (course.percent ?? 0).toDouble() / 100.0,
                        center: Text("${course.percent ?? 0}%",
                          style: TextStyle(
                              color: Color(0xFF0BAC00),
                              fontSize: size!.width*0.03,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        backgroundColor: Colors.white,
                        progressColor: Color(0xFF0BAC00),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

