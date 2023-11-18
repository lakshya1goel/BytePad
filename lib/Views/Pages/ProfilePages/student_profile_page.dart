import 'package:bytepad/Utils/Constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../Models/Details/student_details_model.dart';
import '../../../Services/Details/student_details.dart';
import '../../../Services/authentication/storage.dart';
import '../../Widgets/bottom_navigation_bar.dart';

String? accessToken;
class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({super.key});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {

  late Size size;
  StudentDetailsModel? studentDetails;
  final SecureStorage secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    secureStorage.readSecureData('accessToken').then((value) {
      accessToken = value;
      print('Access Token: $accessToken');
      getStudentDetails(accessToken).then((data) {
        setState(() {
          studentDetails = data;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: blueColor,
      appBar: AppBar(
        backgroundColor: blueColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
          child: IconButton(
            icon: Icon(Icons.arrow_back,
              color: Colors.white,
              size: size.width*0.1,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: studentDetails != null? Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
                    child: Text("My Profile",
                      style: TextStyle(
                          fontSize: size.width*0.1,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: size.height*0.02,),
                  Center(
                    child: ClipOval(
                      child: Image.network(studentDetails!.profilePicture?? '',
                        width: size.width*0.25,
                        height: size.width*0.25,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height*0.01),
                    child: Center(child: Text(studentDetails!.name??'',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width*0.04
                      ),
                    )),
                  ),
                  Center(child: Text(studentDetails!.rollNumber.toString()??'',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width*0.04
                    ),
                  )),
                ],
              ),
              SizedBox(height: size.height*0.02,),
              Container(
                width: double.infinity,
                height: size.height*0.65,
                decoration: ShapeDecoration(
                  color: bgColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: size.width*0.08, top: size.height*0.03, right: size.width*0.08),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Roll Number',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: size.width*0.04
                                ),
                              ),
                              Text(studentDetails!.rollNumber.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width*0.04
                                ),
                              ),
                              SizedBox(height: size.height*0.02,),
                              Container(height: size.height*0.002, width: size.width*0.3, color: Colors.grey,),
                            ],
                          ),
                          SizedBox(width: size.width*0.15,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Semester',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: size.width*0.04
                                ),
                              ),
                              Text(studentDetails!.currentSemester.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width*0.04
                                ),),
                              SizedBox(height: size.height*0.02,),
                              Container(height: size.height*0.002, width: size.width*0.3, color: Colors.grey,),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width*0.08, top: size.height*0.03, right: size.width*0.08),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Branch',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: size.width*0.04
                                ),),
                              Text(studentDetails!.branch.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width*0.04
                                ),),
                              SizedBox(height: size.height*0.02,),
                              Container(height: size.height*0.002, width: size.width*0.3, color: Colors.grey,),
                            ],
                          ),
                          SizedBox(width: size.width*0.15,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Date of Birth',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: size.width*0.04
                                ),),
                              Text(studentDetails!.dateOfBirth.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width*0.04
                                ),),
                              SizedBox(height: size.height*0.02,),
                              Container(height: size.height*0.002, width: size.width*0.3, color: Colors.grey,),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width*0.08, top: size.height*0.03, right: size.width*0.08),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Student Email',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: size.width*0.04
                            ),),
                          Text(studentDetails!.email.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width*0.04
                            ),),
                          SizedBox(height: size.height*0.02,),
                          Container(height: size.height*0.002, width: size.width*0.75, color: Colors.grey,),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width*0.08, top: size.height*0.03, right: size.width*0.08),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Student Contact No.',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: size.width*0.04
                            ),),
                          Text(studentDetails!.contactNumber.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width*0.04
                            ),),
                          SizedBox(height: size.height*0.02,),
                          Container(height: size.height*0.002, width: size.width*0.75, color: Colors.grey,),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width*0.08, top: size.height*0.03, right: size.width*0.08),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Guardian Name',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: size.width*0.04
                            ),),
                          Text(studentDetails!.guardianName.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width*0.04
                            ),),
                          SizedBox(height: size.height*0.02,),
                          Container(height: size.height*0.002, width: size.width*0.75, color: Colors.grey,),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width*0.08, top: size.height*0.03, right: size.width*0.08),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Guardian Contact No.',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: size.width*0.04
                            ),),
                          Text(studentDetails!.guardianContactNumber.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width*0.04
                            ),),
                          SizedBox(height: size.height*0.02,),
                          Container(height: size.height*0.002, width: size.width*0.75, color: Colors.grey,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ): Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
