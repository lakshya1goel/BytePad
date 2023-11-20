import 'package:bytepad/Views/Pages/DocumentViewScreens/papers_solutions_display.dart';
import 'package:flutter/material.dart';

import '../../../Models/PastYearPapers/myCollection_paper_list_model.dart';
import '../../../Models/PastYearPapers/paper_read_model.dart';
import '../../../Services/PastYearPapers/myCollections_papers_list.dart';
import '../../../Services/PastYearPapers/paper_reading.dart';
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

  bool isLoading = false;
  late Size size;
  Future<List<Results>>? papers;
  // List<Results> myCollectionPapers = [];
  final SecureStorage secureStorage = SecureStorage();
  // PaperReadModel? paperReading = PaperReadModel();

  @override
  void initState() {
    super.initState();
    // fetchData();
    secureStorage.readSecureData('accessToken').then((value) {
      accessToken = value;
      print(accessToken);
      papers = getPapersFromCollection(accessToken);
    });
  }

  // void fetchData() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   try {
  //     List<Results> papers = await getPapersFromCollection("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzAyODgxNTMzLCJpYXQiOjE3MDAyODk1MzMsImp0aSI6ImM0N2JmNDc0MWIzODQwOGI5OWVlMDIyMjE1NjNlNGRkIiwidXNlcl9pZCI6Imxha3NoeWEyMjEyMDIyQGFrZ2VjLmFjLmluIn0.JKF6SJad21xBRTNy-VX_BVOeaGG-SNQaZOaypRJuNAo");
  //     setState(() {
  //       myCollectionPapers = papers;
  //     });
  //   } catch (e) {
  //     // Handle error if needed
  //     print('Error fetching data: $e');
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: IconButton(
            icon: Icon(Icons.arrow_back,
              color: Colors.black,
              size: size.width * 0.1,
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
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.07,
                    vertical: size.height * 0.02),
                child: Text('My Collections',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.09,
                  ),
                ),
              ),
              FutureBuilder<List<Results>>(
                future: papers,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    List<Results>? results = snapshot.data ?? [];
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        Results result = results[index];
                        return GestureDetector(
                          onTap: (){
                            print("hhhhhhhhh");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaperSolutionDisplay(paperId: result.paper,),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: size.width*0.95,
                              height: size.height*0.15,
                              child: ListTile(
                                title: Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(result.title ?? '',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                subtitle: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(result.courses.toString() ?? '',
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
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Text("Sem: ${result.semester}"),
                                        ),
                                        Text("Year: ${result.year}"),
                                      ],
                                    ),
                                  ],
                                ),
                                // Add more details as needed
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
