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
  final SecureStorage secureStorage = SecureStorage();
  String? selectedName;
  int selectedYearIndex = -1;
  int selectedExamIndex = -1;
  int selectedCodeIndex = -1;

  @override
  void initState() {
    super.initState();
    secureStorage.readSecureData('accessToken').then((value) {
      accessToken = value;
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
                    height: size.height*0.8,
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
                  Container(
                    color: bgColor,
                    width: size.width*0.55,
                    child: getContent(selectedTabIndex),
                  ),
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
    final List<String> codes = ['BAS103', 'BAS101', 'BEE101', 'BCS101', 'BAS104', 'BAS151', 'BEE151', 'BCS151', 'BCE151', 'BAS203'];
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
          physics: NeverScrollableScrollPhysics(),
          itemCount: codes.length,
          itemBuilder: (context, index) {
            return RadioListTile(
              title: Text(codes[index]),
              value: index,
              groupValue: selectedCodeIndex,
              activeColor: selectedCodeIndex == index ? blueColor: null,
              onChanged: (value) {
                setState(() {
                  selectedCodeIndex = value as int;
                });
              },
            );
          },
        );
      default:
        return Container();
    }
  }
}

