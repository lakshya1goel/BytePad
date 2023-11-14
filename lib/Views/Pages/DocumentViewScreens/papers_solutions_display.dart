import 'package:bytepad/Services/PastYearPapers/paper_reading.dart';
import 'package:flutter/material.dart';

import '../../../Models/PastYearPapers/paper_read_model.dart';
import '../../../Services/storage.dart';
import '../../../Utils/Constants/colors.dart';
String? accessToken;
class PaperSolutionDisplay extends StatefulWidget {
  final int? paperId;
  const PaperSolutionDisplay({required this.paperId, Key? key}) : super(key: key);

  @override
  State<PaperSolutionDisplay> createState() => _PaperSolutionDisplayState();
}

class _PaperSolutionDisplayState extends State<PaperSolutionDisplay> {
  bool isLoading = true;
  PaperReadModel? paperModel;
  final SecureStorage secureStorage = SecureStorage();
  @override
  void initState() {
    super.initState();
    secureStorage.readSecureData('accessToken').then((value) {
      setState(() {
        accessToken = value;
      });
      print('Access Token: $accessToken');
      fetchData();
    });
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        isLoading = true; // Set loading to true before making the API call
      });

      // Call the paperRead function to get data
      final result = await paperRead(accessToken, widget.paperId);

      // Update the UI with the retrieved data
      setState(() {
        paperModel = result;
      });
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      setState(() {
        isLoading = false; // Set loading to false after the API call is complete
      });
    }
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
              (isLoading) ?
                Center(child: CircularProgressIndicator()): SizedBox(height: size.height*0.02,),
              (paperModel != null) ?
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  width: size.width*0.95,
                  height: size.height*0.15,
                  child: Padding(
                    padding: EdgeInsets.only(left: size.width*0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(paperModel?.title ?? '',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Row(
                          children: [
                            Text(paperModel?.courses.toString() ?? '',
                              style: TextStyle(color: Color(0xFF656565), fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: size.width*0.28),
                            IconButton(
                                onPressed: (){
                                  print("dddddd");
                                },
                                icon: Icon(Icons.download,
                                  color: Colors.grey,
                                )),
                            IconButton(
                                onPressed: (){
                                  print("fffffff");
                                },
                                icon: Icon(Icons.create_new_folder,
                                  color: Colors.grey,
                                )),
                            IconButton(
                                onPressed: (){
                                  print("sssssss");
                                },
                                icon: Icon(Icons.share,
                                  color: Colors.grey,
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text("Sem: ${paperModel?.semester.toString() ?? ''}",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Text("Year: ${paperModel?.year.toString() ?? ''}",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
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
              ): Container(),
            ],
          ),
        ),
      ),
    );
  }
}
