import 'package:flutter/material.dart';

import '../../../Utils/Constants/colors.dart';
import '../../Widgets/bottom_navigation_bar.dart';

class LearningSection extends StatefulWidget {
  const LearningSection({super.key});

  @override
  State<LearningSection> createState() => _LearningSectionState();
}

class _LearningSectionState extends State<LearningSection> {
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
                padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
                child: Text('Learning',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width*0.09,
                  ),
                ),
              ),
              SizedBox(height: size.height*0.03,),
              Center(
                child: Card(
                  child: Container(
                    height: size.height*0.4,
                    width: size.width*0.85,
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset("assets/images/learning.png")
                            )
                        ),
                        SizedBox(height: size.height*0.02,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
                          child: Text("Past Exams",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.05),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
                          child: Text("Access and review past exam papers effortlessly with our app's comprehensive Past Papers feature"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height*0.02,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.07),
                child: Row(
                  children: [
                    Text("Subject (s)",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.06),
                    ),
                    SizedBox(width: size.width*0.3,),
                    TextButton(
                        onPressed: (){},
                        child: Text("View All",
                          style: TextStyle(color: Colors.grey, fontSize: size.width*0.05),
                        )
                    )
                  ],
                ),
              ),
              DefaultTabController(
                length: 6,
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      unselectedLabelColor: blueColor,
                      labelColor: Colors.white,
                      indicator: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        Container(
                            height: size.height*0.04,
                            width: size.width*0.2,
                            decoration: BoxDecoration(
                              color: Color(0x3321209C),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Tab(text: 'BAS101')),
                        Container(
                            height: size.height*0.04,
                            width: size.width*0.2,
                            decoration: BoxDecoration(
                              color: Color(0x3321209C),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Tab(text: 'BAS102')),
                        Container(
                            height: size.height*0.04,
                            width: size.width*0.2,
                            decoration: BoxDecoration(
                              color: Color(0x3321209C),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Tab(text: 'BAS103')),
                        Container(
                            height: size.height*0.04,
                            width: size.width*0.2,
                            decoration: BoxDecoration(
                              color: Color(0x3321209C),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Tab(text: 'BAS104')),
                        Container(
                            height: size.height*0.04,
                            width: size.width*0.2,
                            decoration: BoxDecoration(
                              color: Color(0x3321209C),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Tab(text: 'BAS105')),
                        Container(
                            height: size.height*0.04,
                            width: size.width*0.2,
                            decoration: BoxDecoration(
                              color: Color(0x3321209C),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Tab(text: 'BAS106')),
                      ],
                    ),
                    SizedBox(
                      height: size.height*0.6,
                      child: TabBarView(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: size.height*0.02,),
                              Container(
                                width: size.width*0.9,
                                height: size.height*0.05,
                                decoration: ShapeDecoration(
                                  color: Color(0xFF0FD76B),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text("Upcoming",
                                    style: TextStyle(color: Colors.white,
                                      fontSize: size.width*0.05,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: size.width*0.8,
                                height: size.height*0.17,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(size.width*0.03),
                                      child: Text(
                                        'Add a Quiz for Students of 3CO - JVY on the subject Fundamentals of Programming',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                    // SizedBox(height: size.height*0.03,),
                                    TextButton(
                                      onPressed: () {},
                                        child: Text("View Details",
                                          style: TextStyle(color: Color(0xFF3D70F5)),
                                        )),
                                  ],
                                ),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x26000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: size.height*0.02,),
                              Container(
                                width: size.width*0.9,
                                height: size.height*0.05,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF4BA24),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text("This Week",
                                    style: TextStyle(color: Colors.white,
                                        fontSize: size.width*0.05,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: size.width*0.8,
                                height: size.height*0.17,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(size.width*0.03),
                                      child: Text(
                                        'Add a Quiz for Students of 3CO - JVY on the subject Fundamentals of Programming',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                    // SizedBox(height: size.height*0.03,),
                                    TextButton(
                                        onPressed: () {},
                                        child: Text("View Details",
                                          style: TextStyle(color: Color(0xFF3D70F5)),
                                        )),
                                  ],
                                ),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x26000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: size.height*0.03,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                      onPressed: () {},
                                      child: Container(
                                        height: size.height*0.045,
                                        width: size.width*0.35,
                                        decoration: BoxDecoration(
                                          color: blueColor,
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: Center(
                                          child: Text("Previous",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: size.width*0.05
                                            ),
                                          ),
                                        ),
                                      )
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Container(
                                        height: size.height*0.045,
                                        width: size.width*0.35,
                                        decoration: BoxDecoration(
                                          color: blueColor,
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: Center(
                                          child: Text("Previous",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: size.width*0.05
                                            ),
                                          ),
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ],
                          ),
                          // Center(child: Text('Content for Tab 1')),
                          Center(child: Text('Content for Tab 2')),
                          Center(child: Text('Content for Tab 3')),
                          Center(child: Text('Content for Tab 4')),
                          Center(child: Text('Content for Tab 5')),
                          Center(child: Text('Content for Tab 6')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(currentIndex: 1,),
    );
  }
}
