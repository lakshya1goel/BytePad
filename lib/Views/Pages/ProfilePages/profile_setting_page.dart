import 'package:bytepad/Views/Pages/DocumentViewScreens/papers_collection.dart';
import 'package:bytepad/Views/Pages/ProfilePages/hod_faculty_profile_page.dart';
import 'package:bytepad/Views/Pages/ProfilePages/student_profile_page.dart';
import 'package:bytepad/Views/Pages/authentication/login_page.dart';
import 'package:bytepad/Views/Widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../../Models/Details/student_details_model.dart';
import '../../../Services/Details/student_details.dart';
import '../../../Services/authentication/storage.dart';
import '../../../Utils/Constants/colors.dart';

String? accessToken;
class ProfileSettingPage extends StatefulWidget {
  const ProfileSettingPage({super.key});

  @override
  State<ProfileSettingPage> createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfileSettingPage> {

  final List<Map<String, dynamic>> itemList = [
    {'title': 'My Account', 'subtitle': 'View and make changes to your account', 'icon': Icons.person},
    {'title': 'My Collections', 'subtitle': 'Manage your saved material', 'icon': Icons.create_new_folder},
    {'title': 'Notifications', 'subtitle': 'Minimized distractions and improved focus', 'icon': Icons.security},
    {'title': 'Log out', 'subtitle': 'Further secure your account for safety', 'icon': Icons.logout},
  ];

  final List<Map<String, dynamic>> itemList2 = [
    {'title': 'Help & Support', 'icon': Icons.notifications},
    {'title': 'About App', 'icon': Icons.favorite_outline_rounded},
  ];

  final SecureStorage secureStorage = SecureStorage();
  StudentDetailsModel? studentDetails;

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

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: blueColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height*0.02,),
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
                    child: studentDetails != null? ClipOval(
                      child: Image.network(studentDetails!.profilePicture?? '',
                        width: size.width*0.25,
                        height: size.width*0.25,
                        fit: BoxFit.cover,
                      ),
                    ) : CircularProgressIndicator(),
                  ),
                ],
              ),
              SizedBox(height: size.height*0.02,),
              Container(
                width: double.infinity,
                height: size.height*0.7,
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
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: size.height*0.01),
                        child: Container(
                          width: size.width*0.95,
                          height: size.height*0.4,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            shadows: [
                              BoxShadow(
                                color: Color(0x0F000000),
                                blurRadius: 44,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: size.height*0.02),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: itemList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Icon(itemList[index]['icon']),
                                  title: Text(itemList[index]['title']),
                                  subtitle: Text(itemList[index]['subtitle']),
                                  onTap: () {
                                    if (index == 0) {
                                    if (studentDetails != null && studentDetails!.isStudent == true) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => StudentProfilePage()),
                                      );
                                    } else{
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => HodFacultyProfilePage()),
                                      );
                                    }
                                    }
                                    if (index == 1) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MyCollections()),
                                      );
                                    }
                                    if (index == 3) {
                                      secureStorage.deleteSecureData('accessToken');
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginPage()),
                                      );
                                    }
                                    print('Tapped on ${itemList[index]['title']}');
                                  },
                                  trailing: Icon(Icons.arrow_forward_ios_outlined),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.05, vertical: size.height*0.02),
                      child: Text("More",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: size.width*0.05),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: size.width*0.95,
                        height: size.height*0.2,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          shadows: [
                            BoxShadow(
                              color: Color(0x0F000000),
                              blurRadius: 44,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: size.height*0.02),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: itemList2.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Icon(itemList2[index]['icon']),
                                title: Text(itemList2[index]['title']),
                                onTap: () {
                                  // Add your onTap functionality here
                                  print('Tapped on ${itemList2[index]['title']}');
                                },
                                trailing: Icon(Icons.arrow_forward_ios_outlined),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
