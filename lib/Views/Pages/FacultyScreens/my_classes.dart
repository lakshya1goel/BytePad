import 'package:flutter/material.dart';

import '../../../Models/Details/batch_list_model.dart';
import '../../../Services/Details/batch_list.dart';
import '../../../Services/authentication/storage.dart';
import '../../../Utils/Constants/colors.dart';

String? accessToken;
class MyClasses extends StatefulWidget {
  const MyClasses({super.key});

  @override
  State<MyClasses> createState() => _MyClassesState();
}

class _MyClassesState extends State<MyClasses> {

  Future<List<BatchListModel>>? batchList;
  final SecureStorage secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    secureStorage.readSecureData('accessToken').then((value) {
      accessToken = value;
      print('Access Token: $accessToken');
      setState(() {
        batchList = getBatchList('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzAzMjI2NzY0LCJpYXQiOjE3MDA2MzQ3NjQsImp0aSI6ImVhMGI1NDkwNzA3MDQzNjk5ZDgxY2FiNTJjNjU3NzgxIiwidXNlcl9pZCI6Inlhc2gyMDA0YmFuc2FsQGdtYWlsLmNvbSJ9.cIyguABGqQG8FzRJXQAAP9qC78OoSbu60wSEwCm38ow');
        print(batchList);
      });
      print("hhhhhhhh");
    });
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height*0.02,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
                child: Text('My Classes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width*0.09,
                  ),
                ),
              ),
              SizedBox(height: size.height*0.05,),
              FutureBuilder<List<BatchListModel>>(
                future: batchList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text('No data available.'),
                    );
                  } else {
                    // Display the batchList in a TabView
                    return DefaultTabController(
                      length: snapshot.data!.length,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TabBar(
                            unselectedLabelColor: blueColor,
                            labelColor: Colors.white,
                            indicator: BoxDecoration(
                              color: blueColor,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            indicatorSize: TabBarIndicatorSize.label,
                            isScrollable: snapshot.data!.length > 1,
                            tabs: snapshot.data!
                                .map((batch) => Container(
                              height: size.height*0.04,
                              width: size.width*0.2,
                              decoration: BoxDecoration(
                                color: Color(0x3321209C),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                                  child: Tab(
                              text: batch.branch ?? 'Unknown',
                            ),
                                ))
                                .toList(),
                          ),
                          SizedBox(
                            height: size.height*0.05,
                            child: TabBarView(
                              children: snapshot.data!
                                  .map(
                                    (batch) => Center(
                                  // child: Text('Year: ${batch.year}, Semester: ${batch.semester}'),
                                      child: SizedBox(
                                        height: size.height*0.03,
                                      ),
                                ),
                              ).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
          Center(
            child: Container(
              width: size.width*0.9,
              height: size.height*0.15,
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: Color(0xFF21209C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 16,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Row(
                children: [
                  Text("LT-07",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                    child: Container(
                      height: size.height*0.1,
                      width: size.width*0.005,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    width: size.width*0.6,
                    child: Text("Display any necessary information here about the section.",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
              SizedBox(height: size.height*0.05,),
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
                                  child: Image.asset("assets/images/student.png",
                                    // color: blueColor,
                                  ),
                                ),
                              ),
                            ),
                            Text("Students"),
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
                                  child: Image.asset("assets/images/Device.png",
                                    // color: blueColor,
                                  ),
                                ),
                              ),
                            ),
                            Text("Attendance"),
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
                                  child: Image.asset("assets/images/Clock.png",
                                  ),
                                ),
                              ),
                            ),
                            Text("Announcements"),
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


// import 'package:flutter/material.dart';
//
// import '../../../Services/Details/batch_list.dart';
//
// class MyClasses extends StatefulWidget {
//   const MyClasses({super.key});
//
//   @override
//   State<MyClasses> createState() => _MyClassesState();
// }
//
// class _MyClassesState extends State<MyClasses> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           getBatchList("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzAzMjI2NzY0LCJpYXQiOjE3MDA2MzQ3NjQsImp0aSI6ImVhMGI1NDkwNzA3MDQzNjk5ZDgxY2FiNTJjNjU3NzgxIiwidXNlcl9pZCI6Inlhc2gyMDA0YmFuc2FsQGdtYWlsLmNvbSJ9.cIyguABGqQG8FzRJXQAAP9qC78OoSbu60wSEwCm38ow");
//         },
//       ),
//     );
//   }
// }
