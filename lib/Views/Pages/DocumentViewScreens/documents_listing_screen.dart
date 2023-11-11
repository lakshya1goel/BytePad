import 'package:bytepad/Utils/Constants/colors.dart';
import 'package:bytepad/Views/Widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../../Models/PastYearPapers/papers_listing_model.dart';
import '../../../Services/PastYearPapers/papers_listing.dart';

class DocumentListingScreen extends StatefulWidget {
  const DocumentListingScreen({super.key});

  @override
  State<DocumentListingScreen> createState() => _DocumentListingScreenState();
}

class _DocumentListingScreenState extends State<DocumentListingScreen> {

  Future<PaperListingModel?>? papersFuture;

  @override
  void initState() {
    super.initState();
    papersFuture = paperListing("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjk5NzMwNzIxLCJpYXQiOjE2OTk3MzA0MjEsImp0aSI6ImRjYjkyMzMxMDFhMjQ5ZGU5Y2I0NmU3NzI2YWJjMmM5IiwidXNlcl9pZCI6Imxha3NoeWEyMjEyMDIyQGFrZ2VjLmFjLmluIn0.Nts9FdNFrKliCxzd0W3xZv1QPVOig2JX-iL1W9j3WHI");
  }

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
              FutureBuilder<PaperListingModel?>(
                future: papersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.results == null || snapshot.data!.results!.isEmpty) {
                    return Center(
                      child: Text('No papers available.'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.results!.length,
                      itemBuilder: (context, index) {
                        Results paper = snapshot.data!.results![index];
                        return Card(
                          child: ListTile(
                            title: Text(paper.title ?? ''),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
