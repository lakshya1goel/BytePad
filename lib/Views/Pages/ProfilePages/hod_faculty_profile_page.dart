import 'package:bytepad/Models/Details/hod_faculty_details_model.dart';
import 'package:bytepad/Services/Details/hod_faculty_details.dart';
import 'package:bytepad/Utils/Constants/colors.dart';
import 'package:flutter/material.dart';
import '../../../Services/authentication/storage.dart';
import '../../Widgets/bottom_navigation_bar.dart';

String? accessToken;
class HodFacultyProfilePage extends StatefulWidget {
  const HodFacultyProfilePage({super.key});

  @override
  State<HodFacultyProfilePage> createState() => _HodFacultyProfilePage();
}

class _HodFacultyProfilePage extends State<HodFacultyProfilePage> {

  late Size size;
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
          child: hodFacultyDetailsModel != null? Column(
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
                      child: Image.network(hodFacultyDetailsModel!.profilePicture?? '',
                        width: size.width*0.25,
                        height: size.width*0.25,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height*0.01),
                    child: Center(child: Text(hodFacultyDetailsModel!.name??'',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width*0.04
                      ),
                    )),
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
                    Padding(
                      padding: EdgeInsets.only(left: size.width*0.08, top: size.height*0.03, right: size.width*0.08),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Department',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: size.width*0.04
                                ),
                              ),
                              Text(hodFacultyDetailsModel!.department.toString(),
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
                              Text('Date of Birth',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: size.width*0.04
                                ),
                              ),
                              Text(hodFacultyDetailsModel!.dateOfBirth.toString(),
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
                          Text('Email',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: size.width*0.04
                            ),),
                          Text(hodFacultyDetailsModel!.email.toString(),
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
                          Text(hodFacultyDetailsModel!.contactNumber.toString(),
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
