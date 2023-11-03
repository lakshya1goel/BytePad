import 'package:bytepad/Utils/Constants/colors.dart';
import 'package:flutter/material.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({super.key});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    // color: Colors.red,
                    height: 250,
                      child: Column(
                        children: [
                          Image.asset("assets/images/StudentProfileBackground.png"),
                        ],
                      )
                  ),
                  Positioned(
                      right: 0,
                      left: 0,
                      top: 135,
                      child: CircleAvatar(
                        radius: 55,
                      )
                  ),
                ],
              ),
              Text("Aryan Jaiswal",
                style: TextStyle(
                  fontSize: 20,
                  color: blueColor,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text('2200270100049'),
              SizedBox(height: 30,),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('Student No.'),
                          Text('2210019'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Academic Year'),
                          Text('2023-2024'),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('Branch'),
                          Text('CSE'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Section'),
                          Text('1'),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('Date of Admission'),
                          Text('01 Nov 2022'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Date of Birth'),
                          Text('02 Apr 2003'),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text('Parent Mail ID'),
                      Text('parentbothsample@gmail.com'),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Mother Name'),
                      Text('Shikha Jaiswal'),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Father Name'),
                      Text('K.P. Jaiswal'),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Parmanent Add.'),
                      Text('Indirapuram, Ghaziabad'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}