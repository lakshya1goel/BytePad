import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../Utils/Constants/colors.dart';

class StudentDetailedSubjectAttendance extends StatefulWidget {
  const StudentDetailedSubjectAttendance({super.key});

  @override
  State<StudentDetailedSubjectAttendance> createState() => _StudentDetailedSubjectAttendanceState();
}

class _StudentDetailedSubjectAttendanceState extends State<StudentDetailedSubjectAttendance> {

  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                child: TableCalendar(
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                    titleCentered: true
                  ),
                  firstDay: DateTime(2023, 8, 1),
                  lastDay: DateTime(2024, 2, 29),
                  focusedDay: now,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: const CalendarStyle(
                    todayTextStyle: TextStyle(color: Colors.black87),
                    todayDecoration: BoxDecoration(
                      color: bgColor,
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
