import 'package:bytepad/Utils/Constants/colors.dart';
import 'package:bytepad/Views/Widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../../Services/PastYearPapers/papers_listing.dart';

class DocumentListingScreen extends StatefulWidget {
  const DocumentListingScreen({super.key});

  @override
  State<DocumentListingScreen> createState() => _DocumentListingScreenState();
}

class _DocumentListingScreenState extends State<DocumentListingScreen> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: blueColor,
        onPressed: () {
          paperListing("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjk5NzMwNzIxLCJpYXQiOjE2OTk3MzA0MjEsImp0aSI6ImRjYjkyMzMxMDFhMjQ5ZGU5Y2I0NmU3NzI2YWJjMmM5IiwidXNlcl9pZCI6Imxha3NoeWEyMjEyMDIyQGFrZ2VjLmFjLmluIn0.Nts9FdNFrKliCxzd0W3xZv1QPVOig2JX-iL1W9j3WHI");
        },
        tooltip: 'Files',
        child: Icon(Icons.folder_copy_outlined),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.07, vertical: size.height*0.02),
                child: Text('Past Exams',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width*0.09,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
