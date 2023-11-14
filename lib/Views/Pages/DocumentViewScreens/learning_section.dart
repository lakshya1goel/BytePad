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
                      tabs: [
                        Tab(text: 'BAS101'),
                        Tab(text: 'BAS102'),
                        Tab(text: 'BAS103'),
                        Tab(text: 'BAS104'),
                        Tab(text: 'BAS105'),
                        Tab(text: 'BAS106'),
                      ],
                    ),
                    SizedBox(
                      height: size.height*0.5,
                      child: TabBarView(
                        children: [
                          Center(child: Text('Content for Tab 1')),
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
