import 'package:bytepad/Views/Pages/ProfilePages/students_profile_for_faculty.dart';
import 'package:flutter/material.dart';
import '../../../Models/Details/students_list_model.dart';
import '../../../Services/Details/students_list.dart';
import '../../../Services/authentication/storage.dart';
import '../../../Utils/Constants/colors.dart';

String? accessToken;
class MyStudents extends StatefulWidget {
  final String id;

  const MyStudents({Key? key, required this.id}) : super(key: key);

  @override
  State<MyStudents> createState() => _MyStudentsState();
}

class _MyStudentsState extends State<MyStudents> {

  Future<List<StudentsListModel>>? list;
  final SecureStorage secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    secureStorage.readSecureData('accessToken').then((value) {
      accessToken = value;
      print('Access Token: $accessToken');
      setState(() {
        list = getStudentList('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzAzMjI2NzY0LCJpYXQiOjE3MDA2MzQ3NjQsImp0aSI6ImVhMGI1NDkwNzA3MDQzNjk5ZDgxY2FiNTJjNjU3NzgxIiwidXNlcl9pZCI6Inlhc2gyMDA0YmFuc2FsQGdtYWlsLmNvbSJ9.cIyguABGqQG8FzRJXQAAP9qC78OoSbu60wSEwCm38ow', widget.id);
      });
      print("hhhhhhhh");
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
                  child: Text('My Students',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width*0.09,
                    ),
                  ),
                ),
                SizedBox(height: size.height*0.03,),
                FutureBuilder<List<StudentsListModel>>(
                  future: list,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text('No data available'),
                      );
                    } else {
                      List<StudentsListModel> studentList = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: studentList.length,
                        itemBuilder: (context, index) {
                          StudentsListModel student = studentList[index];
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => StudentProfileForFaculty(roll: student.rollNumber.toString())),
                                  );
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(student.profilePic ?? ''),
                                  ),
                                  title: Text(student.userName ?? '',
                                    style: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Lato',),
                                  ),
                                  subtitle: Text('${student.rollNumber}',
                                    style: TextStyle(
                                      color: Color(0xFF6B7280),
                                      fontSize: 12,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w400,
                                      height: 0.12,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: size.height*0.001,
                                width: size.width*0.9,
                                color: Colors.grey,
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                )
              ],
            )
        ),
      ),
    );
  }
}
