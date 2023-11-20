import 'package:bytepad/Utils/Constants/colors.dart';
import 'package:bytepad/Views/Pages/DocumentUploadingScreens/solution_uploading_screen.dart';
import 'package:bytepad/Views/Pages/DocumentViewScreens/papers_collection.dart';
import 'package:bytepad/Views/Pages/DocumentViewScreens/papers_solutions_display.dart';
import 'package:bytepad/Views/Widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../../Models/PastYearPapers/papers_listing_model.dart';
import '../../../Services/PastYearPapers/papers_listing.dart';
import '../../../Services/authentication/storage.dart';
String? accessToken;
class DocumentListingFacultyScreen extends StatefulWidget {
  const DocumentListingFacultyScreen({super.key});

  @override
  State<DocumentListingFacultyScreen> createState() => _DocumentListingFacultyScreenState();
}

class _DocumentListingFacultyScreenState extends State<DocumentListingFacultyScreen> {
  late Size size;
  Future<PaperListingModel?>? papersFuture;
  final SecureStorage secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    secureStorage.readSecureData('accessToken').then((value) {
      accessToken = value;
      print(accessToken);
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: blueColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyCollections(),
            ),
          );
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
                padding: EdgeInsets.symmetric(horizontal: size.width*0.07,),
                child: Text('Past Exams',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width*0.09,
                  ),
                ),
              ),
              SizedBox(height: size.height*0.02,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                child: Row(
                  children: [
                    Container(
                      width: size.width*0.7,
                      decoration: BoxDecoration(
                        color: Color(0xFF979797).withOpacity(0.25),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                              Icons.search,
                              color: Color(0xFF979797)
                          ),
                          hintText: 'What are you looking for?',
                          hintStyle: TextStyle(color: Color(0xFF979797)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width*0.02),
                      child: Container(
                        width: size.width*0.17,
                        decoration: BoxDecoration(
                          color: Color(0xFF979797).withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Image.asset("assets/images/SlidersHorizontal.png"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: size.height*0.02,),
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
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.results!.length,
                      itemBuilder: (context, index) {
                        Results paper = snapshot.data!.results![index];
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                            width: size.width*0.95,
                            height: size.height*0.17,
                            child: ListTile(
                                title: Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(paper.title ?? '',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          Text(paper.courses.toString() ?? '',
                                            style: TextStyle(color: Color(0xFF656565), fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: size.width*0.28),
                                          IconButton(
                                              onPressed: (){
                                                print("dddddd");
                                              },
                                              icon: Icon(Icons.download,)),
                                          IconButton(
                                              onPressed: (){
                                                print("fffffff");
                                              },
                                              icon: Icon(Icons.create_new_folder,)),
                                          IconButton(
                                              onPressed: (){
                                                print("sssssss");
                                              },
                                              icon: Icon(Icons.share,)),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Text("Sem: ${paper.semester.toString() ?? ''}"),
                                        ),
                                        Text("Year: ${paper.year.toString() ?? ''}"),
                                        SizedBox(width: size.width*0.2,),
                                        Container(
                                          height: size.height*0.04,
                                          decoration: BoxDecoration(
                                            color: blueColor,
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          child: TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => SolutionUploadingScreen(paperId: paper.id,),
                                                  ),
                                                );
                                              },
                                              child: Text('Add Solution',
                                                style: TextStyle(color: Colors.white),
                                              ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                            ),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
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
    );
  }
}
