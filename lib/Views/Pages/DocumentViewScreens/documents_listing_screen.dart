import 'package:bytepad/Utils/Constants/colors.dart';
import 'package:bytepad/Views/Widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class DocumentListingScreen extends StatefulWidget {
  const DocumentListingScreen({super.key});

  @override
  State<DocumentListingScreen> createState() => _DocumentListingScreenState();
}

class _DocumentListingScreenState extends State<DocumentListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blueColor,
        onPressed: () {},
        tooltip: 'Files',
        child: Icon(Icons.folder_copy_outlined),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Text("Past Exams"),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
