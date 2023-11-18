import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../Services/authentication/storage.dart';
import '../../../Utils/Constants/colors.dart';
String? accessToken;
class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  int selectedTabIndex = 0;
  String? selectedName;
  int selectedYearIndex = -1;
  int selectedExamIndex = -1;
  int selectedCodeIndex = -1;
  final ScrollController _scrollController = ScrollController();
  List<dynamic> courses = [];
  int currentPage = 1;
  bool isLoading = false;
  final SecureStorage secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    secureStorage.readSecureData('accessToken').then((value) {
      accessToken = value;
      _scrollController.addListener(_scrollListener);
      _fetchCourses();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchCourses();
    }
  }

  Future<void> _fetchCourses() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    var url =
    Uri.parse('https://bytepad.onrender.com/details/courses/?page=$currentPage');
    var headers = {
      'accept': 'application/json',
      'Authorization':
      'Bearer $accessToken'
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      if (jsonResponse.containsKey('next') && jsonResponse['next'] != null) {
        var results = jsonResponse['results'];

        var names = results.map((result) => result['course_code']).toList();

        setState(() {
          courses.addAll(names);
          currentPage++;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('No more pages or unexpected response format');
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
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
              Container(
                width: size.width,
                color: bgColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width*0.07,),
                  child: Text('Filters',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width*0.09,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height*0.05,),
              Container(
                color: Colors.black,
                height: 0.5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: blueColor,
                    height: size.height*0.79,
                    width: size.width*0.45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        buildTab(0, 'Session'),
                        buildTab(1, 'Exam'),
                        buildTab(2, 'Subject'),
                        // Add more tabs as needed
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.65,
                      width: size.width*0.55,
                      child: getContent(selectedTabIndex)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTab(int index, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTabIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        color: selectedTabIndex == index ? Colors.white : blueColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 2),
              child: Text(title,
                style: TextStyle(
                    fontSize: 15,
                    color: selectedTabIndex == index ? Colors.black : Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 2),
              child: Icon(Icons.arrow_forward_ios,
                color: selectedTabIndex == index ? Colors.black : Colors.white,
                size: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getContent(int index) {
    final List<int> years = List.generate(2023 - 2015, (index) => 2015 + index);
    final List<String> exams = ['ST1', 'ST2', 'PUT', 'UT', 'Retest(s)'];
    // final List<String> codes = ['BAS103', 'BAS101', 'BEE101', 'BCS101', 'BAS104', 'BAS151', 'BEE151', 'BCS151', 'BCE151', 'BAS203'];
    switch (index) {
      case 0:
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: years.length,
          itemBuilder: (context, index) {
            return RadioListTile(
              title: Text(years[index].toString()),
              value: index,
              groupValue: selectedYearIndex,
              activeColor: selectedYearIndex == index ? blueColor: null,
              onChanged: (value) {
                setState(() {
                  selectedYearIndex = value as int;
                });
              },
            );
          },
        );
      case 1:
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: exams.length,
          itemBuilder: (context, index) {
            return RadioListTile(
              title: Text(exams[index]),
              value: index,
              groupValue: selectedExamIndex,
              activeColor: selectedExamIndex == index ? blueColor: null,
              onChanged: (value) {
                setState(() {
                  selectedExamIndex = value as int;
                });
              },
            );
          },
        );
      case 2:
        return ListView.builder(
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: courses.length + 1,
          itemBuilder: (context, index) {
            if (index < courses.length) {
              final course = courses[index];
              return RadioListTile(
                title: Text(course),
                value: index,
                groupValue: selectedCodeIndex,
                activeColor: selectedCodeIndex == index ? blueColor: null,
                onChanged: (value) {
                  setState(() {
                    selectedCodeIndex = value as int;
                  });
                },
              );
            } else if (isLoading) {
                    return Center(child: CircularProgressIndicator());
            } else {
              return Container();
            }
          },
        );
        // return ListView.builder(
        //   shrinkWrap: true,
        //   physics: NeverScrollableScrollPhysics(),
        //   itemCount: codes.length,
        //   itemBuilder: (context, index) {
        //     return RadioListTile(
        //       title: Text(codes[index]),
        //       value: index,
        //       groupValue: selectedCodeIndex,
        //       activeColor: selectedCodeIndex == index ? blueColor: null,
        //       onChanged: (value) {
        //         setState(() {
        //           selectedCodeIndex = value as int;
        //         });
        //       },
        //     );
        //   },
        // );
      default:
        return Container();
    }
  }
}

