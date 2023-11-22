import 'package:bytepad/Views/Pages/DocumentUploadingScreens/document_listing_page_faculty.dart';
import 'package:bytepad/Views/Pages/DocumentUploadingScreens/document_selction_screen.dart';
import 'package:bytepad/Views/Pages/FacultyScreens/my_classes.dart';
import 'package:flutter/material.dart';
import 'package:bytepad/Utils/Constants/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../Models/Details/hod_faculty_details_model.dart';
import '../../../Services/Details/hod_faculty_details.dart';
import '../../../Services/authentication/storage.dart';
String? accessToken;
class FacultyDashboard extends StatefulWidget {
  const FacultyDashboard({super.key});

  @override
  State<FacultyDashboard> createState() => _FacultyDashboardState();
}

class _FacultyDashboardState extends State<FacultyDashboard> {

  List display = [
    {"heading": 'CSE-1 Digital Forum', "content": 'Could someone please send the notes...'},
    {"heading": 'CSE-1 Digital Forum', "content": 'Could someone please send the notes...'},
    {"heading": 'CSE-1 Digital Forum', "content": 'Could someone please send the notes...'},
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  HodFacultyDetailsModel? hodFacultyDetailsModel;
  final SecureStorage secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    secureStorage.readSecureData('accessToken').then((value) {
      accessToken = value;
      print('Access Token: $accessToken');
      getHodFacultyDetails(accessToken).then((data) {
        setState(() {
          hodFacultyDetailsModel = data;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: hodFacultyDetailsModel != null? AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(hodFacultyDetailsModel!.profilePicture?? ''),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Greetings!",
              style: TextStyle(color: Colors.black, fontSize: size.width*0.05),
            ),
            Text(hodFacultyDetailsModel!.name??'',
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
      ): AppBar(backgroundColor: bgColor,
          elevation: 0,
          title: CircularProgressIndicator()),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height*0.05,),
              Container(
                height: size.height*0.2,
                width: double.infinity,
                child: CarouselSlider(
                  items: display.map((item) => Card(
                    child: Container(
                      width: size.width*0.9,
                      child: Row(
                        children: [
                          Container(
                            color: blueColor,
                            height: size.height*0.2,
                            width: size.width*0.03,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: size.width*0.05, vertical: size.height*0.02),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0x332B27FD),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Text('New', style: TextStyle(color: blueColor, fontSize: size.width*0.03),),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left : size.width*0.05, right : size.width*0.05, bottom: size.height*0.01),
                                child: Text(item['heading'],
                                  style: TextStyle(
                                      fontSize: size.width*0.05,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              // SizedBox(height: size.height*0.05),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: size.width*0.05,),
                                child: Text(item['content'],
                                  style: TextStyle(
                                    fontSize: size.width*0.035,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )).toList(),
                  carouselController: carouselController,
                  options: CarouselOptions(
                      scrollPhysics: const BouncingScrollPhysics(),
                      aspectRatio: 0.55,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      }
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: display.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => carouselController.animateToPage(entry.key),
                    child: Container(
                      width: size.width*0.025,
                      height: size.height*0.012,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: currentIndex == entry.key? blueColor : Colors.grey,
                        borderRadius: BorderRadius.circular(size.width*0.025),
                      ),
                    ),
                  );
                }).toList(),
              ),
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
                                child: Padding(
                                  padding: EdgeInsets.all(size.width*0.04),
                                  child: Image.asset("assets/images/announcement.png",
                                    // color: blueColor,
                                  ),
                                ),
                              ),
                            ),
                            Text("Announcements"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: size.width*0.07),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DocumentListingFacultyScreen()),
                                );
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF28C2A0).withOpacity(0.1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(size.width*0.04),
                                  child: Image.asset("assets/images/solution.png",
                                    // color: blueColor,
                                  ),
                                ),
                              ),
                            ),
                            Text("Upload Solutions"),
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
                                child: Padding(
                                  padding: EdgeInsets.all(size.width*0.04),
                                  child: Image.asset("assets/images/timetable.png",
                                  ),
                                ),
                              ),
                            ),
                            Text("Timetable"),
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
