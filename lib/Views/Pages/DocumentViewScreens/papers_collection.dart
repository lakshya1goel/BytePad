import 'package:flutter/material.dart';
import '../../../Models/PastYearPapers/papers_listing_model.dart';
import '../../../Services/PastYearPapers/papers_listing.dart';
import '../../../Services/authentication/storage.dart';
import '../../../Utils/Constants/colors.dart';

String? accessToken;
class MyCollections extends StatefulWidget {
  const MyCollections({super.key});

  @override
  State<MyCollections> createState() => _MyCollectionsState();
}

class _MyCollectionsState extends State<MyCollections> {

  late Size size;
  Future<PaperListingModel?>? papersFuture;
  final SecureStorage secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    secureStorage.readSecureData('accessToken').then((value) {
      accessToken = value;
      setState(() {
        papersFuture = paperListing(accessToken);
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

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
                padding: EdgeInsets.symmetric(horizontal: size.width*0.07, vertical: size.height*0.02),
                child: Text('My Collections',
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
                    return SizedBox(
                      height: size.height,
                      child: ListView.builder(
                        itemCount: snapshot.data!.results!.length,
                        itemBuilder: (context, index) {
                          Results paper = snapshot.data!.results![index];
                          return Card(
                            child: ListTile(
                                title: Text(paper.title ?? ''),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(paper.courses.toString() ?? ''),
                                    Row(
                                      children: [
                                        Text(paper.year.toString() ?? ''),
                                        SizedBox(width: size.width*0.75,),
                                        Text(paper.semester.toString() ?? ''),
                                      ],
                                    ),
                                  ],
                                )
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
