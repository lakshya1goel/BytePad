import 'package:flutter/material.dart';

import '../../../Services/Details/course_list.dart';
import '../../../Services/storage.dart';
import '../../../Utils/Constants/colors.dart';
String? accessToken;
class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  int selectedTabIndex = 0;
  final SecureStorage secureStorage = SecureStorage();
  String? selectedName;

  @override
  void initState() {
    super.initState();
    secureStorage.readSecureData('accessToken').then((value) {
      accessToken = value;
    });
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: blueColor,
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
              Container(
                width: size.width,
                color: bgColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.07,),
                  child: Text('Filters',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width*0.09,
                    ),
                  ),
                ),
              ),
              Container(
                color: bgColor,
                width: size.width,
                height: size.height*0.05,),
              Container(
                color: Colors.black,
                height: 0.5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // height: size.height,
                    width: size.width*0.45,
                    color: blueColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        buildTab(0, 'Session'),
                        buildTab(1, 'Exam'),
                        buildTab(2, 'Subject'),
                        // Add more tabs as needed
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      color: bgColor,
                      width: size.width*0.55,
                      child: getContent(selectedTabIndex),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTab(int index, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTabIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        color: selectedTabIndex == index ? Colors.white : blueColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 2),
              child: Text(title,
                style: TextStyle(
                    fontSize: 15,
                    color: selectedTabIndex == index ? Colors.black : Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 2),
              child: Icon(Icons.arrow_forward_ios,
                color: selectedTabIndex == index ? Colors.black : Colors.white,
                size: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getContent(int index) {
    switch (index) {
      case 0:
        return Text('Content of Tab 1');
      case 1:
        return Text('Content of Tab 2');
      case 2:
        return FutureBuilder(
            future: getCourseNames(accessToken),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 200,
                  child: Padding(
                    padding: EdgeInsets.all(50),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(blueColor),
                    ),
                  ),
                );
              }
              else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              else {
                List<String> names = snapshot.data as List<String>;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      for (String name in names)
                        RadioListTile<String>(
                          title: Text(name),
                          value: name,
                          groupValue: selectedName,
                          onChanged: (value) {
                            // Handle the selection here
                            setState(() {
                              selectedName = value;
                            });
                          },
                        ),
                    ],
                  ),
                );
              }
            }
        );
      default:
        return Container();
    }
  }
}

