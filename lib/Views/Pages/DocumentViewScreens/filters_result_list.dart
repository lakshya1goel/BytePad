import 'package:bytepad/Views/Pages/DocumentViewScreens/papers_solutions_display.dart';
import 'package:flutter/material.dart';

import '../../../Models/PastYearPapers/papers_listing_model.dart';
import '../../../Services/PastYearPapers/filtersDetails.dart';
import '../../../Services/authentication/storage.dart';
import '../../../Utils/Constants/colors.dart';

String? accessToken;
class FiltersResultList extends StatefulWidget {
  final String year;
  final String exam;
  final String code;
  const FiltersResultList({required this.year, required this.exam, required this.code, Key? key,}) : super(key: key);

  @override
  State<FiltersResultList> createState() => _FiltersResultListState();
}

class _FiltersResultListState extends State<FiltersResultList> {

  Future<PaperListingModel?>? papersFuture;

  final SecureStorage secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    secureStorage.readSecureData('accessToken').then((value) {
      accessToken = value;
      print(accessToken);
      setState(() {
        papersFuture = paperListFilters(accessToken, widget.year, widget.exam, widget.code);
      });
    });
  }

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
                padding: EdgeInsets.symmetric(horizontal: size.width*0.07,),
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
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.results!.length,
                      itemBuilder: (context, index) {
                        Results paper = snapshot.data!.results![index];
                        return GestureDetector(
                          onTap: (){
                            print("hhhhhhhhh");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaperSolutionDisplay(paperId: paper.id),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              width: size.width*0.95,
                              height: size.height*0.15,
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
                                      Row(
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
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: 8.0),
                                            child: Text("Sem: ${paper.semester.toString() ?? ''}"),
                                          ),
                                          Text("Year: ${paper.year.toString() ?? ''}"),
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
